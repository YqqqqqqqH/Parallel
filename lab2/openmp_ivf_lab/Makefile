CXX = g++
CPPFLAGS = -I.
CXXFLAGS = -O3 -std=c++17 -Wall -Wextra -Wpedantic -fopenmp -pthread
# 实验 E 才使用的 -march=native 构建（本机 g++ 13 识别为 alderlake：AVX2 + FMA）
NATIVE = -march=native
SAN = -O1 -g -fno-omit-frame-pointer -fsanitize=address,undefined -fno-sanitize-recover=all

COMMON = ivf_io.cpp ivf_search.cpp ivf_student.cpp ivf_simd.cpp
HEADERS = ivf_io.h ivf_search.h ivf_stats.h

.PHONY: all test student_test student_test_asan clean vecreport
all: ivf_lab

# 正式计时用：默认编译选项，与课程要求一致
ivf_lab: ivf_lab.cpp $(COMMON) $(HEADERS)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -DIVF_ISA='"default"' ivf_lab.cpp $(COMMON) -o $@

# 实验 E：所有源文件统一加 -march=native
ivf_lab_native: ivf_lab.cpp $(COMMON) $(HEADERS)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) $(NATIVE) -DIVF_ISA='"native"' ivf_lab.cpp $(COMMON) -o $@

# 统计插桩构建：只用于收集 W_t / 忙碌时间 / 分阶段时间，不用于正式计时
ivf_lab_stats: ivf_lab.cpp $(COMMON) $(HEADERS)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -DIVF_STATS -DIVF_ISA='"default"' ivf_lab.cpp $(COMMON) -o $@

# ASan + UBSan 构建
ivf_lab_asan: ivf_lab.cpp $(COMMON) $(HEADERS)
	$(CXX) $(CPPFLAGS) $(subst -O3,,$(CXXFLAGS)) $(SAN) -DIVF_ISA='"asan"' ivf_lab.cpp $(COMMON) -o $@

ivf_tests: tests/ivf_tests.cpp $(COMMON) $(HEADERS)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) tests/ivf_tests.cpp $(COMMON) -o $@

student_tests: tests/student_tests.cpp $(COMMON) $(HEADERS)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) tests/student_tests.cpp $(COMMON) -o $@

student_tests_asan: tests/student_tests.cpp $(COMMON) $(HEADERS)
	$(CXX) $(CPPFLAGS) $(subst -O3,,$(CXXFLAGS)) $(SAN) tests/student_tests.cpp $(COMMON) -o $@

test: ivf_tests
	./ivf_tests

student_test: student_tests
	./student_tests

student_test_asan: student_tests_asan
	./student_tests_asan

# 读带宽探针（实验 E / perf 分析用）
bw_probe: bw_probe.cpp
	$(CXX) $(CXXFLAGS) bw_probe.cpp -o $@

# 向量化报告与反汇编：默认选项和 -march=native 各一份，输出到 results/vec/
vecreport:
	bash scripts/vecreport.sh

clean:
	rm -f bw_probe ivf_lab ivf_lab_native ivf_lab_stats ivf_lab_asan ivf_tests student_tests student_tests_asan
