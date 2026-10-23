#!/usr/bin/env python3
"""直接测量 E2 中"按行切分实测 ≈ 0.61 × W/L"的来源（原先只是推断）。

对 OpenMP 1（按行 / dynamic,64），完成时间由处理长行的线程决定。实测比值可以严格分解为三个因子：
    (T1 / makespan) / (W / L)
      = (该线程速度 / 串行速度)     ← 速度因子：线程比串行慢多少
      × (L / 该线程处理的 nnz)      ← 长行占比：它在长行之外还顺带做了多少普通行
      × (该线程忙碌时间 / makespan) ← 忙碌占比：通常接近 1
三个量都由 TRACE 构建直接读出。串行速度取同一进程内 spmv_serial 的中位数。

用法：python scripts/long_row_probe.py [--runs 10]  → results/long_row_probe.csv
"""
import argparse
import csv
import io
import os
import statistics
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TRACE_BIN = ROOT / "build" / "csr_spmv_lab_trace"
BASE = ["--rows", "10000", "--cols", "200000", "--normal-nnz", "32", "--long-rows", "1"]
ENV = {"OMP_PROC_BIND": "close", "OMP_PLACES": "cores"}


def one_run(L, threads):
    env = dict(os.environ, **ENV)
    cmd = [str(TRACE_BIN), *BASE, "--long-nnz", str(L), "--threads", str(threads),
           "--only", "serial,omp1", "--repeats", "10", "--csv"]
    out = subprocess.run(cmd, capture_output=True, text=True, env=env, check=True).stdout
    lines = out.splitlines()
    rows = {r["strategy"]: r for r in csv.DictReader(
        io.StringIO("\n".join(l for l in lines if not l.startswith("trace,"))))}
    trace = [l.split(",") for l in lines if l.startswith("trace,omp1,")]
    W = int(rows["serial"]["nnz"])
    serial_rate = W / (float(rows["serial"]["median_ms"]) * 1e3)  # nnz/µs
    th = [dict(begin=float(t[4]), end=float(t[5]), nnz=int(t[6])) for t in trace]
    makespan = max(t["end"] for t in th) - min(t["begin"] for t in th)
    long_t = max(th, key=lambda t: t["nnz"])                   # 处理了长行的线程
    busy = long_t["end"] - long_t["begin"]
    rate_long = long_t["nnz"] / busy
    others = [t["nnz"] / (t["end"] - t["begin"]) for t in th
              if t is not long_t and t["end"] > t["begin"]]
    speed_f = rate_long / serial_rate
    share_f = L / long_t["nnz"]
    busy_f = busy / makespan
    t1_ms = float(rows["serial"]["median_ms"])
    omp1_ms = float(rows["omp1"]["median_ms"])
    return dict(L=L, threads=threads, W=W, serial_rate=serial_rate, makespan_us=makespan,
                omp1_median_us=omp1_ms * 1e3,
                # 与 E2 相同的墙钟口径：含 fork/join 与屏障，取 10 次重复的中位数
                wall_ratio=(t1_ms / omp1_ms) / (W / L),
                long_thread_nnz=long_t["nnz"], long_thread_rate=rate_long,
                others_mean_rate=statistics.mean(others),
                # 由 TRACE 得到的口径：只看最后一次调用、并行区内部的完成时间
                measured_ratio=(W / serial_rate / makespan) / (W / L),
                speed_factor=speed_f, share_factor=share_f, busy_factor=busy_f,
                product=speed_f * share_f * busy_f,
                long_is_last=long_t["end"] == max(t["end"] for t in th))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--runs", type=int, default=10)
    args = ap.parse_args()
    rows = [one_run(L, 16) for _ in range(args.runs) for L in (40000, 80000, 160000)]
    path = ROOT / "results" / "long_row_probe.csv"
    with path.open("w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0]))
        w.writeheader()
        w.writerows(rows)
    print(f"已写入 {path.relative_to(ROOT)}（{len(rows)} 行）\n")
    keys = ["wall_ratio", "measured_ratio", "speed_factor", "share_factor", "busy_factor", "product",
            "long_thread_rate", "others_mean_rate", "serial_rate"]
    print("各 L 下的中位数（10 次运行）：")
    print(f"{'L':>7} " + " ".join(f"{k:>16}" for k in keys) + "  长行线程最后结束")
    for L in (40000, 80000, 160000):
        g = [r for r in rows if r["L"] == L]
        print(f"{L:>7} " + " ".join(f"{statistics.median(r[k] for r in g):>16.3f}" for k in keys)
              + f"  {sum(r['long_is_last'] for r in g)}/{len(g)}")


if __name__ == "__main__":
    main()
