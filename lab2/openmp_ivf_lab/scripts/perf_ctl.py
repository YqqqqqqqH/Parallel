#!/usr/bin/env python3
"""perf 测量：只统计检索部分。

做法：perf stat --delay=-1 --control fifo:CTL,ACK 启动时计数器关闭；ivf_lab --perf-ctl CTL,ACK
在加载数据、计算参考结果、预热之后发 enable 并等待 ack，10 次正式重复结束后发 disable。
计数窗口 = 10 次重复（含每次重复前填充输出和重复后的 check_result，二者为 O(Q·k)，可忽略）。
计数默认继承到子线程（OpenMP 工作线程、std::thread 新建线程都会被统计）。

换算：
  CPU 利用率 = task-clock / Σ检索墙钟时间（墙钟取程序自己 CSV 中 10 次 time_ms 之和）
  每查询 task-clock、每次调用的上下文切换 / 迁移 / 缺页
不支持的硬件事件（WSL2 不暴露 PMU）照原样记录为 <not supported>。

用法：python -I scripts/perf_ctl.py [--rounds 3]
"""
import argparse
import csv
import os
import subprocess
import sys
import tempfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from bench import DATA_ARGS, GRAIN, SCHED1  # noqa: E402

PERF = "/usr/lib/linux-tools/6.8.0-147-generic/perf"
EVENTS = ["task-clock", "context-switches", "cpu-migrations", "page-faults",
          "cycles", "instructions", "cache-misses", "branch-misses"]
Q, P, BIG = 1024, 16, 64

CONFIGS = [
    ("serial", dict(only="serial", batch=BIG), ""),
    ("omp1", dict(only="omp1", threads=P, batch=BIG, sched=SCHED1), ""),
    ("omp2", dict(only="omp2", threads=P, batch=BIG, grain=GRAIN[BIG]), ""),
    ("std", dict(only="std", threads=P, batch=BIG), ""),
    ("omp1_static", dict(only="omp1", threads=P, batch=BIG, sched="static"), ""),
    ("omp2_b1", dict(only="omp2", threads=P, batch=1, grain=GRAIN[1]), ""),
    ("omp2_b1_passive", dict(only="omp2", threads=P, batch=1, grain=GRAIN[1]),
     "OMP_WAIT_POLICY=passive"),
]


def run(name, cfg, env_str, rnd, raw_dir, fifo_dir):
    ctl, ack = os.path.join(fifo_dir, "ctl"), os.path.join(fifo_dir, "ack")
    for f in (ctl, ack):
        if os.path.exists(f):
            os.remove(f)
        os.mkfifo(f)
    out_csv = os.path.join(raw_dir, f"{name}_r{rnd}.timing.csv")
    perf_out = os.path.join(raw_dir, f"{name}_r{rnd}.perf.txt")
    args = []
    for k, v in dict(cfg, queries=Q, repeats=10).items():
        args += [f"--{k}", str(v)]
    cmd = [PERF, "stat", "-x", ",", "-o", perf_out, "--delay=-1",
           "--control", f"fifo:{ctl},{ack}", "-e", ",".join(EVENTS),
           "./ivf_lab", *DATA_ARGS, *args, "--csv", out_csv, "--perf-ctl", f"{ctl},{ack}"]
    env = dict(os.environ)
    for item in filter(None, env_str.split(";")):
        k, v = item.split("=", 1)
        env[k] = v
    proc = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True, env=env)
    if proc.returncode != 0:
        sys.stderr.write(proc.stdout + proc.stderr)
        raise SystemExit(f"perf 运行失败：{name}")
    with open(out_csv) as f:
        rows = list(csv.DictReader(f))
    wall_ms = sum(float(r["time_ms"]) for r in rows)
    calls = len(rows) * -(-Q // int(cfg["batch"]))
    counts = {}
    with open(perf_out) as f:
        for line in f:
            parts = line.strip().split(",")
            if len(parts) < 3 or line.startswith("#"):
                continue
            value, event = parts[0], parts[2].split(":")[0]
            counts[event] = value
    rec = dict(config=name, env=env_str, round=rnd, wall_ms=round(wall_ms, 3), calls=calls,
               queries=Q * len(rows))
    for e in EVENTS:
        rec[e] = counts.get(e, "missing")
    try:
        tc = float(rec["task-clock"])  # 单位 msec
        rec["cpu_util"] = round(tc / wall_ms, 3)
        rec["task_clock_us_per_query"] = round(tc * 1000 / rec["queries"], 2)
        for e in ("context-switches", "cpu-migrations", "page-faults"):
            rec[f"{e}_per_call"] = round(float(rec[e]) / calls, 4)
    except ValueError:
        pass
    return rec


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--rounds", type=int, default=3)
    args = ap.parse_args()
    raw_dir = os.path.join(ROOT, "results", "perf_raw")
    os.makedirs(raw_dir, exist_ok=True)
    with open("/proc/sys/kernel/perf_event_paranoid") as f:
        paranoid = f.read().strip()
    print(f"perf_event_paranoid={paranoid}")
    records = []
    with tempfile.TemporaryDirectory() as fifo_dir:
        for rnd in range(1, args.rounds + 1):
            for name, cfg, env in CONFIGS:
                rec = run(name, cfg, env, rnd, raw_dir, fifo_dir)
                rec["paranoid"] = paranoid
                records.append(rec)
                print({k: rec[k] for k in ("config", "round", "wall_ms", "cpu_util",
                                           "task_clock_us_per_query", "context-switches_per_call",
                                           "page-faults_per_call", "cycles") if k in rec}, flush=True)
    out = os.path.join(ROOT, "results", "perf_main.csv")
    fields = sorted({k for r in records for k in r}, key=lambda k: list(records[0]).index(k)
                    if k in records[0] else 999)
    with open(out, "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=fields)
        w.writeheader()
        w.writerows(records)
    print(f"写入 {out}")


if __name__ == "__main__":
    main()
