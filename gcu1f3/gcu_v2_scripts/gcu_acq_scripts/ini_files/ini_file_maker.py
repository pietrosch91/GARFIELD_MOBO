import argparse

parser = argparse.ArgumentParser()

parser.add_argument('-n', action='store_true', dest='not_store',
                    help='do not store files')
parser.add_argument('-g', action='store_true', dest='gen_setup_file',
                    help='generate setup file')
parser.add_argument('-s', action='store', dest='gcu_num',
                    help='number of gcus connected')
parser.add_argument('-t', action='store', dest='threshold',
                    help='threshold')
parser.add_argument('-p', action='store', dest='pre_trigger',
                    help='pre-trigger')
parser.add_argument('-w', action='store', dest='trig_window',
                    help='trigger window')
results = parser.parse_args()

gcu_num = results.gcu_num
threshold = results.threshold
pre_trigger = results.pre_trigger
trig_window = results.trig_window

file_names = []
for i in range(1,int(gcu_num)+1):
  for j in range(3):
    file_name= "gcu_"+str(i)+"_ch"+str(j)+".ini"
    #print file_name
    #file_names.append(file_name)
    with open(file_name, "w+") as f:
        f.write("[IPBusParameters]")
        f.write("\n")
        f.write("ConnectionFile=../xml_files/connections.xml")
        f.write("\n")
        f.write("GCUid=GCU1F3_" + str(i))
        f.write("\n")
        f.write("[ChannelSelection]")
        f.write("\n")
        f.write("Channel=" + str(j))
        f.write("\n")
        f.write("[DaqParameters]")
        f.write("\n")
        f.write("Threshold="+threshold)
        f.write("\n")
        f.write("PreTrigger="+pre_trigger)
        f.write("\n")
        f.write("TriggerWindow="+trig_window)
        f.write("\n")
        f.write("[ReadoutParameters]")
        f.write("\n")
        f.write("delay=0.0")
        f.write("\n")
        f.write("initial_size=2048")
        f.write("\n")
        f.write("granularity=10")
        f.write("\n")
        f.write("FifoThreshold=1000")
        f.write("\n")
        if results.not_store:
          f.write("DumpFile=/dev/null")
        else:
          f.write("DumpFile=gcu_"+str(i)+"_ch"+str(j)+"_data.txt")

with open("../setup_channels.sh", "w+") as s:
  for i in range(1,int(gcu_num)+1):
    for j in range(3):
      s.write("python setup_channel.py -c ini_files/gcu_"+str(i)+"_ch"+str(j)+".ini")
      s.write("\n")

  for i in range(1,int(gcu_num)+1):
    s.write("python setup_trg.py -b -e -s "+str(i))
    s.write("\n")

if (not results.not_store):
  with open("../../master_readout.sh", "w+") as r:
    r.write("cd gcu_acq_scripts")
    r.write("\n")
    for i in range(1,int(gcu_num)+1):
      for j in range(3):
        r.write("python gcu_readout.py -c ini_files/gcu_" + str(i) + "_ch" + str(j) + ".ini -t False -p False -s 1 &")
        r.write("\n")
    r.write("cd ..")
