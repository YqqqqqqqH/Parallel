#!/usr/bin/env python3
"""差分法 perf stat：用 repeats=R_LO 和 R_HI 两次运行的计数之差，得到单次 SpMV 的计数。

动机：PDF 示例命令会把矩阵生成、参考解计算、warm-up 也计入计数器；对较大矩阵来说，
这些固定开销甚至比 SpMV 本身还大。两次运行只差在核心循环的重复次数，相减后固定开销正好抵消：
    单次计数 = (C(R_HI) − C(R_LO)) / (R_HI − R_LO)

用法：
    python scripts/perf_diff.py probe          # 探测本机可用的事件
    python scripts/perf_diff.py run            # 主对比：serial / thread / omp1 static / omp3
    python scripts/perf_diff.py wait           # 补充：OMP_WAIT_POLICY active vs passive（p=20）
    python scripts/perf_diff.py p24            # 检验 p=24 双峰：逐进程的上下文切换次数
需要 kernel.perf_event_paranoid ≤ 1，否则 context-switches / cpu-migrations 恒为 0。
结果写入 results/perf_<名称>.csv，原始 perf 输出存于 results/perf_raw/。
"""
import csv
import glob
import os
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BIN = ROOT / "csr_spmv_lab"
RAW = ROOT / "results" / "perf_raw"
R_LO, R_HI = 20, 220
PERF_REPEATS = 5

CONFIG_B = ["--rows", "20000", "--cols", "200000", "--normal-nnz", "16",
            "--long-rows", "16", "--long-nnz", "80000"]
BASE_ENV = {"OMP_PROC_BIND": "close", "OMP_PLACES": "cores"}
SW_EVENTS = ["task-clock", "user_time", "system_time", "context-switches", "cpu-migrations",
             "page-faults"]
HW_EVENTS = ["cycles", "instructions", "cache-references", "cache-misses", "branch-misses"]


def find_perf():
    """WSL 内核没有对应的 linux-tools 包，/usr/bin/perf 包装脚本会拒绝运行，直接用 generic 版本。"""
    if os.environ.get("PERF"):
        return os.environ["PERF"]
    candidates = sorted(glob.glob("/usr/lib/linux-tools/*/perf"))
    if candidates:
        return candidates[-1]
    found = shutil.which("perf")
    if found:
        return found
    sys.exit("找不到 perf：请先执行 sudo apt-get install -y linux-tools-common linux-tools-generic")


def perf_stat(perf, events, args, env_extra, tag):
    env = dict(os.environ)
    env.update(BASE_ENV)
    env.update(env_extra or {})
    RAW.mkdir(parents=True, exist_ok=True)
    out = RAW / f"{tag}.txt"
    cmd = [perf, "stat", "-x", ",", "-r", str(PERF_REPEATS), "-o", str(out),
           "-e", ",".join(events), str(BIN), *args]
    proc = subprocess.run(cmd, capture_output=True, text=True, env=env)
    if proc.returncode != 0:
        sys.exit(f"perf 运行失败：{' '.join(cmd)}\n{proc.stderr}")
    # perf 拿不到 duration_time（受 perf_event_paranoid 限制），墙钟时间用程序自己的计时：
    # -r 次运行的 stdout 首尾相接，每次都是"表头 + 一行数据"，取各次 mean_ms 的平均
    lines = proc.stdout.splitlines()
    header = lines[0].split(",")
    walls = [float(next(csv.reader([l]))[header.index("mean_ms")])
             for l in lines if not l.startswith("strategy,")]
    counts = {"wall_ms_per_call": sum(walls) / len(walls)}
    for line in out.read_text().splitlines():
        if not line or line.startswith("#"):
            continue
        fields = line.split(",")
        value, unit, event = fields[0], fields[1], fields[2].split(":")[0]
        if value.startswith("<"):
            counts[event] = None
        else:
            counts[event] = float(value) / 1e6 if unit == "ns" else float(value)  # ns → ms
    return counts


def probe(perf):
    print(f"perf: {perf}")
    subprocess.run([perf, "--version"])
    for ev in SW_EVENTS + HW_EVENTS:
        proc = subprocess.run([perf, "stat", "-x", ",", "-e", ev, "true"],
                              capture_output=True, text=True)
        line = [l for l in proc.stderr.splitlines() if ev in l]
        status = line[0].split(",")[0] if line else proc.stderr.strip()[:80]
        print(f"  {ev:18s} -> {status}")


def available_events(perf):
    events = list(SW_EVENTS)
    for ev in HW_EVENTS:
        proc = subprocess.run([perf, "stat", "-x", ",", "-e", ev, "true"],
                              capture_output=True, text=True)
        line = [l for l in proc.stderr.splitlines() if ev in l]
        if line and not line[0].split(",")[0].startswith("<"):
            events.append(ev)
    return events


def diff_runs(perf, events, name, cases, threads):
    rows = []
    for label, strategy, extra, env_extra in cases:
        base = CONFIG_B + ["--threads", str(threads), "--only", strategy, "--csv", *extra]
        lo = perf_stat(perf, events, base + ["--repeats", str(R_LO)], env_extra,
                       f"{name}_{label}_R{R_LO}")
        hi = perf_stat(perf, events, base + ["--repeats", str(R_HI)], env_extra,
                       f"{name}_{label}_R{R_HI}")
        row = {"case": label, "strategy": strategy, "threads": threads,
               "wall_ms_per_call": hi["wall_ms_per_call"]}
        for ev in events:
            if lo.get(ev) is None or hi.get(ev) is None:
                row[ev] = ""
                continue
            row[ev] = (hi[ev] - lo[ev]) / (R_HI - R_LO)
            row[f"{ev}_fixed"] = lo[ev] - row[ev] * R_LO  # 与 SpMV 无关的固定部分
        if row.get("task-clock") not in ("", None):
            row["cpu_per_wall"] = row["task-clock"] / row["wall_ms_per_call"]
        rows.append(row)
        print(f"  {label:14s} wall={row['wall_ms_per_call']:.3f}ms " + "  ".join(
            f"{ev}={row[ev]:.4g}" for ev in events if row[ev] != ""), flush=True)
    path = ROOT / "results" / f"perf_{name}.csv"
    keys = list(dict.fromkeys(k for r in rows for k in r))
    with path.open("w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=keys)
        writer.writeheader()
        writer.writerows(rows)
    print(f"已写入 {path.relative_to(ROOT)}")


def p24_runs(perf, runs=10, repeats=200):
    """检验 p=24 双峰假设：逐进程记录中位数时间与上下文切换 / 迁移次数（不做差分，看单次运行）。

    假设成立的话，"慢进程"的上下文切换应显著多于"快进程"：OpenMP 线程占满全部 vCPU 时，
    后台进程只能抢占某个自旋中的工作线程，整个并行区被拖慢。
    """
    events = ["task-clock", "context-switches", "cpu-migrations"]
    rows = []
    for threads in (20, 24):
        for i in range(runs):
            env = dict(os.environ)
            env.update(BASE_ENV)
            RAW.mkdir(parents=True, exist_ok=True)
            out = RAW / f"p24_p{threads}_run{i}.txt"
            cmd = [perf, "stat", "-x", ",", "-o", str(out), "-e", ",".join(events), str(BIN),
                   *CONFIG_B, "--threads", str(threads), "--only", "omp3", "--csv",
                   "--repeats", str(repeats)]
            proc = subprocess.run(cmd, capture_output=True, text=True, env=env)
            if proc.returncode != 0:
                sys.exit(f"perf 运行失败：{' '.join(cmd)}\n{proc.stderr}")
            data = next(csv.DictReader(proc.stdout.splitlines()))
            row = {"threads": threads, "run": i, "median_ms": float(data["median_ms"]),
                   "max_ms": float(data["max_ms"])}
            for line in out.read_text().splitlines():
                if line and not line.startswith("#"):
                    fields = line.split(",")
                    row[fields[2].split(":")[0]] = float(fields[0])
            rows.append(row)
            print(f"  p={threads} run{i}: median={row['median_ms']:.3f} ms  "
                  f"cs={row['context-switches']:.0f}  mig={row['cpu-migrations']:.0f}",
                  flush=True)
    path = ROOT / "results" / "perf_p24.csv"
    with path.open("w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)
    print(f"已写入 {path.relative_to(ROOT)}")


def main():
    mode = sys.argv[1] if len(sys.argv) > 1 else "run"
    perf = find_perf()
    if mode == "probe":
        probe(perf)
        return
    if mode == "p24":
        p24_runs(perf)
        return
    events = available_events(perf)
    print(f"使用事件：{events}")
    if mode == "run":
        cases = [("serial", "serial", [], None),
                 ("thread", "thread", [], None),
                 ("omp1-static", "omp1", ["--sched", "static", "--chunk", "0"], None),
                 ("omp3", "omp3", [], None)]
        diff_runs(perf, events, "main", cases, threads=16)
    elif mode == "wait":
        cases = [("omp3-active", "omp3", [], {"OMP_WAIT_POLICY": "ACTIVE"}),
                 ("omp3-passive", "omp3", [], {"OMP_WAIT_POLICY": "PASSIVE"})]
        diff_runs(perf, events, "wait", cases, threads=20)
    else:
        sys.exit(f"未知模式：{mode}")


if __name__ == "__main__":
    main()
