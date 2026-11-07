#!/usr/bin/env python3
"""汇总 bench.py 的原始 CSV：
  每个配置先在每一轮（进程）内取 10 次重复的中位数，再取各轮中位数的中位数作为代表值 T；
  同时给出全部重复中的最小值和最大值、调用级 p50/p95 的轮间中位数。
  S = T_serial / T（串行使用同一 batch、nprobe、order 的串行 IVF），E = S / p。
输出 results/<exp>_summary.csv，并在终端打印 Markdown 表。

用法：python -I scripts/summarize.py A
"""

import os
import sys

import pandas as pd

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
KEYS = ["strategy", "threads", "queries", "batch", "k", "nprobe", "grain", "dist", "isa",
        "sched", "coarse", "cutoff", "order", "bin", "env"]


def summarize(exp):
    raw = pd.read_csv(os.path.join(ROOT, "results", f"{exp}.csv"))
    if "bin" not in raw:
        raw["bin"] = "./ivf_lab"
    raw["env"] = raw["env"].astype("string").fillna("") if "env" in raw else ""
    per_round = raw.groupby(KEYS + ["round"], dropna=False).agg(
        t=("time_ms", "median"), tmin=("time_ms", "min"), tmax=("time_ms", "max"),
        p50=("call_ms_p50", "median"), p95=("call_ms_p95", "median"),
        threads_active=("threads_active", "first"), mean_c=("mean_candidates", "first"),
        blocks=("blocks_per_query", "first"), part_bytes=("part_bytes_per_query", "first"),
        recall=("recall", "first")).reset_index()
    s = per_round.groupby(KEYS, dropna=False).agg(
        T_ms=("t", "median"), round_spread=("t", lambda x: (x.max() - x.min()) / x.median()),
        min_ms=("tmin", "min"), max_ms=("tmax", "max"), rounds=("t", "size"),
        call_p50_ms=("p50", "median"), call_p95_ms=("p95", "median"),
        threads_active=("threads_active", "first"), mean_C=("mean_c", "first"),
        blocks_per_query=("blocks", "first"), part_bytes_per_query=("part_bytes", "first"),
        recall=("recall", "first")).reset_index()
    ser = s[s.strategy == "serial"]
    serial = ser.set_index(["queries", "batch", "nprobe", "order"])["T_ms"]
    # 串行时间与 batch 无关；没有同 batch 的串行配置时，用同 queries/nprobe/order 下各 batch 的中位数
    serial_any = ser.groupby(["queries", "nprobe", "order"])["T_ms"].median()

    def speedup(row):
        key = (row.queries, row.batch, row.nprobe, row.order)
        base = serial.get(key, serial_any.get((row.queries, row.nprobe, row.order), float("nan")))
        return base / row.T_ms

    s["S"] = s.apply(speedup, axis=1)
    s["E"] = s.S / s.threads
    s["QPS"] = s.queries * 1000.0 / s.T_ms
    s = s.sort_values(["batch", "strategy", "coarse", "threads", "grain", "dist", "isa"])
    s.to_csv(os.path.join(ROOT, "results", f"{exp}_summary.csv"), index=False)
    cols = ["strategy", "coarse", "threads", "queries", "batch", "grain", "sched", "dist", "isa", "order",
            "nprobe", "cutoff", "T_ms", "min_ms", "max_ms", "round_spread", "S", "E", "QPS",
            "call_p50_ms", "call_p95_ms", "threads_active", "recall", "env"]
    varying = [col for col in cols if col in ("T_ms", "S", "E", "QPS") or s[col].nunique() > 1]
    print(s[varying].to_markdown(index=False, floatfmt=".3f"))


if __name__ == "__main__":
    summarize(sys.argv[1])
