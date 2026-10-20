#!/usr/bin/env python3
"""实验网格运行器。

用法：python scripts/bench.py <实验名> [--rounds N]
实验名：bind e1 e2 e3 e4 e5 e6 e7（含义见 lab1/实验计划.md §4）

公平性约定：
  - 每个策略单独一个进程（--only），避免同一进程内后跑的策略因芯片升温吃亏；
  - 每轮轮换策略顺序，共跑 rounds 轮；每个进程内重复 10 次取中位数（首次调用为 warm-up）；
  - 所有策略共用同一个二进制、同一套编译选项。
结果写入 results/<实验名>.csv（每个进程一行，含 round 列，汇总在 plot.py 中完成）。
"""
import argparse
import csv
import io
import os
import random
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BIN = ROOT / "csr_spmv_lab"
TRACE_BIN = ROOT / "build" / "csr_spmv_lab_trace"
RESULTS = ROOT / "results"

# 线程绑定：由 bind 实验决定，见 实验日志.md
BASE_ENV = {"OMP_PROC_BIND": "close", "OMP_PLACES": "cores"}

CONFIGS = {
    "A": [],  # 默认：32 条 20000 长行，nnz≈0.96M，约 11.5MB，落在 L3 内
    "B": ["--rows", "20000", "--cols", "200000", "--normal-nnz", "16",
          "--long-rows", "16", "--long-nnz", "80000"],  # README：长行占 80%
    "C": ["--cols", "200000", "--long-rows", "1", "--long-nnz", "100000"],  # 单条极长行，W/L=4.2
}
THREADS = [1, 2, 4, 8, 12, 16, 20, 24]
ALL = ["serial", "thread", "omp1", "omp2", "omp3"]


def run_one(strategy, args, threads, env_extra=None, repeats=10, binary=BIN):
    env = dict(os.environ)
    env.update(BASE_ENV)
    if env_extra is not None:
        for key, value in env_extra.items():
            if value is None:
                env.pop(key, None)
            else:
                env[key] = value
    cmd = [str(binary), *args, "--threads", str(threads), "--only", strategy,
           "--repeats", str(repeats), "--csv"]
    proc = subprocess.run(cmd, capture_output=True, text=True, env=env)
    if proc.returncode != 0:
        sys.exit(f"运行失败：{' '.join(cmd)}\n{proc.stderr}")
    return proc.stdout


def parse_rows(stdout):
    lines = [line for line in stdout.splitlines() if not line.startswith("trace,")]
    return list(csv.DictReader(io.StringIO("\n".join(lines))))


def sweep(points, strategies, rounds):
    """points: [(标签字典, 矩阵参数, 线程数, 额外环境变量[, 该点专用的策略列表])]。

    每轮把全部"配置点 × 策略"任务用固定种子随机打乱后执行：笔记本的睿频与温度会随
    时间漂移（例如串行若排在一长串 24 线程满载运行之后，会因芯片升温被测慢约 20%），
    打乱顺序让这种漂移均匀摊到所有策略上，而不是系统性地偏向某一个。
    """
    jobs = [(point, strategy) for point in points
            for strategy in (point[4] if len(point) > 4 else strategies)]
    rows = []
    for rnd in range(rounds):
        order = list(jobs)
        random.Random(1000 + rnd).shuffle(order)
        for (labels, args, threads, env_extra, *_), strategy in order:
            for row in parse_rows(run_one(strategy, args, threads, env_extra)):
                row.update(labels)
                row["round"] = rnd
                rows.append(row)
        print(f"  第 {rnd + 1}/{rounds} 轮完成（每轮 {len(jobs)} 个进程）", flush=True)
    return rows


def save(name, rows):
    RESULTS.mkdir(exist_ok=True)
    path = RESULTS / f"{name}.csv"
    keys = []
    for row in rows:
        for key in row:
            if key not in keys:
                keys.append(key)
    with path.open("w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=keys)
        writer.writeheader()
        writer.writerows(rows)
    print(f"已写入 {path.relative_to(ROOT)}（{len(rows)} 行）")


# ---------------------------------------------------------------- 各实验定义

def exp_bind(rounds):
    """线程绑定方式探测：决定后续实验统一使用的 OMP_PROC_BIND/OMP_PLACES。"""
    variants = {
        "unbound": {"OMP_PROC_BIND": None, "OMP_PLACES": None},
        "close/cores": {"OMP_PROC_BIND": "close", "OMP_PLACES": "cores"},
        "close/threads": {"OMP_PROC_BIND": "close", "OMP_PLACES": "threads"},
        "spread/threads": {"OMP_PROC_BIND": "spread", "OMP_PLACES": "threads"},
    }
    points = [({"config": "B", "bind": name}, CONFIGS["B"], p, env)
              for name, env in variants.items() for p in (8, 16, 24)]
    return sweep(points, ["omp1", "omp2", "omp3"], rounds)


def exp_wait(rounds):
    """CP1 决定的对照：等待策略能否消除 p=24 的进程级双峰。

    libgomp 默认先自旋一段时间再休眠；active 一直自旋；passive 立即休眠让出 CPU。
    若双峰源于"OpenMP 线程占满 vCPU、后台进程抢时间片"，passive 应能显著缓解。
    """
    policies = {"default": {"OMP_WAIT_POLICY": None}, "active": {"OMP_WAIT_POLICY": "ACTIVE"},
                "passive": {"OMP_WAIT_POLICY": "PASSIVE"}}
    points = [({"config": c, "wait": name}, CONFIGS[c], p, env)
              for c in ("A", "B") for name, env in policies.items() for p in (16, 20, 24)]
    return sweep(points, ["omp1", "omp2", "omp3"], rounds)


def exp_e1(rounds):
    """线程扩展性：配置 A、B，p = 1..24。"""
    points = [({"config": c}, CONFIGS[c], p, None) for c in ("A", "B") for p in THREADS]
    # 串行与线程数无关，每个配置只需一个点，但要和其它任务混在同一轮里随机排序
    points += [({"config": c}, CONFIGS[c], 1, None, ["serial"]) for c in ("A", "B")]
    return sweep(points, ["thread", "omp1", "omp2", "omp3"], rounds)


def exp_e2(rounds):
    """偏斜扫描：单条长行，长度从 2.5k 到 160k，p=16，检验 min(p, W/L) 上界。"""
    base = ["--rows", "10000", "--cols", "200000", "--normal-nnz", "32", "--long-rows", "1"]
    points = [({"long_nnz_label": L}, base + ["--long-nnz", str(L)], 16, None)
              for L in (2500, 5000, 10000, 20000, 40000, 80000, 160000)]
    return sweep(points, ALL, rounds)


def exp_e3(rounds):
    """按行切分的调度消融：配置 B，p=16。"""
    scheds = [("static", 0)] + [(kind, c) for kind in ("static", "dynamic", "guided")
                                for c in (1, 16, 64, 256, 1024)]
    points = [({"config": "B"}, CONFIGS["B"] + ["--sched", k, "--chunk", str(c)], 16, None)
              for k, c in scheds]
    return sweep(points, ["omp1"], rounds)


def exp_e4(rounds):
    """规模扫描：长行比例不变（每 312 行 1 条 20000 长行），rows 1e3 → 3e5。"""
    points = []
    for rows in (1000, 3000, 10000, 30000, 100000, 300000):
        args = ["--rows", str(rows), "--cols", "100000", "--normal-nnz", "32",
                "--long-rows", str(max(1, rows // 312)), "--long-nnz", "20000"]
        points.append(({"rows_label": rows}, args, 16, None))
    return sweep(points, ALL, rounds)


def exp_e5(rounds):
    """种子鲁棒性：配置 A，20 个种子，p=8/16。"""
    points = [({"config": "A", "cell": "default"}, ["--seed", str(seed)], p, None)
              for seed in range(1, 21) for p in (8, 16)]
    # std::thread 的时间被每次创建线程的开销（约 0.4 ms）主导，看不出分块不均的影响；
    # 用分块方式完全相同、但没有创建开销的 omp1 static 作为"按行×静态"格子的对照
    points += [({"config": "A", "cell": "row-static"},
                ["--seed", str(seed), "--sched", "static", "--chunk", "0"], p, None, ["omp1"])
               for seed in range(1, 21) for p in (8, 16)]
    return sweep(points, ["thread", "omp1", "omp2", "omp3"], rounds)


def exp_e7(rounds):
    """student_3 块大小消融：配置 B，p=16。"""
    points = [({"config": "B"}, CONFIGS["B"] + ["--nnz-chunk", str(c)], 16, None)
              for c in (256, 1024, 4096, 16384, 65536, 262144, 1048576)]
    return sweep(points, ["omp3"], rounds)


def exp_e6(rounds):
    """每线程时间线：TRACE 构建，配置 B，p=16/20（CP1：主结论只取到 p=20），四种策略格子。"""
    rows = []
    for rnd in range(rounds):
        for p in (16, 20):
            for strategy, extra in (("omp1", ["--sched", "static", "--chunk", "0"]),
                                    ("omp1", ["--sched", "dynamic", "--chunk", "64"]),
                                    ("omp2", []), ("omp3", [])):
                out = run_one(strategy, CONFIGS["B"] + extra, p, binary=TRACE_BIN)
                cell = f"{strategy}:{extra[1] if extra else ''}"
                for line in out.splitlines():
                    if line.startswith("trace,"):
                        _, key, tid, cpu, begin, end, nnz = line.split(",")
                        rows.append({"cell": cell, "threads": p, "round": rnd, "tid": tid,
                                     "cpu": cpu, "begin_us": begin, "end_us": end,
                                     "nnz": nnz})
        print(f"  第 {rnd + 1}/{rounds} 轮完成", flush=True)
    return rows


EXPERIMENTS = {"bind": exp_bind, "wait": exp_wait, "e1": exp_e1, "e2": exp_e2, "e3": exp_e3, "e4": exp_e4,
               "e5": exp_e5, "e6": exp_e6, "e7": exp_e7}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("experiment", choices=sorted(EXPERIMENTS))
    parser.add_argument("--rounds", type=int, default=3)
    args = parser.parse_args()
    print(f"运行 {args.experiment}，{args.rounds} 轮，绑定 {BASE_ENV}")
    save(args.experiment, EXPERIMENTS[args.experiment](args.rounds))


if __name__ == "__main__":
    main()
