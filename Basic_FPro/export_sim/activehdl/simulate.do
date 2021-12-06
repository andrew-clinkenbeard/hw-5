onbreak {quit -force}
onerror {quit -force}

asim +access +r +m+temp -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.temp xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure

do {temp.udo}

run -all

endsim

quit -force
