"""变异体定义：每个变异体模拟一类典型错误，用"在指定 module 内把原文替换为新文本"的方式
从 src/alu.v 生成，交付源码本身不动。每处替换都断言在该 module 内恰好匹配一次。

tb_model.py 用 Python 实现同样的错误语义来做预测，mutate.py 用这里的编辑生成 Verilog。
"""
import re

# (ID, 文件名用的 ID, 描述)
MUTANTS = [
    ("M0", "M0", "沿用旧加法器写死的 c0=0，SUB 时没接 cin"),
    ("M1", "M1", "cla_unit4 的 c[1] 漏掉 P0·cin 项（组间进位）"),
    ("M1′", "M1p", "同 M1，但 ADD/ADDU 单独用一套 CLA，SUB/SUBU 用另一套正确的"),
    ("M2", "M2", "顶层 c16 漏掉 pg_lo·cin 项"),
    ("M3", "M3", "cla4 的 c[1] 漏掉 p0·cin 项（组内进位）"),
    ("M4", "M4", "先求 ~B+1 再相加，并用它的符号判溢出"),
    ("M5", "M5", "移位量用整个 A，而不是 A[4:0]"),
    ("M6", "M6", "SRL/SRA 合进一个三目表达式，SRA 因符号性规则退化成逻辑右移"),
    ("M7", "M7", "ADDU/SUBU 也输出溢出"),
    ("M8", "M8", "把进位输出当成溢出"),
]


def module_span(src, name):
    m = re.search(rf"^module {name}\(.*?^endmodule\n", src, re.S | re.M)
    assert m, f"找不到 module {name}"
    return m.span()


def edit(src, module, old, new):
    """在 module 内把 old 替换为 new，要求 old 在该 module 内恰好出现一次。"""
    lo, hi = module_span(src, module)
    body = src[lo:hi]
    n = body.count(old)
    assert n == 1, f"module {module} 内 {old!r} 出现 {n} 次"
    return src[:lo] + body.replace(old, new) + src[hi:]


def _m1p(src):
    # 复制一套带 M1 错误的加法器（cla_unit4_bad → cla16_bad → cla32_bad），只给 ADD/ADDU 用
    bad = ""
    for name in ("cla_unit4", "cla16", "cla32"):
        lo, hi = module_span(src, name)
        bad += src[lo:hi]
    bad = bad.replace("module cla_unit4(", "module cla_unit4_bad(") \
             .replace("cla_unit4 lcu(", "cla_unit4_bad lcu(") \
             .replace("module cla16(", "module cla16_bad(") \
             .replace("cla16 lo(", "cla16_bad lo(").replace("cla16 hi(", "cla16_bad hi(") \
             .replace("module cla32(", "module cla32_bad(")
    bad = edit(bad, "cla_unit4_bad", "assign c[1] = g[0] | (p[0] & cin);", "assign c[1] = g[0];")
    src = src + "\n// ---- 变异体 M1′：只给 ADD/ADDU 用的另一套 CLA（带 M1 错误）----\n" + bad
    src = edit(src, "alu", "    always @(*) begin\n",
               "    wire [31:0] sum_add;\n"
               "    wire        cout_add;\n"
               "    cla32_bad u_cla_add(.a(A), .b(B), .cin(1'b0), .sum(sum_add), .cout(cout_add));\n"
               "    wire ovf_add = (A[31] == B[31]) && (sum_add[31] != A[31]);\n\n"
               "    always @(*) begin\n")
    src = edit(src, "alu", "OP_ADD:  begin C = sum; Over = ovf; end", "OP_ADD:  begin C = sum_add; Over = ovf_add; end")
    src = edit(src, "alu", "OP_ADDU: C = sum;", "OP_ADDU: C = sum_add;")
    return src


def apply(mid, src):
    """返回变异体 mid 的 Verilog 源码。"""
    if mid == "M0":
        return edit(src, "alu", ".cin(sub)", ".cin(1'b0)")
    if mid == "M1":
        return edit(src, "cla_unit4", "assign c[1] = g[0] | (p[0] & cin);", "assign c[1] = g[0];")
    if mid == "M1p":
        return _m1p(src)
    if mid == "M2":
        return edit(src, "cla32", "assign c16  = gg_lo | (pg_lo & cin);", "assign c16  = gg_lo;")
    if mid == "M3":
        return edit(src, "cla4", "assign c[1] = g[0] | (p[0] & cin);", "assign c[1] = g[0];")
    if mid == "M4":
        src = edit(src, "alu", "wire [31:0] b_eff = B ^ {32{sub}};", "wire [31:0] b_eff = sub ? (~B + 32'd1) : B;")
        return edit(src, "alu", ".cin(sub)", ".cin(1'b0)")
    if mid == "M5":
        src = edit(src, "alu", "C = B << A[4:0];", "C = B << A;")
        src = edit(src, "alu", "C = B >> A[4:0];", "C = B >> A;")
        return edit(src, "alu", "C = $signed(B) >>> A[4:0];", "C = $signed(B) >>> A;")
    if mid == "M6":
        return edit(src, "alu",
                    "            OP_SRL:  C = B >> A[4:0];\n            OP_SRA:  C = $signed(B) >>> A[4:0];\n",
                    "            OP_SRL, OP_SRA: C = Op[0] ? ($signed(B) >>> A[4:0]) : (B >> A[4:0]);\n")
    if mid == "M7":
        src = edit(src, "alu", "OP_ADDU: C = sum;", "OP_ADDU: begin C = sum; Over = ovf; end")
        return edit(src, "alu", "OP_SUBU: C = sum;", "OP_SUBU: begin C = sum; Over = ovf; end")
    if mid == "M8":
        return edit(src, "alu", "wire ovf = (A[31] == b_eff[31]) && (sum[31] != A[31]);", "wire ovf = cout;")
    raise KeyError(mid)
