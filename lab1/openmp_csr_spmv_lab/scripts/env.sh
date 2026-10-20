#!/usr/bin/env bash
# 记录实验环境到 results/env.txt（编译器、CPU、OS、OpenMP 运行时、Windows 电源方案）
set -u
cd "$(dirname "$0")/.."
{
  echo "== 记录时间"; date -Iseconds
  echo "== uname -a"; uname -a
  echo "== lscpu"; lscpu
  echo "== 编译器"; g++ --version | head -1
  echo "== 编译选项"; echo "g++ -O2 -std=c++17 -fopenmp -pthread csr_spmv_lab.cpp -o csr_spmv_lab"
  echo "== libgomp"; ldd ./csr_spmv_lab | grep -i gomp
  echo "== OpenMP 环境变量"; env | grep '^OMP_' || echo "(未设置)"
  echo "== 内存"; free -h
  echo "== WSL 版本"; wsl.exe --version 2>/dev/null | tr -d '\0\r' || echo "(不可用)"
  echo "== Windows 电源方案"; powercfg.exe /getactivescheme 2>/dev/null | iconv -f gbk -t utf-8 | tr -d "\r"; echo
  echo "== Windows 电源模式（插电）"
  # ded574b5-…=最佳性能，961cc777-…=最佳能效，00000000-…/缺省=平衡
  reg.exe query 'HKLM\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes' /v ActiveOverlayAcPowerScheme 2>/dev/null | tr -d '\r' | grep -i overlay || echo "(不可用)"
  echo "== 电源适配器"; cat /sys/class/power_supply/*/online 2>/dev/null || echo "(WSL 中不可读)"
} > results/env.txt 2>&1
echo "已写入 results/env.txt"
