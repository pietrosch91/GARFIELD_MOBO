**Scripts needed for acquistion**

*gcu_readout.py: this is the main acquisition script. To start the script you need to set its options: 
-c path_to_ini_file: inside the ini file (all located in the ini_files folder) there is the channel number (or PMT number, 0,1 or 2), the threshold, the trigger window, the pre-trigger etc. Once the script start, the acquisiton is set to work on these parameters (Some parameters can be dynamicallly changed during acquisiton, read on on the istructions to know how). 
-t True/False print some packet informations on screen. 
-p True/False plot the waveform on screen (no gui, it plots on the terminal, you'll probably need to de-zoom in order to see the entire waveform). 
-s x (x equals a number) when plotting on screen, only plot one waveform out of x
So an example is "python gcu_readout.py -c ini_files/gcu_1_ch0.ini -t True -p True -s 1"

*gui_control_x.py (x corresponds to the gcu_id (it actually correspond to the ip of the gcu. You can check the ip on the connections.xml file)) This is the dynamic control for the acquisiton. if you run a script a GUI pops up. One GUI corresponds to one GCU. Here you can change the threshold, the trigger window, the pre-trigger number, the trigger source (trigger mode. not selected means threshold trigger, selected means external trigger, which is disabled at the moment), the trigger system (trigger path. selected means BEC global trigger validation, not selected means auto-trigger). You can also force the trigger (send trigger pulses via ipbus, to check the baseline for example) and reset the ADU. All of this can be done dynamically, even during an acquisition.

*auto_trigger.py: This scripts force a trigger to the gcu with a user defined frequency. Used for debugging to make sure the trigger works, the ADU are calibrated, etc. to select the channel number to send the trigger, go inside the code and it very trivial to change and send trigger to the channel you want.

**istructional video**
https://istnazfisnucl-my.sharepoint.com/:v:/g/personal/fmarini_infn_it/EW29Php7UmROoId4ov6alOgBz_J9ldHQLDadzXfO9C_LKg?e=EcJ1wd
