import uhal
import time


manager = uhal.ConnectionManager("file://../xml_files/connections.xml")
hw = manager.getDevice("GCU1F3_1")
i=0
while True:
    try:
        hw.getNode("trigger_manager.auto_trigger_mode.force_trigger_ch0").write(1)
        hw.dispatch()
        print i,"trigger sent"
        i = i + 1
        time.sleep(0.1)
    except Exception as e:
        print e
        print "IPBUS ERR"

