onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+xadc_fpro -L xpm -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.xadc_fpro xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {xadc_fpro.udo}

run -all

endsim

quit -force
