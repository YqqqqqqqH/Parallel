# xsim 批处理脚本：跑完整个仿真，再读出 tb_monitor 的计数器
run all
puts "MONITOR_END time=[current_time] first_fail=[get_value -radix dec /tb_monitor/first_fail] fail_ns=[get_value -radix dec /tb_monitor/fail_ns] bad_since=[get_value -radix dec /tb_monitor/bad_since]"
quit
