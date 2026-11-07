#include "ivf_search.h"
#include "ivf_stats.h"

#include <fcntl.h>
#include <omp.h>
#include <unistd.h>

#include <algorithm>
#include <charconv>
#include <chrono>
#include <climits>
#include <cmath>
#include <cstring>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <numeric>
#include <stdexcept>
#include <string>

#ifndef IVF_ISA
#define IVF_ISA "default"
#endif

// 学生改动（相对配套代码）：
//   - 新增 --dist/--sched/--coarse/--cutoff/--order/--perf-ctl/--stats-csv/--profile-csv 参数
//   - 新增 --mode profile：单线程分阶段计时（中心选择 / 候选扫描），逐查询输出 C(q)
//   - 记录每次 batch 调用的耗时 call_ms 的 p50/p95：batch=1 时即单查询延迟分位数，
//     batch>1 时是 batch 完成时间（除以 batch 只是分摊开销，不是单查询响应时间）
//   - CSV 增加开关取值和派生统计列
// 未改动：数据加载、串行参考、check_result 逐项检查、计时范围（只包住检索函数调用）。

struct Arguments {
    std::string base = "/var/dataset/sift_base.fbin";
    std::string centroids = "/var/dataset/centroid_4096.fvecs";
    std::string cluster_ids = "/var/dataset/cluster_id_4096.ivecs";
    std::string queries_file = "/var/dataset/sift_query.fbin";
    std::string groundtruth = "/var/dataset/gt.ibin";
    std::string only = "serial", mode = "bench", csv;
    std::string dist = "scalar", sched = "static", coarse = "lib", order = "orig";
    std::string perf_ctl, stats_csv, profile_csv;
    std::size_t queries = 128, batch = 32, repeats = 10, warmup = 1;
    ivf::SearchOptions search;
};

std::size_t number(const std::string& value) {
    std::size_t n;
    const auto result = std::from_chars(value.data(), value.data() + value.size(), n);
    if (result.ec != std::errc{} || result.ptr != value.data() + value.size()) {
        throw std::invalid_argument("invalid integer: " + value);
    }
    return n;
}

ivf::DistKind parse_dist(const std::string& name) {
    if (name == "scalar") return ivf::DistKind::scalar;
    if (name == "f32") return ivf::DistKind::f32;
    if (name == "simd64") return ivf::DistKind::simd64;
    if (name == "simd32") return ivf::DistKind::simd32;
    throw std::invalid_argument("--dist expects scalar|f32|simd64|simd32");
}

// --sched 取 kind 或 kind:chunk（用冒号而不是逗号，避免 CSV 列错位）
void apply_schedule(const std::string& spec) {
    const auto colon = spec.find(':');
    const std::string kind = spec.substr(0, colon);
    const int chunk = colon == std::string::npos ? 0 : int(number(spec.substr(colon + 1)));
    omp_sched_t s;
    if (kind == "static") s = omp_sched_static;
    else if (kind == "dynamic") s = omp_sched_dynamic;
    else if (kind == "guided") s = omp_sched_guided;
    else if (kind == "auto") s = omp_sched_auto;
    else throw std::invalid_argument("--sched expects static|dynamic|guided|auto[:chunk]");
    omp_set_schedule(s, chunk);
}

Arguments parse(int argc, char** argv) {
    Arguments args;
    for (int i = 1; i < argc; i += 2) {
        const std::string key = argv[i];
        if (i + 1 == argc) throw std::invalid_argument("missing value for " + key);
        const std::string value = argv[i + 1];
        if (key == "--base") args.base = value;
        else if (key == "--centroids") args.centroids = value;
        else if (key == "--cluster-ids") args.cluster_ids = value;
        else if (key == "--queries-file") args.queries_file = value;
        else if (key == "--gt") args.groundtruth = value;
        else if (key == "--only") args.only = value;
        else if (key == "--mode") args.mode = value;
        else if (key == "--csv") args.csv = value;
        else if (key == "--queries") args.queries = number(value);
        else if (key == "--batch") args.batch = number(value);
        else if (key == "--repeats") args.repeats = number(value);
        else if (key == "--warmup") args.warmup = number(value);
        else if (key == "--k") args.search.k = number(value);
        else if (key == "--nprobe") args.search.nprobe = number(value);
        else if (key == "--grain") args.search.grain = number(value);
        else if (key == "--cutoff") args.search.cutoff = number(value);
        else if (key == "--dist") args.dist = value;
        else if (key == "--sched") args.sched = value;
        else if (key == "--coarse") args.coarse = value;
        else if (key == "--order") args.order = value;
        else if (key == "--perf-ctl") args.perf_ctl = value;
        else if (key == "--stats-csv") args.stats_csv = value;
        else if (key == "--profile-csv") args.profile_csv = value;
        else if (key == "--threads") {
            const auto n = number(value);
            if (n == 0 || n > INT_MAX) throw std::invalid_argument("invalid thread count");
            args.search.threads = static_cast<int>(n);
        } else throw std::invalid_argument("unknown option: " + key);
    }
    if (!args.queries || !args.batch || !args.repeats || !args.search.k ||
        !args.search.nprobe || !args.search.grain) {
        throw std::invalid_argument("counts must be positive (except warmup)");
    }
    if (args.mode != "check" && args.mode != "bench" && args.mode != "profile") {
        throw std::invalid_argument("--mode expects check, bench or profile");
    }
    args.search.dist = parse_dist(args.dist);
    if (args.coarse != "lib" && args.coarse != "split") {
        throw std::invalid_argument("--coarse expects lib or split");
    }
    args.search.coarse_split = args.coarse == "split";
    if (args.order != "orig" && args.order != "asc" && args.order != "desc") {
        throw std::invalid_argument("--order expects orig, asc or desc");
    }
#ifndef IVF_STATS
    if (!args.stats_csv.empty()) {
        throw std::invalid_argument("--stats-csv needs the IVF_STATS build (make ivf_lab_stats)");
    }
#endif
    return args;
}

ivf::SearchFunction select_strategy(const std::string& name) {
    if (name == "serial") return ivf::search_ivf_serial;
    if (name == "std") return ivf::search_std_thread;
    if (name == "exact") return ivf::search_exact_serial;
    if (name == "omp1") return ivf::search_omp_student_1;
    if (name == "omp2") return ivf::search_omp_student_2;
    if (name == "omp3") return ivf::search_omp_student_3;
    throw std::invalid_argument("unknown strategy: " + name);
}

// 每个查询选中列表的候选总数 C(q)（计时之外计算）
std::vector<std::size_t> candidate_counts(const ivf::IVFIndex& index, const ivf::FloatMatrix& q,
                                          std::size_t count, std::size_t nprobe) {
    std::vector<std::size_t> result(count);
    for (std::size_t i = 0; i < count; ++i) {
        std::size_t c = 0;
        for (auto l : ivf::select_lists(index, q.row(i), nprobe)) {
            c += index.list_ptr[l + 1] - index.list_ptr[l];
        }
        result[i] = c;
    }
    return result;
}

double percentile(std::vector<double> v, double p) {  // 最近秩法
    std::sort(v.begin(), v.end());
    const auto rank = std::size_t(std::ceil(p / 100.0 * double(v.size())));
    return v[std::min(v.size() - 1, rank == 0 ? 0 : rank - 1)];
}

// perf stat --control fifo:ctl,ack 的配合端：发命令并等待 ack
class PerfControl {
public:
    explicit PerfControl(const std::string& spec) {
        if (spec.empty()) return;
        const auto comma = spec.find(',');
        if (comma == std::string::npos) throw std::invalid_argument("--perf-ctl expects ctl,ack");
        ctl_ = open(spec.substr(0, comma).c_str(), O_WRONLY | O_CLOEXEC);
        ack_ = open(spec.substr(comma + 1).c_str(), O_RDONLY | O_CLOEXEC);
        if (ctl_ < 0 || ack_ < 0) throw std::runtime_error("cannot open perf control fifos");
    }
    ~PerfControl() {
        if (ctl_ >= 0) close(ctl_);
        if (ack_ >= 0) close(ack_);
    }
    void command(const char* cmd) {
        if (ctl_ < 0) return;
        const std::string line = std::string(cmd) + "\n";
        if (write(ctl_, line.data(), line.size()) != ssize_t(line.size())) {
            throw std::runtime_error("perf control write failed");
        }
        char buf[16] = {};
        std::size_t got = 0;
        while (got < 4) {  // 等待 "ack\n"
            const auto n = read(ack_, buf + got, sizeof(buf) - 1 - got);
            if (n <= 0) throw std::runtime_error("perf control ack failed");
            got += std::size_t(n);
        }
        if (std::strncmp(buf, "ack", 3) != 0) throw std::runtime_error("unexpected perf ack");
    }

private:
    int ctl_ = -1, ack_ = -1;
};

int profile(const Arguments& args, const ivf::IVFIndex& index, const ivf::FloatMatrix& queries,
            const std::vector<std::size_t>& counts) {
    // 单线程分阶段墙钟计时：每个查询分别计时 select_lists 和标量扫描（含 Top-k），取各次重复的中位数
    std::ofstream csv;
    if (!args.profile_csv.empty()) {
        csv.exceptions(std::ios::failbit | std::ios::badbit);
        csv.open(args.profile_csv);
        csv << "pos,candidates,select_us,scan_us\n" << std::setprecision(10);
    }
    std::vector<ivf::Neighbor> out(args.search.k);
    double sum_sel = 0, sum_scan = 0;
    for (std::size_t r = 0; r < args.warmup; ++r) {
        for (std::size_t q = 0; q < args.queries; ++q) ivf::select_lists(index, queries.row(q), args.search.nprobe);
    }
    for (std::size_t q = 0; q < args.queries; ++q) {
        std::vector<double> sel(args.repeats), scan(args.repeats);
        for (std::size_t r = 0; r < args.repeats; ++r) {
            const auto t0 = std::chrono::steady_clock::now();
            const auto lists = ivf::select_lists(index, queries.row(q), args.search.nprobe);
            const auto t1 = std::chrono::steady_clock::now();
            ivf::TopK best(args.search.k);
            for (auto l : lists) {
                for (std::size_t p = index.list_ptr[l]; p < index.list_ptr[l + 1]; ++p) {
                    best.add({ivf::l2_distance_scalar(queries.row(q), index.vector(p), index.dim), index.ids[p]});
                }
            }
            best.finish(out.data());
            const auto t2 = std::chrono::steady_clock::now();
            sel[r] = std::chrono::duration<double, std::micro>(t1 - t0).count();
            scan[r] = std::chrono::duration<double, std::micro>(t2 - t1).count();
        }
        const double s = percentile(sel, 50), c = percentile(scan, 50);
        sum_sel += s;
        sum_scan += c;
        if (csv.is_open()) csv << q << ',' << counts[q] << ',' << s << ',' << c << '\n';
    }
    std::vector<double> cs(counts.begin(), counts.end());
    std::cout << std::fixed << std::setprecision(3)
              << "profile nprobe=" << args.search.nprobe << " queries=" << args.queries
              << " C(q)[median/p95/max/mean]=" << percentile(cs, 50) << '/' << percentile(cs, 95)
              << '/' << percentile(cs, 100) << '/'
              << std::accumulate(cs.begin(), cs.end(), 0.0) / double(cs.size()) << '\n'
              << "select_us_total=" << sum_sel << " scan_us_total=" << sum_scan
              << " f_sel=" << sum_sel / (sum_sel + sum_scan) << '\n';
    return 0;
}

int run(int argc, char** argv) {
    if (argc == 2 && std::string(argv[1]) == "--help") {
        std::cout << "SIFT IVF-Flat starter\n"
            "  --only serial|std|exact|omp1|omp2|omp3   --mode check|bench|profile\n"
            "  --queries 128   --batch 32   --k 10   --nprobe 8\n"
            "  --threads 4   --grain 1024   --repeats 10   --warmup 1\n"
            "  --dist scalar|f32|simd64|simd32   --sched static|dynamic|guided[:chunk]\n"
            "  --coarse lib|split   --cutoff 0   --order orig|asc|desc\n"
            "  --perf-ctl CTL_FIFO,ACK_FIFO   --stats-csv PATH (stats build)   --profile-csv PATH\n"
            "  --base PATH (.fbin)   --centroids PATH (.fvecs)\n"
            "  --cluster-ids PATH (.ivecs)   --queries-file PATH (.fbin)\n"
            "  --gt PATH (.ibin)   --csv PATH\n";
        return 0;
    }
    auto args = parse(argc, argv);
    const auto search = select_strategy(args.only);
    const auto index = ivf::read_ivf(args.base, args.centroids, args.cluster_ids);
    auto queries = ivf::read_fbin(args.queries_file);
    auto truth = ivf::read_ibin(args.groundtruth);
    if (args.only == "exact") args.search.nprobe = index.nlist;
    if (args.only == "serial" || args.only == "exact") args.search.threads = 1;
    if (queries.dim != index.dim || args.queries > queries.rows || args.queries > truth.rows ||
        args.search.k > index.size || args.search.k > truth.dim || args.search.nprobe > index.nlist) {
        throw std::invalid_argument("query count, dimension, k or nprobe exceeds input bounds");
    }
    for (std::size_t q = 0; q < args.queries; ++q) {
        const auto* row = truth.row(q);
        for (std::size_t j = 0; j < args.search.k; ++j) {
            if (row[j] < 0 || std::size_t(row[j]) >= index.size ||
                std::find(row, row + j, row[j]) != row + j) {
                throw std::invalid_argument("invalid or duplicate ground truth ID");
            }
        }
    }
    const bool uses_f32 = args.search.dist == ivf::DistKind::f32 ||
                          args.search.dist == ivf::DistKind::simd32;
    if (uses_f32 && !ivf::f32_distance_exact(index, queries.data.data(), args.queries)) {
        throw std::invalid_argument("--dist f32/simd32 requires integer coordinates with d*M^2 < 2^24");
    }

    // C(q) 与查询池重排（都在计时之外）；重排时 ground truth 同步重排
    auto counts = candidate_counts(index, queries, args.queries, args.search.nprobe);
    if (args.order != "orig") {
        std::vector<std::size_t> perm(args.queries);
        std::iota(perm.begin(), perm.end(), 0);
        std::stable_sort(perm.begin(), perm.end(), [&](std::size_t a, std::size_t b) {
            return args.order == "asc" ? counts[a] < counts[b] : counts[a] > counts[b];
        });
        auto q2 = queries;
        auto t2 = truth;
        std::vector<std::size_t> c2(args.queries);
        for (std::size_t i = 0; i < args.queries; ++i) {
            std::copy_n(queries.row(perm[i]), queries.dim, q2.data.data() + i * queries.dim);
            std::copy_n(truth.row(perm[i]), truth.dim, t2.data.data() + i * truth.dim);
            c2[i] = counts[perm[i]];
        }
        queries = std::move(q2);
        truth = std::move(t2);
        counts = std::move(c2);
    }

    omp_set_dynamic(0);
    omp_set_num_threads(args.search.threads);
    apply_schedule(args.sched);
    std::cout << "N=" << index.size << " dim=" << index.dim << " nlist=" << index.nlist
              << " strategy=" << args.only << " threads=" << args.search.threads
              << " dist=" << ivf::dist_name(args.search.dist) << " isa=" << IVF_ISA
              << " sched=" << args.sched << " coarse=" << args.coarse
              << " cutoff=" << args.search.cutoff << " order=" << args.order << '\n';
    if (args.mode == "profile") return profile(args, index, queries, counts);

    // 派生统计（解析计算，不计时）
    const bool task_strategy = args.only == "omp2" || args.only == "omp3";
    double blocks_sum = 0, part_bytes_sum = 0;
    for (auto c : counts) {
        const std::size_t nb = (c + args.search.grain - 1) / args.search.grain;
        const bool split = nb > 1 && c > args.search.cutoff;
        blocks_sum += split ? double(nb) : 1.0;
        if (split && args.only == "omp2") part_bytes_sum += double(nb * args.search.k * sizeof(ivf::Neighbor));
    }
    const double mean_c = std::accumulate(counts.begin(), counts.end(), 0.0) / double(args.queries);
    const double blocks_per_query = task_strategy ? blocks_sum / double(args.queries) : 0;
    const double part_bytes_per_query = part_bytes_sum / double(args.queries);
    const std::size_t full_batch = std::min(args.batch, args.queries);
    const int threads_active = args.only == "serial" || args.only == "exact" ? 1
        : args.only == "omp1" || args.only == "std"
            ? int(std::min<std::size_t>(std::size_t(args.search.threads), full_batch))
            : args.search.threads;

    std::vector<ivf::Neighbor> reference(args.queries * args.search.k), output(reference.size());
    const auto reference_search = args.search.nprobe == index.nlist
        ? ivf::search_exact_serial : ivf::search_ivf_serial;
    reference_search(index, queries.data.data(), args.queries, args.search, reference.data());
    const double recall = ivf::recall_at_k(reference, truth, args.queries, args.search.k);
    std::vector<double> calls;  // 本轮每次 batch 调用的耗时
    auto run_once = [&] {
        std::fill(output.begin(), output.end(),
                  ivf::Neighbor{std::numeric_limits<double>::quiet_NaN(), -2});
        calls.clear();
        double ms = 0;
        for (std::size_t begin = 0; begin < args.queries; begin += args.batch) {
            const auto count = std::min(args.batch, args.queries - begin);
            const auto start = std::chrono::steady_clock::now();
            search(index, queries.row(begin), count, args.search, output.data() + begin * args.search.k);
            const double call = std::chrono::duration<double, std::milli>(
                std::chrono::steady_clock::now() - start).count();
            ms += call;
            calls.push_back(call);
        }
        ivf::check_result(output, reference);
        return ms;
    };
    std::cout << std::fixed << std::setprecision(6);
    if (args.mode == "check") {
        run_once();
        std::cout << "correctness=PASS recall@" << args.search.k << '=' << recall << '\n';
        return 0;
    }

    std::ofstream csv;
    if (!args.csv.empty()) {
        csv.exceptions(std::ios::failbit | std::ios::badbit);
        csv.open(args.csv);
        csv << "strategy,threads,queries,batch,k,nprobe,grain,repeat,time_ms,qps,recall,correctness,"
               "dist,isa,sched,coarse,cutoff,order,threads_active,mean_candidates,"
               "blocks_per_query,part_bytes_per_query,call_ms_p50,call_ms_p95\n"
            << std::setprecision(12);
    }
#ifdef IVF_STATS
    std::ofstream stats_csv;
    if (!args.stats_csv.empty()) {
        stats_csv.exceptions(std::ios::failbit | std::ios::badbit);
        stats_csv.open(args.stats_csv);
        stats_csv << "strategy,threads,batch,grain,order,repeat,tid,candidates,tasks,"
                     "busy_ms,select_ms,scan_ms,merge_ms\n" << std::setprecision(10);
    }
    const std::size_t total_candidates = std::accumulate(counts.begin(), counts.end(), std::size_t{0});
#endif
    for (std::size_t r = 0; r < args.warmup; ++r) run_once();
    PerfControl perf(args.perf_ctl);
    perf.command("enable");  // 加载、参考结果和预热都已完成，开始计数
    std::vector<double> times(args.repeats), all_calls;
    for (std::size_t r = 0; r < args.repeats; ++r) {
        IVF_STAT(ivf::stats::reset();)
        times[r] = run_once();
        all_calls.insert(all_calls.end(), calls.begin(), calls.end());
#ifdef IVF_STATS
        if (args.only == "omp1" || args.only == "omp2" || args.only == "std") {
            std::size_t sum = 0;
            for (const auto& s : ivf::stats::slots) sum += s.candidates;
            if (sum != total_candidates) {
                throw std::runtime_error("stats: sum of W_t != total candidates");
            }
        }
        if (stats_csv.is_open()) {
            for (int t = 0; t < args.search.threads && t < ivf::stats::kMaxThreads; ++t) {
                const auto& s = ivf::stats::slots[t];
                stats_csv << args.only << ',' << args.search.threads << ',' << args.batch << ','
                          << args.search.grain << ',' << args.order << ',' << r + 1 << ',' << t << ','
                          << s.candidates << ',' << s.tasks << ',' << s.busy_ns / 1e6 << ','
                          << s.select_ns / 1e6 << ',' << s.scan_ns / 1e6 << ',' << s.merge_ns / 1e6 << '\n';
            }
        }
#endif
        if (csv.is_open()) {
            csv << args.only << ',' << args.search.threads << ',' << args.queries << ','
                << args.batch << ',' << args.search.k << ',' << args.search.nprobe << ','
                << args.search.grain << ',' << r + 1 << ',' << times[r] << ','
                << args.queries * 1000.0 / times[r] << ',' << recall << ",PASS,"
                << ivf::dist_name(args.search.dist) << ',' << IVF_ISA << ',' << args.sched << ','
                << args.coarse << ',' << args.search.cutoff << ',' << args.order << ','
                << threads_active << ',' << mean_c << ',' << blocks_per_query << ','
                << part_bytes_per_query << ',' << percentile(calls, 50) << ','
                << percentile(calls, 95) << '\n';
        }
    }
    perf.command("disable");
    if (csv.is_open()) csv.close();
    std::sort(times.begin(), times.end());
    const double median = (times[(times.size() - 1) / 2] + times[times.size() / 2]) / 2;
    std::cout << "correctness=PASS recall@" << args.search.k << '=' << recall << '\n'
              << "time_ms[min/median/max]=" << times.front() << '/' << median << '/' << times.back()
              << " qps=" << args.queries * 1000.0 / median << '\n'
              << "call_ms[p50/p95]=" << percentile(all_calls, 50) << '/' << percentile(all_calls, 95)
              << " mean_C=" << mean_c << " threads_active=" << threads_active << '\n';
    return 0;
}

int main(int argc, char** argv) {
    try {
        return run(argc, argv);
    } catch (const std::exception& error) {
        std::cerr << "error: " << error.what() << '\n';
        return 1;
    }
}
