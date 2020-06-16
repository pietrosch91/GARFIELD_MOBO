#!/usr/bin/env python
print('\n')
print("----------1588 hw ptp - Demonstration script----------------")
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
print "GCU rx channel calibration procedure"
hw.getNode("cs_write.ctrl.gcu_select").write(int(gcu_num))
hw.getNode("cs_write.ctrl.enable_trigger").write(0)
hw.dispatch()
sleep(0.1)
hw.getNode("cs_write.ctrl.hit_toggle").write(0)
hw.getNode("cs_write.ctrl.l1a_tap_calibration_enable").write(0)
hw.dispatch()
hw.getNode("cs_write.ctrl.l1a_tap_calibration_enable").write(1)
hw.dispatch()
sleep(3)
hw.getNode("cs_write.ctrl.l1a_tap_calibration_enable").write(0)
hw.dispatch()
print "done"
print "GCU1 rx channel eye:"
GCU1_eye = hw.getNode("cs_read.l1a" + gcu_num + "_eye").read()
hw.dispatch()
print GCU1_eye

if GCU1_eye < 40:
    #raw_input("press enter to go with the second eye")
    print "need a second eye"
    hw.getNode("cs_write.ctrl.hit_toggle").write(1)
    hw.getNode("cs_write.ctrl.l1a_tap_calibration_enable").write(0)
    hw.dispatch()
    hw.getNode("cs_write.ctrl.l1a_tap_calibration_enable").write(1)
    hw.dispatch()
    sleep(3)
    hw.getNode("cs_write.ctrl.l1a_tap_calibration_enable").write(0)
    hw.dispatch()
    print "done"
    print "GCU1 rx channel eye:"
    GCU1_eye = hw.getNode("cs_read.l1a" + gcu_num + "_eye").read()
    hw.dispatch()
    print GCU1_eye


hw.getNode("cs_write.ctrl.enable_trigger").write(1)
hw.dispatch()
