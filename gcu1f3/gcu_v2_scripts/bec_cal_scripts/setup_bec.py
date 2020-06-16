import argparse
from time import sleep

parser = argparse.ArgumentParser()
parser.add_argument('-s', action='store', dest='gcu_num',
                    help='select gcu number')

results = parser.parse_args()

import uhal

manager = uhal.ConnectionManager("file://../xml_files/connections.xml")
hw = manager.getDevice("BEC")

for index in range(1,(int(results.gcu_num))+1):

    #ttc calibration
    print "GCU" + str(index) + " rx ttc channel calibration procedure"
    hw.getNode("cs_write.ctrl.gcu_select").write(index)
    hw.getNode("cs_write.ctrl.tap_calibration_enable").write(0)
    hw.dispatch()
    hw.getNode("cs_write.ctrl.tap_calibration_enable").write(1)
    hw.dispatch()
    sleep(2)
    hw.getNode("cs_write.ctrl.tap_calibration_enable").write(0)
    hw.dispatch()
    print "ttc done"

    #l1a calibration
    print "GCU" + str(index) + " rx l1a channel calibration procedure"
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
    GCU1_l1a_eye = hw.getNode("cs_read.l1a" + str(index) + "_eye").read()
    hw.dispatch()
    if GCU1_l1a_eye < 40:
        print "need a second eye"
        hw.getNode("cs_write.ctrl.hit_toggle").write(1)
        hw.getNode("cs_write.ctrl.l1a_tap_calibration_enable").write(0)
        hw.dispatch()
        hw.getNode("cs_write.ctrl.l1a_tap_calibration_enable").write(1)
        hw.dispatch()
        sleep(3)
        hw.getNode("cs_write.ctrl.l1a_tap_calibration_enable").write(0)
        hw.dispatch()
    print "l1a done"
    hw.getNode("cs_write.ctrl.enable_trigger").write(1)
    hw.dispatch()                

for index in range(1,(int(results.gcu_num))+1):

    print "GCU" + str(index) + " rx ttc channel eye:"
    GCU1_eye = hw.getNode("cs_read.ttcrx" + str(index) + "_eye").read()
    hw.dispatch()
    print GCU1_eye

    print "GCU" + str(index) + " rx l1a channel eye:"
    GCU1_l1a_eye = hw.getNode("cs_read.l1a" + str(index) + "_eye").read()
    hw.dispatch()
    print GCU1_l1a_eye


#Synchronize GCU
print "Time synchronization"
hw.getNode("cs_write.1588ptp_period").write(0x04000000)
hw.dispatch()
hw.getNode("cs_write.ctrl.1588ptp_enable").write(0)
hw.dispatch()
hw.getNode("cs_write.ctrl.1588ptp_enable").write(1)
hw.dispatch()
print "done"

