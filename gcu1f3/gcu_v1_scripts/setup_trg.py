import uhal
import ConfigParser
import argparse
import sys

manager = uhal.ConnectionManager("file://connections.xml")


parser = argparse.ArgumentParser()
parser.add_argument('-e', action='store_true', dest='ext_trg',
                    help='set external trigger, threshold if false')
parser.add_argument('-b', action='store_true', dest='bec_validation',
                    help='set bec validation mode for trigger. Autotrigger if false')
parser.add_argument('-s', action='store', dest='gcu_num',
                    help='select gcu number')

results = parser.parse_args()

try:
    device = 'GCU1F3_' + results.gcu_num
except:
    print "*** Must insert a GCU number ***"
    sys.exit()

hw = manager.getDevice(str(device))

if results.ext_trg:
    ext_trg_value = 1
else:
    ext_trg_value = 0


if results.bec_validation:
    bec_validation_value = 1
else:
    bec_validation_value = 0

hw.getNode("trigger_manager.auto_trigger_mode.trigger_source_selection").write(ext_trg_value)
hw.dispatch()
hw.getNode("trigger_manager.auto_trigger_mode.trigger_path_selection").write(bec_validation_value)
hw.dispatch()
