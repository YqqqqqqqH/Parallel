// 学生实现：两种 OpenMP 检索（omp1 按查询、omp2 查询内任务）、critical 反面对照（omp3）
// 以及 std::thread 对照版本。距离函数见 ivf_simd.cpp，统计插桩见 ivf_stats.h。
#include "ivf_search.h"
#include "ivf_stats.h"

#include <omp.h>

#include <algorithm>
#include <stdexcept>
#include <thread>
#include <vector>

namespace ivf {
namespace {

// ---- 距离函数对象：开关在每次调用分派一次，扫描循环内不再判断 ----
struct DistScalar {
    double operator()(const float* a, const float* b, std::size_t d) const {
        return l2_distance_scalar(a, b, d);
    }
};
struct DistF32 {
    double operator()(const float* a, const float* b, std::size_t d) const {
        return l2_distance_f32(a, b, d);
    }
};
struct DistSimd64 {
    double operator()(const float* a, const float* b, std::size_t d) const {
        return l2_distance_simd64(a, b, d);
    }
};
struct DistSimd32 {
    double operator()(const float* a, const float* b, std::size_t d) const {
        return l2_distance_simd32(a, b, d);
    }
};

template <class Fn>
void with_distance(DistKind kind, Fn&& fn) {
    switch (kind) {
    case DistKind::scalar: fn(DistScalar{}); return;
    case DistKind::f32: fn(DistF32{}); return;
    case DistKind::simd64: fn(DistSimd64{}); return;
    case DistKind::simd32: fn(DistSimd32{}); return;
    }
    throw std::logic_error("unknown distance kind");
}

// 中心距离拆成任务时每个任务负责的中心数（4096 个中心 → 16 个任务）
constexpr std::size_t kCentroidChunk = 256;

// 选中的 nprobe 个列表首尾相接，构成虚拟候选区间 [0, C)。
// off[i] 是第 i 个选中列表在虚拟区间中的起点，off[nprobe] = C(q)。
struct Candidates {
    std::vector<std::uint32_t> lists;
    std::vector<std::size_t> off;
    std::size_t total() const { return off.back(); }
};

Candidates make_candidates(const IVFIndex& index, std::vector<std::uint32_t> lists) {
    Candidates c{std::move(lists), {}};
    c.off.assign(c.lists.size() + 1, 0);
    for (std::size_t i = 0; i < c.lists.size(); ++i) {
        const auto l = c.lists[i];
        c.off[i + 1] = c.off[i] + (index.list_ptr[l + 1] - index.list_ptr[l]);
    }
    return c;
}

// 扫描虚拟区间 [begin, end) 中的候选，每个候选恰好交给 sink 一次。块可以跨越列表边界。
template <class Dist, class Sink>
void scan_range(const IVFIndex& index, const float* query, const std::uint32_t* lists,
                const std::size_t* off, std::size_t nprobe, std::size_t begin, std::size_t end,
                Dist dist, Sink&& sink) {
    if (begin >= end) return;
    // 最后一个满足 off[li] <= begin 的位置；空列表（off[i] == off[i+1]）会被跳过
    std::size_t li = std::size_t(std::upper_bound(off, off + nprobe + 1, begin) - off) - 1;
    std::size_t v = begin;
    while (v < end) {
        const std::size_t stop = std::min(end, off[li + 1]);
        std::size_t pos = index.list_ptr[lists[li]] + (v - off[li]);
        for (; v < stop; ++v, ++pos) {
            sink(Neighbor{dist(query, index.vector(pos), index.dim), index.ids[pos]});
        }
        ++li;
    }
}

// 单个查询的完整串行检索（omp1 与 std::thread 共用），结构与 search_ivf_serial 相同
template <class Dist>
void search_one(const IVFIndex& index, const float* query, const SearchOptions& o, Dist dist,
                Neighbor* out, [[maybe_unused]] int tid) {
    IVF_STAT(const double t0 = stats::now_ns();)
    const auto lists = select_lists(index, query, o.nprobe);
    IVF_STAT(const double t1 = stats::now_ns(); std::uint64_t cand = 0;)
    TopK best(o.k);
    for (auto list : lists) {
        const std::size_t b = index.list_ptr[list], e = index.list_ptr[list + 1];
        for (std::size_t p = b; p < e; ++p) {
            best.add({dist(query, index.vector(p), index.dim), index.ids[p]});
        }
        IVF_STAT(cand += e - b;)
    }
    best.finish(out);
    IVF_STAT(const double t2 = stats::now_ns(); auto& s = stats::slot(tid);
             s.select_ns += t1 - t0; s.scan_ns += t2 - t1; s.busy_ns += t2 - t0;
             s.candidates += cand; ++s.tasks;)
}

// ---------------- omp1：按查询并行 ----------------
template <class Dist>
void omp1_impl(const IVFIndex& index, const float* queries, std::size_t count,
               const SearchOptions& o, Neighbor* output, Dist dist) {
    // batch 小于线程数时，只有 count 个线程有事可做
    const int team = int(std::min<std::size_t>(std::size_t(o.threads), count));
#pragma omp parallel for schedule(runtime) num_threads(team) default(none) \
    shared(index, queries, count, o, output, dist)
    for (std::size_t q = 0; q < count; ++q) {
        search_one(index, queries + q * index.dim, o, dist, output + q * o.k, omp_get_thread_num());
    }
}

// ---------------- omp2：查询内任务划分 ----------------

// 中心距离拆成任务计算，再用与 select_lists 相同的比较器选前 nprobe 个。
// better 是 (distance, id) 上的严格全序，每个中心距离由同一个 l2_distance_scalar 算出，
// 因此选中的列表与 select_lists 的结果逐项相同。
std::vector<std::uint32_t> select_lists_split(const IVFIndex& index, const float* query,
                                              std::size_t nprobe) {
    std::vector<Neighbor> centers(index.nlist);
    const IVFIndex* ix = &index;
    Neighbor* cp = centers.data();
    const std::size_t nlist = index.nlist, chunk = kCentroidChunk;
    const std::size_t nchunks = (nlist + chunk - 1) / chunk;
#pragma omp taskloop grainsize(1) default(none) firstprivate(ix, query, cp, nlist, chunk, nchunks)
    for (std::size_t c = 0; c < nchunks; ++c) {
        IVF_STAT(const double t0 = stats::now_ns();)
        const std::size_t e = std::min(nlist, (c + 1) * chunk);
        for (std::size_t l = c * chunk; l < e; ++l) {
            cp[l] = {l2_distance_scalar(query, ix->centroid(l), ix->dim), static_cast<std::int32_t>(l)};
        }
        IVF_STAT(const double dt = stats::now_ns() - t0; auto& s = stats::slot(omp_get_thread_num());
                 s.select_ns += dt; s.busy_ns += dt; ++s.tasks;)
    }
    // taskloop 的隐式 taskgroup 结束：所有中心距离都已写入 centers
    IVF_STAT(const double t0 = stats::now_ns();)
    std::partial_sort(centers.begin(), centers.begin() + nprobe, centers.end(), better);
    std::vector<std::uint32_t> lists(nprobe);
    for (std::size_t i = 0; i < nprobe; ++i) lists[i] = centers[i].id;
    IVF_STAT(const double dt = stats::now_ns() - t0; auto& s = stats::slot(omp_get_thread_num());
             s.select_ns += dt; s.busy_ns += dt;)
    return lists;
}

Candidates choose_lists(const IVFIndex& index, const float* query, const SearchOptions& o) {
    if (o.coarse_split) return make_candidates(index, select_lists_split(index, query, o.nprobe));
    IVF_STAT(const double t0 = stats::now_ns();)
    auto c = make_candidates(index, select_lists(index, query, o.nprobe));
    IVF_STAT(const double dt = stats::now_ns() - t0; auto& s = stats::slot(omp_get_thread_num());
             s.select_ns += dt; s.busy_ns += dt;)
    return c;
}

// 不拆块，直接在当前任务里扫描全部候选
template <class Dist>
void scan_inline(const IVFIndex& index, const float* query, const Candidates& c,
                 const SearchOptions& o, Dist dist, Neighbor* out) {
    IVF_STAT(const double t0 = stats::now_ns();)
    TopK best(o.k);
    scan_range(index, query, c.lists.data(), c.off.data(), c.lists.size(), 0, c.total(), dist,
               [&](Neighbor n) { best.add(n); });
    best.finish(out);
    IVF_STAT(const double dt = stats::now_ns() - t0; auto& s = stats::slot(omp_get_thread_num());
             s.scan_ns += dt; s.busy_ns += dt; s.candidates += c.total(); ++s.tasks;)
}

// 查询任务 Tq：选列表 → 划分候选块 → 每块局部 Top-k → 等待 → 合并
template <class Dist>
void omp2_query(const IVFIndex& index, const float* query, const SearchOptions& o, Dist dist,
                Neighbor* out) {
    const Candidates c = choose_lists(index, query, o);
    const std::size_t total = c.total(), grain = o.grain, k = o.k;
    const std::size_t nb = (total + grain - 1) / grain;
    if (nb <= 1 || total <= o.cutoff) {
        scan_inline(index, query, c, o, dist, out);
        return;
    }
    // part 归 Tq 所有：块 b 只写 part[b*k, (b+1)*k)，Tq 在 taskloop 结束后读取，Tq 返回时释放。
    // 注意：Tq 内的局部变量在嵌套 taskloop 中默认是 firstprivate，会被逐任务复制，
    // 所以这里只把裸指针以 firstprivate 传入，并用 default(none) 强制写明。
    std::vector<Neighbor> part(nb * k);
    const IVFIndex* ix = &index;
    const std::uint32_t* lp = c.lists.data();
    const std::size_t* op = c.off.data();
    const std::size_t np = c.lists.size();
    Neighbor* pp = part.data();
#pragma omp taskloop grainsize(1) default(none) \
    firstprivate(ix, query, lp, op, np, nb, total, k, grain, pp, dist)
    for (std::size_t b = 0; b < nb; ++b) {
        IVF_STAT(const double t0 = stats::now_ns();)
        const std::size_t begin = b * grain, end = std::min(total, begin + grain);
        TopK local(k);
        scan_range(*ix, query, lp, op, np, begin, end, dist, [&](Neighbor n) { local.add(n); });
        local.finish(pp + b * k);
        IVF_STAT(const double dt = stats::now_ns() - t0; auto& s = stats::slot(omp_get_thread_num());
                 s.scan_ns += dt; s.busy_ns += dt; s.candidates += end - begin; ++s.tasks;)
    }
    // taskloop 默认带隐式 taskgroup：此处所有块任务（及其后代）均已完成，可以安全读取 part。
    // 每块保留 k 个已足够：全局前 k 名中的任一元素，在其所在块内排名也不会超过 k。
    IVF_STAT(const double t0 = stats::now_ns();)
    TopK best(k);
    for (const auto& e : part) {
        if (e.id != -1) best.add(e);  // 块内候选不足 k 时的填充项不参与合并
    }
    best.finish(out);
    IVF_STAT(const double dt = stats::now_ns() - t0; auto& s = stats::slot(omp_get_thread_num());
             s.merge_ns += dt; s.busy_ns += dt;)
}

template <class Dist>
void omp2_impl(const IVFIndex& index, const float* queries, std::size_t count,
               const SearchOptions& o, Neighbor* output, Dist dist) {
    // 每次 batch 调用只建立这一个线程团队；所有查询的任务都在其中执行
#pragma omp parallel num_threads(o.threads) default(none) \
    shared(index, queries, count, o, output, dist)
#pragma omp single
    for (std::size_t q = 0; q < count; ++q) {
#pragma omp task default(none) firstprivate(q) shared(index, queries, o, output, dist)
        omp2_query(index, queries + q * index.dim, o, dist, output + q * o.k);
    }
    // single 结束处的隐式 barrier 会等待全部任务完成
}

// ---------------- omp3：critical 反面对照 ----------------
template <class Dist>
void omp3_query(const IVFIndex& index, const float* query, const SearchOptions& o, Dist dist,
                Neighbor* out) {
    const Candidates c = make_candidates(index, select_lists(index, query, o.nprobe));
    const std::size_t total = c.total(), grain = o.grain;
    const std::size_t nb = (total + grain - 1) / grain;
    TopK shared_best(o.k);
    if (nb <= 1 || total <= o.cutoff) {
        scan_range(index, query, c.lists.data(), c.off.data(), c.lists.size(), 0, total, dist,
                   [&](Neighbor n) { shared_best.add(n); });
        shared_best.finish(out);
        return;
    }
    const IVFIndex* ix = &index;
    const std::uint32_t* lp = c.lists.data();
    const std::size_t* op = c.off.data();
    const std::size_t np = c.lists.size();
    TopK* sb = &shared_best;
#pragma omp taskloop grainsize(1) default(none) firstprivate(ix, query, lp, op, np, nb, total, grain, sb, dist)
    for (std::size_t b = 0; b < nb; ++b) {
        const std::size_t begin = b * grain, end = std::min(total, begin + grain);
        scan_range(*ix, query, lp, op, np, begin, end, dist, [sb](Neighbor n) {
#pragma omp critical(ivf_omp3_topk)
            sb->add(n);
        });
    }
    shared_best.finish(out);
}

template <class Dist>
void omp3_impl(const IVFIndex& index, const float* queries, std::size_t count,
               const SearchOptions& o, Neighbor* output, Dist dist) {
#pragma omp parallel num_threads(o.threads) default(none) \
    shared(index, queries, count, o, output, dist)
#pragma omp single
    for (std::size_t q = 0; q < count; ++q) {
#pragma omp task default(none) firstprivate(q) shared(index, queries, o, output, dist)
        omp3_query(index, queries + q * index.dim, o, dist, output + q * o.k);
    }
}

}  // namespace

// ---------------- std::thread 对照 ----------------
// 每次调用创建 nt-1 个线程，调用线程自己处理第 0 段；返回前全部 join。
// 区间划分与 libgomp 的 schedule(static) 相同：前 count % nt 个线程各多分 1 个查询。
// 按题目要求只使用公共的 select_lists 和 l2_distance_scalar。
void search_std_thread(const IVFIndex& index, const float* queries, std::size_t count,
                       const SearchOptions& options, Neighbor* output) {
    if (count == 0) return;
    const std::size_t nt = std::max<std::size_t>(
        1, std::min<std::size_t>(std::size_t(options.threads), count));
    auto work = [&](std::size_t t) {
        const std::size_t base = count / nt, extra = count % nt;
        const std::size_t begin = t * base + std::min(t, extra);
        const std::size_t end = begin + base + (t < extra ? 1 : 0);
        for (std::size_t q = begin; q < end; ++q) {
            search_one(index, queries + q * index.dim, options, DistScalar{},
                       output + q * options.k, int(t));
        }
    };
    std::vector<std::thread> workers;
    workers.reserve(nt - 1);
    try {
        for (std::size_t t = 1; t < nt; ++t) workers.emplace_back(work, t);
        work(0);
    } catch (...) {
        for (auto& w : workers) w.join();
        throw;
    }
    for (auto& w : workers) w.join();
}

void search_omp_student_1(const IVFIndex& index, const float* queries, std::size_t count,
                          const SearchOptions& options, Neighbor* output) {
    with_distance(options.dist, [&](auto dist) {
        omp1_impl(index, queries, count, options, output, dist);
    });
}

void search_omp_student_2(const IVFIndex& index, const float* queries, std::size_t count,
                          const SearchOptions& options, Neighbor* output) {
    with_distance(options.dist, [&](auto dist) {
        omp2_impl(index, queries, count, options, output, dist);
    });
}

void search_omp_student_3(const IVFIndex& index, const float* queries, std::size_t count,
                          const SearchOptions& options, Neighbor* output) {
    with_distance(options.dist, [&](auto dist) {
        omp3_impl(index, queries, count, options, output, dist);
    });
}

}
