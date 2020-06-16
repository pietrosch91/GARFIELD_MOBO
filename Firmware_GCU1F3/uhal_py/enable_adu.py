import uhal
import time
import sys
manager = uhal.ConnectionManager("file://connections.xml")

hw  = manager.getDevice("GCU1F3_CH_LOCAL")
#hw  = manager.getDevice("GCU1F3")
hw.getNode('adu_manager.control_reg.enable_adu_0').write(1)
hw.getNode('adu_manager.control_reg.enable_clock_adu_0').write(1)
hw.dispatch()
hw.getNode('adu_manager.control_reg.enable_adu_1').write(1)
hw.getNode('adu_manager.control_reg.enable_clock_adu_1').write(1)
hw.dispatch()

hw.getNode('adu_manager.control_reg.enable_adu_2').write(1)
hw.getNode('adu_manager.control_reg.enable_clock_adu_2').write(1)
hw.dispatch()
