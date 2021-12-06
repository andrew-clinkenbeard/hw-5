vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu -sv "+incdir+../../../../../Desktop/Class Report 4/FPro/FPro.srcs/sources_1/imports/bridge" \
"../../../../../Desktop/Class Report 4/FPro/FPro.srcs/sources_1/new/temp.sv" \


vlog -work xil_defaultlib \
"glbl.v"

