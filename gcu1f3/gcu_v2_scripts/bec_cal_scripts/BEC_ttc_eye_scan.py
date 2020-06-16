#!/usr/bin/env python
print('\n')
print("----------Eye scan - Demonstration script----------------")
print('\n')

import uhal
import matplotlib as mp
import matplotlib.pyplot as plt
import numpy as np
from math import pow
from time import sleep

manager = uhal.ConnectionManager("file://../xml_files/connections.xml")
hw = manager.getDevice("BEC")

print "BEC Status: "
print '\n'

pll_locked = hw.getNode("cs_read.status.pll_locked").read()
ttc_tx_ready = hw.getNode("cs_read.status.ttc_tx_ready").read()
ttc_rx_ready1 = hw.getNode("cs_read.ttcrx_ready1").read()
ttc_rx_ready2 = hw.getNode("cs_read.ttcrx_ready2").read()
aligned1 = hw.getNode("cs_read.ttcrx_aligned1").read()
aligned2 = hw.getNode("cs_read.ttcrx_aligned2").read()

hw.dispatch()

ttc_rx_ready = hex(ttc_rx_ready2.value() << 32 | ttc_rx_ready1.value())
aligned = hex(aligned2.value() << 32 | aligned1.value())

print "pll locked: "
print pll_locked
print "ttc tx ready: "
print ttc_tx_ready
print "ttc rx ready vector of flags: "
print ttc_rx_ready
print "ttc rx aligned vector of flags: "
print aligned

gcu_num = raw_input("GCU number: ")

"""
print "GCU1 rx channel eye scansion start"
x = []
lst = []
hw.getNode("cs_write.ctrl.gcu_select").write(1)
hw.getNode("cs_write.ctrl.tap_rst").write(0)
hw.dispatch()
hw.getNode("cs_write.ctrl.tap_rst").write(1)
hw.dispatch()
hw.getNode("cs_write.ctrl.tap_rst").write(0)
hw.dispatch()
sleep(0.1)
err_count = hw.getNode("cs_read.tap_err_count").read()
hw.dispatch()  
#lst.append(err_count.value())
#x.append(0)
j = 1
while j < 100: 
   hw.getNode("cs_write.ctrl.tap_incr").write(0)
   hw.dispatch()
   hw.getNode("cs_write.ctrl.tap_incr").write(1)
   hw.dispatch()
   hw.getNode("cs_write.ctrl.tap_incr").write(0)
   hw.dispatch()
   sleep(0.1)
   err_count = hw.getNode("cs_read.tap_err_count").read()
   hw.dispatch()
   err_number = err_count.value()
   if err_number > 2000:
      err_number = 2000
   x.append(j)      
   lst.append(err_number)
   j = j+1

fig1, ax1 = plt.subplots(figsize=(10,5))
ax1.set_title('TTC RX1 eye scansion')
ax1.set_xlabel('tap count')
ax1.set_ylabel('error number')
plt.plot(x,lst,'ro')

print "GCU1 rx channel eye scansion stop"
"""
print "GCU1 rx channel eye scansion start"
x2 = []
lst2 = []
#hw.getNode("cs_write.ctrl.gcu_select").write(1)
hw.getNode("cs_write.ctrl.gcu_select").write(int(gcu_num))
hw.getNode("cs_write.ctrl.tap_rst").write(0)
hw.dispatch()
hw.getNode("cs_write.ctrl.tap_rst").write(1)
hw.dispatch()
hw.getNode("cs_write.ctrl.tap_rst").write(0)
hw.dispatch()
sleep(0.1)
err_count = hw.getNode("cs_read.tap_err_count").read()
hw.dispatch()
#lst2.append(err_count.value())
#x2.append(0)
j = 1
while j < 123:
   hw.getNode("cs_write.ctrl.tap_incr").write(0)
   hw.dispatch()
   hw.getNode("cs_write.ctrl.tap_incr").write(1)
   hw.dispatch()
   hw.getNode("cs_write.ctrl.tap_incr").write(0)
   hw.dispatch()
   sleep(0.03)
   err_count = hw.getNode("cs_read.tap_err_count").read()
   hw.dispatch()
   err_number = err_count.value()
   if err_number > 2000:
      err_number = 2000
   x2.append(j)
   lst2.append(err_number)
   j = j+1

fig2, ax2 = plt.subplots(figsize=(10,5))
ax2.set_title('TTC RX2 eye scansion')
ax2.set_xlabel('tap count')
ax2.set_ylabel('error number')
plt.plot(x2,lst2,'ro')

print "GCU rx channel eye scansion stop"
plt.show()


