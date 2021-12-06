vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../../Desktop/Class Report 4/FPro/FPro.srcs/sources_1/imports/bridge" \
"../../../../../Desktop/Class Report 4/FPro/FPro.srcs/sources_1/new/temp.sv" \


vlog -work xil_defaultlib \
"glbl.v"

