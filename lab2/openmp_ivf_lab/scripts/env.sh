#!/usr/bin/env bash
# 记录实验环境到 results/env.txt（编译器、CPU、OS、OpenMP 运行时、CPU 集合、绑定变量、电源状态、数据）
set -u
cd "$(dirname "$0")/.."
source scripts/common.sh
{
  echo "== 记录时间"; date -Iseconds
  echo "== uname -a"; uname -a
  echo "== lscpu"; lscpu
  echo "== 说明：物理 CPU 为 i7-14650HX（8P+8E=16 核 24 线程）；WSL2 中 lscpu 的 12 核×2 是虚拟拓扑。本实验 P=16"
  echo "== 可用 CPU 集合"; taskset -cp $$
  echo "== 编译器"; g++ --version | head -1
  echo "== 编译选项"; grep -E '^(CXXFLAGS|NATIVE|SAN) =' Makefile
  echo "== OpenMP 运行时"; ldd ./ivf_lab 2>/dev/null | grep -iE 'gomp|pthread' || echo "(先 make)"
  echo "== OpenMP/绑定环境变量"; env | grep -E '^(OMP_|GOMP_)' || echo "(未设置：不绑核，OpenMP 与 std::thread 都由内核调度)"
  echo "== 内存"; free -h
  echo "== WSL 版本"; wsl.exe --version 2>/dev/null | tr -d '\0\r' || echo "(不可用)"
  echo "== Windows 电源模式（插电，AC overlay）"
  # ded574b5-…=最佳性能，961cc777-…=最佳能效，00000000-…/缺省=平衡
  reg.exe query 'HKLM\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes' /v ActiveOverlayAcPowerScheme 2>/dev/null | tr -d '\r' | grep -i overlay || echo "(不可用)"
  echo "== perf"; /usr/lib/linux-tools/6.8.0-147-generic/perf version 2>&1; echo "perf_event_paranoid=$(cat /proc/sys/kernel/perf_event_paranoid)"
  echo "== 数据目录 $IVF_DATA"; ls -la "$IVF_DATA"
} > results/env.txt 2>&1
echo "已写入 results/env.txt"
