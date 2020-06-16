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

hit_toggle = raw_input("hit toggle: ")

hw.getNode("cs_write.ctrl.hit_toggle").write(int(hit_toggle))
hw.dispatch()

