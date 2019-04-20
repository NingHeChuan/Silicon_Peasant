vlib work
vlib activehdl

vlib activehdl/xil_defaultlib
vlib activehdl/xpm

vmap xil_defaultlib activehdl/xil_defaultlib
vmap xpm activehdl/xpm

vlog -work xil_defaultlib  -sv2k12 \
"D:/Xilinx/Vivado/2017.4/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \

vcom -work xpm -93 \
"D:/Xilinx/Vivado/2017.4/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -93 \
"../../../../HDMI_output_test.srcs/sources_1/ip/hdmi_disp/src/SyncAsync.vhd" \
"../../../../HDMI_output_test.srcs/sources_1/ip/hdmi_disp/src/SyncAsyncReset.vhd" \
"../../../../HDMI_output_test.srcs/sources_1/ip/hdmi_disp/src/ClockGen.vhd" \
"../../../../HDMI_output_test.srcs/sources_1/ip/hdmi_disp/src/DVI_Constants.vhd" \
"../../../../HDMI_output_test.srcs/sources_1/ip/hdmi_disp/src/OutputSERDES.vhd" \
"../../../../HDMI_output_test.srcs/sources_1/ip/hdmi_disp/src/TMDS_Encoder.vhd" \
"../../../../HDMI_output_test.srcs/sources_1/ip/hdmi_disp/src/rgb2dvi.vhd" \
"../../../../HDMI_output_test.srcs/sources_1/ip/hdmi_disp/sim/hdmi_disp.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

