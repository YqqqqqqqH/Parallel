#!/usr/bin/env python3
"""官方激励 alu_tb.v 的 Python 复刻：逐个向量重放，给出覆盖统计和各变异体的预测。

- 向量序列和时刻与 alu_tb.v 完全一致（每个向量 #2，段与段之间 #5）
- 加法器按 src/alu.v 的层次逐位实现（cla4 / cla_unit4 / cla16 / cla32），可打开变异开关
- 每个变异体预测两项，供 xsim 实测比对：
    first_fail  首次出错的向量时刻（ns）
    fail_ns     correct != 1 的累计时长（ns）
输出 results/predictions.csv 和 results/coverage.csv。只用标准库。
"""
import csv
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from mutants import MUTANTS  # noqa: E402

LAB = Path(__file__).resolve().parent.parent
M32 = 0xFFFFFFFF
ADD, ADDU, SUB, SUBU = 0b100000, 0b100001, 0b100010, 0b100011
SLL, SRL, SRA = 0b000000, 0b000010, 0b000011
AND, OR, XOR, NOR = 0b100100, 0b100101, 0b100110, 0b100111
NAMES = {ADD: "ADD", ADDU: "ADDU", SUB: "SUB", SUBU: "SUBU", SLL: "SLL", SRL: "SRL",
         SRA: "SRA", AND: "AND", OR: "OR", XOR: "XOR", NOR: "NOR"}
# (操作码, 两操作数循环的 ii/jj 上界；None 表示移位段的循环结构)
SECTIONS = [(ADD, 16), (SUB, 16), (ADDU, 4), (SUBU, 4), (SLL, None), (SRL, None), (SRA, None),
            (AND, 8), (OR, 8), (XOR, 8), (NOR, 8)]


def vectors():
    """按 alu_tb.v 的顺序产生 (时刻, 持续 ns, op, A, B)。"""
    t = 0
    for k, (op, n) in enumerate(SECTIONS):
        if n:
            vecs = [((ii << i) & M32, (jj << j) & M32)
                    for i in range(32) for ii in range(n) for j in range(32) for jj in range(n)]
        else:
            vecs = [(i, (jj << j) & M32) for i in range(32) for j in range(32) for jj in range(128)]
        last = len(vecs) - 1
        for idx, (a, b) in enumerate(vecs):
            # 每段最后一个向量还要保持段间的 #5；全程最后一个向量之后紧接 $finish
            dur = 2 + (5 if idx == last and k < len(SECTIONS) - 1 else 0)
            yield t, dur, op, a, b
            t += dur


def bit(x, k):
    return (x >> k) & 1


# ---------------- 逐位 CLA（与 src/alu.v 的层次一致） ----------------
def cla4(a, b, cin, mut):
    p, g = a ^ b, a & b
    p0, p1, p2, p3 = bit(p, 0), bit(p, 1), bit(p, 2), bit(p, 3)
    g0, g1, g2, g3 = bit(g, 0), bit(g, 1), bit(g, 2), bit(g, 3)
    c1 = g0 if mut == "M3" else g0 | (p0 & cin)
    c2 = g1 | (p1 & g0) | (p1 & p0 & cin)
    c3 = g2 | (p2 & g1) | (p2 & p1 & g0) | (p2 & p1 & p0 & cin)
    s = (p ^ (cin | (c1 << 1) | (c2 << 2) | (c3 << 3))) & 0xF
    return s, p0 & p1 & p2 & p3, g3 | (p3 & g2) | (p3 & p2 & g1) | (p3 & p2 & p1 & g0)


def cla_unit4(P, G, cin, mut):
    c1 = G[0] if mut == "M1" else G[0] | (P[0] & cin)
    c2 = G[1] | (P[1] & G[0]) | (P[1] & P[0] & cin)
    c3 = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & cin)
    pg = P[0] & P[1] & P[2] & P[3]
    gg = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0])
    return (cin, c1, c2, c3), pg, gg


def cla16(a, b, cin, mut):
    blocks = [((a >> 4 * k) & 0xF, (b >> 4 * k) & 0xF) for k in range(4)]
    pgs = [cla4(x, y, 0, mut)[1:] for x, y in blocks]   # 组 P / G 与 cin 无关
    c, pg, gg = cla_unit4([q[0] for q in pgs], [q[1] for q in pgs], cin, mut)
    s = 0
    for k, (x, y) in enumerate(blocks):
        s |= cla4(x, y, c[k], mut)[0] << (4 * k)
    return s, pg, gg


def cla32(a, b, cin, mut=None):
    s_lo, pg_lo, gg_lo = cla16(a & 0xFFFF, b & 0xFFFF, cin, mut)
    c16 = gg_lo if mut == "M2" else gg_lo | (pg_lo & cin)
    s_hi, pg_hi, gg_hi = cla16(a >> 16, b >> 16, c16, mut)
    return s_lo | (s_hi << 16), gg_hi | (pg_hi & c16)


# ---------------- 参考答案（照抄 alu_tb.v 的 ans / cov） ----------------
def signed32(x):
    return x - (1 << 32) if x >> 31 else x


def golden(op, a, b):
    if op in (ADD, ADDU):
        s = (a + b) & M32
        return s, int(op == ADD and bit(a, 31) == bit(b, 31) and bit(a, 31) != bit(s, 31))
    if op in (SUB, SUBU):
        s = (a - b) & M32
        return s, int(op == SUB and bit(a, 31) != bit(b, 31) and bit(a, 31) != bit(s, 31))
    sa = a & 31
    if op == SLL:
        return (b << sa) & M32, 0
    if op == SRL:
        return b >> sa, 0
    if op == SRA:
        return (signed32(b) >> sa) & M32, 0
    return {AND: a & b, OR: a | b, XOR: a ^ b, NOR: ~(a | b) & M32}[op], 0


# ---------------- 变异体语义（与 mutants.py 的 Verilog 编辑一一对应） ----------------
ADDER_OPS = (ADD, ADDU, SUB, SUBU)
TOUCHES = {  # 每个变异体会影响哪些运算；其余运算与正确设计相同
    "M0": ADDER_OPS, "M1": ADDER_OPS, "M1p": (ADD, ADDU), "M2": ADDER_OPS, "M3": ADDER_OPS,
    "M4": ADDER_OPS, "M5": (SLL, SRL, SRA), "M6": (SRA,), "M7": (ADDU, SUBU), "M8": ADDER_OPS,
}


def ovf_of(a, be, s):
    return int(bit(a, 31) == bit(be, 31) and bit(s, 31) != bit(a, 31))


def mutant(mid, op, a, b):
    if op in ADDER_OPS:
        sub = int(op in (SUB, SUBU))
        be = b ^ (M32 if sub else 0)
        if mid in ("M1", "M2", "M3"):
            s, _ = cla32(a, be, sub, mid)
            ov = ovf_of(a, be, s)
        elif mid == "M1p":            # ADD/ADDU 走带 M1 错误的那套 CLA
            s, _ = cla32(a, b, 0, "M1")
            ov = ovf_of(a, b, s)
        elif mid == "M0":
            s = (a + be) & M32
            ov = ovf_of(a, be, s)
        elif mid == "M4":
            be = ((~b + 1) & M32) if sub else b
            s = (a + be) & M32
            ov = ovf_of(a, be, s)
        elif mid == "M8":
            full = a + be + sub
            s, ov = full & M32, full >> 32
        else:                         # M7：加法本身正确
            s = (a + be + sub) & M32
            ov = ovf_of(a, be, s)
        return s, ov if (op in (ADD, SUB) or mid == "M7") else 0
    if mid == "M5":
        r = {SLL: (b << a) & M32 if a < 32 else 0, SRL: b >> a if a < 32 else 0,
             SRA: (signed32(b) >> min(a, 31)) & M32}[op]
        return r, 0
    if mid == "M6":                   # 三目表达式整体无符号，>>> 退化为逻辑右移
        return b >> (a & 31), 0
    raise AssertionError((mid, op))


# ---------------- 覆盖统计 ----------------
def adder_coverage(a, be, cin):
    """返回 (组间 P_k·C_k 是否触发, 进位连续穿透的最长位数)。"""
    carry = (a + be + cin) ^ a ^ be          # 第 i 位为进入第 i 位的进位
    p = a ^ be
    group_pc = any(((p >> 4 * k) & 0xF) == 0xF and bit(carry, 4 * k) for k in range(8))
    run = best = 0
    thru = p & carry & M32                   # 进位进入且被传播的位
    for i in range(32):
        run = run + 1 if bit(thru, i) else 0
        best = max(best, run)
    return group_pc, best


def main():
    t0 = time.time()
    # 正确设计先与参考答案逐向量比对，确认模型本身没问题
    ids = [fid for _, fid, _ in MUTANTS]
    first = {m: None for m in ids}
    fail_ns = {m: 0 for m in ids}
    fail_vec = {m: 0 for m in ids}
    cov = {}
    end = 0
    for t, dur, op, a, b in vectors():
        end = t + dur
        g = golden(op, a, b)
        sec = cov.setdefault(NAMES[op], {"start": t, "vectors": 0, "group_pc": 0,
                                        "run_ge4": 0, "run_ge8": 0, "run_ge16": 0, "run_32": 0,
                                        "max_run": 0, "a_hi_nonzero": 0, "b31_set": 0})
        sec["vectors"] += 1
        if op in ADDER_OPS:
            sub = int(op in (SUB, SUBU))
            be = b ^ (M32 if sub else 0)
            s, _ = cla32(a, be, sub)
            assert (s, ovf_of(a, be, s) if op in (ADD, SUB) else 0) == g, (t, op, a, b)
            gp, run = adder_coverage(a, be, sub)
            sec["group_pc"] += gp
            sec["max_run"] = max(sec["max_run"], run)
            for lim, key in ((4, "run_ge4"), (8, "run_ge8"), (16, "run_ge16"), (32, "run_32")):
                sec[key] += run >= lim
        if op in (SLL, SRL, SRA):
            sec["a_hi_nonzero"] += a >> 5 != 0
            sec["b31_set"] += bit(b, 31)
        for m in ids:
            if op in TOUCHES[m] and mutant(m, op, a, b) != g:
                if first[m] is None:
                    first[m] = (t, NAMES[op], a, b)
                fail_ns[m] += dur
                fail_vec[m] += 1

    out = LAB / "results"
    out.mkdir(exist_ok=True)
    with open(out / "predictions.csv", "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["id", "file_id", "desc", "first_fail_ns", "op", "A", "B", "fail_ns", "fail_vectors"])
        for mid, fid, desc in MUTANTS:
            ff = first[fid]
            w.writerow([mid, fid, desc, ff[0] if ff else -1, ff[1] if ff else "", f"{ff[2]:08x}" if ff else "",
                        f"{ff[3]:08x}" if ff else "", fail_ns[fid], fail_vec[fid]])
    keys = ["start", "vectors", "group_pc", "max_run", "run_ge4", "run_ge8", "run_ge16", "run_32",
            "a_hi_nonzero", "b31_set"]
    with open(out / "coverage.csv", "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["section", *keys])
        for name, sec in cov.items():
            w.writerow([name, *[sec[k] for k in keys]])

    print(f"总向量数 {sum(s['vectors'] for s in cov.values())}，结束时刻 {end} ns，用时 {time.time() - t0:.1f} s")
    print(f"{'段':6}{'起始':>10}{'向量':>8}{'P·C触发':>9}{'最长穿透':>9}{'≥4':>8}{'≥8':>8}{'≥16':>8}{'=32':>8}")
    for name, s in cov.items():
        if name in ("ADD", "SUB", "ADDU", "SUBU"):
            print(f"{name:6}{s['start']:>10}{s['vectors']:>8}{s['group_pc']:>9}{s['max_run']:>9}"
                  f"{s['run_ge4']:>8}{s['run_ge8']:>8}{s['run_ge16']:>8}{s['run_32']:>8}")
    for name in ("SLL", "SRL", "SRA"):
        s = cov[name]
        print(f"{name:6}{s['start']:>10}{s['vectors']:>8}  A[31:5]≠0 的向量 {s['a_hi_nonzero']}，B[31]=1 的向量 {s['b31_set']}")
    print("\n变异体预测：")
    for mid, fid, desc in MUTANTS:
        ff = first[fid]
        where = f"{ff[0]:>9} ns  {ff[1]:5} A={ff[2]:08x} B={ff[3]:08x}" if ff else "      存活"
        print(f"  {mid:4} {where}  fail_ns={fail_ns[fid]:<8} 出错向量={fail_vec[fid]:<7} {desc}")


if __name__ == "__main__":
    main()
