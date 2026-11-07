#!/usr/bin/env bash
# 报告用的两份服务器材料：
#   1. results/server/correctness_run.txt：一次运行检查各策略（供截图放入报告附录 E）
#   2. results/server/index_stats.txt：官方索引的列表长度统计（标准库 python，读 cluster_id_4096.ivecs）
set -eu
cd "$(dirname "$0")/.."
export IVF_DATA="${IVF_DATA:-/var/dataset}"
source scripts/common.sh
make -s ivf_lab student_tests
{
  echo "\$ hostname; lscpu | grep 'Model name'"; hostname; lscpu | grep "Model name"
  echo "\$ ls -l /var/dataset"; ls -l /var/dataset
  echo "\$ ./student_tests"; ./student_tests | tail -1
  for s in "serial" "omp1 --threads 16 --batch 64 --sched dynamic:1 --dist simd32" \
           "omp2 --threads 16 --batch 1 --grain 128" "omp2 --threads 16 --batch 1 --grain 128 --coarse split" \
           "omp2 --threads 16 --batch 64 --grain 1024 --dist simd32" "std --threads 16 --batch 64" \
           "exact --queries 8 --batch 1"; do
    echo "\$ ./ivf_lab --mode check --queries 1024 --only $s"
    ./ivf_lab "${DATA_ARGS[@]}" --mode check --queries 1024 --only $s 2>&1 | tail -2
  done
} 2>&1 | tee results/server/correctness_run.txt
python3 - <<'EOF' | tee results/server/index_stats.txt
import struct, statistics
with open("/var/dataset/cluster_id_4096.ivecs", "rb") as f:
    raw = f.read()
n = len(raw) // 8
ids = struct.unpack("<" + "i" * (2 * n), raw)[1::2]
sizes = [0] * 4096
for c in ids:
    sizes[c] += 1
s = sorted(sizes)
print(f"官方索引列表长度：N={n} 列表数=4096 最小={s[0]} 中位数={statistics.median(s)} 平均={n/4096:.1f} "
      f"p99={s[int(0.99 * 4095)]} 最大={s[-1]} 空列表={s.count(0)}")
EOF
