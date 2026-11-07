#!/usr/bin/env bash
# 打包提交材料：代码、复现命令、原始 CSV、性能工具输出、实验报告与心路历程（不含数据文件）。
# 用法：bash scripts/pack.sh [输出 zip 路径，默认 ../lab2_submission.zip]
set -eu
cd "$(dirname "$0")/.."
OUT="$(realpath -m "${1:-../lab2_submission.zip}")"
if [[ ! -f 心路历程.md && ! -f 心路历程.pdf ]]; then
    echo "提醒：尚未找到 心路历程.md / 心路历程.pdf，本次打包不含心路历程。" >&2
fi
make -s clean
rm -f "$OUT"
FILES=(Makefile README.md openmp_ivf_topk_lab.md 复现说明.md 实验日志.md
       ivf_io.h ivf_io.cpp ivf_search.h ivf_search.cpp ivf_student.cpp ivf_simd.cpp ivf_stats.h
       ivf_lab.cpp bw_probe.cpp tests scripts data_manifest results figures report/report.pdf
       report/report.md report/build.sh)
for f in 心路历程.md 心路历程.pdf; do [[ -f $f ]] && FILES+=("$f"); done
# 不打包：编译产物、.o、隐藏的运行日志之外的临时文件、python 缓存
zip -qr "$OUT" "${FILES[@]}" -x '*.o' -x '*/__pycache__/*' -x 'results/.tmp_*'
echo "已生成 $OUT（$(du -h "$OUT" | cut -f1)）"
unzip -l "$OUT" | tail -1
