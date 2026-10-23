#!/usr/bin/env python3
"""GOMP_SPINCOUNT 折中实验：能否让 p=24 既不被抢占拖垮（ACTIVE 的问题），又不付唤醒代价（PASSIVE 的问题）？

libgomp 中，线程在屏障或线程池里等待时先自旋 GOMP_SPINCOUNT 次，再进入 futex 休眠：
  ACTIVE  = 自旋极久（几乎不休眠）；默认 = 30 万次；PASSIVE = 不自旋，立即休眠。
在 p=24（占满全部 vCPU，会被抢占）和 p=16（不会被抢占，用来量出代价）下比较，
每种设置跑 10 个独立进程（每个进程调用 200 次），全部任务按固定种子随机打乱后执行。
上下文切换次数由 GNU time 读取 rusage（%w 主动、%c 被动），不受 perf_event_paranoid 限制。

用法：python scripts/spin_probe.py [--runs 10]  → results/spin_probe.csv
"""
import argparse
import csv
import io
import os
import random
import statistics
import subprocess
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BIN = ROOT / "csr_spmv_lab"
CONFIG_B = ["--rows", "20000", "--cols", "200000", "--normal-nnz", "16",
            "--long-rows", "16", "--long-nnz", "80000"]
BASE_ENV = {"OMP_PROC_BIND": "close", "OMP_PLACES": "cores"}
SETTINGS = {
    "ACTIVE": {"OMP_WAIT_POLICY": "ACTIVE"},
    "默认(3e5)": {},
    "1e5": {"GOMP_SPINCOUNT": "100000"},
    "1e4": {"GOMP_SPINCOUNT": "10000"},
    "1e3": {"GOMP_SPINCOUNT": "1000"},
    "PASSIVE": {"OMP_WAIT_POLICY": "PASSIVE"},
}


def run(setting, threads):
    env = {k: v for k, v in os.environ.items()
           if k not in ("OMP_WAIT_POLICY", "GOMP_SPINCOUNT")}
    env.update(BASE_ENV)
    env.update(SETTINGS[setting])
    with tempfile.NamedTemporaryFile("r", suffix=".txt") as tf:
        cmd = ["/usr/bin/time", "-f", "%w %c", "-o", tf.name, str(BIN), *CONFIG_B,
               "--threads", str(threads), "--only", "omp3", "--repeats", "200", "--csv"]
        out = subprocess.run(cmd, capture_output=True, text=True, env=env, check=True).stdout
        voluntary, involuntary = map(int, tf.read().split()[-2:])
    row = next(csv.DictReader(io.StringIO(out)))
    return dict(setting=setting, threads=threads, median_ms=float(row["median_ms"]),
                max_ms=float(row["max_ms"]), voluntary_cs=voluntary,
                involuntary_cs=involuntary)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--runs", type=int, default=10)
    args = ap.parse_args()
    jobs = [(s, p) for s in SETTINGS for p in (16, 24)] * args.runs
    random.Random(2026).shuffle(jobs)
    rows = []
    for i, (s, p) in enumerate(jobs, 1):
        rows.append(run(s, p))
        if i % 24 == 0:
            print(f"  {i}/{len(jobs)}", flush=True)
    path = ROOT / "results" / "spin_probe.csv"
    with path.open("w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0]))
        w.writeheader()
        w.writerows(rows)
    print(f"已写入 {path.relative_to(ROOT)}（{len(rows)} 行）\n")
    for p in (16, 24):
        fast = min(r["median_ms"] for r in rows if r["threads"] == p)
        print(f"p={p}（“慢进程” = 中位数超过该 p 下最快进程的 3 倍，最快 {fast * 1e3:.0f} µs）")
        print(f"{'设置':<10}{'中位数µs':>10}{'p90 µs':>10}{'慢进程':>8}{'主动切换':>10}{'被动切换':>10}")
        for s in SETTINGS:
            g = [r for r in rows if r["setting"] == s and r["threads"] == p]
            med = sorted(r["median_ms"] for r in g)
            p90 = med[int(0.9 * (len(med) - 1))]
            slow = sum(r["median_ms"] > 3 * fast for r in g)
            print(f"{s:<10}{statistics.median(med) * 1e3:>10.0f}{p90 * 1e3:>10.0f}"
                  f"{slow:>6}/{len(g)}"
                  f"{statistics.median(r['voluntary_cs'] for r in g):>10.0f}"
                  f"{statistics.median(r['involuntary_cs'] for r in g):>10.0f}")
        print()


if __name__ == "__main__":
    main()
