#pragma once
// 统计插桩，只在 -DIVF_STATS 构建（ivf_lab_stats）中生效。正式计时的二进制里
// IVF_STAT(...) 展开为空，不引入任何代码。
//
// 每个线程一个按缓存行对齐的槽位，避免伪共享。各字段的口径：
//   candidates  该线程完成的候选距离计算次数 W_t（各线程之和应等于总候选数）
//   busy_ns     该线程执行查询/块/中心任务的时间之和（线程工作时间，不是墙钟）
//   select_ns   中心选择耗时之和；scan_ns 候选扫描耗时之和；merge_ns 合并局部 Top-k 耗时之和
//   tasks       该线程执行的任务数（omp1/std 中为处理的查询数）

#include <chrono>
#include <cstdint>

namespace ivf::stats {

constexpr int kMaxThreads = 256;

struct alignas(64) Slot {
    std::uint64_t candidates = 0;
    std::uint64_t tasks = 0;
    double busy_ns = 0;
    double select_ns = 0;
    double scan_ns = 0;
    double merge_ns = 0;
};

inline Slot slots[kMaxThreads];

// 通过函数访问，避免 default(none) 的 OpenMP 区域里直接引用全局数组
inline Slot& slot(int tid) { return slots[tid]; }

inline void reset() {
    for (auto& s : slots) s = Slot{};
}

inline double now_ns() {
    return std::chrono::duration<double, std::nano>(
        std::chrono::steady_clock::now().time_since_epoch()).count();
}

}

#ifdef IVF_STATS
#define IVF_STAT(...) __VA_ARGS__
#else
#define IVF_STAT(...)
#endif
