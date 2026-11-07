#pragma once

#include "ivf_io.h"

#include <limits>
#include <vector>

namespace ivf {

struct Neighbor {
    double distance = std::numeric_limits<double>::infinity();
    std::int32_t id = -1;
};

bool better(const Neighbor& a, const Neighbor& b);

class TopK {
public:
    explicit TopK(std::size_t k);
    void add(Neighbor value);
    void finish(Neighbor* output);

private:
    std::size_t k_;
    std::vector<Neighbor> heap_;
};

// 候选距离函数的开关（学生扩展）。f64/f32 表示累加类型，simd 表示是否加 omp simd：
//   scalar  = 公共 l2_distance_scalar（double，无 omp simd，作为对照基线）
//   f32     = float 累加，无 omp simd（用于分离"数据类型"和"向量化"两个因素）
//   simd64  = double 累加 + omp simd reduction
//   simd32  = float 累加 + omp simd reduction
// f32 / simd32 只在 f32_distance_exact() 成立时允许使用（坐标为整数且 d*M^2 < 2^24）。
enum class DistKind { scalar, f32, simd64, simd32 };

struct SearchOptions {
    std::size_t k = 10;
    std::size_t nprobe = 8;
    int threads = 4;
    std::size_t grain = 1024;
    // 以下为学生扩展，默认值与原有行为一致
    DistKind dist = DistKind::scalar;
    bool coarse_split = false;   // omp2：把中心距离计算拆成任务（选中的列表与 select_lists 相同）
    std::size_t cutoff = 0;      // omp2/omp3：C(q) <= cutoff 时不拆块，直接在查询任务里扫描
};

double l2_distance_scalar(const float* a, const float* b, std::size_t dim);
double l2_distance_f32(const float* a, const float* b, std::size_t dim);
double l2_distance_simd64(const float* a, const float* b, std::size_t dim);
double l2_distance_simd32(const float* a, const float* b, std::size_t dim);
bool f32_distance_exact(const IVFIndex& index, const float* queries, std::size_t count);
const char* dist_name(DistKind kind);
std::vector<std::uint32_t> select_lists(const IVFIndex& index, const float* query,
                                      std::size_t nprobe);

using SearchFunction = void (*)(const IVFIndex&, const float*, std::size_t,
                               const SearchOptions&, Neighbor*);

void search_ivf_serial(const IVFIndex&, const float*, std::size_t,
                       const SearchOptions&, Neighbor*);
void search_exact_serial(const IVFIndex&, const float*, std::size_t,
                         const SearchOptions&, Neighbor*);
void search_std_thread(const IVFIndex&, const float*, std::size_t,
                       const SearchOptions&, Neighbor*);
void search_omp_student_1(const IVFIndex&, const float*, std::size_t,
                          const SearchOptions&, Neighbor*);
void search_omp_student_2(const IVFIndex&, const float*, std::size_t,
                          const SearchOptions&, Neighbor*);
// 反面对照：任务划分与 omp2 相同，但每个候选都在 critical 中更新共享 Top-k
void search_omp_student_3(const IVFIndex&, const float*, std::size_t,
                          const SearchOptions&, Neighbor*);

void check_result(const std::vector<Neighbor>& actual,
                  const std::vector<Neighbor>& expected);
double recall_at_k(const std::vector<Neighbor>& result,
                   const IntMatrix& groundtruth, std::size_t count, std::size_t k);

}
