-makelib ies_lib/xil_defaultlib -sv \
  "D:/Xilinx/Vivado/2017.4/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Xilinx/Vivado/2017.4/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../HDMI_output_test.srcs/sources_1/ip/hdmi_disp/src/SyncAsync.vhd" \
  "../../../../HDMI_output_test.srcs/sources_1/ip/hdmi_disp/src/SyncAsyncReset.vhd" \
  "../../../../HDMI_output_test.srcs/sources_1/ip/hdmi_disp/src/ClockGen.vhd" \
  "../../../../HDMI_output_test.srcs/sources_1/ip/hdmi_disp/src/DVI_Constants.vhd" \
  "../../../../HDMI_output_test.srcs/sources_1/ip/hdmi_disp/src/OutputSERDES.vhd" \
  "../../../../HDMI_output_test.srcs/sources_1/ip/hdmi_disp/src/TMDS_Encoder.vhd" \
  "../../../../HDMI_output_test.srcs/sources_1/ip/hdmi_disp/src/rgb2dvi.vhd" \
  "../../../../HDMI_output_test.srcs/sources_1/ip/hdmi_disp/sim/hdmi_disp.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

