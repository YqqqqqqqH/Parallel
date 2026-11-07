#!/usr/bin/env python3
"""实验驱动：按实验名生成配置，每个配置单独启动一个 ivf_lab 进程，汇总各进程 --csv 输出。

- 每一轮内配置顺序随机打乱（种子固定），减少笔记本温度/功耗随时间漂移带来的系统偏差；
- 每行结果附加 exp、round、bin 三列，写入 results/<exp>.csv（追加模式由 --append 控制）；
- 任一进程失败（含正确性检查失败）立即中止。

环境变量（服务器对照用，默认值与本机实验一致）：
  IVF_P        物理核数 P（默认 16），大 batch 取 4P
  IVF_THREADS  线程数列表，逗号分隔（默认 1,2,4,8,16,24）
  IVF_RESULTS  结果目录，相对本目录（默认 results；服务器上用 results/server）
  IVF_DATA     数据目录

用法示例：
  python -I scripts/bench.py A --rounds 3
  python -I scripts/bench.py C --rounds 1
  python -I scripts/bench.py list            # 列出各实验的配置数
"""

import argparse
import csv
import io
import os
import random
import subprocess
import sys
import time

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA = os.environ.get("IVF_DATA", "/home/felix/datasets/sift1m")
DATA_ARGS = ["--base", f"{DATA}/sift_base.fbin", "--centroids", f"{DATA}/centroid_4096.fvecs",
             "--cluster-ids", f"{DATA}/cluster_id_4096.ivecs",
             "--queries-file", f"{DATA}/sift_query.fbin", "--gt", f"{DATA}/gt.ibin"]

P = int(os.environ.get("IVF_P", "16"))   # 物理核数：本机 8P+8E=16；服务器在 CP-S1 确定
BIG = 4 * P     # 大 batch 固定为 4P
Q = 1024        # 统一查询数
THREADS = ([int(x) for x in os.environ["IVF_THREADS"].split(",")]
           if os.environ.get("IVF_THREADS") else [1, 2, 4, 8, 16, 24])
RESULTS = os.environ.get("IVF_RESULTS", "results")

# 由检查点决定的默认值：SCHED1 在 CP1 确定，GRAIN 在 CP2 确定（见实验日志）
SCHED1 = "dynamic:1"     # omp1 默认调度
GRAIN = {1: 128, BIG: 1024}  # omp2 在 batch=1 / batch=4P 时的 grain


def c(only, **kw):
    kw["only"] = only
    kw.setdefault("queries", Q)
    return kw


def exp_A():  # 线程数：batch=1 与 batch=4P，标量距离
    cfgs = [c("serial", batch=b) for b in (1, BIG)]
    for p in THREADS:
        for b in (1, BIG):
            cfgs.append(c("omp1", threads=p, batch=b, sched=SCHED1))
            cfgs.append(c("omp2", threads=p, batch=b, grain=GRAIN[b]))
            if b == 1:
                cfgs.append(c("omp2", threads=p, batch=b, grain=GRAIN[b], coarse="split"))
    return cfgs


def exp_A_wait():  # batch=1 时 omp2 比串行慢的原因：自旋等待 vs 任务落在哪个线程
    cfgs = []
    for p in (1, 2, 16):
        for policy in ("", "OMP_WAIT_POLICY=passive"):
            cfgs.append(c("omp2", threads=p, batch=1, grain=4096, env=policy))
            cfgs.append(c("omp2", threads=p, batch=1, grain=GRAIN[1], env=policy))
    cfgs.append(c("serial", batch=1))
    return cfgs


def exp_A_sched():  # omp1 调度消融
    return [c("omp1", threads=P, batch=BIG, sched=s)
            for s in ("static", "dynamic:1", "dynamic:4", "guided")]


def exp_B():  # 查询工作量分布：原始顺序 / 按 C(q) 升序 / 降序
    cfgs = []
    for order in ("orig", "asc", "desc"):
        cfgs.append(c("serial", batch=BIG, order=order))
        for sched in ("static", SCHED1):
            cfgs.append(c("omp1", threads=P, batch=BIG, sched=sched, order=order))
            cfgs.append(c("omp1", threads=P, batch=Q, sched=sched, order=order))  # 对照：只有一个 batch
        cfgs.append(c("omp2", threads=P, batch=BIG, grain=GRAIN[BIG], order=order))
        cfgs.append(c("omp2", threads=P, batch=Q, grain=GRAIN[BIG], order=order))
    return cfgs


def exp_C():  # 任务大小
    cfgs = []
    for b in (1, BIG):
        for g in (64, 128, 256, 1024, 4096):
            cfgs.append(c("omp2", threads=P, batch=b, grain=g))
    cfgs.append(c("omp3", threads=P, batch=1, grain=256, queries=128))  # critical 对照（慢）
    cfgs.append(c("omp2", threads=P, batch=1, grain=256, queries=128))  # 同条件下的 omp2
    return cfgs


def exp_C_cutoff():  # batch=1 时小查询直接计算的阈值
    return [c("omp2", threads=P, batch=1, grain=GRAIN[1], cutoff=t)
            for t in (0, 512, 1024, 2048, 4096)]


def exp_D():  # 搜索范围
    cfgs = []
    for np_ in (1, 2, 4, 8, 16, 32, 64):
        cfgs.append(c("serial", batch=BIG, nprobe=np_))
        cfgs.append(c("omp1", threads=P, batch=BIG, nprobe=np_, sched=SCHED1))
    return cfgs


def exp_E():  # SIMD：距离 × 线程数 × ISA（ISA 通过二进制区分）
    cfgs = []
    for binary in ("./ivf_lab", "./ivf_lab_native"):
        for p in (1, P):
            for np_ in (8, 32):
                for d in ("scalar", "f32", "simd64", "simd32"):
                    cfgs.append(c("omp1", threads=p, batch=BIG, sched=SCHED1, dist=d,
                                  nprobe=np_, bin=binary))
    return cfgs


def exp_F():  # std::thread 与 omp1-static（相同划分）
    cfgs = []
    for b in (16, BIG, 256):
        cfgs.append(c("std", threads=P, batch=b))
        cfgs.append(c("omp1", threads=P, batch=b, sched="static"))
    return cfgs


# ---------------- 服务器对照（实验名以 S 开头；见 实验计划_服务器对照.md） ----------------
def exp_S1():  # 确定 P：只受计算限制、数据在缓存内（nprobe=1，中心选择占 93%，2 MB 中心常驻缓存）
    cfgs = [c("serial", batch=128, nprobe=1)]
    for p in (8, 16, 24, 32):
        cfgs.append(c("omp1", threads=p, batch=128, nprobe=1, sched=SCHED1))
    return cfgs


def exp_S2():  # 实验 A 复现（H1、H2）
    cfgs = [c("serial", batch=b) for b in (1, BIG)]
    for p in THREADS:
        cfgs.append(c("omp1", threads=p, batch=BIG, sched=SCHED1))
        cfgs.append(c("omp2", threads=p, batch=BIG, grain=GRAIN[BIG]))
    for p in [t for t in THREADS if t <= 16]:
        cfgs.append(c("omp2", threads=p, batch=1, grain=GRAIN[1]))
        cfgs.append(c("omp2", threads=p, batch=1, grain=GRAIN[1], coarse="split"))
    for policy in ("", "OMP_WAIT_POLICY=passive"):  # H2：每查询只有 1 个任务时的墙钟
        cfgs.append(c("omp2", threads=16, batch=1, grain=4096, env=policy))
    return cfgs


def exp_S4():  # SIMD × ISA（含 AVX-512 偏好），区组设计（H4、H6）
    cfgs = []
    for binary in ("./ivf_lab", "./ivf_lab_native", "./ivf_lab_native512"):
        for p in (1, P):
            for np_ in (8, 32):
                for d in ("scalar", "f32", "simd32"):
                    cfgs.append(c("omp1", threads=p, batch=BIG, sched=SCHED1, dist=d,
                                  nprobe=np_, bin=binary))
    return cfgs


def exp_S5():  # 实验 B 子集（H3）
    cfgs = []
    for order in ("orig", "asc"):
        cfgs.append(c("serial", batch=BIG, order=order))
        for sched in ("static", SCHED1):
            for b in (BIG, Q):
                cfgs.append(c("omp1", threads=P, batch=b, sched=sched, order=order))
    return cfgs


def exp_S6():  # 实验 F 复现（H5）
    cfgs = []
    for b in (16, 64, 256):
        cfgs.append(c("std", threads=P, batch=b))
        cfgs.append(c("omp1", threads=P, batch=b, sched="static"))
    return cfgs


# 区组设计：同一组（除 dist 外其他参数相同）的配置背靠背运行，组内比值抵消机器状态的缓慢漂移。
# 首次 E 运行中，第 2 轮几乎所有配置系统性偏慢（轮间差 10–75%），因此 E 改用区组设计重测。
BLOCK_KEYS = {"E_blocked": ("bin", "threads", "nprobe"), "S4_blocked": ("bin", "threads", "nprobe")}


def exp_E_blocked():
    return exp_E()


EXPERIMENTS = {"A": exp_A, "E_blocked": exp_E_blocked, "A_sched": exp_A_sched, "A_wait": exp_A_wait, "B": exp_B, "C": exp_C,
               "C_cutoff": exp_C_cutoff, "D": exp_D, "E": exp_E, "F": exp_F,
               "S1": exp_S1, "S2": exp_S2, "S4_blocked": exp_S4, "S5": exp_S5, "S6": exp_S6}


def runnable_others():
    """共享服务器的负载门控：/proc/loadavg 第 4 列是此刻可运行的调度实体数（含采样进程自己）。
    取 5 次采样（间隔 0.2 s）的中位数减 1。不用 load1：本实验自己的 p=16 进程跑几秒就会把
    load1 抬高约 1.3，用它做门控会等自己的残留负载衰减。"""
    samples, load1 = [], 0.0
    for _ in range(5):
        with open("/proc/loadavg") as f:
            parts = f.read().split()
        load1 = float(parts[0])
        samples.append(int(parts[3].split("/")[0]) - 1)
        time.sleep(0.2)
    samples.sort()
    return samples[2], load1


def wait_for_quiet(max_busy, max_wait=600.0):
    busy, load1 = runnable_others()
    waited = 0.0
    while max_busy is not None and busy > max_busy:
        if waited >= max_wait:
            raise SystemExit(f"负载门控：其他用户的可运行进程持续 > {max_busy}（当前 {busy}，load1={load1}），"
                             f"已等待 {waited:.0f} s，暂停实验")
        time.sleep(15)
        waited += 15
        busy, load1 = runnable_others()
    return busy, load1, waited


def to_args(cfg):
    args = []
    for key, value in cfg.items():
        if key in ("bin", "env"):
            continue
        args += [f"--{key}", str(value)]
    return args


def run(cfg, tmp_csv):
    binary = cfg.get("bin", "./ivf_lab")
    cmd = [binary, *DATA_ARGS, *to_args(cfg), "--csv", tmp_csv]
    env = dict(os.environ)
    for item in filter(None, cfg.get("env", "").split(";")):  # 形如 "OMP_WAIT_POLICY=passive;X=1"
        key, value = item.split("=", 1)
        env[key] = value
    proc = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True, env=env)
    if proc.returncode != 0:
        sys.stderr.write(proc.stdout + proc.stderr)
        raise SystemExit(f"运行失败：{' '.join(cmd)}")
    with open(tmp_csv, newline="") as f:
        rows = list(csv.DictReader(f))
    return rows, proc.stdout


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("exp", choices=[*EXPERIMENTS, "list"])
    ap.add_argument("--rounds", type=int, default=1)
    ap.add_argument("--repeats", type=int, default=10)
    ap.add_argument("--append", action="store_true")
    ap.add_argument("--seed", type=int, default=2026)
    ap.add_argument("--max-busy", type=int, default=None,
                    help="其他用户可运行进程数的上限，超过则等待（默认不门控）")
    args = ap.parse_args()
    if args.exp == "list":
        for name, fn in EXPERIMENTS.items():
            print(f"{name}: {len(fn())} 个配置")
        return
    cfgs = EXPERIMENTS[args.exp]()
    os.makedirs(os.path.join(ROOT, RESULTS), exist_ok=True)
    out_path = os.path.join(ROOT, RESULTS, f"{args.exp}.csv")
    tmp_csv = os.path.join(ROOT, RESULTS, f".tmp_{args.exp}.csv")
    rng = random.Random(args.seed)
    writer, out = None, None
    mode = "a" if args.append and os.path.exists(out_path) else "w"
    start = time.time()
    try:
        out = open(out_path, mode, newline="")
        for r in range(1, args.rounds + 1):
            if args.exp in BLOCK_KEYS:  # 组间随机、组内随机，同组背靠背
                keys = BLOCK_KEYS[args.exp]
                groups = {}
                for cfg in cfgs:
                    groups.setdefault(tuple(cfg.get(k) for k in keys), []).append(cfg)
                blocks = list(groups.values())
                rng.shuffle(blocks)
                order = []
                for block in blocks:
                    block = block[:]
                    rng.shuffle(block)
                    order += block
            else:
                order = cfgs[:]
                rng.shuffle(order)
            for i, cfg in enumerate(order, 1):
                cfg = dict(cfg, repeats=args.repeats)
                busy, load1, waited = wait_for_quiet(args.max_busy)
                rows, stdout = run(cfg, tmp_csv)
                for row in rows:
                    row.update(exp=args.exp, round=r, bin=cfg.get("bin", "./ivf_lab"),
                               env=cfg.get("env", ""), busy_others=busy, load1=load1,
                               wait_s=waited)
                    if writer is None:
                        writer = csv.DictWriter(out, fieldnames=list(row))
                        if mode == "w":
                            writer.writeheader()
                    writer.writerow(row)
                out.flush()
                summary = stdout.strip().splitlines()[-2]
                print(f"[{args.exp} r{r} {i}/{len(order)} {time.time() - start:6.0f}s "
                      f"busy={busy} load1={load1:.2f} wait={waited:.0f}s] "
                      f"{cfg.get('env', '')} {' '.join(to_args(cfg))} | {summary}", flush=True)
    finally:
        if out:
            out.close()
        if os.path.exists(tmp_csv):
            os.remove(tmp_csv)


if __name__ == "__main__":
    main()
