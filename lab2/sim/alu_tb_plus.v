`timescale 1ns / 1ns
// 增强激励（自检式）：补上官方激励的盲区，逐向量与参考模型比对
// - 用 !== 比较 {Over, C}，X / Z 也算错
// - 五类向量分别计错：corner 边界值全组合、carry 长进位链、shamt 移位量高位污染、
//   random 固定种子随机满位操作数、undef 未定义操作码（设计约定 C=0、Over=0）
// - 打印前 10 个不一致的向量，最后输出各类错误数与 PLUS_TOTAL
module alu_tb_plus();
    reg  [31:0] A, B;
    reg  [5:0]  Op;
    wire [31:0] C;
    wire        Over;

    alu uut(.A(A), .B(B), .C(C), .Op(Op), .Over(Over));

    localparam OP_ADD  = 6'b100000, OP_ADDU = 6'b100001, OP_SUB = 6'b100010, OP_SUBU = 6'b100011,
               OP_SLL  = 6'b000000, OP_SRL  = 6'b000010, OP_SRA = 6'b000011,
               OP_AND  = 6'b100100, OP_OR   = 6'b100101, OP_XOR = 6'b100110, OP_NOR  = 6'b100111;
    localparam CORNER = 0, CARRY = 1, SHAMT = 2, RANDOM = 3, UNDEF = 4;

    integer err[0:4];
    integer nvec, nerr, seed;
    integer i, j, k, n;
    reg [5:0]  ops[0:10];
    reg [31:0] corners[0:9];
    reg [31:0] x, y;

    // 参考模型，返回 {Over, C}；写法与官方激励的 ans / cov 相同
    function [32:0] ref_alu;
        input [5:0]  op;
        input [31:0] a, b;
        reg   [31:0] r;
        reg          ov;
        begin
            ov = 1'b0;
            case (op)
                OP_ADD:  begin r = a + b; ov = (a[31] == b[31]) && (r[31] != a[31]); end
                OP_ADDU: r = a + b;
                OP_SUB:  begin r = a - b; ov = (a[31] != b[31]) && (r[31] != a[31]); end
                OP_SUBU: r = a - b;
                OP_SLL:  r = b << a[4:0];
                OP_SRL:  r = b >> a[4:0];
                OP_SRA:  r = $signed(b) >>> a[4:0];
                OP_AND:  r = a & b;
                OP_OR:   r = a | b;
                OP_XOR:  r = a ^ b;
                OP_NOR:  r = ~(a | b);
                default: r = 32'b0;
            endcase
            ref_alu = {ov, r};
        end
    endfunction

    function is_defined;
        input [5:0] op;
        integer t;
        begin
            is_defined = 1'b0;
            for (t = 0; t < 11; t = t + 1)
                if (ops[t] == op) is_defined = 1'b1;
        end
    endfunction

    task check;
        input [5:0]  op;
        input [31:0] a, b;
        input [2:0]  cls;
        reg   [32:0] exp;
        begin
            Op = op; A = a; B = b;
            #1;
            exp  = ref_alu(op, a, b);
            nvec = nvec + 1;
            if ({Over, C} !== exp) begin
                err[cls] = err[cls] + 1;
                nerr     = nerr + 1;
                if (nerr <= 10)
                    $display("MISMATCH class=%0d t=%0t op=%b A=%h B=%h C=%h Over=%b expC=%h expOver=%b",
                             cls, $time, op, a, b, C, Over, exp[31:0], exp[32]);
            end
            #1;
        end
    endtask

    initial begin
        ops[0] = OP_ADD; ops[1] = OP_ADDU; ops[2] = OP_SUB; ops[3] = OP_SUBU;
        ops[4] = OP_SLL; ops[5] = OP_SRL;  ops[6] = OP_SRA;
        ops[7] = OP_AND; ops[8] = OP_OR;   ops[9] = OP_XOR; ops[10] = OP_NOR;
        corners[0] = 32'h00000000; corners[1] = 32'h00000001; corners[2] = 32'h00000002;
        corners[3] = 32'h7FFFFFFF; corners[4] = 32'h80000000; corners[5] = 32'h80000001;
        corners[6] = 32'hFFFFFFFE; corners[7] = 32'hFFFFFFFF; corners[8] = 32'h55555555;
        corners[9] = 32'hAAAAAAAA;
        for (i = 0; i < 5; i = i + 1) err[i] = 0;
        nvec = 0; nerr = 0; seed = 2026;

        // ① 边界值全组合：10 x 10 x 11 种运算（移位时 A 的高位也不全为 0）
        for (k = 0; k < 11; k = k + 1)
            for (i = 0; i < 10; i = i + 1)
                for (j = 0; j < 10; j = j + 1)
                    check(ops[k], corners[i], corners[j], CORNER);

        // ② 长进位链：(2^n - 1) + 1、2^n - 1，以及随机 x 的 x + ~x、x + (-x)、x - x
        for (k = 0; k < 4; k = k + 1) begin
            for (n = 0; n <= 32; n = n + 1) begin
                x = (n == 32) ? 32'hFFFFFFFF : ((32'd1 << n) - 32'd1);
                check(ops[k], x, 32'd1, CARRY);
                check(ops[k], x + 32'd1, 32'd1, CARRY);
            end
            for (n = 0; n < 200; n = n + 1) begin
                x = $random(seed);
                check(ops[k], x, ~x, CARRY);
                check(ops[k], x, ~x + 32'd1, CARRY);
                check(ops[k], x, x, CARRY);
            end
        end

        // ③ 移位量高位污染：A[4:0] 取遍 0..31，A[31:5] 随机且非零
        for (k = 4; k < 7; k = k + 1)
            for (n = 0; n < 32; n = n + 1)
                for (i = 0; i < 20; i = i + 1) begin
                    x = $random(seed);
                    x = {x[31:6], 1'b1, n[4:0]};
                    check(ops[k], x, $random(seed), SHAMT);
                end

        // ④ 随机满位操作数：每种运算 20000 组
        for (k = 0; k < 11; k = k + 1)
            for (n = 0; n < 20000; n = n + 1) begin
                x = $random(seed);
                y = $random(seed);
                check(ops[k], x, y, RANDOM);
            end

        // ⑤ 未定义操作码：53 个，每个 20 组随机操作数，期望 C=0、Over=0
        for (k = 0; k < 64; k = k + 1)
            if (!is_defined(k[5:0]))
                for (n = 0; n < 20; n = n + 1) begin
                    x = $random(seed);
                    y = $random(seed);
                    check(k[5:0], x, y, UNDEF);
                end

        $display("PLUS class=corner errors=%0d", err[CORNER]);
        $display("PLUS class=carry errors=%0d",  err[CARRY]);
        $display("PLUS class=shamt errors=%0d",  err[SHAMT]);
        $display("PLUS class=random errors=%0d", err[RANDOM]);
        $display("PLUS class=undef errors=%0d",  err[UNDEF]);
        $display("PLUS_TOTAL vectors=%0d errors=%0d", nvec, nerr);
        $display("PLUS RESULT %0s", (nerr == 0) ? "PASS" : "FAIL");
        $finish;
    end
endmodule
