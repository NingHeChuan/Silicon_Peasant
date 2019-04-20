#Clock signal
set_property PACKAGE_PIN L16 [get_ports {sys_clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {sys_clk}]
create_clock -period 8.000 -waveform {0.000 4.000} [get_ports sys_clk]

set_property IOSTANDARD TMDS_33 [get_ports TMDS_clk_n]


set_property PACKAGE_PIN H16 [get_ports TMDS_clk_p]
set_property IOSTANDARD TMDS_33 [get_ports TMDS_clk_p]


set_property IOSTANDARD TMDS_33 [get_ports {TMDS_data_n[0]}]


set_property PACKAGE_PIN D19 [get_ports {TMDS_data_p[0]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_data_p[0]}]

set_property IOSTANDARD TMDS_33 [get_ports {TMDS_data_n[1]}]


set_property PACKAGE_PIN C20 [get_ports {TMDS_data_p[1]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_data_p[1]}]


set_property IOSTANDARD TMDS_33 [get_ports {TMDS_data_n[2]}]


set_property PACKAGE_PIN B19 [get_ports {TMDS_data_p[2]}]
set_property IOSTANDARD TMDS_33 [get_ports {TMDS_data_p[2]}]


set_property PACKAGE_PIN F17 [get_ports {HDMI_OEN[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {HDMI_OEN[0]}]

#set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets video_pll_m0/inst/clk_in1_video_pll]