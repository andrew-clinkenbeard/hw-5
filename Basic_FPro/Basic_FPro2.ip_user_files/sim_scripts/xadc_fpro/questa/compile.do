vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm  -incr -mfcu -sv \
"C:/XilinxVitis/Vivado/2021.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93 \
"C:/XilinxVitis/Vivado/2021.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -mfcu \
"../../../../Basic_FPro2.gen/sources_1/ip/xadc_fpro/xadc_fpro.v" \


vlog -work xil_defaultlib \
"glbl.v"

