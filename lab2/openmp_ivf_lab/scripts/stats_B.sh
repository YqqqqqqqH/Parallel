#!/usr/bin/env bash
# 实验 B 的统计采集（另跑一遍，不影响正式计时）：每线程完成的候选数 W_t 与忙碌时间。
# 输出 $IVF_RESULTS/stats/B_<策略>_<调度>_b<batch>_<顺序>.csv（IVF_RESULTS 默认 results）
# 服务器对照：IVF_RESULTS=results/server IVF_P=16 STATS_ORDERS="orig asc" STATS_OMP2=0 bash scripts/stats_B.sh
set -eu
cd "$(dirname "$0")/.."
source scripts/common.sh
make -s ivf_lab_stats
R="${IVF_RESULTS:-results}"
P="${IVF_P:-16}"
mkdir -p "$R/stats"
for order in ${STATS_ORDERS:-orig asc desc}; do
  for b in $((4 * P)) 1024; do
    for sched in static dynamic:1; do
      ./ivf_lab_stats "${DATA_ARGS[@]}" --only omp1 --threads "$P" --batch "$b" --sched "$sched" \
          --order "$order" --queries 1024 --repeats 3 \
          --stats-csv "$R/stats/B_omp1_${sched/:/}_b${b}_${order}.csv" > /dev/null
    done
    if [[ "${STATS_OMP2:-1}" == 1 ]]; then
      ./ivf_lab_stats "${DATA_ARGS[@]}" --only omp2 --threads "$P" --batch "$b" --grain 1024 \
          --order "$order" --queries 1024 --repeats 3 \
          --stats-csv "$R/stats/B_omp2_task_b${b}_${order}.csv" > /dev/null
    fi
  done
done
echo "stats_B 完成"
