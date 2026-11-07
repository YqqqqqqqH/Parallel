#!/usr/bin/env bash
# E0：真实 SIFT1M 上的正确性矩阵。每次运行都用 --mode check（完整逐项检查）。
# 用法：bash scripts/check_correctness.sh [二进制，默认 ./ivf_lab] [输出文件]
set -u
cd "$(dirname "$0")/.."
source scripts/common.sh
BIN="${1:-./ivf_lab}"
OUT="${2:-results/e0_correctness.txt}"
pass=0; fail=0
run() {
    local line
    line=$("$BIN" "${DATA_ARGS[@]}" --mode check "$@" 2>&1 | tail -1)
    if [[ "$line" == correctness=PASS* ]]; then pass=$((pass+1)); echo "PASS $* | $line"
    else fail=$((fail+1)); echo "FAIL $* | $line"; fi
}
{
echo "# 二进制: $BIN  数据: $IVF_DATA  时间: $(date -Iseconds)"
for np in 1 8; do
  for t in 1 2 3 7 16; do
    for b in 1 64; do
      run --only omp1 --queries 128 --nprobe "$np" --threads "$t" --batch "$b" --sched dynamic:1
      run --only omp2 --queries 128 --nprobe "$np" --threads "$t" --batch "$b" --grain 256
      run --only omp2 --queries 128 --nprobe "$np" --threads "$t" --batch "$b" --grain 64 --coarse split
      run --only std  --queries 128 --nprobe "$np" --threads "$t" --batch "$b"
    done
  done
  for d in f32 simd64 simd32; do
    run --only omp1 --queries 128 --nprobe "$np" --threads 16 --batch 64 --dist "$d"
    run --only omp2 --queries 128 --nprobe "$np" --threads 7 --batch 1 --grain 64 --dist "$d"
  done
  run --only omp3 --queries 32 --nprobe "$np" --threads 7 --batch 1 --grain 256
done
# 等距与 k：k=1 与 k=100；nprobe=nlist 时参考结果为全库扫描
run --only omp2 --queries 64 --k 1 --threads 16 --batch 1 --grain 64
run --only omp2 --queries 64 --k 100 --threads 16 --batch 64 --grain 64 --dist simd32
run --only omp1 --queries 64 --k 100 --threads 7 --batch 64 --dist simd32
for s in omp1 omp2 std; do
  run --only "$s" --queries 4 --nprobe 4096 --threads 16 --batch 1 --grain 4096 --dist scalar
done
run --only omp2 --queries 4 --nprobe 4096 --threads 16 --batch 4 --grain 4096 --dist simd32 --coarse split
echo "# 合计 PASS=$pass FAIL=$fail"
} | tee "$OUT"
# 管道右侧是子 shell，计数不会传回，这里从输出文件判定
grep -q "^# 合计 PASS=[0-9]* FAIL=0$" "$OUT"
