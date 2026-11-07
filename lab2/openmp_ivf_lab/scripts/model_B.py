#!/usr/bin/env python3
"""实验 B 的调度模型：假设所有线程同速，用 P0 测得的每查询串行工作量 W(q)=select_us+scan_us
模拟三种查询顺序下 omp1 static（libgomp 连续划分）与 dynamic:1（按顺序贪心领取）的完成时间。

输出每种 (顺序, batch, 调度) 的：模型完成时间之和（各 batch 的最长线程时间相加）、
理想下界 ΣW/p 以及二者之比（模型不均衡度）。写入 results/B_model.csv。
它只刻画"工作量分布 + 调度方式"，不含线程速度差异；与实测比较即可分离两类因素。
"""
import csv
import heapq
import os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
P = 16


def load():
    with open(os.path.join(ROOT, "results", "p0_profile_np8.csv")) as f:
        rows = list(csv.DictReader(f))
    return [(int(r["candidates"]), float(r["select_us"]) + float(r["scan_us"])) for r in rows]


def static_makespan(work, p):
    n = len(work)
    nt = min(p, n)
    base, extra = divmod(n, nt)
    loads, begin = [], 0
    for t in range(nt):
        size = base + (1 if t < extra else 0)
        loads.append(sum(work[begin:begin + size]))
        begin += size
    return max(loads)


def dynamic_makespan(work, p):  # dynamic,1：空闲线程按顺序领取下一个查询
    heap = [0.0] * min(p, len(work))
    for w in work:
        heapq.heapreplace(heap, heap[0] + w)
    return max(heap)


def main():
    data = load()
    orders = {
        "orig": data,
        "asc": sorted(data, key=lambda x: x[0]),       # 与 harness 相同：按 C(q) 稳定排序
        "desc": sorted(data, key=lambda x: -x[0]),
    }
    out = []
    for order, rows in orders.items():
        work = [w for _, w in rows]
        for batch in (64, len(work)):
            for sched, fn in (("static", static_makespan), ("dynamic:1", dynamic_makespan)):
                total = sum(fn(work[i:i + batch], P) for i in range(0, len(work), batch))
                lower = sum(work) / P
                out.append(dict(order=order, batch=batch, sched=sched, model_ms=total / 1000,
                                ideal_ms=lower / 1000, model_imbalance=total / lower))
    path = os.path.join(ROOT, "results", "B_model.csv")
    with open(path, "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(out[0]))
        w.writeheader()
        w.writerows(out)
    for r in out:
        print(f"{r['order']:5s} batch={r['batch']:5d} {r['sched']:10s} 模型={r['model_ms']:7.2f} ms "
              f"下界={r['ideal_ms']:6.2f} ms  不均衡={r['model_imbalance']:.3f}")


if __name__ == "__main__":
    main()
