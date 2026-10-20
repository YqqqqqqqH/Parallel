#!/usr/bin/env python3
"""E0 正确性矩阵：线程数 × 种子 × 边界矩阵 × 调度参数，任何一次失败都以非零码退出。

用法：
    python scripts/check_correctness.py                 # 主构建
    python scripts/check_correctness.py --asan          # 额外用 ASan+UBSan 构建跑精简矩阵
"""
import argparse
import csv
import io
import itertools
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MAIN_BIN = ROOT / "csr_spmv_lab"
ASAN_BIN = ROOT / "build" / "csr_spmv_lab_asan"

THREADS = [1, 2, 3, 4, 7, 8, 13, 16, 24]
SEEDS = [20260926, 1, 424242]

# (名称, 矩阵参数, 额外的策略参数组合)
CASES = [
    ("A 默认", [], [[]]),
    ("B README 16x80000",
     ["--rows", "20000", "--cols", "200000", "--normal-nnz", "16",
      "--long-rows", "16", "--long-nnz", "80000"], [[]]),
    ("C 极端 1x100000",
     ["--cols", "200000", "--long-rows", "1", "--long-nnz", "100000"], [[]]),
    ("无长行", ["--long-rows", "0", "--long-nnz", "0"], [[]]),
    ("普通行为空", ["--rows", "2000", "--normal-nnz", "0", "--long-rows", "5",
                "--long-nnz", "3000"], [[]]),
    ("全空矩阵", ["--rows", "500", "--normal-nnz", "0", "--long-rows", "0", "--long-nnz", "0"], [[]]),
    ("全是长行", ["--rows", "100", "--cols", "1000", "--long-rows", "100",
              "--long-nnz", "500"], [[]]),
    ("单行", ["--rows", "1", "--cols", "1000", "--long-rows", "1", "--long-nnz", "777"], [[]]),
    ("nnz 少于线程数", ["--rows", "5", "--cols", "10", "--normal-nnz", "1",
                   "--long-rows", "0", "--long-nnz", "0"], [[]]),
    # 调度/块大小的边界：块大小 1、奇数、超过 nnz；omp1 的各种调度
    ("小矩阵+调度/块大小边界",
     ["--rows", "300", "--cols", "5000", "--normal-nnz", "3", "--long-rows", "4",
      "--long-nnz", "2000"],
     [["--nnz-chunk", "1"], ["--nnz-chunk", "7"], ["--nnz-chunk", "1000000000"],
      ["--sched", "static", "--chunk", "0"], ["--sched", "static", "--chunk", "3"],
      ["--sched", "dynamic", "--chunk", "1"], ["--sched", "guided", "--chunk", "7"],
      ["--sched", "auto", "--chunk", "0"]]),
]


def run_case(binary, matrix_args, extra, threads, seed):
    cmd = [str(binary), *matrix_args, *extra, "--threads", str(threads),
           "--seed", str(seed), "--repeats", "1", "--csv"]
    proc = subprocess.run(cmd, capture_output=True, text=True)
    return cmd, proc


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--asan", action="store_true", help="同时跑 ASan+UBSan 构建")
    args = parser.parse_args()

    runs = [(MAIN_BIN, THREADS, SEEDS)]
    if args.asan:
        runs.append((ASAN_BIN, [1, 3, 8, 24], SEEDS[:1]))

    failures = 0
    total = 0
    worst = {}  # strategy -> (tol_ratio, max_abs, 描述)
    for binary, threads_list, seeds in runs:
        for name, matrix_args, extras in CASES:
            for extra, threads, seed in itertools.product(extras, threads_list, seeds):
                total += 1
                cmd, proc = run_case(binary, matrix_args, extra, threads, seed)
                bad = proc.returncode != 0 or "runtime error" in proc.stderr \
                    or "AddressSanitizer" in proc.stderr
                if bad:
                    failures += 1
                    print(f"[FAIL] {binary.name} {name} p={threads} seed={seed} {extra}")
                    print("  cmd:", " ".join(cmd))
                    print("  stderr:", proc.stderr.strip()[:2000])
                    continue
                for row in csv.DictReader(io.StringIO(proc.stdout)):
                    ratio = float(row["tol_ratio"])
                    if ratio >= worst.get(row["strategy"], (-1,))[0]:
                        worst[row["strategy"]] = (
                            ratio, float(row["max_abs_err"]),
                            f"{name} p={threads} seed={seed} {' '.join(extra)}")

    print(f"\n共 {total} 次运行（每次 5 个策略各检查一次），失败 {failures} 次")
    print("各策略在全部运行中的最坏误差（tol_ratio = 误差/容差，<1 即通过）：")
    for key in ["serial", "thread", "omp1", "omp2", "omp3"]:
        if key in worst:
            ratio, max_abs, where = worst[key]
            print(f"  {key:6s} tol_ratio={ratio:.3e}  max_abs_err={max_abs:.3e}  @ {where}")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())
