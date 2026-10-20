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


# ---------------------------------------------------------------- E2 偏斜扫描（核心图）
def fig_e2():
    d = pd.read_csv(RESULTS / "e2.csv")
    p = int(d.threads.iloc[0])
    info = d.groupby("long_nnz_label")[["nnz", "max_row_nnz", "row_ceiling"]].first()
    info["r"] = p / info.row_ceiling  # r = L / (W/p)
    t_serial = d[d.strategy == "serial"].groupby("long_nnz_label").median_ms.median()

    fig, ax = plt.subplots(figsize=(6.4, 4.2))
    r = info.r.values
    rr = np.geomspace(r.min() * 0.85, r.max() * 1.15, 200)
    ax.plot(rr, np.minimum(p, p / rr), color=MUTED, linewidth=1.2, linestyle=(0, (1, 2)),
            zorder=1)
    ax.text(0.2, p * 1.08, f"按行切分上界 min(p, W/L)，p={p}", color=MUTED, fontsize=8)
    ax.axvline(1.0, color="#c3c2b7", linewidth=0.8, zorder=1)
    ax.text(1.04, 0.36, "r = 1：最长一行 = 每线程平均工作量", color=MUTED, fontsize=7.5,
            rotation=90, va="bottom")
    rows = []
    for key in ORDER:
        g = d[d.strategy == key].groupby("long_nnz_label").median_ms
        speed = t_serial / g.median()
        line(ax, r, speed.values, key)
        band(ax, r, (t_serial / g.quantile(0.75)).values, (t_serial / g.quantile(0.25)).values,
             key)
        rows.append(speed.rename(key))
    omp1 = rows[1]
    ratio = (omp1 / info.row_ceiling)[info.r > 1]
    ax.annotate(f"实测 ≈ {ratio.mean():.2f} × W/L\n（与上界平行）", (r[-2], omp1.values[-2]),
                xytext=(r[-2] * 0.42, omp1.values[-2] * 0.5), color=INK2, fontsize=8,
                arrowprops=dict(arrowstyle="-", color=MUTED, linewidth=0.8))
    ax.set_xscale("log")
    ax.set_yscale("log")
    ax.set_xticks(r)
    ax.set_xticklabels([f"{v:.2g}\n{L / 1000:g}k" for v, L in zip(r, info.index)], fontsize=7.5)
    ax.set_yticks([0.5, 1, 2, 4, 8, 16])
    ax.set_yticklabels(["0.5", "1", "2", "4", "8", "16"])
    ax.minorticks_off()
    ax.set_xlabel("长行占比 r = L / (W/p)    （第二行：最长行 L 的非零元数）")
    ax.set_ylabel("加速比  T₁ / Tₚ")
    ax.set_title("E2：单条长行逐渐变长时各策略的加速比（rows=1e4，普通行 32 nnz，p=16）",
                 loc="left")
    ax.legend(loc="lower left", fontsize=8)
    fig.tight_layout()
    save(fig, "e2_skew_bound")

    table = pd.concat([info, t_serial.rename("serial_ms"), *rows], axis=1)
    table.to_csv(RESULTS / "e2_summary.csv", float_format="%.4f")
    print("已生成 results/e2_summary.csv")


# ---------------------------------------------------------------- E3 / E7 消融
def fig_e3_e7():
    fig, (ax3, ax7) = plt.subplots(1, 2, figsize=(9.2, 3.6),
                                   gridspec_kw={"width_ratios": [1.05, 1]})

    e3 = pd.read_csv(RESULTS / "e3.csv")
    g = e3.groupby("sched").median_ms
    med = g.median().sort_values(ascending=False)
    y = np.arange(len(med))
    ax3.barh(y, med.values, height=0.62, color=STYLE["omp1"]["color"], zorder=3)
    for yi, v in zip(y, med.values):
        ax3.text(v + 0.01, yi, f"{v:.3f}", va="center", fontsize=7.5, color=INK2)
    ax3.set_yticks(y)
    ax3.set_yticklabels(med.index, fontsize=7.5)
    ax3.grid(axis="y", visible=False)
    ax3.set_xlabel("中位数时间 (ms)")
    ax3.set_xlim(0, med.max() * 1.15)
    ax3.set_title("E3：OpenMP 1（按行）各调度方式，配置 B，p=16", loc="left")

    e7 = pd.read_csv(RESULTS / "e7.csv")
    g = e7.groupby("nnz_chunk").median_ms
    x = g.median().index.values
    nnz = int(e7.nnz.iloc[0])
    band(ax7, x, g.quantile(0.25).values, g.quantile(0.75).values, "omp3")
    line(ax7, x, g.median().values, "omp3", label=False)
    best = g.median().idxmin()
    ax7.annotate(f"最低 {g.median()[best]:.3f} ms", (best, g.median()[best]),
                 xytext=(best * 0.35, g.median()[best] + 0.25), color=INK2, fontsize=8,
                 arrowprops=dict(arrowstyle="-", color=MUTED, linewidth=0.8))
    ax7.set_xscale("log", base=2)
    ax7.set_xticks(x)
    ax7.set_xticklabels([f"{c // 1024}K\n{-(-nnz // c)} 块" if c >= 1024 else
                         f"{c}\n{-(-nnz // c)} 块" for c in x], fontsize=7.5)
    ax7.minorticks_off()
    ax7.set_ylim(0, None)
    ax7.set_xlabel("每块非零元数（第二行：块数）")
    ax7.set_ylabel("中位数时间 (ms)")
    ax7.set_title("E7：OpenMP 3 块大小，配置 B，p=16", loc="left")
    fig.tight_layout()
    save(fig, "e3_e7_ablation")


# ---------------------------------------------------------------- E6 每线程时间线
# 2×2 的四个格子按"它在概念上等价的实体"着色：按行×静态与 std::thread 分块相同，用黄色
CELLS = [
    ("omp1:static", "按行 × 静态（与 std::thread 同分块）", "thread"),
    ("omp1:dynamic", "按行 × 动态（OpenMP 1）", "omp1"),
    ("omp2:", "nnz × 静态（OpenMP 2）", "omp2"),
    ("omp3:", "nnz × 动态（OpenMP 3）", "omp3"),
]


def fig_e6(p=16):
    d = pd.read_csv(RESULTS / "e6.csv")
    d = d[d.threads == p].copy()
    d["rate"] = d.nnz / (d.end_us - d.begin_us)
    fig = plt.figure(figsize=(9.6, 5.4))
    gs = fig.add_gridspec(2, 3, width_ratios=[1, 1, 0.78], wspace=0.32, hspace=0.42)
    xmax = d.end_us.max() * 1.02
    stats = []
    for i, (cell, title, key) in enumerate(CELLS):
        ax = fig.add_subplot(gs[i // 2, i % 2])
        x = d[d.cell == cell]
        span = x.groupby("round").end_us.max()
        rnd = span.index[np.argsort(span.values)[len(span) // 2]]  # 取完成时间居中的一轮
        g = x[x["round"] == rnd].sort_values("tid")
        lam = g.end_us.max() / g.end_us.mean()
        lam_med = x.groupby("round").apply(lambda t: t.end_us.max() / t.end_us.mean()).median()
        stats.append((cell, p, lam_med, x.groupby("round").end_us.max().median()))
        ax.barh(g.tid, g.end_us - g.begin_us, left=g.begin_us, height=0.68,
                color=STYLE[key]["color"], zorder=3)
        ax.axvline(g.end_us.max(), color=MUTED, linewidth=0.8, zorder=2)
        if cell == "omp3:":  # 只在动态那格标出每线程领到的工作量，显示"快者多劳"
            for _, row in g.iterrows():
                ax.text(row.end_us + 3, row.tid, f"{row.nnz / 1000:.0f}k", va="center",
                        fontsize=6.5, color=INK2)
        ax.set_xlim(0, xmax)
        ax.set_ylim(p - 0.4, -0.6)
        ax.set_yticks([0, 5, 10, 15])
        ax.grid(axis="y", visible=False)
        ax.set_title(f"{title}\n完成 {g.end_us.max():.0f} µs · λ = {lam:.2f}", loc="left",
                     fontsize=8.5)
        if i % 2 == 0:
            ax.set_ylabel("线程号")
        if i // 2 == 1:
            ax.set_xlabel("调用内时间 (µs)")

    ax_h = fig.add_subplot(gs[:, 2])
    rates = d[d.cell == "omp2:"].rate
    ax_h.hist(rates, bins=np.arange(300, 1800, 75), orientation="horizontal",
              color=STYLE["omp2"]["color"], rwidth=0.85, zorder=3)
    serial = pd.read_csv(RESULTS / "e1.csv")
    serial = serial[(serial.config == "B") & (serial.strategy == "serial")]
    serial_rate = serial.nnz.iloc[0] / (serial.median_ms.median() * 1e3)
    ax_h.axhline(serial_rate, color=MUTED, linewidth=1, linestyle=(0, (4, 3)))
    ax_h.text(ax_h.get_xlim()[1] * 0.97, serial_rate + 25, f"串行 {serial_rate:.0f}",
              ha="right", fontsize=7.5, color=MUTED)
    ax_h.axhline(rates.mean(), color=INK2, linewidth=1)
    ax_h.text(ax_h.get_xlim()[1] * 0.97, rates.mean() + 25,
              f"线程均值 {rates.mean():.0f}（{rates.mean() / serial_rate:.2f}×）",
              ha="right", fontsize=7.5, color=INK2)
    ax_h.grid(axis="y", visible=False)
    ax_h.set_ylabel("每线程速度 (nnz/µs)")
    ax_h.set_xlabel("线程数（10 轮合计）")
    ax_h.set_title(f"nnz × 静态下每线程速度\n（工作量相同，速度分三档）", loc="left",
                   fontsize=8.5)
    fig.suptitle(f"E6：配置 B，p={p}，每线程忙碌区间（各取完成时间居中的一轮）",
                 x=0.06, ha="left", fontsize=9.5)
    save(fig, f"e6_timeline_p{p}")
    return stats, rates.mean() / serial_rate


def fig_e6_all():
    rows = []
    for p in (16, 20):
        stats, ratio = fig_e6(p)
        rows += [s + (ratio,) for s in stats]
    pd.DataFrame(rows, columns=["cell", "threads", "lambda_median", "makespan_us_median",
                                "mean_thread_rate_over_serial"]).to_csv(
        RESULTS / "e6_summary.csv", index=False, float_format="%.3f")
    print("已生成 results/e6_summary.csv")


FIGS = {"e1": fig_e1, "e2": fig_e2, "e3_e7": fig_e3_e7, "e6": fig_e6_all}

if __name__ == "__main__":
    names = sys.argv[1:] or list(FIGS)
    for name in names:
        FIGS[name]()
