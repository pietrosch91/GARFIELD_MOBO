#!/usr/bin/env python
import configparser
import signal
import sys
import os
import logging
import argparse
import uhal
import time
import asciichart
from collections import deque
from time import gmtime, strftime
from numpy import mean, std
# matplotlib.use('TKAgg')

__author__ = "Antonio Bergnoli", "Davide Pedretti"
__copyright__ = "Copyright 2017, INFN, LNL"
__credits__ = []
__license__ = "GPL"
__version__ = "0.0.1"
__maintainer__ = "Antonio Bergnoli"
__email__ = "antonio.bergnoli@dwave.it"
__status__ = "Developement"

# Utils section
ANSI_COLOR_RED = "\x1b[31m"
ANSI_COLOR_RESET = "\x1b[0m"

BUFFER_TRESHOLD = 2000


def signal_handler(signal, frame):
    print('Termination by Ctrl+C!')
    sys.exit(0)


def add_newline(s):
    return s + "\n"


def hex_pretty_print(d):
    return "{0:#0{1}x}".format(d, 6)


def seq_in_seq(subseq, seq):
    while subseq[0] in seq:
        index = seq.index(subseq[0])
        if subseq == seq[index:index + len(subseq)]:
            return index
        else:
            seq = seq[index + 1:]
    else:
        return None


def get_2_words(a):
    w1 = a >> 16
    w2 = a & 0x0000FFFF
    return w1, w2
#####################


check_incoming_packet = True
signal.signal(signal.SIGINT, signal_handler)
print('Press Ctrl+C')
logger = logging.getLogger()
handler = logging.StreamHandler()
formatter = logging.Formatter(
    '%(asctime)s %(name)-12s %(levelname)-8s %(message)s')
handler.setFormatter(formatter)
logger.addHandler(handler)
logger.setLevel(logging.DEBUG)


print('\n')
print("---------- DAQ Test - Demonstration script----------------")
print('\n')

Config = configparser.ConfigParser()
parser = argparse.ArgumentParser()
parser.add_argument('-c', action='store', dest='config_file',
                    help='configuration file')
parser.add_argument('-t', action='store', dest='check_incoming_packet',
                    help='on line trigger count check and packet parsing')
parser.add_argument('-p', action='store', dest='ascii_plot_trace',
                    help='plot traces with ascii art ')
parser.add_argument('-s', action='store', dest='plot_selector',
                    help='select decimation factor fot plot')
results = parser.parse_args()

if (results.check_incoming_packet == "False"):
    check_incoming_packet = False
elif (results.check_incoming_packet == "True"):
    check_incoming_packet = True

if (results.ascii_plot_trace == "False"):
    ascii_plot_trace = False
elif (results.ascii_plot_trace == "True"):
    ascii_plot_trace = True
plot_selector = 0
plot_count = 0
plot_selector = int(results.plot_selector)
try:
    Config.read(results.config_file)
except:
    print " Wrong or missing config_file"
    
selected_channel = Config.get('ChannelSelection', 'Channel')
if (selected_channel == "0"):
    print "Channel 0 selected"
    import gcu_adu0_conf as gcu
elif (selected_channel == "1"):
    print "Channel 1 selected"
    import gcu_adu1_conf as gcu
elif (selected_channel == "2"):
    print "Channel 2 selected"
    import gcu_adu2_conf as gcu
else:
    print "channel number must be 0-2"
    sys.exit()
trailer = [0x55aa, 0x0123, 0x4567, 0x89ab, 0xcdef, 0xff00]
data = []
connection_string = 'file://' + \
                    Config.get('IPBusParameters', 'ConnectionFile')
print "conn string:", connection_string

manager = uhal.ConnectionManager(str(connection_string))
device = Config.get('IPBusParameters', 'GCUid')
hw = manager.getDevice(str(device))
my_gcu = gcu.GCU(hw)
my_gcu.try_dispatch()
fifo = []
buf = deque()
# read parameters from configuration file
# Daq Parameters
Threshold = int(Config.get('DaqParameters', 'Threshold'))
PreTrigger = int(Config.get('DaqParameters', 'PreTrigger'))
TriggerWindow = int(Config.get('DaqParameters', 'TriggerWindow'))
# enable the

my_gcu.set_pre_trigger(PreTrigger)
my_gcu.set_trigger_window(TriggerWindow)
my_gcu.set_trigger_threshold(Threshold)
my_gcu.try_dispatch()
print " set threshold to:", Threshold
size = int(Config.get('ReadoutParameters', 'initial_size'))
Fifo_threshold = int(Config.get('ReadoutParameters', 'FifoThreshold'))
delay = float(Config.get('ReadoutParameters', 'delay'))
granularity = int(Config.get('ReadoutParameters', 'granularity'))
occupied_current = Fifo_threshold
dump_file = Config.get('ReadoutParameters', 'DumpFile')
##
with open(dump_file, 'a+') as outfile:
    # dump file header
    outfile.write("* GCU Daq readout: " +
                  strftime("%Y-%m-%d %H:%M:%S", gmtime()) + '\n')
    outfile.write("* Threshold: " + str(Threshold) + '\n')
    outfile.write("* PreTrigger: " + str(PreTrigger) + '\n')
    outfile.write("* TriggerWindow: " + str(TriggerWindow) + '\n')
    outfile.write("* Begin Data * \n")
    trig_num_old = 0
    while True:
        try:
           # print "Dentro While"
            time.sleep(delay)
            data = []
            # gain lock to the second stage fifo
            my_gcu.acquire_fifo_lock()
            # get 2nd stage Fifo occupation
            occupied = my_gcu.get_fifo_occupation()
#            my_gcu.try_dispatch()
#            occupied_current = occupied.value()
           # print "OCCUPATION FIfo", occupied_current
            fifo = my_gcu.read_from_daq_fifo(size)
            count = my_gcu.get_fifo_count()
           # print "Count" , count.value()
            control = my_gcu.get_fifo_control()
            # release lock to the second stage Fifo
            my_gcu.release_fifo_lock()
            my_gcu.try_dispatch()
            data = fifo.value()  # incoming data from ipbus Fifo
            # File dump section
            list_of_lists = []
            if count.value() != 0:
                print "Received Data" , count.value()
                map(list_of_lists.append, map(get_2_words, data[:count.value()]))
                d_buf = [val for sublist in list_of_lists for val in sublist]
                # Log incoming fifo metadata
                # dump to file all the *valid* data read from ipbus Fifo
                map(outfile.write, map(add_newline, map(hex_pretty_print,
                                                        d_buf)))
                if (check_incoming_packet):
                    # # accumulate incoming data in a buffer
                    map(buf.append, d_buf)
                    # extact track/s to plot
                    while(len(buf) > BUFFER_TRESHOLD):
                        trailer_idx_a = seq_in_seq(trailer, list(buf))
                        #print "trailer_idx_a: ", trailer_idx_a
                        if not trailer_idx_a:
                            continue
                        else:
                            trailer_idx_b = seq_in_seq(
                                trailer, (list(buf)[trailer_idx_a + 10:]))
                            if not trailer_idx_b:
                                continue
                            else:
                                trailer_idx_b = trailer_idx_b + trailer_idx_a
                                data_to_plot = list(buf)[
                                    trailer_idx_a + 16: trailer_idx_b - 8]
				data_mean = int(mean(data_to_plot))
				data_std  = int(std(data_to_plot))
                                abs_time = buf[trailer_idx_a + 10]
                                trig_num = buf[trailer_idx_a + 11]
                                channel_num = buf[trailer_idx_a + 9]
                                time_stamp = []
                                time_stamp.append(buf[trailer_idx_a + 12])
                                time_stamp.append(buf[trailer_idx_a + 13])
                                time_stamp.append(buf[trailer_idx_a + 14])
                                time_stamp.append(buf[trailer_idx_a + 15])
                                time_stamp_scalar = time_stamp[0] * (2 ** (16 * 3)) + \
                                    time_stamp[1] * (2 ** (16 * 2)) + \
                                    time_stamp[2] * (2 ** (16)) + time_stamp[3]
                                if (trig_num - trig_num_old) != 1 and trig_num_old != 0:
                                    print ANSI_COLOR_RED + "-ERROR-********************************************\
                                    *******************************************************" + ANSI_COLOR_RESET
                                    # outfile.write("GCU Daq readout END: " +
                                    #              strftime("%Y-%m-%d %H:%M:%S", gmtime()) + '\n')
                                    # outfile.close()
                                    # sys.exit()
                                trig_num_old = trig_num
                        [buf.popleft() for _i in range(trailer_idx_b - 8)]
                        plot_count = plot_count + 1
                        if ((plot_count % plot_selector) == 0):
                        # remanining data into the buffer
                            if(ascii_plot_trace):
                                os.system('clear')
                            print "trailer_idx_a: ", trailer_idx_a
                            print "trailer_idx_b: ", trailer_idx_b
                            print"time_stamp_scalar:", time_stamp_scalar
		            print "Abs Time" , abs_time
                            print "trig_num:", trig_num
                            print "Channel_num:", channel_num 
                            print "BUF LEN:", len(buf)
			    print "Mean" , data_mean
			    print "Sigma", data_std
                        if(ascii_plot_trace):
                            print "Inside ASCII PLOT"
                            cfg = {}
                            cfg['height'] = 40
                            if ((plot_count % plot_selector) == 0):
                                print asciichart.plot(data_to_plot, cfg)
        except Exception as e:
            print e
            print "IPBUS ERR"
