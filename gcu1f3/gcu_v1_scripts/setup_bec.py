import uhal
import argparse
from time import sleep


manager = uhal.ConnectionManager("file://timing_connections.xml")
hw = manager.getDevice("BEC")

parser = argparse.ArgumentParser()
parser.add_argument('-s', action='store', dest='gcu_num',
                    help='select gcu number')

results = parser.parse_args()

for index in range(1,(int(results.gcu_num))+1):

    print "GCU" + str(index) + " rx channel calibration procedure"
    hw.getNode("cs_write.ctrl.gcu_select").write(index)
    hw.getNode("cs_write.ctrl.tap_calibration_enable").write(0)
    hw.dispatch()
    hw.getNode("cs_write.ctrl.tap_calibration_enable").write(1)
    hw.dispatch()
    sleep(2)
    hw.getNode("cs_write.ctrl.tap_calibration_enable").write(0)
    hw.dispatch()
    print "done"

for index in range(1,(int(results.gcu_num))+1):

    print "GCU" + str(index) + " rx channel eye:"
    GCU1_eye = hw.getNode("cs_read.ttcrx" + str(index) + "_eye").read()
    hw.dispatch()
    print GCU1_eye


#Synchronize GCU
print "Time synchronization"
hw.getNode("cs_write.ctrl.1588ptp_enable").write(0)
hw.dispatch()
hw.getNode("cs_write.ctrl.1588ptp_enable").write(1)
hw.dispatch()
print "done"

