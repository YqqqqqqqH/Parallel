#!/usr/bin/env bash
# 服务器对照 S0′ + S1（见 实验计划_服务器对照.md §3、§4）。在课程服务器上运行：
#   cd ~/Parallel/lab2/openmp_ivf_lab && nohup bash scripts/server_S1.sh > results/server/.run_S1.log 2>&1 &
# S0′：编译全部构建，student_test；native / native512 在官方数据上做完整检查。
# S1 ：确定 P。omp1，nprobe=1（只受计算限制、数据在缓存内），batch=128，p∈{8,16,24,32}，3 轮；
#      统计构建测 p=1/16/32 时各线程工作时间之和。
set -eu
cd "$(dirname "$0")/.."
export IVF_DATA="${IVF_DATA:-/var/dataset}" IVF_RESULTS="${IVF_RESULTS:-results/server}"
source scripts/common.sh
mkdir -p "$IVF_RESULTS/stats"
echo "== $(date -Iseconds) 编译"
make -s ivf_lab ivf_lab_native ivf_lab_native512 ivf_lab_stats student_tests
echo "== student_test"; ./student_tests | tail -1
echo "== S0′ native / native512 正确性"
{
  for b in ivf_lab_native ivf_lab_native512; do
    for d in simd32 simd64 scalar; do
      for cfg in "--only omp1 --threads 16 --batch 64" "--only omp2 --threads 16 --batch 1 --grain 128"; do
        line=$(./$b "${DATA_ARGS[@]}" --mode check --queries 1024 --dist $d $cfg | tail -1)
        echo "$b --dist $d $cfg | $line"
      done
    done
  done
} | tee "$IVF_RESULTS/s0p_native_check.txt"
grep -c "correctness=PASS" "$IVF_RESULTS/s0p_native_check.txt"
echo "== $(date -Iseconds) S1 计时（3 轮，负载门控 --max-busy 2）"
python3 -I scripts/bench.py S1 --rounds 3 --max-busy 2
echo "== $(date -Iseconds) S1 统计构建"
for p in 1 16 32; do
  ./ivf_lab_stats "${DATA_ARGS[@]}" --only omp1 --threads $p --batch 128 --nprobe 1 --sched dynamic:1 \
      --queries 1024 --repeats 3 --stats-csv "$IVF_RESULTS/stats/S1_omp1_np1_b128_p$p.csv" | tail -2
done
echo "== $(date -Iseconds) 完成"
