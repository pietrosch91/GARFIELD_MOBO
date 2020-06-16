import uhal
import configparser
import argparse
from time import sleep

# Read parameters
Config = configparser.ConfigParser()
parser = argparse.ArgumentParser()
"""
parser.add_argument('-a', action='store_true', dest='config_adus',
                    help='Configure adus for data acquisition')
"""
parser.add_argument('-c', action='store', dest='config_file',
                    help='configuration file')
results = parser.parse_args()

#Read ini file
try:
    Config.read(results.config_file)
except:
    print " Wrong or missing config_file"

# Select Channel
selected_channel = Config.get('ChannelSelection', 'Channel')
if (selected_channel == "0"):
    import gcu_adu0_conf as gcu
elif (selected_channel == "1"):
    import gcu_adu1_conf as gcu
elif (selected_channel == "2"):
    import gcu_adu2_conf as gcu
else:
    print "channel number must be 0-2"
    sys.exit()

#Enable ADUs
connection_string = 'file://' + \
                    Config.get('IPBusParameters', 'ConnectionFile')

"""
if results.config_adus:
    manager = uhal.ConnectionManager(str(connection_string))
    device = Config.get('IPBusParameters', 'GCUid')
    hw = manager.getDevice(str(device))

    hw.getNode(str('adu_manager.control_reg.enable_clock_adu_' + selected_channel)).write(1)
    hw.dispatch()
    hw.getNode(str('adu_manager.control_reg.enable_adu_' + selected_channel)).write(0)
    hw.dispatch()
    sleep(1)
    hw.getNode(str('adu_manager.control_reg.enable_adu_' + selected_channel)).write(1)
    hw.dispatch()
"""

connection_string = 'file://' + \
                    Config.get('IPBusParameters', 'ConnectionFile')
# Connect to GCU
manager = uhal.ConnectionManager(str(connection_string))
device = Config.get('IPBusParameters', 'GCUid')
hw = manager.getDevice(str(device))
my_gcu = gcu.GCU(hw)
#apply configurations from ini file
Threshold = int(Config.get('DaqParameters', 'Threshold'))
PreTrigger = int(Config.get('DaqParameters', 'PreTrigger'))
TriggerWindow = int(Config.get('DaqParameters', 'TriggerWindow'))
my_gcu.set_pre_trigger(PreTrigger)
my_gcu.set_trigger_window(TriggerWindow)
my_gcu.set_trigger_threshold(Threshold)
my_gcu.try_dispatch()
