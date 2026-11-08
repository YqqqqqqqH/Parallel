#!/usr/bin/env bash
# 记录实验环境到 $IVF_RESULTS/env.txt（默认 results/env.txt；服务器上用 IVF_RESULTS=results/server）：
# 编译器、CPU、OS、OpenMP 运行时、CPU 集合、绑定变量、内存、perf 可用性、数据目录。
set -u
cd "$(dirname "$0")/.."
source scripts/common.sh
OUT="${IVF_RESULTS:-results}/env.txt"
{
  echo "== 记录时间"; date -Iseconds
  echo "== uname -a"; uname -a
  echo "== lscpu"; lscpu
  if grep -qw hypervisor /proc/cpuinfo; then
    echo "== 说明：运行在虚拟机中（CPU flags 含 hypervisor），lscpu 的核/线程拓扑是虚拟拓扑；P 的确定方法见报告 §1"
  fi
  echo "== 可用 CPU 集合"; taskset -cp $$
  echo "== 编译器"; g++ --version | head -1
  echo "== 编译选项"; grep -E '^(CXXFLAGS|NATIVE|SAN) =' Makefile
  echo "== OpenMP 运行时"; ldd ./ivf_lab 2>/dev/null | grep -iE 'gomp|pthread' || echo "(先 make)"
  echo "== OpenMP/绑定环境变量"; env | grep -E '^(OMP_|GOMP_)' || echo "(未设置：不绑核，OpenMP 与 std::thread 都由内核调度)"
  echo "== 内存"; free -h
  echo "== perf"
  echo "perf_event_paranoid=$(cat /proc/sys/kernel/perf_event_paranoid)"
  if command -v perf > /dev/null; then perf version 2>&1 | head -3; else echo "(PATH 中没有 perf)"; fi
  if grep -qi microsoft /proc/version; then   # 只在 WSL 上记录 Windows 侧信息
    echo "== WSL 版本"; wsl.exe --version 2>/dev/null | tr -d '\0\r' || echo "(不可用)"
    echo "== Windows 电源模式（插电，AC overlay）"
    reg.exe query 'HKLM\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes' /v ActiveOverlayAcPowerScheme 2>/dev/null | tr -d '\r' | grep -i overlay || echo "(不可用)"
  fi
  echo "== 数据目录 $IVF_DATA"; ls -la "$IVF_DATA"
} > "$OUT" 2>&1
echo "已写入 $OUT"
