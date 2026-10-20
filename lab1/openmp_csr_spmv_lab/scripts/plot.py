#!/usr/bin/env python3
"""由 results/*.csv 生成报告用图：python scripts/plot.py <实验名> ...

配色按实体固定（所有图一致，不随筛选/排名变化），已用 dataviz 校验器检查：
  omp3 蓝 #2a78d6 · omp1 橙 #eb6834 · omp2 青 #1baf7a · std::thread 黄 #eda100
青、黄对浅色背景对比度 < 3:1，因此每条线同时配不同标记形状 + 图例 + 选择性直接标注。
"""
import sys
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt  # noqa: E402
import numpy as np  # noqa: E402
import pandas as pd  # noqa: E402
from matplotlib import font_manager  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
RESULTS = ROOT / "results"
FIGURES = ROOT / "figures"

# ---------------------------------------------------------------- 统一样式
for font in ("/mnt/c/Windows/Fonts/msyh.ttc", "/mnt/c/Windows/Fonts/msyhbd.ttc"):
    if Path(font).exists():
        font_manager.fontManager.addfont(font)
plt.rcParams.update({
    "font.family": ["Microsoft YaHei", "DejaVu Sans"],
    "axes.unicode_minus": False,
    "font.size": 9,
    "axes.edgecolor": "#c3c2b7",
    "axes.linewidth": 0.8,
    "axes.labelcolor": "#52514e",
    "axes.titlesize": 9.5,
    "axes.titlecolor": "#0b0b0b",
    "xtick.color": "#898781",
    "ytick.color": "#898781",
    "xtick.labelcolor": "#52514e",
    "ytick.labelcolor": "#52514e",
    "axes.grid": True,
    "grid.color": "#e1e0d9",
    "grid.linewidth": 0.6,
    "axes.spines.top": False,
    "axes.spines.right": False,
    "figure.facecolor": "white",
    "axes.facecolor": "white",
    "legend.frameon": False,
    "savefig.dpi": 200,
    "savefig.bbox": "tight",
})

INK = "#0b0b0b"
INK2 = "#52514e"
MUTED = "#898781"
STYLE = {
    "omp3": dict(color="#2a78d6", marker="o", label="OpenMP 3  nnz 切分 / 动态"),
    "omp1": dict(color="#eb6834", marker="s", label="OpenMP 1  按行 / dynamic,64"),
    "omp2": dict(color="#1baf7a", marker="D", label="OpenMP 2  nnz 切分 / 静态"),
    "thread": dict(color="#eda100", marker="^", label="std::thread  按行 / 静态"),
}
ORDER = ["omp3", "omp1", "omp2", "thread"]


def line(ax, x, y, key, label=True, **kw):
    s = STYLE[key]
    ax.plot(x, y, color=s["color"], marker=s["marker"], markersize=5, linewidth=2,
            markeredgecolor="white", markeredgewidth=1.2, solid_capstyle="round",
            solid_joinstyle="round", label=s["label"] if label else None, zorder=3, **kw)


def band(ax, x, lo, hi, key):
    ax.fill_between(x, lo, hi, color=STYLE[key]["color"], alpha=0.12, linewidth=0, zorder=2)


def end_label(ax, x, y, text, dx=0.4, dy=0.0):
    ax.annotate(text, (x, y), xytext=(x + dx, y + dy), color=INK2, fontsize=8,
                va="center", ha="left", zorder=4)


def save(fig, name):
    FIGURES.mkdir(exist_ok=True)
    path = FIGURES / f"{name}.png"
    fig.savefig(path)
    plt.close(fig)
    print(f"已生成 {path.relative_to(ROOT)}")


# ---------------------------------------------------------------- E1 线程扩展性
CONFIG_TITLE = {
    "A": "配置 A：默认（32 条 2 万长行，W≈0.96M，≈11.5MB）",
    "B": "配置 B：README（16 条 8 万长行，W≈1.6M，≈19MB）",
}


def fig_e1():
    d = pd.read_csv(RESULTS / "e1.csv")
    fig, axes = plt.subplots(2, 2, figsize=(9.2, 6.0), sharex=True)
    summary = []
    for col, config in enumerate(("A", "B")):
        x = d[d.config == config]
        t_serial = x[x.strategy == "serial"].median_ms.median()
        ceiling = x.row_ceiling.iloc[0]
        ax_s, ax_e = axes[0, col], axes[1, col]
        threads = sorted(x.threads.unique())
        for ax in (ax_s, ax_e):
            ax.axvspan(20.5, 24.8, color="#f0efec", zorder=0, linewidth=0)
        ax_s.plot([1, 24], [1, 24], color=MUTED, linewidth=1, linestyle=(0, (4, 3)), zorder=1)
        ax_s.annotate("理想 S=p", (14.5, 14.5), xytext=(10.2, 17.5), color=MUTED, fontsize=8)
        if ceiling < 26:
            ax_s.axhline(ceiling, color=MUTED, linewidth=1, linestyle=(0, (1, 2)), zorder=1)
            ax_s.text(1.2, ceiling + 0.5, f"按行切分上界 W/L = {ceiling:.0f}", color=MUTED,
                      fontsize=8)
        ax_e.axhline(1.0, color=MUTED, linewidth=1, linestyle=(0, (4, 3)), zorder=1)
        for key in ORDER:
            g = x[x.strategy == key].groupby("threads").median_ms
            speed = t_serial / g.median()
            q1, q3 = t_serial / g.quantile(0.75), t_serial / g.quantile(0.25)
            line(ax_s, threads, speed.values, key, label=(col == 0))
            band(ax_s, threads, q1.values, q3.values, key)
            line(ax_e, threads, (speed / speed.index).values, key, label=False)
            for p in threads:
                summary.append((config, key, p, g.median()[p], speed[p], speed[p] / p))
        best = (t_serial / x[x.strategy == "omp3"].groupby("threads").median_ms.median())
        end_label(ax_s, 20, best[20], f"{best[20]:.1f}×", dx=0.5, dy=1.4)
        ax_s.set_title(CONFIG_TITLE[config] + f"\n串行 T₁ = {t_serial:.3f} ms", loc="left")
        ax_s.set_ylim(0, 24.5)
        ax_e.set_ylim(0, 1.15)
        ax_s.text(22.65, 17.0, "占满 24 个 vCPU\n进程级双峰", ha="center", va="top",
                  color=MUTED, fontsize=7.5)
        ax_e.set_xlabel("线程数 p")
        ax_e.set_xticks(threads)
    axes[0, 0].set_ylabel("加速比  T₁ / Tₚ（中位数，阴影为四分位）")
    axes[1, 0].set_ylabel("并行效率  S / p")
    fig.legend(loc="upper center", ncol=4, bbox_to_anchor=(0.5, 1.02), fontsize=8.5,
               handlelength=2.2, columnspacing=1.6)
    fig.tight_layout(rect=(0, 0, 1, 0.965))
    save(fig, "e1_scaling")

    table = pd.DataFrame(summary, columns=["config", "strategy", "threads", "median_ms",
                                           "speedup", "efficiency"])
    table.to_csv(RESULTS / "e1_summary.csv", index=False, float_format="%.4f")
    print(f"已生成 results/e1_summary.csv")


FIGS = {"e1": fig_e1}

if __name__ == "__main__":
    names = sys.argv[1:] or list(FIGS)
    for name in names:
        FIGS[name]()
