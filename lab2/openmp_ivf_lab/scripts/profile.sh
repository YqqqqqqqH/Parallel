#!/usr/bin/env bash
# P0 数据画像：单线程分阶段墙钟计时（中心选择 vs 候选扫描），逐查询输出 C(q)。
# 每个查询各计时 5 次取中位数；结果写入 results/p0_profile_np{1,8,32}.csv 与 results/p0_summary.txt
set -eu
cd "$(dirname "$0")/.."
source scripts/common.sh
: > results/p0_summary.txt
for np in 1 8 32; do
    ./ivf_lab "${DATA_ARGS[@]}" --mode profile --queries 1024 --nprobe "$np" --repeats 5 \
        --profile-csv "results/p0_profile_np$np.csv" | tail -2 | tee -a results/p0_summary.txt
done
