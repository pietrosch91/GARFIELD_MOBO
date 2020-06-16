#!/usr/bin/env python
import configparser
import signal
import sys
import logging
import argparse
import matplotlib.pyplot as plt
import mmap
from os import stat as file_stat
import time
import asciichart
import cPickle as pickle
__author__ = "Antonio Bergnoli"
__copyright__ = "Copyright 2017, INFN, LNL"
__credits__ = []
__license__ = "GPL"
__version__ = "0.0.1"
__maintainer__ = "Antonio Bergnoli"
__email__ = "antonio.bergnoli@dwave.it"
__status__ = "Developement"

def seq_in_seq(subseq, seq):
    while subseq[0] in seq:
        index = seq.index(subseq[0])
        if subseq == seq[index:index + len(subseq)]:
            return index
        else:
            seq = seq[index + 1:]
    else:
        return None
trailer = [0x55aa, 0x0123, 0x4567, 0x89ab, 0xcdef, 0xff00]
Config = configparser.ConfigParser()
parser = argparse.ArgumentParser()
parser.add_argument('-f', action='store', dest='datafile',
                    help='dump data file ')
results = parser.parse_args()
# obtaining data file size in pages 
st = file_stat(results.datafile)
file_size = st.st_size
n_pages = file_size / mmap.PAGESIZE
remind  = file_size % mmap.PAGESIZE

n_pages_per_chunk = 0
vector_data = []
traces = {}
with open(results.datafile, 'r') as data_file_descriptor: 
    print " opening file" , results.datafile
    mm =  mmap.mmap(data_file_descriptor.fileno(), length=mmap.PAGESIZE * n_pages_per_chunk ,
                    access=mmap.ACCESS_COPY,offset=(mmap.PAGESIZE * n_pages_per_chunk))
    while True:
        line = mm.readline()
        if not line:
            break
        elif line[0] != '*':
           vector_data.append(int(line, 16))
    index = 0
    new_index = 0
    while vector_data:
        new_index = seq_in_seq(trailer, vector_data)
        if not new_index:
            break
        time_stamp = []
        time_stamp.append(vector_data[new_index+ 12])
        time_stamp.append(vector_data[new_index + 13])
        time_stamp.append(vector_data[new_index + 14])
        time_stamp.append(vector_data[new_index + 15])
        time_stamp_scalar = time_stamp[0] * (2 ** (16 * 3)) + \
        	time_stamp[1] * (2 ** (16 * 2)) + \
                time_stamp[2] * (2 ** (16)) + time_stamp[3]
        traces[time_stamp_scalar] = (vector_data[10:new_index])
        print len(vector_data),index, new_index, vector_data[new_index +11], time_stamp_scalar
        del vector_data[:(new_index + len(trailer))]
        index = new_index

pickle.dump( traces, open( results.datafile + ".pickle", "wb" ) )

