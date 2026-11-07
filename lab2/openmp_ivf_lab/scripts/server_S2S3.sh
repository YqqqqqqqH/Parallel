#!/usr/bin/env bash
# 服务器对照 S2 + S3（P=16，CP-S1 由用户确定）。在课程服务器上运行：
#   cd ~/Parallel/lab2/openmp_ivf_lab && nohup bash scripts/server_S2S3.sh > results/server/.run_S2S3.log 2>&1 < /dev/null &
# S2：实验 A 复现（H1、H2），3 轮计时 + 统计构建：
#     omp1 b=64 在 p=1、16；omp2 b=1 grain=4096 p=16 分别用自旋（默认）和 passive。
# S3：GNU time 差分代替 perf（见 scripts/timev.py）。
set -eu
cd "$(dirname "$0")/.."
export IVF_DATA="${IVF_DATA:-/var/dataset}" IVF_RESULTS="${IVF_RESULTS:-results/server}"
export IVF_P=16 IVF_THREADS=1,2,4,8,16
source scripts/common.sh
mkdir -p "$IVF_RESULTS/stats"
make -s ivf_lab ivf_lab_stats
echo "== $(date -Iseconds) S2 计时（3 轮，--max-busy 2）"
python3 -I scripts/bench.py S2 --rounds 3 --max-busy 2
echo "== $(date -Iseconds) S2 统计构建"
for p in 1 16; do
  ./ivf_lab_stats "${DATA_ARGS[@]}" --only omp1 --threads $p --batch 64 --sched dynamic:1 \
      --queries 1024 --repeats 3 --stats-csv "$IVF_RESULTS/stats/S2_omp1_b64_p$p.csv" | tail -2
done
./ivf_lab_stats "${DATA_ARGS[@]}" --only omp2 --threads 16 --batch 1 --grain 4096 \
    --queries 1024 --repeats 3 --stats-csv "$IVF_RESULTS/stats/S2_omp2_b1_g4096_p16.csv" | tail -2
OMP_WAIT_POLICY=passive ./ivf_lab_stats "${DATA_ARGS[@]}" --only omp2 --threads 16 --batch 1 --grain 4096 \
    --queries 1024 --repeats 3 --stats-csv "$IVF_RESULTS/stats/S2_omp2_b1_g4096_p16_passive.csv" | tail -2
echo "== $(date -Iseconds) S3 GNU time 差分"
python3 -I scripts/timev.py --runs 3 --out "$IVF_RESULTS"
echo "== $(date -Iseconds) 完成"
