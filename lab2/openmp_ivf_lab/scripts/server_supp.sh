#!/usr/bin/env bash
# 报告改为以服务器官方数据为准后，补跑报告需要、但服务器上还没有的实验（P=16）：
#   P0（nprobe=1/8/32）、omp1 调度消融、实验 C（grain、omp3）与 cutoff、实验 D（nprobe）、
#   实验 B 全量（orig/asc/desc，含 omp2）与 W_t 统计，最后跑 ASan 构建的正确性检查。
# 在课程服务器上运行：
#   cd ~/Parallel/lab2/openmp_ivf_lab && nohup bash scripts/server_supp.sh > results/server/.run_supp.log 2>&1 < /dev/null &
set -eu
cd "$(dirname "$0")/.."
export IVF_DATA="${IVF_DATA:-/var/dataset}" IVF_RESULTS="${IVF_RESULTS:-results/server}" IVF_P=16
R="$IVF_RESULTS"
# 留底：分叉会话测的 P0 与 S5 的统计会被同名文件覆盖，先改名
[[ -f "$R/p0_profile_np8.csv" && ! -f "$R/p0_profile_np8_s0.csv" ]] && mv "$R/p0_profile_np8.csv" "$R/p0_profile_np8_s0.csv"
for f in "$R"/stats/B_*.csv; do [[ -f "$f" ]] && mv "$f" "$R/stats/S5_$(basename "$f")"; done
make -s ivf_lab ivf_lab_stats
echo "== $(date -Iseconds) P0"
bash scripts/profile.sh
for exp in A_sched C C_cutoff D B; do
  echo "== $(date -Iseconds) $exp（3 轮）"
  python3 -I scripts/bench.py "$exp" --rounds 3 --max-busy 2
done
echo "== $(date -Iseconds) B 统计"
bash scripts/stats_B.sh
echo "== $(date -Iseconds) ASan"
if make -s ivf_lab_asan student_tests_asan; then
  ./student_tests_asan | tail -1
  bash scripts/check_correctness.sh ./ivf_lab_asan "$R/e0_correctness_official_asan.txt" | tail -1 || echo "ASan 正确性矩阵失败"
else
  echo "ASan 构建失败（可能缺少 libasan），跳过"
fi
echo "== $(date -Iseconds) 完成"
