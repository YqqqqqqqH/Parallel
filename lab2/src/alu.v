`timescale 1ns / 1ns
// 32 位 ALU
// 加法器层次：cla32 = 2 x cla16 + 顶层超前进位
//             cla16 = 4 x cla4  + cla_unit4
//             cla4  = 4 位超前进位块，向上输出组传播 / 组生成
// ADD / ADDU / SUB / SUBU 共用同一个 cla32：A - B = A + ~B + 1

// 4 位超前进位块：块内各位进位由 p、g、cin 并行算出，并输出组 P / G 供上一级使用
module cla4(
    input  [3:0] a,
    input  [3:0] b,
    input        cin,
    output [3:0] sum,
    output       pg,    // 组传播
    output       gg     // 组生成
);
    wire [3:0] p, g;
    wire [3:0] c;

    assign p = a ^ b;
    assign g = a & b;

    assign c[0] = cin;
    assign c[1] = g[0] | (p[0] & cin);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0])
                | (p[2] & p[1] & p[0] & cin);

    assign pg = &p;
    assign gg = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1])
              | (p[3] & p[2] & p[1] & g[0]);

    assign sum = p ^ c;
endmodule

// 4 组超前进位单元：由各组 P / G 直接算出进入第 1..3 组的进位，并输出整段的 P / G
module cla_unit4(
    input  [3:0] p,
    input  [3:0] g,
    input        cin,
    output [3:1] c,
    output       pg,
    output       gg
);
    assign c[1] = g[0] | (p[0] & cin);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0])
                | (p[2] & p[1] & p[0] & cin);

    assign pg = &p;
    assign gg = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1])
              | (p[3] & p[2] & p[1] & g[0]);
endmodule

// 16 位：四个 cla4，各块的进位都来自同一个 cla_unit4
module cla16(
    input  [15:0] a,
    input  [15:0] b,
    input         cin,
    output [15:0] sum,
    output        pg,
    output        gg
);
    wire [3:0] p, g;
    wire [3:0] c;       // c[k] 为进入第 4k..4k+3 位的进位

    assign c[0] = cin;

    cla4 blk0(.a(a[3:0]),   .b(b[3:0]),   .cin(c[0]), .sum(sum[3:0]),   .pg(p[0]), .gg(g[0]));
    cla4 blk1(.a(a[7:4]),   .b(b[7:4]),   .cin(c[1]), .sum(sum[7:4]),   .pg(p[1]), .gg(g[1]));
    cla4 blk2(.a(a[11:8]),  .b(b[11:8]),  .cin(c[2]), .sum(sum[11:8]),  .pg(p[2]), .gg(g[2]));
    cla4 blk3(.a(a[15:12]), .b(b[15:12]), .cin(c[3]), .sum(sum[15:12]), .pg(p[3]), .gg(g[3]));

    cla_unit4 lcu(.p(p), .g(g), .cin(cin), .c(c[3:1]), .pg(pg), .gg(gg));
endmodule

// 32 位：两个 cla16，进入高半段的进位由低半段的 P / G 与 cin 超前算出
module cla32(
    input  [31:0] a,
    input  [31:0] b,
    input         cin,
    output [31:0] sum,
    output        cout
);
    wire pg_lo, gg_lo, pg_hi, gg_hi;
    wire c16;

    assign c16  = gg_lo | (pg_lo & cin);
    assign cout = gg_hi | (pg_hi & c16);

    cla16 lo(.a(a[15:0]),  .b(b[15:0]),  .cin(cin), .sum(sum[15:0]),  .pg(pg_lo), .gg(gg_lo));
    cla16 hi(.a(a[31:16]), .b(b[31:16]), .cin(c16), .sum(sum[31:16]), .pg(pg_hi), .gg(gg_hi));
endmodule

module alu(
    input      [31:0] A,
    input      [31:0] B,
    input      [5:0]  Op,
    output reg [31:0] C,
    output reg        Over
);
    localparam OP_ADD  = 6'b100000,
               OP_ADDU = 6'b100001,
               OP_SUB  = 6'b100010,
               OP_SUBU = 6'b100011,
               OP_SLL  = 6'b000000,
               OP_SRL  = 6'b000010,
               OP_SRA  = 6'b000011,
               OP_AND  = 6'b100100,
               OP_OR   = 6'b100101,
               OP_XOR  = 6'b100110,
               OP_NOR  = 6'b100111;

    // 减法时把 B 取反、cin 置 1，一步算出 A + ~B + 1
    wire        sub   = (Op == OP_SUB) || (Op == OP_SUBU);
    wire [31:0] b_eff = B ^ {32{sub}};
    wire [31:0] sum;
    wire        cout;   // 进位输出，本 ALU 不对外输出

    cla32 u_cla(.a(A), .b(b_eff), .cin(sub), .sum(sum), .cout(cout));

    // 有符号溢出：两个加数同号而和的符号与之相反（等价于 c31 ^ c32）
    wire ovf = (A[31] == b_eff[31]) && (sum[31] != A[31]);

    always @(*) begin
        C    = 32'b0;
        Over = 1'b0;
        case (Op)
            OP_ADD:  begin C = sum; Over = ovf; end
            OP_ADDU: C = sum;
            OP_SUB:  begin C = sum; Over = ovf; end
            OP_SUBU: C = sum;
            OP_SLL:  C = B << A[4:0];
            OP_SRL:  C = B >> A[4:0];
            OP_SRA:  C = $signed(B) >>> A[4:0];
            OP_AND:  C = A & B;
            OP_OR:   C = A | B;
            OP_XOR:  C = A ^ B;
            OP_NOR:  C = ~(A | B);
            default: ;  // 未定义的操作码：C = 0，Over = 0
        endcase
    end
endmodule
