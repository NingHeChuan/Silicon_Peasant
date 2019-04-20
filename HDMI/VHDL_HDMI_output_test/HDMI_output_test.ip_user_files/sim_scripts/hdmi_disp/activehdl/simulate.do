onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+hdmi_disp -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.hdmi_disp xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {hdmi_disp.udo}

run -all

endsim

quit -force
