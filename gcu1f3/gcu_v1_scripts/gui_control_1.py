from Tkinter import  Tk, Label, Entry, Button, StringVar, IntVar, Checkbutton
import ttk
import uhal

def write_on_ipbus_reg( ipbus_node, entry_obj):
	hw.getNode(ipbus_node).write(int(entry_obj.get()))
	hw.dispatch()

def read_from_ipbus_reg(ipbus_node, var_obj):
	data = hw.getNode(ipbus_node).read()
	hw.dispatch()
	var_obj.set(str(data.value()))	




def cb1():
    hw.getNode("trigger_manager.auto_trigger_mode.trigger_source_selection").write(
        var1.get())
    hw.dispatch()

def cb2():
    hw.getNode("trigger_manager.auto_trigger_mode.trigger_path_selection").write(
        var2.get())
    hw.dispatch()


def write_one(ipbus_node):
    hw.getNode(ipbus_node).write(1)
    hw.dispatch()


manager = uhal.ConnectionManager("file://connections.xml")
hw = manager.getDevice("GCU1F3_1")
master = Tk()
N_CHANNELS = 3
Label(master, text="CH0 Threshold").grid(row=0)
Label(master, text="CH0 Pre Trigger").grid(row=1)
Label(master, text="CH0 Trigger Window").grid(row=2)
Label(master, text="TestReg").grid(row=3)

Label(master, text="CH1 Threshold").grid(row=5)
Label(master, text="CH1 Pre Trigger").grid(row=6)
Label(master, text="CH1 Trigger Window").grid(row=7)
Label(master, text="TestReg").grid(row=8)

Label(master, text="CH2 Threshold").grid(row=10)
Label(master, text="CH2 Pre Trigger").grid(row=11)
Label(master, text="CH2 Trigger Window").grid(row=12)
Label(master, text="TestReg").grid(row=13)

varList = []
entryList = []
for i in range(4 * N_CHANNELS):
	varList.append( StringVar())
	entryList.append( Entry(master, textvariable=varList[i]))
	entryList[i].grid(row=i + (i / 4) , column=1)
#Channel 0
Button(master, text='Read', command=lambda: read_from_ipbus_reg("l1_cache_0.trigger_threshold",varList[0])).grid(
    row=0, column=3,  pady=4)
Button(master, text='Send', command=lambda: write_on_ipbus_reg("l1_cache_0.trigger_threshold", entryList[0])).grid(
    row=0, column=2,  pady=4)

Button(master, text='Read', command=lambda: read_from_ipbus_reg("l1_cache_0.pre_trigger",varList[1])).grid(
    row=1, column=3,  pady=4)
Button(master, text='Send', command=lambda: write_on_ipbus_reg("l1_cache_0.pre_trigger", entryList[1])).grid(
    row=1, column=2,  pady=4)

Button(master, text='Read', command=lambda: read_from_ipbus_reg("l1_cache_0.trigger_window",varList[2])).grid(
    row=2, column=3,  pady=4)
Button(master, text='Send', command=lambda: write_on_ipbus_reg("l1_cache_0.trigger_window", entryList[2])).grid(
    row=2, column=2,  pady=4)

Button(master, text='Read', command=lambda: read_from_ipbus_reg("test_reg",varList[3])).grid(
    row=3, column=3,  pady=4)
Button(master, text='Send', command=lambda: write_on_ipbus_reg("test_reg", entryList[3])).grid(
    row=3, column=2,  pady=4)

Button(master, text='Force Trigger', command=lambda: write_one("trigger_manager.auto_trigger_mode.force_trigger_ch0")).grid(
    row=4, column=2, pady=4)
Button(master, text='Soft Reset', command=lambda: write_one("l1_cache_0.control_register.soft_reset")).grid(
    row=4, column=3, pady=4)

#Channel 1
Button(master, text='Read', command=lambda: read_from_ipbus_reg("l1_cache_1.trigger_threshold",varList[4])).grid(
    row=5, column=3,  pady=4)
Button(master, text='Send', command=lambda: write_on_ipbus_reg("l1_cache_1.trigger_threshold", entryList[4])).grid(
    row=5, column=2,  pady=4)

Button(master, text='Read', command=lambda: read_from_ipbus_reg("l1_cache_1.pre_trigger",varList[5])).grid(
    row=6, column=3,  pady=4)
Button(master, text='Send', command=lambda: write_on_ipbus_reg("l1_cache_1.pre_trigger", entryList[5])).grid(
    row=6, column=2,  pady=4)

Button(master, text='Read', command=lambda: read_from_ipbus_reg("l1_cache_1.trigger_window",varList[6])).grid(
    row=7, column=3,  pady=4)
Button(master, text='Send', command=lambda: write_on_ipbus_reg("l1_cache_1.trigger_window", entryList[6])).grid(
    row=7, column=2,  pady=4)

Button(master, text='Read', command=lambda: read_from_ipbus_reg("test_reg",varList[7])).grid(
    row=8, column=3,  pady=4)
Button(master, text='Send', command=lambda: write_on_ipbus_reg("test_reg", entryList[7])).grid(
    row=8, column=2,  pady=4)

Button(master, text='Force Trigger', command=lambda: write_one("trigger_manager.auto_trigger_mode.force_trigger_ch1")).grid(
    row=9, column=2, pady=4)
Button(master, text='Soft Reset', command=lambda: write_one("l1_cache_1.control_register.soft_reset")).grid(
    row=9, column=3, pady=4)

#Channel 2
Button(master, text='Read', command=lambda: read_from_ipbus_reg("l1_cache_2.trigger_threshold",varList[8])).grid(
    row=10, column=3,  pady=4)
Button(master, text='Send', command=lambda: write_on_ipbus_reg("l1_cache_2.trigger_threshold", entryList[8])).grid(
    row=10, column=2,  pady=4)

Button(master, text='Read', command=lambda: read_from_ipbus_reg("l1_cache_2.pre_trigger",varList[9])).grid(
    row=11, column=3,  pady=4)
Button(master, text='Send', command=lambda: write_on_ipbus_reg("l1_cache_2.pre_trigger", entryList[9])).grid(
    row=11, column=2,  pady=4)

Button(master, text='Read', command=lambda: read_from_ipbus_reg("l1_cache_2.trigger_window",varList[10])).grid(
    row=12, column=3,  pady=4)
Button(master, text='Send', command=lambda: write_on_ipbus_reg("l1_cache_2.trigger_window", entryList[10])).grid(
    row=12, column=2,  pady=4)

Button(master, text='Read', command=lambda: read_from_ipbus_reg("test_reg",varList[11])).grid(
    row=13, column=3,  pady=4)
Button(master, text='Send', command=lambda: write_on_ipbus_reg("test_reg", entryList[11])).grid(
    row=13, column=2,  pady=4)

Button(master, text='Force Trigger', command=lambda: write_one("trigger_manager.auto_trigger_mode.force_trigger_ch2")).grid(
    row=14, column=2, pady=4)
Button(master, text='Soft Reset', command=lambda: write_one("l1_cache_2.control_register.soft_reset")).grid(
    row=14, column=3, pady=4)

#initialization
hw.getNode('adu_manager.control_reg.enable_adu_0').write(1)
hw.getNode('adu_manager.control_reg.enable_clock_adu_0').write(1)
hw.dispatch()
hw.getNode('adu_manager.control_reg.enable_adu_1').write(1)
hw.getNode('adu_manager.control_reg.enable_clock_adu_1').write(1)
hw.dispatch()

hw.getNode('adu_manager.control_reg.enable_adu_2').write(1)
hw.getNode('adu_manager.control_reg.enable_clock_adu_2').write(1)
hw.dispatch()
var1 = IntVar()
d = hw.getNode(
    "trigger_manager.auto_trigger_mode.trigger_source_selection").read()
hw.dispatch()
var1.set(d.value())

c1 = Checkbutton(master, text="trigger mode selection", command=cb1, variable=var1).grid(
    row=16, column=0, pady=4)
var2 = IntVar()
d = hw.getNode(
    "trigger_manager.auto_trigger_mode.trigger_path_selection").read()
hw.dispatch()
var2.set(d.value())
c2 = Checkbutton(master, text="trigger path selection", command=cb2, variable=var2).grid(row=16 ,column=1, pady=4)
l1 = Label(master, text="GCU 1").grid(row=16,column=2)

Button(master, text='Quit', command=master.quit).grid(row=18, column=0, pady=4)
master.mainloop()
