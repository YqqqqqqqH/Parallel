// 学生实现的候选距离函数。单独成一个编译单元，原因有二：
//   1. 和公共的 l2_distance_scalar（在 ivf_search.cpp）一样以普通函数调用的方式进入扫描循环，
//      开关只改变距离内核本身，不改变调用方式；
//   2. 便于对这一个文件出向量化报告（-fopt-info-vec）和反汇编（scripts/vecreport.sh）。
//
// 精确性：SIFT 坐标是 [0, 218] 的整数。f32/simd32 的每一项 (a-b)^2 和任意顺序的部分和
// 都是小于 2^24 的非负整数，float 可精确表示，因此结果与 double 标量逐位相同；
// f32_distance_exact() 在计时之外检查这个前提，不满足时 harness 拒绝使用 f32/simd32。
#include "ivf_search.h"

#include <cmath>

namespace ivf {

double l2_distance_f32(const float* a, const float* b, std::size_t dim) {
    float sum = 0;
    for (std::size_t j = 0; j < dim; ++j) {
        const float delta = a[j] - b[j];
        sum += delta * delta;
    }
    return sum;
}

double l2_distance_simd64(const float* a, const float* b, std::size_t dim) {
    double sum = 0;
#pragma omp simd reduction(+ : sum)
    for (std::size_t j = 0; j < dim; ++j) {
        const double delta = double(a[j]) - double(b[j]);
        sum += delta * delta;
    }
    return sum;
}

double l2_distance_simd32(const float* a, const float* b, std::size_t dim) {
    float sum = 0;
#pragma omp simd reduction(+ : sum)
    for (std::size_t j = 0; j < dim; ++j) {
        const float delta = a[j] - b[j];
        sum += delta * delta;
    }
    return sum;
}

// 前提：库向量和查询的坐标都是整数，且 dim * M^2 < 2^24，M 为任意两坐标之差的最大绝对值。
// 满足时，每一项和任意顺序的部分和都是 [0, 2^24) 内的整数，float 运算没有舍入。
bool f32_distance_exact(const IVFIndex& index, const float* queries, std::size_t count) {
    float lo = INFINITY, hi = -INFINITY;
    auto scan = [&](const float* data, std::size_t n) {
        for (std::size_t i = 0; i < n; ++i) {
            const float v = data[i];
            if (v != std::nearbyint(v)) return false;
            lo = v < lo ? v : lo;
            hi = v > hi ? v : hi;
        }
        return true;
    };
    if (!scan(index.vectors.data(), index.vectors.size()) || !scan(queries, count * index.dim)) {
        return false;
    }
    if (index.vectors.empty() && count == 0) return true;
    const double span = double(hi) - double(lo);
    return double(index.dim) * span * span < 16777216.0;  // 2^24
}

const char* dist_name(DistKind kind) {
    switch (kind) {
    case DistKind::scalar: return "scalar";
    case DistKind::f32: return "f32";
    case DistKind::simd64: return "simd64";
    case DistKind::simd32: return "simd32";
    }
    return "?";
}

}
