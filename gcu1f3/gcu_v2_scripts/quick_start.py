gcu_num = raw_input("How many GCUs are connected? ")
threshold = raw_input("Insert threshold: ")
pre_trigger = raw_input("Insert pre-trigger: ")
trg_window = raw_input("Insert trigger window: ")
store = raw_input("Do you want to store the acquisition data (y/n)? ")
create_ethers = raw_input("Do you want to create a rarpd ethers file (y/n)? (Remember to place it in /etc folder) ")
set_auto = raw_input("Do you want to enable some triggers (y/n)? ")

if (set_auto == 'y'):
    set_auto_which_string = raw_input("- Write all the GCU numbers that you want to fire to the BEC, separated by a comma (w/o spaces): ")

with open("Makefile", "w+") as m:
    m.write("store = " + store)
    m.write('\n')
    m.write('gcu_num = ' + gcu_num)
    m.write('\n')
    m.write('threshold = ' + threshold)
    m.write('\n')
    m.write('pre_trigger = ' + pre_trigger)
    m.write('\n')
    m.write('trg_window = ' + trg_window)
    m.write('\n')
    m.write('\n')
    if (set_auto == 'y'):
        m.write('master_script.sh: mod_setup_channels.sh xml_files/connections.xml')
    else:
        m.write('master_script.sh: gcu_acq_scripts/setup_channels.sh xml_files/connections.xml')
    m.write('\n')
    m.write('\t$(file > master_script.sh, cd bec_cal_scripts; python setup_bec.py -s $(gcu_num))')
    m.write('\n')
    m.write('\t$(file >> master_script.sh, cd ../gcu_acq_scripts; . setup_channels.sh; cd ..)')
    m.write('\n')
    m.write('\n')
    m.write('gcu_acq_scripts/setup_channels.sh:')
    m.write('\n')
    m.write("ifeq ('$(store)', 'y')\n\t@cd gcu_acq_scripts/ini_files; python ini_file_maker.py -g -s $(gcu_num) -t $(threshold) -p $(pre_trigger) -w $(trg_window);\nelse\n\t@cd gcu_acq_scripts/ini_files; python ini_file_maker.py -g -n -s $(gcu_num) -t $(threshold) -p $(pre_trigger) -w $(trg_window);\nendif")
    m.write('\n')
    m.write('\n')
    if (create_ethers == 'n'):
        m.write('xml_files/connections.xml:\n\t@cd xml_files; python create_connection_file.py -s$(gcu_num)')
    else:
        m.write('xml_files/connections.xml: ethers\n\t@cd xml_files; python create_connection_file.py -s$(gcu_num)')
        m.write('\n')
        m.write('\n')
        m.write('ethers:\n\t@python xml_files/create_ethers_file.py -s$(gcu_num)')
    m.write('\n')
    m.write('\n')
    if (set_auto == 'y'):
        m.write("mod_setup_channels.sh: gcu_acq_scripts/setup_channels.sh\n\t@cd gcu_acq_scripts; python set_trg_conditions.py -a " + set_auto_which_string)
        m.write('\n')
        m.write('\n')
    if (store == 'n'):
        if (create_ethers == 'n'):
            m.write('clean:\n\trm gcu_acq_scripts/setup_channels.sh gcu_acq_scripts/*.pyc gcu_acq_scripts/ini_files/*.ini xml_files/connections.xml master_script.sh')
        else:
            m.write('clean:\n\trm ethers gcu_acq_scripts/setup_channels.sh gcu_acq_scripts/*.pyc gcu_acq_scripts/ini_files/*.ini xml_files/connections.xml master_script.sh')
    else:
        if (create_ethers == 'n'):
            m.write('clean:\n\trm master_readout.sh gcu_acq_scripts/setup_channels.sh gcu_acq_scripts/*.pyc gcu_acq_scripts/ini_files/*.ini xml_files/connections.xml master_script.sh')
        else:
            m.write('clean:\n\trm master_readout.sh ethers gcu_acq_scripts/setup_channels.sh gcu_acq_scripts/*.pyc gcu_acq_scripts/ini_files/*.ini xml_files/connections.xml master_script.sh')


