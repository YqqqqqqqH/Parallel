# 创建供截图用的 GUI 工程 E:\vivado_proj\lab2_alu\lab2_alu.xpr
# 只含交付的 alu.v 和课程下发的 alu_tb.v；仿真时长设为 2500us（官方激励在 2424882 ns 结束，默认的 1000ns 不够）
# 用法：先把 src/alu.v、alu_tb.v 复制到 E:\vivado_proj\lab2_alu\src\，再在该目录下运行
#   vivado -mode batch -source make_project.tcl
set root [file dirname [file normalize [info script]]]

create_project lab2_alu $root -part xc7a35tcsg324-1 -force
add_files -norecurse $root/src/alu.v
add_files -fileset sim_1 -norecurse $root/src/alu_tb.v
set_property top alu [current_fileset]
set_property top alu_tb [get_filesets sim_1]
set_property -name {xsim.simulate.runtime} -value {2500us} -objects [get_filesets sim_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
close_project
