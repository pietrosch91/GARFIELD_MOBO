onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib trig_header_fifo_opt

do {wave.do}

view wave
view structure
view signals

do {trig_header_fifo.udo}

run -all

quit -force
