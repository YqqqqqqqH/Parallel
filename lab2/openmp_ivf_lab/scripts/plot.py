#!/usr/bin/env python3
"""由 results/<exp>_summary.csv 生成报告用图：python -I scripts/plot.py A [B C ...]

配色按实体固定（所有图一致），已用 dataviz 校验器检查（light 模式全部通过）：
  omp1 蓝 #2a78d6 · omp2 橙 #eb6834 · omp2+split 青 #1baf7a · std::thread 黄 #eda100
青、黄对浅色背景对比度 < 3:1，所以每条线同时用不同标记形状 + 图例 + 线端直接标注。
参考线（理想加速比、Amdahl 上界）用中性灰虚线。
"""
import sys
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt  # noqa: E402
import pandas as pd  # noqa: E402
from matplotlib import font_manager  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
RESULTS = ROOT / "results"
FIGURES = ROOT / "figures"

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
    "grid.color": "#e8e7e2",
    "grid.linewidth": 0.8,
    "grid.linestyle": "-",
    "axes.spines.top": False,
    "axes.spines.right": False,
    "legend.frameon": False,
    "figure.facecolor": "#fcfcfb",
    "axes.facecolor": "#fcfcfb",
    "savefig.dpi": 200,
})
TEXT2 = "#52514e"
REF = "#898781"
SERIES = {  # 实体 → (颜色, 标记, 图例名)
    "omp1": ("#2a78d6", "o", "omp1 按查询"),
    "omp2": ("#eb6834", "s", "omp2 查询内任务"),
    "omp2+split": ("#1baf7a", "D", "omp2 + 中心距离拆分"),
    "std": ("#eda100", "^", "std::thread"),
}


def entity(row):
    return "omp2+split" if row.strategy == "omp2" and row.coarse == "split" else row.strategy


def line(ax, x, y, key, label_at=None, above=True):
    color, marker, name = SERIES[key]
    ax.plot(x, y, color=color, marker=marker, markersize=5, linewidth=2, label=name,
            solid_joinstyle="round", solid_capstyle="round",
            markeredgecolor="#fcfcfb", markeredgewidth=1.2, zorder=3)
    if label_at is not None:  # 只在关键点直接标注数值（文字用正文色，不用系列色）
        x, y = list(x), list(y)
        if label_at in x:
            i = x.index(label_at)
            # 两条线在同一点汇合时，数值较高者标在上方、较低者标在下方
            ax.annotate(f"{y[i]:.2f}", (x[i], y[i]), xytext=(-7, 6 if above else -11),
                        textcoords="offset points", ha="right", fontsize=8, color=TEXT2)


def fig_A():
    s = pd.read_csv(RESULTS / "A_summary.csv")
    s["entity"] = s.apply(entity, axis=1)
    p0 = (RESULTS / "p0_summary.txt").read_text()
    f_sel = float(p0.split("nprobe=8")[1].split("f_sel=")[1].split()[0])
    big = int(s.batch.max())
    fig, axes = plt.subplots(1, 2, figsize=(7.2, 2.8))
    xs = sorted(s.threads.unique())
    for ax, batch in zip(axes, (big, 1)):
        d = s[(s.batch == batch) & (s.strategy != "serial")]
        at16 = d[d.threads == 16].groupby("entity").S.first()
        for key in ("omp1", "omp2", "omp2+split"):
            e = d[d.entity == key].sort_values("threads")
            if len(e):
                others = at16.drop(key, errors="ignore")
                v = at16.get(key, 0)  # 与 y 值最接近的另一条线比较，较高者标在上方
                above = others.empty or v >= others.iloc[(others - v).abs().argmin()]
                line(ax, e.threads, e.S, key, label_at=16, above=above)
        if batch == big:
            ideal = [min(x, 16) for x in xs]  # 物理核只有 16 个
            ax.plot(xs, ideal, color=REF, linestyle="--", linewidth=1, zorder=1)
            ax.annotate("理想（16 个物理核封顶）", (8, 8), xytext=(-4, 6), textcoords="offset points",
                        ha="right", fontsize=8, color=REF)
            ax.set_ylim(0, 17)
        else:
            amdahl = [1 / (f_sel + (1 - f_sel) / p) for p in xs]
            ax.plot(xs, amdahl, color=REF, linestyle="--", linewidth=1, zorder=1)
            ax.annotate(f"Amdahl 上界（f_sel={f_sel:.3f}）", (xs[-1], amdahl[-1]),
                        xytext=(0, 5), textcoords="offset points", ha="right", fontsize=8, color=REF)
            ax.axhline(1, color="#c3c2b7", linewidth=0.8, zorder=1)
        ax.set_xscale("log", base=2)
        ax.set_xticks(xs, [str(x) for x in xs])
        ax.minorticks_off()
        ax.set_xlabel("线程数 p")
        ax.set_ylabel("加速比 S(p)（相对串行 IVF）")
        ax.set_title(f"batch = {batch}" + ("（4P）" if batch == big else "（单查询）"), loc="left")
    handles, labels = axes[1].get_legend_handles_labels()
    fig.legend(handles, labels, loc="upper center", ncol=3, fontsize=8, bbox_to_anchor=(0.5, 1.0))
    fig.tight_layout(rect=(0, 0, 1, 0.92))
    FIGURES.mkdir(exist_ok=True)
    out = FIGURES / "A_scaling.png"
    fig.savefig(out)
    print(f"写入 {out}")


def fig_C():
    s = pd.read_csv(RESULTS / "C_summary.csv")
    s = s[(s.strategy == "omp2") & (s.queries == s.queries.max())]
    serial = pd.read_csv(RESULTS / "A_summary.csv")
    serial = serial[serial.strategy == "serial"].set_index("batch").T_ms
    fig, axes = plt.subplots(1, 2, figsize=(7.2, 2.6))
    color, marker, _ = SERIES["omp2"]
    for ax, batch in zip(axes, sorted(s.batch.unique())):
        d = s[s.batch == batch].sort_values("grain")
        speed = serial[batch] / d.T_ms  # 相对同 batch 串行 IVF 的加速比
        ax.plot(d.grain, speed, color=color, marker=marker, markersize=5, linewidth=2,
                markeredgecolor="#fcfcfb", markeredgewidth=1.2, zorder=3)
        for g, v in zip(d.grain, speed):
            ax.annotate(f"{v:.2f}", (g, v), xytext=(0, 6), textcoords="offset points",
                        ha="center", fontsize=8, color=TEXT2)
        ax.axhline(1, color=REF, linestyle="--", linewidth=1, zorder=1)
        ax.annotate("串行 = 1", (d.grain.iloc[-1], 1), xytext=(0, 4), textcoords="offset points",
                    ha="right", fontsize=8, color=REF)
        ax.set_xscale("log", base=2)
        ax.set_xticks(list(d.grain), [f"{g}\n{nb:.1f} 块" for g, nb in zip(d.grain, d.blocks_per_query)])
        ax.minorticks_off()
        ax.set_ylim(0, max(1.0, speed.max()) * 1.25)
        ax.set_xlabel("grain（每块最多候选数）/ 平均每查询块数")
        ax.set_ylabel("加速比 S（相对串行 IVF）")
        ax.set_title(f"omp2，p=16，batch = {batch}", loc="left")
    fig.tight_layout()
    out = FIGURES / "C_grain.png"
    fig.savefig(out)
    print(f"写入 {out}")


FIGS = {"A": fig_A, "C": fig_C}

if __name__ == "__main__":
    for name in sys.argv[1:]:
        FIGS[name]()
