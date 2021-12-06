vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib  -incr -mfcu -sv "+incdir+../../../../../Desktop/Class Report 4/FPro/FPro.srcs/sources_1/imports/bridge" \
"../../../../../Desktop/Class Report 4/FPro/FPro.srcs/sources_1/new/temp.sv" \


vlog -work xil_defaultlib \
"glbl.v"

