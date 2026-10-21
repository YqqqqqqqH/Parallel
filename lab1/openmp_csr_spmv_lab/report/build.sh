#!/usr/bin/env bash
# 用 pandoc + xelatex 把 report.md 导出为 PDF（图片路径相对 report/ 目录）
set -euo pipefail
cd "$(dirname "$0")"
pandoc report.md -o report.pdf --pdf-engine=xelatex --resource-path=.:..
echo "已生成 report/report.pdf"
