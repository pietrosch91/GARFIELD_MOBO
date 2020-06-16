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
GCU1 = manager.getDevice("GCU1")
GCU2 = manager.getDevice("GCU2")
GCU3 = manager.getDevice("GCU3")

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


# wait until fmc initialization ends

while 1:
  reply = raw_input('enter the number of the function, q to exit' '\n'
  '1 = 1588 ptp enable' '\n'
  '2 = 1588 ptp disable' '\n'
  '3 = set 1588 ptp period' '\n'
  '4 = set pulse polarity - positive pulse' '\n'
  '5 = set pulse polarity - negative pulse' '\n'
  '6 = set pulse width - 10 TCK' '\n'
  '7 = set pulse delay - 2 TCK' '\n'
  '8 = get time' '\n'
  '9 = set pulse time' '\n'
  '10 = software reset' '\n'
  '11 = TTCRX1 error report' '\n'
  '12 = TTCRX2 error report' '\n'
  '13 = TTCRX3 error report' '\n'
  '14 = set coarse delay' '\n'
  '15 = set pulse time all' '\n'
  '16 = broadcast rst errors' '\n'
  '17 = broadcast idle' '\n'
  '18 = GCU1 rx channel calibration' '\n'
  '19 = GCU2 rx channel calibration' '\n'
  '20 = GCU3 rx channel calibration' '\n'
  '21 = broadcast reset time' '\n'
  '22 = ttcrx1 coarse delay' '\n'
  '23 = ttcrx2 coarse delay' '\n'
  '24 = ttcrx3 coarse delay' '\n'
  )
  if reply == "q":
    exit()
  elif reply == "1":
    hw.getNode("cs_write.ctrl.1588ptp_enable").write(1)
    hw.dispatch()
    print "done"
    print '\n'
    sleep(1)
  elif reply == "2":
    hw.getNode("cs_write.ctrl.1588ptp_enable").write(0)
    hw.dispatch()
    print "done"
    print '\n'
    sleep(1)
  elif reply == "3":
    hw.getNode("cs_write.1588ptp_period").write(0x04000000)
    hw.dispatch()
    print "1588 ptp period 0x04000000"
    print '\n'
    sleep(1)
  elif reply == "4":
    hw.getNode("cs_write.ctrl.polarity").write(0) #positive pulse
    hw.dispatch()
    print "done"
    print '\n'
    sleep(1)  
  elif reply == "5":
    hw.getNode("cs_write.ctrl.polarity").write(1) #negative pulse
    hw.dispatch()
    print "done"
    print '\n'
    sleep(1)    
  elif reply == "6":
    hw.getNode("cs_write.pulse_width").write(0xa)
    hw.dispatch()
    print "10 TCK"
    print '\n'
    sleep(1)
  elif reply == "7":
    hw.getNode("cs_write.pulse_delay").write(0x2)
    hw.dispatch()
    print "2 TCK"
    print '\n'
    sleep(1)
  elif reply == "8":
    time1 = hw.getNode("cs_read.globaltime1").read()
    time2 = hw.getNode("cs_read.globaltime2").read()
    hw.dispatch()
    time = hex(time2.value() << 32 | time1.value()) 
    print time
    print '\n'
    sleep(1)
  elif reply == "9":
    pulse_time = input("enter the pulse time: ")
    pulse_time1 = pulse_time & 0x00000000ffffffff
    pulse_time2 = pulse_time & 0x0000ffff00000000
    hw.getNode("cs_write.pulse_time1").write(pulse_time1)
    hw.getNode("cs_write.pulse_time2").write(pulse_time2 >> 32)
    hw.dispatch()
    print 'done'
    print '\n'
    sleep(1)
  elif reply == "10":
    hw.getNode("cs_write.ctrl.sw_rst").write(1)
    hw.dispatch()
    hw.getNode("cs_write.ctrl.sw_rst").write(0)
    hw.dispatch()
    print "done"
    print '\n'
    sleep(1)
  elif reply == "11":
    n_1bit_errors = hw.getNode("cs_read.ttcrx1_1_bit_error_counter").read()
    n_2bit_errors = hw.getNode("cs_read.ttcrx1_2_bit_error_counter").read()
    n_comm_errors = hw.getNode("cs_read.ttcrx1_comm_error_counter").read()
    hw.dispatch()

    print "TTCRX1 single bit error counter: "
    print n_1bit_errors

    print "TTCRX1 double bit error counter: "
    print n_2bit_errors

    print "TTCRX1 comm error counter: "
    print n_comm_errors

  elif reply == "12":
    n_1bit_errors = hw.getNode("cs_read.ttcrx2_1_bit_error_counter").read()
    n_2bit_errors = hw.getNode("cs_read.ttcrx2_2_bit_error_counter").read()
    n_comm_errors = hw.getNode("cs_read.ttcrx2_comm_error_counter").read()
    hw.dispatch()

    print "TTCRX2 single bit error counter: "
    print n_1bit_errors

    print "TTCRX2 double bit error counter: "
    print n_2bit_errors

    print "TTCRX2 comm error counter: "
    print n_comm_errors

  elif reply == "13":
    n_1bit_errors = hw.getNode("cs_read.ttcrx3_1_bit_error_counter").read()
    n_2bit_errors = hw.getNode("cs_read.ttcrx3_2_bit_error_counter").read()
    n_comm_errors = hw.getNode("cs_read.ttcrx3_comm_error_counter").read()
    hw.dispatch()

    print "TTCRX3 single bit error counter: "
    print n_1bit_errors

    print "TTCRX3 double bit error counter: "
    print n_2bit_errors

    print "TTCRX3 comm error counter: "
    print n_comm_errors
 
  elif reply == "14":
    coarse_delay = input("enter coarse delay: ")
    hw.getNode("cs_write.ctrl.coarse_delay").write(coarse_delay)
    hw.dispatch()
    print 'done'
    print '\n'
    sleep(1)

  elif reply == "15":
    pulse_time = input("enter the pulse time: ")
    pulse_time1 = pulse_time & 0x00000000ffffffff
    pulse_time2 = pulse_time & 0x0000ffff00000000

    GCU1_pulse_time1 = pulse_time1 
    GCU1_pulse_time2 = pulse_time2

    GCU2_pulse_time1 = pulse_time1
    GCU2_pulse_time2 = pulse_time2

    GCU3_pulse_time1 = pulse_time1
    GCU3_pulse_time2 = pulse_time2

    hw.getNode("cs_write.pulse_time1").write(pulse_time1)
    hw.getNode("cs_write.pulse_time2").write(pulse_time2 >> 32)
    hw.dispatch()
    sleep(0.001)
    GCU1.getNode("cs_write.pulsetime1").write(GCU1_pulse_time1)
    GCU1.getNode("cs_write.pulsetime2").write(GCU1_pulse_time2 >> 32)
    GCU1.dispatch()
    sleep(0.001)
    GCU2.getNode("cs_write.pulsetime1").write(GCU2_pulse_time1)
    GCU2.getNode("cs_write.pulsetime2").write(GCU2_pulse_time2 >> 32)
    GCU2.dispatch()
    sleep(0.001)
    GCU3.getNode("cs_write.pulsetime1").write(GCU3_pulse_time1)
    GCU3.getNode("cs_write.pulsetime2").write(GCU3_pulse_time2 >> 32)
    GCU3.dispatch()
    sleep(0.001)

    print 'done'
    print '\n'
    sleep(1)

  elif reply == "16":
    print "broadcasting error reset command"
    # TTC channel b request:
    hw.getNode("cs_write.ctrl.chb_req1").write(1)
    hw.dispatch()
    # wait until chb has been granted:
    i = 0
    while i < 1:
       grant = hw.getNode("cs_read.status.chb_grant1").read()
       hw.dispatch()
       if grant == 1:
          i = 1
    hw.getNode("cs_write.ctrl.chb_req1").write(0)
    hw.getNode("cs_write.ctrl.brd_rst_errors").write(0)
    hw.dispatch()
    hw.getNode("cs_write.ctrl.brd_rst_errors").write(1)
    hw.dispatch()
    hw.getNode("cs_write.ctrl.brd_rst_errors").write(0)
    hw.dispatch()
    print "done"

  elif reply == "17":
    print "broadcasting idle command"
    # TTC channel b request:
    hw.getNode("cs_write.ctrl.chb_req1").write(1)
    hw.dispatch()
    # wait until chb has been granted:
    i = 0
    while i < 1:
       grant = hw.getNode("cs_read.status.chb_grant1").read()
       hw.dispatch()
       if grant.value() == 1:
          i = 1
    hw.getNode("cs_write.ctrl.chb_req1").write(0)
    hw.getNode("cs_write.ctrl.brd_idle").write(0)
    hw.dispatch()
    hw.getNode("cs_write.ctrl.brd_idle").write(1)
    hw.dispatch()
    hw.getNode("cs_write.ctrl.brd_idle").write(0)
    hw.dispatch()
    print "done"
  elif reply == "18":
    print "GCU5 rx channel calibration procedure"
    hw.getNode("cs_write.ctrl.gcu_select").write(1)
    hw.getNode("cs_write.ctrl.tap_calibration_enable").write(0)
    hw.dispatch()
    hw.getNode("cs_write.ctrl.tap_calibration_enable").write(1)
    hw.dispatch()
    sleep(2)
    hw.getNode("cs_write.ctrl.tap_calibration_enable").write(0)
    hw.dispatch()
    print "done"
    print "GCU1 rx channel eye:"
    GCU1_eye = hw.getNode("cs_read.ttcrx1_eye").read()
    hw.dispatch()
    print GCU1_eye
  elif reply == "19":
    print "GCU2 rx channel calibration procedure"
    hw.getNode("cs_write.ctrl.gcu_select").write(2)
    hw.getNode("cs_write.ctrl.tap_calibration_enable").write(0)
    hw.dispatch()
    hw.getNode("cs_write.ctrl.tap_calibration_enable").write(1)
    hw.dispatch()
    sleep(2)
    hw.getNode("cs_write.ctrl.tap_calibration_enable").write(0)
    hw.dispatch()
    print "done"
    print "GCU2 rx channel eye:"
    GCU2_eye = hw.getNode("cs_read.ttcrx2_eye").read()
    hw.dispatch()
    print GCU2_eye
  elif reply == "20":
    print "GCU3 rx channel calibration procedure"
    hw.getNode("cs_write.ctrl.gcu_select").write(3)
    hw.getNode("cs_write.ctrl.tap_calibration_enable").write(0)
    hw.dispatch()
    hw.getNode("cs_write.ctrl.tap_calibration_enable").write(1)
    hw.dispatch()
    hw.getNode("cs_write.ctrl.tap_calibration_enable").write(0)
    hw.dispatch()
    sleep(2)
    print "done"
    print "GCU3 rx channel eye:"
    GCU3_eye = hw.getNode("cs_read.ttcrx3_eye").read()
    hw.dispatch()
    print GCU3_eye
  elif reply == "21":
    print "broadcasting reset time command"
    # TTC channel b request:
    hw.getNode("cs_write.ctrl.chb_req1").write(1)
    hw.dispatch()
    # wait until chb has been granted:
    i = 0
    while i < 1:
       grant = hw.getNode("cs_read.status.chb_grant1").read()
       hw.dispatch()
       if grant == 1:
          i = 1
    hw.getNode("cs_write.ctrl.chb_req1").write(0)
    hw.getNode("cs_write.ctrl.brd_rst_time").write(0)
    hw.dispatch()
    hw.getNode("cs_write.ctrl.brd_rst_time").write(1)
    hw.dispatch()
    hw.getNode("cs_write.ctrl.brd_rst_time").write(0)
    hw.dispatch()
    print "done"
  elif reply == "22":
    print '6 tclk are needed to compensate the cdr latency which is 6 tclk'
    coarse_delay = input("enter ttcrx1 coarse delay: ")
    hw.getNode("cs_write.coarse_delay_ttcrx1").write(coarse_delay)
    hw.dispatch()
    print 'done'
    print '\n'
    sleep(1)
  elif reply == "23":
    print '6 tclk are needed to compensate the cdr latency which is 6 tclk'
    coarse_delay = input("enter ttcrx2 coarse delay: ")
    hw.getNode("cs_write.coarse_delay_ttcrx2").write(coarse_delay)
    hw.dispatch()
    print 'done'
    print '\n'
    sleep(1)
  elif reply == "24":
    print '6 tclk are needed to compensate the cdr latency which is 6 tclk'
    coarse_delay = input("enter ttcrx3 coarse delay: ")
    hw.getNode("cs_write.coarse_delay_ttcrx3").write(coarse_delay)
    hw.dispatch()
    print 'done'
    print '\n'
    sleep(1)



