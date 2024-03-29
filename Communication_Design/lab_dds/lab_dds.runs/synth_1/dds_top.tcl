# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7z015iclg485-1L

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir H:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.cache/wt [current_project]
set_property parent.project_path H:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.xpr [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo h:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files H:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.srcs/sources_1/new/sin_coe.coe
add_files H:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.srcs/sources_1/new/square.coe
add_files H:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.srcs/sources_1/new/triangular.coe
add_files H:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.srcs/sources_1/new/cos_coe.coe
read_verilog -library xil_defaultlib {
  H:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.srcs/sources_1/new/DA_5428.v
  H:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.srcs/sources_1/new/Mux_DDS.v
  H:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.srcs/sources_1/new/dds_design.v
}
read_ip -quiet H:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.srcs/sources_1/ip/blk_mem_triangular/blk_mem_triangular.xci
set_property used_in_implementation false [get_files -all h:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.srcs/sources_1/ip/blk_mem_triangular/blk_mem_triangular_ooc.xdc]

read_ip -quiet H:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.srcs/sources_1/ip/blk_mem_square/blk_mem_square.xci
set_property used_in_implementation false [get_files -all h:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.srcs/sources_1/ip/blk_mem_square/blk_mem_square_ooc.xdc]

read_ip -quiet H:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.srcs/sources_1/ip/blk_mem_sin/blk_mem_sin.xci
set_property used_in_implementation false [get_files -all h:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.srcs/sources_1/ip/blk_mem_sin/blk_mem_sin_ooc.xdc]

read_ip -quiet H:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.srcs/sources_1/ip/blk_mem_cos/blk_mem_cos.xci
set_property used_in_implementation false [get_files -all h:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.srcs/sources_1/ip/blk_mem_cos/blk_mem_cos_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc H:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.srcs/constrs_1/new/dds_tp.xdc
set_property used_in_implementation false [get_files H:/Vivado/FPGA_Communicate_Base/lab1_DDS_Design/lab_dds_block_ram/lab_dds/lab_dds.srcs/constrs_1/new/dds_tp.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top dds_top -part xc7z015iclg485-1L


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef dds_top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file dds_top_utilization_synth.rpt -pb dds_top_utilization_synth.pb"
