
import uhal
import binascii
from math import pow
from time import sleep

manager = uhal.ConnectionManager("file://../xml_files/connections.xml")
hw = manager.getDevice("GCU1F3_CH_0")

###### set the baudrate #########
hw.getNode("uart_2.setup.clks").write(2170)
hw.dispatch()
print "baudrate set to 57600"

###### set parity bits #########
hw.getNode("uart_2.setup.parity").write(0x0)   
hw.dispatch()
print "parity set to: no parity"

###### set number of stop bits #########
hw.getNode("uart_2.setup.stop").write(0)  
hw.dispatch()
print "1 stop bit"
 
###### set number of word bits #########
## 0 = 8 bit word
## 1 = 7 bit word
## 2 = 6 bit word
## 3 = 5 bit word
hw.getNode("uart_2.setup.word").write(0x0)  
hw.dispatch()
print "8 bit word"

###### reset receiver #########
hw.getNode("uart_2.rx_data.rx_reset").write(1)
hw.dispatch()
print "receiver reset done"

###### clear receiver errors #########
hw.getNode("uart_2.rx_data.clear").write(0x3)
hw.dispatch()
print "receiver clear errors done"

###### rx fifo level #########
rx_fifo_fill = hw.getNode("uart_2.fifo.rx_fifo_fill").read()
hw.dispatch()
print "rx fifo fill level: "
print rx_fifo_fill.value()

setup = hw.getNode("uart_2.setup").read()
hw.dispatch()
print "setup: %d" % setup.value()

lgln = hw.getNode("uart_2.fifo.rx_fifo_lgln").read()
hw.dispatch()
print "rx fifo lenght: %d" % lgln.value()


rx_data_valid_mask = 0x00000100
rx_data_mask = 0x000000ff

while True:
    sleep(0.1)
    no_empty = hw.getNode("uart_2.fifo.rx_fifo_not_empty").read()
    rx_fifo_fill = hw.getNode("uart_2.fifo.rx_fifo_fill").read()
    hw.dispatch()

#    print "Fifo is not empty=", no_empty.value()
#    print "Fifo is filled with=", rx_fifo_fill.value()

    for i in  range(rx_fifo_fill):
        rx_data = hw.getNode("uart_2.rx_data").read()
        hw.dispatch()
        rword = rx_data_mask & rx_data
        data_valid = rx_data_valid_mask & rx_data
        if data_valid == 0:
            print(chr(rword)) , " ", rword
