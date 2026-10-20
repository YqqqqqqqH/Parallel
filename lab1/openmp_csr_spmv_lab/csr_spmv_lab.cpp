#include <algorithm>
#include <chrono>
#include <cmath>
#include <cstddef>
#include <cstdlib>
#include <exception>
#include <functional>
#include <iomanip>
#include <iostream>
#include <limits>
#include <numeric>
#include <random>
#include <sstream>
#include <stdexcept>
#include <string>
#include <thread>
#include <vector>

#ifdef _OPENMP
#include <omp.h>
#else
// 未启用 OpenMP 时的最小替身：保证不加 -fopenmp 也能编译，此时所有 OpenMP 策略退化为串行。
static int omp_get_thread_num() { return 0; }
static int omp_get_num_threads() { return 1; }
static int omp_get_max_threads() { return 1; }
#endif

#ifdef SPMV_TRACE
#include <sched.h>
#endif

struct CsrMatrix {
    int rows = 0;
    int cols = 0;
    std::vector<int> row_ptr;
    std::vector<int> col_idx;
    std::vector<double> values;
};

struct Options {
    int rows = 10000;
    int cols = 100000;
    int normal_nnz = 32;
    int long_rows = 32;
    int long_nnz = 20000;
    int threads = 8;
    int repeats = 10;
    unsigned seed = 20260926u;
    // 以下为实验扩展参数
    std::string sched = "dynamic";      // student_1 的 schedule(runtime) 类型
    int chunk = 64;                     // student_1 的 chunk，<=0 表示用运行时默认值
    int nnz_chunk = 4096;               // student_3 每块包含的非零元个数
    std::vector<std::string> only;      // 只运行这些策略（按给定顺序），为空表示全部
    bool csv = false;                   // 以 CSV 形式输出，便于脚本汇总
};

static const std::vector<std::string> kStrategyKeys = {"serial", "thread", "omp1", "omp2",
                                                       "omp3"};

static void usage(const char* program) {
    std::cout
        << "Usage: " << program << " [options]\n"
        << "  --rows N          number of rows, default 10000\n"
        << "  --cols N          number of columns, default 100000\n"
        << "  --normal-nnz N    nnz per ordinary row, default 32\n"
        << "  --long-rows N     number of skewed long rows, default 32\n"
        << "  --long-nnz N      nnz per long row, default 20000\n"
        << "  --threads N       std::thread/OpenMP threads, default 8\n"
        << "  --repeats N       timed repetitions, default 10\n"
        << "  --seed N          fixed random seed, default 20260926\n"
        << "  --sched KIND      omp1 schedule: static|dynamic|guided|auto, default dynamic\n"
        << "  --chunk N         omp1 chunk size (<=0: runtime default), default 64\n"
        << "  --nnz-chunk N     omp3 nonzeros per dynamic chunk, default 4096\n"
        << "  --only LIST       comma list of serial,thread,omp1,omp2,omp3 (run in order)\n"
        << "  --csv             print one CSV row per strategy\n";
}

static int read_int_arg(int argc, char** argv, int& i, const std::string& name) {
    if (i + 1 >= argc) {
        throw std::invalid_argument("missing value for " + name);
    }
    return std::stoi(argv[++i]);
}

static std::string read_str_arg(int argc, char** argv, int& i, const std::string& name) {
    if (i + 1 >= argc) {
        throw std::invalid_argument("missing value for " + name);
    }
    return argv[++i];
}

static std::vector<std::string> split_list(const std::string& text) {
    std::vector<std::string> items;
    std::stringstream stream(text);
    std::string item;
    while (std::getline(stream, item, ',')) {
        if (!item.empty()) {
            items.push_back(item);
        }
    }
    return items;
}

static Options parse_options(int argc, char** argv) {
    Options options;
    for (int i = 1; i < argc; ++i) {
        const std::string arg = argv[i];
        if (arg == "--help" || arg == "-h") {
            usage(argv[0]);
            std::exit(0);
        } else if (arg == "--rows") {
            options.rows = read_int_arg(argc, argv, i, arg);
        } else if (arg == "--cols") {
            options.cols = read_int_arg(argc, argv, i, arg);
        } else if (arg == "--normal-nnz") {
            options.normal_nnz = read_int_arg(argc, argv, i, arg);
        } else if (arg == "--long-rows") {
            options.long_rows = read_int_arg(argc, argv, i, arg);
        } else if (arg == "--long-nnz") {
            options.long_nnz = read_int_arg(argc, argv, i, arg);
        } else if (arg == "--threads") {
            options.threads = read_int_arg(argc, argv, i, arg);
        } else if (arg == "--repeats") {
            options.repeats = read_int_arg(argc, argv, i, arg);
        } else if (arg == "--seed") {
            options.seed = static_cast<unsigned>(read_int_arg(argc, argv, i, arg));
        } else if (arg == "--sched") {
            options.sched = read_str_arg(argc, argv, i, arg);
        } else if (arg == "--chunk") {
            options.chunk = read_int_arg(argc, argv, i, arg);
        } else if (arg == "--nnz-chunk") {
            options.nnz_chunk = read_int_arg(argc, argv, i, arg);
        } else if (arg == "--only") {
            options.only = split_list(read_str_arg(argc, argv, i, arg));
        } else if (arg == "--csv") {
            options.csv = true;
        } else {
            throw std::invalid_argument("unknown option: " + arg);
        }
    }

    if (options.rows <= 0 || options.cols <= 0 || options.normal_nnz < 0 ||
        options.long_rows < 0 || options.long_rows > options.rows ||
        options.long_nnz < 0 || options.long_nnz > options.cols ||
        options.threads <= 0 || options.repeats <= 0 || options.nnz_chunk <= 0) {
        throw std::invalid_argument("invalid option value");
    }
    if (options.sched != "static" && options.sched != "dynamic" && options.sched != "guided" &&
        options.sched != "auto") {
        throw std::invalid_argument("unknown schedule: " + options.sched);
    }
    for (const std::string& key : options.only) {
        if (std::find(kStrategyKeys.begin(), kStrategyKeys.end(), key) == kStrategyKeys.end()) {
            throw std::invalid_argument("unknown strategy in --only: " + key);
        }
    }
    if (options.only.empty()) {
        options.only = kStrategyKeys;
    }
    return options;
}

static CsrMatrix make_skewed_matrix(const Options& options) {
    CsrMatrix matrix;
    matrix.rows = options.rows;
    matrix.cols = options.cols;
    matrix.row_ptr.resize(static_cast<std::size_t>(matrix.rows) + 1, 0);

    std::mt19937 rng(options.seed);
    std::vector<int> row_ids(matrix.rows);
    std::iota(row_ids.begin(), row_ids.end(), 0);
    std::shuffle(row_ids.begin(), row_ids.end(), rng);
    std::vector<char> is_long(matrix.rows, false);
    for (int i = 0; i < options.long_rows; ++i) {
        is_long[row_ids[i]] = true;
    }

    std::uniform_real_distribution<double> value_dist(-1.0, 1.0);
    std::uniform_int_distribution<int> column_dist(0, options.cols - 1);

    for (int row = 0; row < matrix.rows; ++row) {
        const int nnz = is_long[row] ? options.long_nnz : options.normal_nnz;
        matrix.row_ptr[row + 1] = matrix.row_ptr[row] + nnz;
        for (int k = 0; k < nnz; ++k) {
            matrix.col_idx.push_back(column_dist(rng));
            matrix.values.push_back(value_dist(rng));
        }
    }
    return matrix;
}

static std::vector<double> make_vector(int size, unsigned seed) {
    std::mt19937 rng(seed ^ 0x9e3779b9u);
    std::uniform_real_distribution<double> dist(-1.0, 1.0);
    std::vector<double> x(size);
    for (double& value : x) {
        value = dist(rng);
    }
    return x;
}

static void spmv_serial(const CsrMatrix& matrix, const std::vector<double>& x,
                        std::vector<double>& y) {
    for (int row = 0; row < matrix.rows; ++row) {
        double sum = 0.0;
        for (int p = matrix.row_ptr[row]; p < matrix.row_ptr[row + 1]; ++p) {
            sum += matrix.values[p] * x[matrix.col_idx[p]];
        }
        y[row] = sum;
    }
}

static void spmv_std_thread(const CsrMatrix& matrix, const std::vector<double>& x,
                            std::vector<double>& y, int thread_count) {
    const int workers = std::max(1, std::min(thread_count, matrix.rows));
    std::vector<std::thread> threads;
    threads.reserve(workers);

    for (int worker = 0; worker < workers; ++worker) {
        const int begin = matrix.rows * worker / workers;
        const int end = matrix.rows * (worker + 1) / workers;
        threads.emplace_back([&, begin, end]() {
            for (int row = begin; row < end; ++row) {
                double sum = 0.0;
                for (int p = matrix.row_ptr[row]; p < matrix.row_ptr[row + 1]; ++p) {
                    sum += matrix.values[p] * x[matrix.col_idx[p]];
                }
                y[row] = sum;
            }
        });
    }
    for (std::thread& thread : threads) {
        thread.join();
    }
}

// ---------------------------------------------------------------------------
// 每线程时间线插桩（仅 -DSPMV_TRACE 编译时生效，用于 breakdown 实验；主计时不开启）
// 记录每个线程进入/离开核心计算的时刻、所在 CPU 和处理的非零元数，只保留最后一次调用。
// ---------------------------------------------------------------------------
#ifdef SPMV_TRACE
struct ThreadTrace {
    double begin_us = 0.0;
    double end_us = 0.0;
    long long nnz = 0;
    int cpu = -1;
};
static std::vector<ThreadTrace> g_trace;
static std::chrono::steady_clock::time_point g_trace_origin;

static double trace_now_us() {
    return std::chrono::duration<double, std::micro>(std::chrono::steady_clock::now() -
                                                     g_trace_origin)
        .count();
}
#define TRACE_RESET()                                             \
    do {                                                          \
        g_trace.assign(omp_get_max_threads(), ThreadTrace{});     \
        g_trace_origin = std::chrono::steady_clock::now();        \
    } while (0)
#define TRACE_BEGIN(tid)                         \
    do {                                         \
        g_trace[tid].begin_us = trace_now_us();  \
        g_trace[tid].cpu = sched_getcpu();       \
    } while (0)
#define TRACE_END(tid, n)                        \
    do {                                         \
        g_trace[tid].end_us = trace_now_us();    \
        g_trace[tid].nnz = (n);                  \
    } while (0)
#define TRACE_ADD(var, n) ((var) += (n))
#else
#define TRACE_RESET() ((void)0)
#define TRACE_BEGIN(tid) ((void)0)
#define TRACE_END(tid, n) ((void)0)
#define TRACE_ADD(var, n) ((void)0)
#endif

// student_3 的块大小，由 --nnz-chunk 设置（student 函数签名固定，只能经全局变量传参）
static int g_nnz_chunk = 4096;

// 策略 1：按行切分 + schedule(runtime)。
// 调度类型与 chunk 由 --sched/--chunk 经 omp_set_schedule 设置。
// --sched static 时与 std::thread 基线的连续行分块一致（边界最多差 1 行），
// 两者的时间差因此只来自线程管理方式，可用来做公平对照。
static void spmv_omp_student_1(const CsrMatrix& matrix,
                                     const std::vector<double>& x,
                                     std::vector<double>& y) {
    TRACE_RESET();
#pragma omp parallel
    {
        [[maybe_unused]] const int tid = omp_get_thread_num();
        [[maybe_unused]] long long traced_nnz = 0;
        TRACE_BEGIN(tid);
#pragma omp for schedule(runtime) nowait
        for (int row = 0; row < matrix.rows; ++row) {
            double sum = 0.0;
            for (int p = matrix.row_ptr[row]; p < matrix.row_ptr[row + 1]; ++p) {
                sum += matrix.values[p] * x[matrix.col_idx[p]];
            }
            y[row] = sum;
            TRACE_ADD(traced_nnz, matrix.row_ptr[row + 1] - matrix.row_ptr[row]);
        }
        TRACE_END(tid, traced_nnz);
    }
}

// 处理非零元区间 [nz_begin, nz_end)，last 为真时右端闭合（负责矩阵末尾的空行）。
// 归属规则：起点 row_ptr[r] 落在本区间内的行 r 由本区间写 y[r]，只累加区间内的部分，
// 超出 nz_end 的尾巴由后续区间以 carry 的形式补上；空行也按起点归属，因此一定会被写 0。
// 区间开头若落在一条更早开始的行中间，这段部分和作为返回值，行号写入 carry_row（否则为 -1）。
static double spmv_nnz_segment(const CsrMatrix& matrix, const std::vector<double>& x,
                               std::vector<double>& y, int nz_begin, int nz_end, bool last,
                               int& carry_row) {
    const int* row_ptr = matrix.row_ptr.data();
    const int* col_idx = matrix.col_idx.data();
    const double* values = matrix.values.data();

    // 第一条起点 >= nz_begin 的行
    int row = static_cast<int>(std::lower_bound(row_ptr, row_ptr + matrix.rows, nz_begin) -
                               row_ptr);

    double carry = 0.0;
    carry_row = -1;
    const int head_end = std::min(nz_end, row_ptr[row]);
    if (nz_begin < head_end) {
        for (int p = nz_begin; p < head_end; ++p) {
            carry += values[p] * x[col_idx[p]];
        }
        carry_row = row - 1;
    }

    for (; row < matrix.rows && (last || row_ptr[row] < nz_end); ++row) {
        const int end = std::min(row_ptr[row + 1], nz_end);
        double sum = 0.0;
        for (int p = row_ptr[row]; p < end; ++p) {
            sum += values[p] * x[col_idx[p]];
        }
        y[row] = sum;
    }
    return carry;
}

// 策略 2：按非零元静态均分。线程 t 负责 [W*t/p, W*(t+1)/p) 的非零元，
// 用二分查找在 row_ptr 上定位起始行；长行会被拆给多个线程，
// 拆出的部分和在并行区结束后按区间顺序串行合并（只有 O(p) 次加法）。
static void spmv_omp_student_2(const CsrMatrix& matrix,
                                      const std::vector<double>& x,
                                      std::vector<double>& y) {
    const int nnz = matrix.row_ptr[matrix.rows];
    const int max_threads = omp_get_max_threads();
    static std::vector<double> carry;
    static std::vector<int> carry_row;
    carry.assign(max_threads, 0.0);
    carry_row.assign(max_threads, -1);

    TRACE_RESET();
#pragma omp parallel
    {
        const int tid = omp_get_thread_num();
        const int team = omp_get_num_threads();
        const int nz_begin = static_cast<int>(static_cast<long long>(nnz) * tid / team);
        const int nz_end = static_cast<int>(static_cast<long long>(nnz) * (tid + 1) / team);
        TRACE_BEGIN(tid);
        carry[tid] = spmv_nnz_segment(matrix, x, y, nz_begin, nz_end, tid == team - 1,
                                      carry_row[tid]);
        TRACE_END(tid, nz_end - nz_begin);
    }

    // 区间顺序固定，合并结果可复现
    for (int s = 0; s < max_threads; ++s) {
        if (carry_row[s] >= 0) {
            y[carry_row[s]] += carry[s];
        }
    }
}

// 策略 3：按非零元切成固定大小的小块（--nnz-chunk），schedule(dynamic) 领取。
// 既能拆开长行，又能让跑得快的线程多领块，用来应对线程速度不一致（P/E 核、SMT、系统噪声）。
static void spmv_omp_student_3(const CsrMatrix& matrix,
                               const std::vector<double>& x,
                               std::vector<double>& y) {
    const int nnz = matrix.row_ptr[matrix.rows];
    const int chunk = std::max(1, g_nnz_chunk);
    // nnz 为 0 时也保留 1 块，由它负责把全部空行写 0
    const int chunks =
        std::max(1, static_cast<int>((static_cast<long long>(nnz) + chunk - 1) / chunk));
    static std::vector<double> carry;
    static std::vector<int> carry_row;
    carry.resize(chunks);
    carry_row.resize(chunks);

    TRACE_RESET();
#pragma omp parallel
    {
        [[maybe_unused]] const int tid = omp_get_thread_num();
        [[maybe_unused]] long long traced_nnz = 0;
        TRACE_BEGIN(tid);
#pragma omp for schedule(dynamic, 1) nowait
        for (int c = 0; c < chunks; ++c) {
            const int nz_begin =
                static_cast<int>(std::min<long long>(nnz, static_cast<long long>(c) * chunk));
            const int nz_end = static_cast<int>(
                std::min<long long>(nnz, static_cast<long long>(c + 1) * chunk));
            carry[c] = spmv_nnz_segment(matrix, x, y, nz_begin, nz_end, c == chunks - 1,
                                        carry_row[c]);
            TRACE_ADD(traced_nnz, nz_end - nz_begin);
        }
        TRACE_END(tid, traced_nnz);
    }

    for (int c = 0; c < chunks; ++c) {
        if (carry_row[c] >= 0) {
            y[carry_row[c]] += carry[c];
        }
    }
}

static bool check_result(const std::vector<double>& expected,
                         const std::vector<double>& actual,
                         double abs_tol = 1e-10, double rel_tol = 1e-10) {
    if (expected.size() != actual.size()) {
        return false;
    }
    for (std::size_t i = 0; i < expected.size(); ++i) {
        const double error = std::abs(expected[i] - actual[i]);
        const double scale = std::max(1.0, std::abs(expected[i]));
        if (error > abs_tol + rel_tol * scale) {
            std::cerr << "mismatch at row " << i << ": expected=" << std::setprecision(17)
                      << expected[i] << ", actual=" << actual[i] << ", error=" << error
                      << '\n';
            return false;
        }
    }
    return true;
}

// 诊断信息（不替代 check_result）：最大绝对误差，以及"误差 / 容差"的最大比值（<1 即在容差内）。
struct ErrorStats {
    double max_abs = 0.0;
    double tol_ratio = 0.0;
};

static ErrorStats measure_error(const std::vector<double>& expected,
                                const std::vector<double>& actual,
                                double abs_tol = 1e-10, double rel_tol = 1e-10) {
    ErrorStats stats;
    for (std::size_t i = 0; i < expected.size(); ++i) {
        const double error = std::abs(expected[i] - actual[i]);
        const double scale = std::max(1.0, std::abs(expected[i]));
        stats.max_abs = std::max(stats.max_abs, error);
        stats.tol_ratio = std::max(stats.tol_ratio, error / (abs_tol + rel_tol * scale));
    }
    return stats;
}

struct TimingStats {
    double median_ms = 0.0;
    double min_ms = 0.0;
    double max_ms = 0.0;
    double mean_ms = 0.0;
    ErrorStats error;
};

template <typename Spmv>
static TimingStats benchmark(Spmv&& spmv, const std::vector<double>& reference,
                             std::vector<double>& output, int repeats) {
    // 先把输出填成毒值：多个策略共用同一个 output，若某策略漏写了某行，
    // 原 harness 会"继承"上一个策略的正确结果而蒙混过关。
    std::fill(output.begin(), output.end(), 1e300);

    // 首次调用兼作 warm-up 与正确性检查，不计入计时
    spmv(output);
    if (!check_result(reference, output)) {
        throw std::runtime_error("correctness check failed");
    }

    TimingStats stats;
    stats.error = measure_error(reference, output);

    std::vector<double> samples(repeats);
    for (int i = 0; i < repeats; ++i) {
        const auto start = std::chrono::steady_clock::now();
        spmv(output);
        const auto stop = std::chrono::steady_clock::now();
        samples[i] = std::chrono::duration<double, std::milli>(stop - start).count();
    }
    stats.mean_ms = std::accumulate(samples.begin(), samples.end(), 0.0) / repeats;
    std::sort(samples.begin(), samples.end());
    stats.min_ms = samples.front();
    stats.max_ms = samples.back();
    stats.median_ms = repeats % 2 == 1
                          ? samples[repeats / 2]
                          : 0.5 * (samples[repeats / 2 - 1] + samples[repeats / 2]);
    return stats;
}

// 矩阵结构统计，用于和实测结果对照的"预测量"：
//  - row_ceiling = W / L：任何按行切分的策略，加速比都不可能超过它；
//  - static_imbalance：按 std::thread 基线的连续行分块，最重块 nnz / 平均块 nnz。
struct MatrixStats {
    long long nnz = 0;
    int max_row_nnz = 0;
    double row_ceiling = 0.0;
    double static_imbalance = 0.0;
};

static MatrixStats analyze_matrix(const CsrMatrix& matrix, int threads) {
    MatrixStats stats;
    stats.nnz = matrix.row_ptr[matrix.rows];
    for (int row = 0; row < matrix.rows; ++row) {
        stats.max_row_nnz =
            std::max(stats.max_row_nnz, matrix.row_ptr[row + 1] - matrix.row_ptr[row]);
    }
    stats.row_ceiling = stats.max_row_nnz > 0
                            ? static_cast<double>(stats.nnz) / stats.max_row_nnz
                            : std::numeric_limits<double>::infinity();

    const int workers = std::max(1, std::min(threads, matrix.rows));
    long long heaviest = 0;
    for (int worker = 0; worker < workers; ++worker) {
        const int begin = static_cast<int>(static_cast<long long>(matrix.rows) * worker / workers);
        const int end =
            static_cast<int>(static_cast<long long>(matrix.rows) * (worker + 1) / workers);
        heaviest = std::max<long long>(heaviest, matrix.row_ptr[end] - matrix.row_ptr[begin]);
    }
    stats.static_imbalance =
        stats.nnz > 0 ? static_cast<double>(heaviest) * workers / stats.nnz : 1.0;
    return stats;
}

struct Strategy {
    std::string key;
    std::string label;
    std::function<void(std::vector<double>&)> run;
};

static std::string schedule_name(const Options& options) {
    if (options.chunk > 0 && options.sched != "auto") {
        return options.sched + "," + std::to_string(options.chunk);
    }
    return options.sched;
}

#ifdef _OPENMP
static void apply_schedule(const Options& options) {
    omp_sched_t kind = omp_sched_dynamic;
    if (options.sched == "static") {
        kind = omp_sched_static;
    } else if (options.sched == "guided") {
        kind = omp_sched_guided;
    } else if (options.sched == "auto") {
        kind = omp_sched_auto;
    }
    // chunk < 1 时由运行时采用默认 chunk（static 即为连续均分）
    omp_set_schedule(kind, options.chunk > 0 ? options.chunk : 0);
}
#endif

int main(int argc, char** argv) {
    try {
        const Options options = parse_options(argc, argv);
        const CsrMatrix matrix = make_skewed_matrix(options);
        const std::vector<double> x = make_vector(options.cols, options.seed);
        const MatrixStats mstats = analyze_matrix(matrix, options.threads);
        const std::vector<double> zero(matrix.rows, 0.0);
        std::vector<double> reference = zero;
        std::vector<double> output = zero;

        spmv_serial(matrix, x, reference);

#ifdef _OPENMP
        omp_set_num_threads(options.threads);
        apply_schedule(options);
#endif
        g_nnz_chunk = options.nnz_chunk;

        if (!options.csv) {
            std::cout << "CSR SpMV skewed-matrix experiment\n"
                      << "rows=" << matrix.rows << ", cols=" << matrix.cols
                      << ", nnz=" << mstats.nnz << ", long_rows=" << options.long_rows
                      << ", long_nnz=" << options.long_nnz << ", seed=" << options.seed
                      << ", requested_threads=" << options.threads << '\n';
#ifdef _OPENMP
            std::cout << "OpenMP enabled, _OPENMP=" << _OPENMP
                      << ", omp1 schedule=" << schedule_name(options)
                      << ", omp3 nnz-chunk=" << options.nnz_chunk << '\n';
#else
            std::cout << "OpenMP disabled: compile with -fopenmp to enable it.\n";
#endif
            std::cout << std::setprecision(4) << "structure: max_row_nnz=" << mstats.max_row_nnz
                      << ", row-level speedup ceiling W/L=" << mstats.row_ceiling
                      << ", static block imbalance(p=" << options.threads
                      << ")=" << mstats.static_imbalance << '\n';
        }

        const std::vector<Strategy> all = {
            {"serial", "serial",
             [&](std::vector<double>& y) { spmv_serial(matrix, x, y); }},
            {"thread", "std::thread (row block)",
             [&](std::vector<double>& y) { spmv_std_thread(matrix, x, y, options.threads); }},
            {"omp1", "OpenMP 1 row/" + schedule_name(options),
             [&](std::vector<double>& y) { spmv_omp_student_1(matrix, x, y); }},
            {"omp2", "OpenMP 2 nnz/static",
             [&](std::vector<double>& y) { spmv_omp_student_2(matrix, x, y); }},
            {"omp3", "OpenMP 3 nnz/dynamic," + std::to_string(options.nnz_chunk),
             [&](std::vector<double>& y) { spmv_omp_student_3(matrix, x, y); }},
        };

        if (options.csv) {
            // sched 形如 "dynamic,64"，自带逗号，因此在 CSV 中加引号
            std::cout << "strategy,threads,rows,cols,normal_nnz,long_rows,long_nnz,seed,nnz,"
                         "max_row_nnz,row_ceiling,static_imbalance,sched,nnz_chunk,repeats,"
                         "median_ms,min_ms,max_ms,mean_ms,max_abs_err,tol_ratio\n";
        } else {
            std::cout << std::left << std::setw(30) << "strategy" << std::right
                      << std::setw(11) << "median_ms" << std::setw(11) << "min_ms"
                      << std::setw(11) << "max_ms" << std::setw(14) << "max_abs_err" << '\n';
        }

        for (const std::string& key : options.only) {
            const Strategy& strategy =
                *std::find_if(all.begin(), all.end(),
                              [&](const Strategy& s) { return s.key == key; });
            const TimingStats t = benchmark(strategy.run, reference, output, options.repeats);

            if (options.csv) {
                std::cout << std::setprecision(6) << strategy.key << ',' << options.threads
                          << ',' << options.rows << ',' << options.cols << ','
                          << options.normal_nnz << ',' << options.long_rows << ','
                          << options.long_nnz << ',' << options.seed << ',' << mstats.nnz
                          << ',' << mstats.max_row_nnz << ',' << mstats.row_ceiling << ','
                          << mstats.static_imbalance << ",\"" << schedule_name(options) << "\","
                          << options.nnz_chunk << ',' << options.repeats << ','
                          << t.median_ms << ',' << t.min_ms << ',' << t.max_ms << ','
                          << t.mean_ms << ',' << t.error.max_abs << ',' << t.error.tol_ratio
                          << '\n';
            } else {
                std::cout << std::left << std::setw(30) << strategy.label << std::right
                          << std::fixed << std::setprecision(3) << std::setw(11)
                          << t.median_ms << std::setw(11) << t.min_ms << std::setw(11)
                          << t.max_ms << std::defaultfloat << std::setprecision(3)
                          << std::setw(14) << t.error.max_abs << '\n';
            }

#ifdef SPMV_TRACE
            if (key.rfind("omp", 0) == 0) {
                for (std::size_t tid = 0; tid < g_trace.size(); ++tid) {
                    const ThreadTrace& tr = g_trace[tid];
                    std::cout << "trace," << key << ',' << tid << ',' << tr.cpu << ','
                              << std::fixed << std::setprecision(2) << tr.begin_us << ','
                              << tr.end_us << ',' << tr.nnz << std::defaultfloat << '\n';
                }
            }
#endif
        }

        if (!options.csv) {
            std::cout << "All correctness checks passed.\n";
        }
    } catch (const std::exception& error) {
        std::cerr << "error: " << error.what() << '\n';
        usage(argv[0]);
        return 1;
    }
    return 0;
}
