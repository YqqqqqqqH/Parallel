#!/usr/bin/env bash
# 实验 E 的向量化证据：对距离函数所在的两个编译单元（公共标量 ivf_search.cpp、学生 ivf_simd.cpp）
# 分别用默认选项和 -march=native 编译，输出 GCC 向量化报告和四个距离函数的反汇编，
# 并统计每个函数里的标量/打包浮点指令数。结果写入 results/vec/（可用第 1 个参数指定目录，
# 服务器上用 results/server/vec）。服务器对照还加了 native512（-mprefer-vector-width=512）并统计 zmm。
set -eu
cd "$(dirname "$0")/.."
OUT="${1:-results/vec}"
mkdir -p "$OUT"
BASE="-O3 -std=c++17 -Wall -Wextra -Wpedantic -fopenmp -pthread -I."
FUNCS="l2_distance_scalar l2_distance_f32 l2_distance_simd64 l2_distance_simd32"
summary="$OUT/summary.txt"
{
echo "# $(g++ --version | head -1)"
for isa in default native native512; do
    flags="$BASE"
    [[ $isa == native ]] && flags="$BASE -march=native"
    [[ $isa == native512 ]] && flags="$BASE -march=native -mprefer-vector-width=512"
    for src in ivf_search.cpp ivf_simd.cpp; do
        obj="$OUT/${src%.cpp}_$isa.o"
        # GCC 一次只接受一个 -fopt-info 输出文件，所以"成功"和"失败"两份报告分两次编译
        g++ $flags -c "$src" -o "$obj" -fopt-info-vec-optimized="$OUT/${src%.cpp}_${isa}_vec_optimized.txt"
        g++ $flags -c "$src" -o /dev/null -fopt-info-vec-missed="$OUT/${src%.cpp}_${isa}_vec_missed.txt"
        objdump -d --no-show-raw-insn -C "$obj" > "$OUT/${src%.cpp}_$isa.asm"
    done
    echo "== ISA=$isa（编译选项：$flags）"
    for f in $FUNCS; do
        src=ivf_simd; [[ $f == l2_distance_scalar ]] && src=ivf_search
        body=$(awk -v fn="ivf::$f(" '$0 ~ /^[0-9a-f]+ </ {on = index($0, fn) > 0} on' "$OUT/${src}_$isa.asm")
        count() { grep -cE "$1" <<<"$body" || true; }
        printf '%-20s 标量(ss/sd)=%-3s 打包(ps/pd)=%-3s 使用xmm=%-3s 使用ymm=%-3s 使用zmm=%-3s 例：%s\n' "$f" \
            "$(count '\s(v?(sub|mul|add|fmadd[0-9]*)s[sd])\s')" \
            "$(count '\s(v?(sub|mul|add|fmadd[0-9]*)p[sd])\s')" \
            "$(count 'xmm')" "$(count 'ymm')" "$(count 'zmm')" \
            "$(grep -oE '\s(v?(sub|mul|add|fmadd[0-9]*)[ps][sd])\s' <<<"$body" | sort | uniq -c | tr -s ' ' | tr '\n' ';')"
    done
    echo "-- 标量 double（ivf_search.cpp:35）的 missed 诊断："
    grep -hE "ivf_search.cpp:35:" "$OUT/ivf_search_${isa}_vec_missed.txt" | sort -u | head -3 || true
    echo "-- 向量化报告中与距离函数相关的条目（行号见源文件）："
    grep -hE "ivf_simd.cpp|ivf_search.cpp:(3[4-9]|4[0-2])" "$OUT"/ivf_s*_"${isa}"_vec_optimized.txt | grep -E "loop vectorized|vectoriz" | sort -u || true
done
} | tee "$summary"
