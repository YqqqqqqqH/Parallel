#!/usr/bin/env bash
# 实验 B 的统计采集（另跑一遍，不影响正式计时）：每线程完成的候选数 W_t 与忙碌时间。
# 输出 results/stats/B_<策略>_<调度>_b<batch>_<顺序>.csv
set -eu
cd "$(dirname "$0")/.."
source scripts/common.sh
make -s ivf_lab_stats
mkdir -p results/stats
for order in orig asc desc; do
  for b in 64 1024; do
    for sched in static dynamic:1; do
      ./ivf_lab_stats "${DATA_ARGS[@]}" --only omp1 --threads 16 --batch "$b" --sched "$sched" \
          --order "$order" --queries 1024 --repeats 3 \
          --stats-csv "results/stats/B_omp1_${sched/:/}_b${b}_${order}.csv" > /dev/null
    done
    ./ivf_lab_stats "${DATA_ARGS[@]}" --only omp2 --threads 16 --batch "$b" --grain 1024 \
        --order "$order" --queries 1024 --repeats 3 \
        --stats-csv "results/stats/B_omp2_task_b${b}_${order}.csv" > /dev/null
  done
done
echo "stats_B 完成"
