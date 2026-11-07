// 学生实现的正确性测试：所有策略 × 距离开关 × 线程数 × batch × grain × cutoff × 中心选择方式，
// 在若干小型数据上与 search_ivf_serial（nprobe=nlist 时再与 search_exact_serial）逐项比较。
//
// 数据覆盖：空列表、候选不足 k、大量等距（坐标只取 0..3 或全相同）、超长列表（远大于 grain）、
// k=1、nprobe=1、nprobe=nlist，以及非整数坐标（此时 f32/simd32 的精确前提不成立，应被拒绝）。
// 整数数据上要求与参考结果逐位相同（距离和编号都用 == 比较），比 check_result 的容差更严。
#include "ivf_search.h"

#include <omp.h>

#include <algorithm>
#include <cstdio>
#include <iostream>
#include <random>
#include <stdexcept>
#include <string>
#include <vector>

using namespace ivf;

namespace {

struct Fixture {
    std::string name;
    IVFIndex index;
    std::vector<float> queries;
    std::size_t nq = 0;
    std::vector<std::pair<std::size_t, std::size_t>> k_nprobe;  // 要测试的 (k, nprobe)
};

// 与 read_ivf 相同的组织方式：按列表计数排序，列表内保持原始编号顺序
IVFIndex build(const std::vector<float>& base, std::size_t dim, const std::vector<float>& centers,
               const std::vector<int>& assign) {
    IVFIndex index;
    index.size = assign.size();
    index.dim = dim;
    index.nlist = centers.size() / dim;
    index.list_ptr.assign(index.nlist + 1, 0);
    for (int l : assign) ++index.list_ptr[l + 1];
    for (std::size_t l = 0; l < index.nlist; ++l) index.list_ptr[l + 1] += index.list_ptr[l];
    auto next = index.list_ptr;
    index.ids.resize(index.size);
    index.vectors.resize(base.size());
    for (std::size_t id = 0; id < index.size; ++id) {
        const auto pos = next[assign[id]]++;
        index.ids[pos] = static_cast<std::int32_t>(id);
        std::copy_n(base.data() + id * dim, dim, index.vectors.data() + pos * dim);
    }
    index.centroids = centers;
    return index;
}

Fixture official() {  // 与 tests/ivf_tests.cpp 相同：列表 0 为空，候选可能不足 k
    Fixture f{"official", build({0, 0, 10, 10, 1, 0, 10, 11, 1, 0}, 2, {99, 99, 0, 0, 10, 10},
                                {1, 2, 1, 2, 1}),
              {0, 0, 10, 10, 99, 99}, 3, {}};
    for (std::size_t k : {1, 4}) {
        for (std::size_t np : {1, 2, 3}) f.k_nprobe.push_back({k, np});
    }
    return f;
}

Fixture random_fixture(const std::string& name, std::size_t n, std::size_t dim, std::size_t nlist,
                       int max_coord, std::size_t nq, std::vector<int> empty_lists, int heavy_list,
                       bool integer, unsigned seed,
                       std::vector<std::pair<std::size_t, std::size_t>> k_nprobe) {
    std::mt19937 rng(seed);
    std::uniform_int_distribution<int> coord(0, max_coord);
    std::uniform_real_distribution<float> real(0.0f, float(max_coord));
    auto value = [&] { return integer ? float(coord(rng)) : real(rng); };
    std::vector<float> base(n * dim), centers(nlist * dim), queries(nq * dim);
    for (auto& v : base) v = value();
    for (auto& v : queries) v = value();
    for (auto& v : centers) v = real(rng);  // 中心总是浮点数
    std::vector<int> allowed;
    for (std::size_t l = 0; l < nlist; ++l) {
        if (std::find(empty_lists.begin(), empty_lists.end(), int(l)) == empty_lists.end()) {
            allowed.push_back(int(l));
        }
    }
    std::uniform_int_distribution<std::size_t> pick(0, allowed.size() - 1);
    std::bernoulli_distribution heavy(0.4);
    std::vector<int> assign(n);
    for (auto& a : assign) a = heavy_list >= 0 && heavy(rng) ? heavy_list : allowed[pick(rng)];
    return Fixture{name, build(base, dim, centers, assign), queries, nq, std::move(k_nprobe)};
}

Fixture all_same() {  // 所有距离都相等：结果完全由编号决定，专门检查跨块合并的等距次序
    const std::size_t n = 200, dim = 4, nlist = 7;
    std::mt19937 rng(7);
    std::vector<float> base(n * dim, 1.0f), centers(nlist * dim);
    for (auto& v : centers) v = std::uniform_real_distribution<float>(0, 2)(rng);
    std::vector<int> assign(n);
    for (auto& a : assign) a = int(rng() % nlist);
    std::vector<float> queries{1, 1, 1, 1, 0, 0, 0, 0, 2, 1, 0, 1};
    Fixture f{"all_same", build(base, dim, centers, assign), queries, 3, {}};
    for (std::size_t k : {1, 10, 199, 250}) {
        for (std::size_t np : {3, 7}) f.k_nprobe.push_back({k, np});
    }
    return f;
}

struct Config {
    std::string strategy;
    SearchFunction fn;
    SearchOptions options;
    std::string sched;
    std::size_t batch;
};

std::string describe(const Fixture& f, const Config& c) {
    char buf[320];
    std::snprintf(buf, sizeof buf,
                  "fixture=%s strategy=%s threads=%d batch=%zu k=%zu nprobe=%zu grain=%zu "
                  "cutoff=%zu dist=%s coarse=%s sched=%s",
                  f.name.c_str(), c.strategy.c_str(), c.options.threads, c.batch, c.options.k,
                  c.options.nprobe, c.options.grain, c.options.cutoff, dist_name(c.options.dist),
                  c.options.coarse_split ? "split" : "lib", c.sched.c_str());
    return buf;
}

void set_schedule(const std::string& s) {
    if (s == "static") omp_set_schedule(omp_sched_static, 0);
    else if (s == "dynamic:1") omp_set_schedule(omp_sched_dynamic, 1);
    else omp_set_schedule(omp_sched_guided, 2);
}

std::size_t runs = 0;

void run_config(const Fixture& f, const Config& c, const std::vector<Neighbor>& reference,
                bool bit_exact) {
    set_schedule(c.sched);
    omp_set_num_threads(c.options.threads);
    const std::size_t k = c.options.k;
    std::vector<Neighbor> out(f.nq * k, Neighbor{std::numeric_limits<double>::quiet_NaN(), -2});
    for (std::size_t begin = 0; begin < f.nq; begin += c.batch) {
        const std::size_t count = std::min(c.batch, f.nq - begin);
        c.fn(f.index, f.queries.data() + begin * f.index.dim, count, c.options, out.data() + begin * k);
    }
    try {
        check_result(out, reference);
        if (bit_exact) {
            for (std::size_t i = 0; i < out.size(); ++i) {
                if (out[i].id != reference[i].id || !(out[i].distance == reference[i].distance)) {
                    throw std::runtime_error("not bit-identical at output " + std::to_string(i));
                }
            }
        }
    } catch (const std::exception& e) {
        throw std::runtime_error(std::string(e.what()) + " | " + describe(f, c));
    }
    ++runs;
}

void test_fixture(const Fixture& f) {
    const bool exact32 = f32_distance_exact(f.index, f.queries.data(), f.nq);
    std::vector<DistKind> dists{DistKind::scalar, DistKind::simd64};
    if (exact32) dists.insert(dists.end(), {DistKind::f32, DistKind::simd32});
    const DistKind fast = exact32 ? DistKind::simd32 : DistKind::simd64;
    const std::size_t big = std::size_t(1) << 20;
    const std::vector<std::size_t> batches{1, 2, 5, f.nq};

    for (auto [k, nprobe] : f.k_nprobe) {
        SearchOptions base;
        base.k = k;
        base.nprobe = nprobe;
        std::vector<Neighbor> reference(f.nq * k);
        search_ivf_serial(f.index, f.queries.data(), f.nq, base, reference.data());
        if (nprobe == f.index.nlist) {  // 搜索全部列表时，串行 IVF 应与全库扫描一致
            std::vector<Neighbor> exact(f.nq * k);
            search_exact_serial(f.index, f.queries.data(), f.nq, base, exact.data());
            check_result(reference, exact);
        }
        // 非整数坐标时，SIMD 改变累加顺序会带来末位舍入差异，只用 check_result 的容差比较
        auto bit_exact_for = [&](DistKind d) { return exact32 || d == DistKind::scalar; };

        // omp1：距离 × 线程数 × batch，调度方式轮换
        const char* scheds[] = {"static", "dynamic:1", "guided:2"};
        int si = 0;
        for (auto d : dists) {
            for (int t : {1, 2, 3, 7, 16, 24}) {
                for (auto b : batches) {
                    Config c{"omp1", search_omp_student_1, base, scheds[si++ % 3], b};
                    c.options.threads = t;
                    c.options.dist = d;
                    run_config(f, c, reference, bit_exact_for(d));
                }
            }
        }
        // omp2：线程数 × batch × grain × cutoff × 中心选择方式（使用一种 SIMD 距离）
        for (int t : {1, 3, 7, 16, 24}) {
            for (auto b : {std::size_t(1), std::size_t(5), f.nq}) {
                for (auto g : {std::size_t(1), std::size_t(2), std::size_t(64), big}) {
                    for (auto cut : {std::size_t(0), big}) {
                        for (bool split : {false, true}) {
                            Config c{"omp2", search_omp_student_2, base, "static", b};
                            c.options.threads = t;
                            c.options.grain = g;
                            c.options.cutoff = cut;
                            c.options.coarse_split = split;
                            c.options.dist = fast;
                            run_config(f, c, reference, bit_exact_for(fast));
                        }
                    }
                }
            }
        }
        // omp2：全部距离开关（小 grain，确保拆块）
        for (auto d : dists) {
            for (int t : {3, 16}) {
                for (auto b : {std::size_t(1), f.nq}) {
                    Config c{"omp2", search_omp_student_2, base, "static", b};
                    c.options.threads = t;
                    c.options.grain = 2;
                    c.options.dist = d;
                    run_config(f, c, reference, bit_exact_for(d));
                }
            }
        }
        // omp3（critical 对照）
        for (int t : {1, 3, 16}) {
            for (auto b : {std::size_t(1), f.nq}) {
                for (auto g : {std::size_t(1), std::size_t(64), big}) {
                    Config c{"omp3", search_omp_student_3, base, "static", b};
                    c.options.threads = t;
                    c.options.grain = g;
                    run_config(f, c, reference, true);
                }
            }
        }
        // std::thread
        for (int t : {1, 2, 3, 7, 16, 24}) {
            for (auto b : batches) {
                Config c{"std", search_std_thread, base, "static", b};
                c.options.threads = t;
                run_config(f, c, reference, true);
            }
        }
    }
    std::cout << "  " << f.name << ": f32_exact=" << (exact32 ? "yes" : "no") << " PASS\n";
}

}  // namespace

int main() {
    try {
        omp_set_dynamic(0);
        std::vector<Fixture> fixtures;
        fixtures.push_back(official());
        // 低熵整数坐标：大量等距；列表 3 和 17 为空；列表 5 约占 40%，远长于 grain
        fixtures.push_back(random_fixture("ties", 3000, 8, 24, 3, 41, {3, 17}, 5, true, 11,
                                          {{1, 1}, {10, 5}, {64, 24}, {10, 1}}));
        // SIFT 风格：坐标 0..255 的整数，维度 32
        fixtures.push_back(random_fixture("wide", 4000, 32, 40, 255, 29, {0}, 9, true, 23,
                                          {{10, 1}, {10, 8}, {10, 40}}));
        // 非整数坐标：f32/simd32 的精确前提不成立
        fixtures.push_back(random_fixture("float", 500, 4, 12, 3, 9, {}, -1, false, 5,
                                          {{5, 2}, {5, 12}}));
        fixtures.push_back(all_same());
        for (const auto& f : fixtures) test_fixture(f);
        // 前提检查本身：非整数坐标必须被拒绝，整数坐标必须被接受
        if (f32_distance_exact(fixtures[3].index, fixtures[3].queries.data(), fixtures[3].nq) ||
            !f32_distance_exact(fixtures[2].index, fixtures[2].queries.data(), fixtures[2].nq)) {
            throw std::runtime_error("f32_distance_exact gives a wrong answer");
        }
        std::cout << "PASS: " << runs << " student configurations match the serial reference\n";
        return 0;
    } catch (const std::exception& e) {
        std::cerr << "FAIL: " << e.what() << '\n';
        return 1;
    }
}
