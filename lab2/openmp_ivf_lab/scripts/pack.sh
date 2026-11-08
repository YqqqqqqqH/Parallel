#!/usr/bin/env bash
# 打包提交材料（只含服务器结果）：代码、复现命令、原始 CSV、性能工具输出、实验报告与心路历程，不含数据文件。
# 用法：bash scripts/pack.sh [输出 zip 路径，默认 ../lab2_submission.zip]
#
# 打包：源码与测试；生成服务器结果用到的脚本；results/server/、figures/server/；报告；复现说明；心路历程。
# 不打包：实验日志.md、results/ 与 figures/ 下的其他结果、data_manifest/、scripts/prepare_data.py、
#         scripts/perf_ctl.py（这些都与服务器结果无关）；编译产物、*.o、python 缓存、临时文件。
set -eu
cd "$(dirname "$0")/.."
OUT="$(realpath -m "${1:-../lab2_submission.zip}")"
if [[ ! -f 心路历程.md && ! -f 心路历程.pdf ]]; then
    echo "提醒：尚未找到 心路历程.md / 心路历程.pdf，本次打包不含心路历程。" >&2
fi
make -s clean
rm -f "$OUT"
SCRIPTS=(common.sh env.sh check_correctness.sh bench.py summarize.py plot.py profile.sh stats_B.sh
         model_B.py vecreport.sh timev.py server_S1.sh server_S2S3.sh server_S4S6.sh server_supp.sh
         server_final.sh pack.sh)
FILES=(Makefile README.md openmp_ivf_topk_lab.md 复现说明.md
       ivf_io.h ivf_io.cpp ivf_search.h ivf_search.cpp ivf_student.cpp ivf_simd.cpp ivf_stats.h
       ivf_lab.cpp bw_probe.cpp tests results/server figures/server
       report/report.pdf report/report.md report/build.sh)
for s in "${SCRIPTS[@]}"; do FILES+=("scripts/$s"); done
for f in 心路历程.md 心路历程.pdf; do [[ -f $f ]] && FILES+=("$f"); done
for f in "${FILES[@]}"; do [[ -e $f ]] || { echo "缺少文件：$f" >&2; exit 1; }; done
zip -qr "$OUT" "${FILES[@]}" -x '*.o' -x '*/__pycache__/*' -x '*/.tmp_*'
echo "已生成 $OUT（$(du -h "$OUT" | cut -f1)）"
unzip -l "$OUT" | tail -1
