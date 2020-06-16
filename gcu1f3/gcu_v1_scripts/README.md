* setup_channel.py\
	Takes the configuration file for the channel and configure Threshold, Pre-trigger and Trigger window.\
    *-c config_file.ini* : config_file.ini in order to retrieve GCU and channel to configure\
	*-a* : Also enable ADUs

* setup_trg.py\
	*-e* : enables external trigger over threshold trigger for gcu #x\
	*-b* : enable bec_validation over autotrigger for gcu #x\
    *-s x* : x is the gcu number 

* setup_channels.sh\
	The script runs setup_trg for every gcu with flag -e -b as set in the file. It also runs setup_channel with -a true for every channel

* bec_setup.py\
    script to run when bec is reprogrammed in order to calibrate the synchronous link of the three GCUs and perform the synchronization

* Scripts are located into jdaq@192.168.55.94:~/uhal_scripts/scripts (Computer accessible from gate.lnl.infn.it)

* To perform the eye scan of the synch links use the script "BEC_eye_scan_sel.py" accessible on jdaq@192.168.55.94:~/uhal_scripts \
    The script will ask for the gcu_number (1 for gcu connected on first channel)

