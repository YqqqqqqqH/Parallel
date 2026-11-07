#!/usr/bin/env bash
# 服务器对照 S4–S6（P=16；CP-S2 用户决定继续）。在课程服务器上运行：
#   cd ~/Parallel/lab2/openmp_ivf_lab && nohup bash scripts/server_S4S6.sh > results/server/.run_S4S6.log 2>&1 < /dev/null &
# S4：读带宽探针 + 向量化报告（含 zmm）+ SIMD × ISA 区组实验（H4、H6）
# S5：实验 B 子集（H3）+ W_t 统计
# S6：std::thread 与 omp1-static（H5）
set -eu
cd "$(dirname "$0")/.."
export IVF_DATA="${IVF_DATA:-/var/dataset}" IVF_RESULTS="${IVF_RESULTS:-results/server}" IVF_P=16
source scripts/common.sh
make -s ivf_lab ivf_lab_native ivf_lab_native512 ivf_lab_stats bw_probe
echo "== $(date -Iseconds) 读带宽探针"
./bw_probe | tee "$IVF_RESULTS/bw_probe.csv"
echo "== $(date -Iseconds) 向量化报告"
bash scripts/vecreport.sh "$IVF_RESULTS/vec" | grep -E "^==|simd32|f32 |scalar"
echo "== $(date -Iseconds) S4（区组设计，3 轮）"
python3 -I scripts/bench.py S4_blocked --rounds 3 --max-busy 2
echo "== $(date -Iseconds) S5（3 轮）"
python3 -I scripts/bench.py S5 --rounds 3 --max-busy 2
echo "== $(date -Iseconds) S5 统计"
STATS_ORDERS="orig asc" STATS_OMP2=0 bash scripts/stats_B.sh
echo "== $(date -Iseconds) S6（3 轮）"
python3 -I scripts/bench.py S6 --rounds 3 --max-busy 2
echo "== $(date -Iseconds) 完成"
