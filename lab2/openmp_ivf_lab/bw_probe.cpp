// 读带宽探针：p 个线程并行顺序读取 512 MiB 数组（与库向量 512 MB 同量级，远大于 30 MB L3），
// 每个 p 重复 5 次取最快一次，输出 GB/s。用整数加法归约（延迟 1 周期），避免浮点累加链限制读速度。
// 用于回答"检索是否受内存带宽限制"：与检索的有效带宽（候选数 × 512 B / 时间）比较。
// 编译：g++ -O3 -std=c++17 -fopenmp bw_probe.cpp -o bw_probe
#include <omp.h>

#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <vector>

int main() {
    const std::size_t n = (std::size_t(512) << 20) / sizeof(std::uint32_t);
    std::vector<std::uint32_t> data(n);
#pragma omp parallel for schedule(static)
    for (std::size_t i = 0; i < n; ++i) data[i] = std::uint32_t(i);  // 并行首次触碰
    std::printf("threads,best_gbps,median_gbps\n");
    for (int p : {1, 2, 4, 8, 12, 16, 20, 24}) {
        std::vector<double> rates;
        std::uint32_t sink = 0;
        for (int rep = 0; rep < 5; ++rep) {
            std::uint32_t sum = 0;
            const auto t0 = std::chrono::steady_clock::now();
#pragma omp parallel for simd num_threads(p) schedule(static) reduction(+ : sum)
            for (std::size_t i = 0; i < n; ++i) sum += data[i];
            const double s = std::chrono::duration<double>(std::chrono::steady_clock::now() - t0).count();
            rates.push_back(double(n * sizeof(std::uint32_t)) / s / 1e9);
            sink ^= sum;
        }
        std::vector<double> sorted = rates;
        std::sort(sorted.begin(), sorted.end());
        std::printf("%d,%.2f,%.2f\n", p, sorted.back(), sorted[sorted.size() / 2]);
        if (sink == 0x12345678u) std::printf("#\n");  // 防止整个循环被优化掉
    }
    return 0;
}
