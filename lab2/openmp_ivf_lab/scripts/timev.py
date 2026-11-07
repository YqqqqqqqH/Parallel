#!/usr/bin/env python3
"""服务器对照 S3：perf 不可用时，用 GNU time（/usr/bin/time -v，来自 rusage）做差分测量。

rusage 统计整个进程（加载数据、参考结果、预热都在内），所以对每个配置分别用 --repeats 10 和
--repeats 60 各跑 N 次，取中位数相减再除以 50 次重复：固定开销抵消，剩下的就是 50 次重复的检索部分。
换算为每次 batch 调用的主动/被动上下文切换、次缺页，以及每个查询的 user+sys CPU 时间。
最大常驻内存（Max RSS）直接记录。另把 perf 的报错原文存为 perf_unavailable.txt。

只用标准库（服务器上的 python3 没有 pandas）。
用法：IVF_DATA=/var/dataset python3 -I scripts/timev.py --runs 3 --out results/server
"""
import argparse
import csv
import os
import re
import statistics
import subprocess

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA = os.environ.get("IVF_DATA", "/var/dataset")
DATA_ARGS = ["--base", f"{DATA}/sift_base.fbin", "--centroids", f"{DATA}/centroid_4096.fvecs",
             "--cluster-ids", f"{DATA}/cluster_id_4096.ivecs",
             "--queries-file", f"{DATA}/sift_query.fbin", "--gt", f"{DATA}/gt.ibin"]
Q = 1024
P = int(os.environ.get("IVF_P", "16"))
BIG = 4 * P
CONFIGS = [  # 名称, 参数, 环境变量
    ("serial", ["--only", "serial", "--batch", str(BIG)], {}),
    ("omp1", ["--only", "omp1", "--threads", str(P), "--batch", str(BIG), "--sched", "dynamic:1"], {}),
    ("std", ["--only", "std", "--threads", str(P), "--batch", str(BIG)], {}),
    ("omp2_b1", ["--only", "omp2", "--threads", "16", "--batch", "1", "--grain", "128"], {}),
    ("omp2_b1_passive", ["--only", "omp2", "--threads", "16", "--batch", "1", "--grain", "128"],
     {"OMP_WAIT_POLICY": "passive"}),
]
FIELDS = {
    "voluntary_cs": r"Voluntary context switches: (\d+)",
    "involuntary_cs": r"Involuntary context switches: (\d+)",
    "minor_pf": r"Minor \(reclaiming a frame\) page faults: (\d+)",
    "major_pf": r"Major \(requiring I/O\) page faults: (\d+)",
    "max_rss_kb": r"Maximum resident set size \(kbytes\): (\d+)",
    "user_s": r"User time \(seconds\): ([\d.]+)",
    "sys_s": r"System time \(seconds\): ([\d.]+)",
}


def run_once(args, env_extra, repeats, raw_path):
    cmd = ["/usr/bin/time", "-v", "./ivf_lab", *DATA_ARGS, *args, "--queries", str(Q),
           "--repeats", str(repeats)]
    env = dict(os.environ, **env_extra)
    proc = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True, env=env)
    with open(raw_path, "w") as f:
        f.write(" ".join(cmd) + "\n" + proc.stdout + proc.stderr)
    if proc.returncode != 0 or "correctness=PASS" not in proc.stdout:
        raise SystemExit(f"运行失败：{raw_path}")
    rec = {k: float(re.search(p, proc.stderr).group(1)) for k, p in FIELDS.items()}
    m = re.search(r"time_ms\[min/median/max\]=([\d.]+)/([\d.]+)/([\d.]+)", proc.stdout)
    rec["median_time_ms"] = float(m.group(2))
    return rec


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--runs", type=int, default=3)
    ap.add_argument("--out", default="results/server")
    args = ap.parse_args()
    out_dir = os.path.join(ROOT, args.out)
    raw_dir = os.path.join(out_dir, "timev_raw")
    os.makedirs(raw_dir, exist_ok=True)
    # perf 报错原文
    with open(os.path.join(out_dir, "perf_unavailable.txt"), "w") as f:
        for cmd in (["cat", "/proc/sys/kernel/perf_event_paranoid"], ["perf", "stat", "-e", "task-clock", "true"]):
            p = subprocess.run(cmd, capture_output=True, text=True)
            f.write(f"$ {' '.join(cmd)}\n{p.stdout}{p.stderr}(exit {p.returncode})\n\n")
    rows = []
    for name, cargs, env in CONFIGS:
        for reps in (10, 60):
            for r in range(1, args.runs + 1):
                rec = run_once(cargs, env, reps, os.path.join(raw_dir, f"{name}_rep{reps}_r{r}.txt"))
                rec.update(config=name, repeats=reps, run=r)
                rows.append(rec)
                print(name, reps, r, {k: rec[k] for k in ("voluntary_cs", "involuntary_cs", "minor_pf", "user_s")},
                      flush=True)
    keys = ["config", "repeats", "run", *FIELDS, "median_time_ms"]
    with open(os.path.join(out_dir, "timev.csv"), "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=keys)
        w.writeheader()
        w.writerows(rows)
    # 差分：(中位数@60 − 中位数@10) / 50 次重复 / 每次重复的调用数
    summary = []
    for name, cargs, _ in CONFIGS:
        batch = int(cargs[cargs.index("--batch") + 1])
        calls = -(-Q // batch)
        med = {reps: {k: statistics.median(r[k] for r in rows if r["config"] == name and r["repeats"] == reps)
                      for k in FIELDS} for reps in (10, 60)}
        d = {k: (med[60][k] - med[10][k]) / 50 for k in FIELDS}
        summary.append(dict(config=name, batch=batch, calls_per_repeat=calls,
                            voluntary_cs_per_call=d["voluntary_cs"] / calls,
                            involuntary_cs_per_call=d["involuntary_cs"] / calls,
                            minor_pf_per_call=d["minor_pf"] / calls,
                            cpu_us_per_query=(d["user_s"] + d["sys_s"]) * 1e6 / Q,
                            sys_us_per_query=d["sys_s"] * 1e6 / Q,
                            max_rss_mb=med[60]["max_rss_kb"] / 1024))
    with open(os.path.join(out_dir, "timev_summary.csv"), "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(summary[0]))
        w.writeheader()
        w.writerows(summary)
    for s in summary:
        print({k: (round(v, 4) if isinstance(v, float) else v) for k, v in s.items()})


if __name__ == "__main__":
    main()
