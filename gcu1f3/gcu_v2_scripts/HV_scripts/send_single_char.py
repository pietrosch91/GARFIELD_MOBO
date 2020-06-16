import uhal
import binascii
from math import pow
from time import sleep

manager = uhal.ConnectionManager("file://../xml_files/connections.xml")
hw = manager.getDevice("GCU1F3_CH_0")

###### set the baudrate #########
hw.getNode("uart.setup.clks").write(2170)
hw.dispatch()
print "baudrate set to 57600"

###### set parity bits #########
hw.getNode("uart.setup.parity").write(0x0)   
hw.dispatch()
print "parity set to: no parity"

###### set number of stop bits #########
hw.getNode("uart.setup.stop").write(0)  
hw.dispatch()
print "1 stop bit"
 
###### set number of word bits #########
## 0 = 8 bit word
## 1 = 7 bit word
## 2 = 6 bit word
## 3 = 5 bit word
hw.getNode("uart.setup.word").write(0x0)  
hw.dispatch()
print "8 bit word"

###### reset receiver #########
hw.getNode("uart.rx_data.rx_reset").write(1)
hw.dispatch()
print "receiver reset done"

###### clear receiver errors #########
hw.getNode("uart.rx_data.clear").write(0x3)
hw.dispatch()
print "receiver clear errors done"

###### rx fifo level #########
rx_fifo_fill = hw.getNode("uart.fifo.rx_fifo_fill").read()
hw.dispatch()
print "rx fifo fill level: "
print rx_fifo_fill.value()

setup = hw.getNode("uart.setup").read()
hw.dispatch()
print "setup: %d" % setup.value()

lgln = hw.getNode("uart.fifo.rx_fifo_lgln").read()
hw.dispatch()
print "rx fifo lenght: %d" % lgln.value()


send = ord('U')
hw.getNode("uart.tx_data").write(send)
hw.dispatch()

