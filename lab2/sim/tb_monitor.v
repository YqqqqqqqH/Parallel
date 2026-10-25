`timescale 1ns / 1ns
// 批处理检查用的外层顶层：例化课程下发的 alu_tb（其文件不做任何改动），监视 tb.correct。
// - 用 !== 判断，correct 为 X / Z 也算出错（官方波形里 Find Value 搜 0 找不到 X）
// - 每个向量至少保持 2 ns，所以在 correct 变化 1 ns 后采样，读到的是该向量稳定后的值，
//   不会把 t=0 时 X->1 的过渡误报成错误
// - first_fail 为首次出错的向量时刻（ns），-1 表示从未出错；fail_ns 为累计出错时长
// - 带 +stop_on_fail 时首次出错即结束仿真（变异测试只需要首次出错时刻）
// 仿真结束后由 sim.tcl 读出这些变量
module tb_monitor();
    alu_tb tb();

    integer first_fail = -1;
    integer fail_ns    = 0;
    integer bad_since  = -1;   // 当前这段出错从何时开始，-1 表示当前正确
    integer t_vec;
    reg     stop_on_fail;

    initial begin
        stop_on_fail = $test$plusargs("stop_on_fail");
        #1;
        forever begin
            t_vec = $time - 1;
            if (tb.correct !== 1'b1) begin
                if (bad_since < 0) bad_since = t_vec;
                if (first_fail < 0) begin
                    first_fail = t_vec;
                    $display("MONITOR first_fail=%0d op=%b A=%h B=%h C=%h Over=%b ans=%h cov=%b",
                             t_vec, tb.op, tb.in1, tb.in2, tb.out, tb.ov, tb.ans, tb.cov);
                    if (stop_on_fail) $finish;
                end
            end else if (bad_since >= 0) begin
                fail_ns   = fail_ns + (t_vec - bad_since);
                bad_since = -1;
            end
            @(tb.correct);
            #1;
        end
    end
endmodule
