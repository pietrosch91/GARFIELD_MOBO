**Script utili per l' acquisizione (i restanti sono script usati per il debug) :**

* BEC_ttc_eye_scan.py: script per fare l eye scan del canale ttc
* BEC_l1a_eye_scan.py: script per fare l eye scan del canale del trigger
* BEC_ttc_calibrate.py: script per effettuare la calibrazione del canale ttc
* BEC_l1a_calibrate.py: script per effettuare la calibrazione del canale del trigger
* BEC_timing.py: Robe varie, importante per la sincronizzazione

**IMPORTANTE!**

* Prima di utilizzare qualsiasi script (tranne solamente BEC_ttc_eye_scan.py) eseguire "BEC_ttc_calibrate.py".
* Una volta eseguito "BEC_l1a_eye_scan.py" l' invio dei timestamp di trigger da BEC a GCU e' disabilitato. Per abilitarlo eseguire "BEC_l1a_calibrate.py" (E' comunque buona norma, anche per il ttc, dopo aver eseguito l' eye scan, eseguire il calibrate, in quanto l' eye scan discalibra il canale)
* Canale GCU 1 primo in alto a sinistra nella BEC

**COSA FARE PER UN ACQUISIZIONE?**

* (Facoltativo) eseguire "BEC_ttc_eye_scan.py"
* Eseguire "BEC_ttc_calibrate.py"
* (Facoltativo) Eseguire "BEC_l1a_eye_scan.py" 
* Eseguire "BEC_l1a_calibrate.py"
* Eseguire "BEC_timing.py"; Per sincronizzare, premere in ordine "3 (impostare countdown per sincronizzare), 2 (facoltativo, per essere sicuri di iniziare da gcu 1), 1 (abilitare sincronizzazione)**

English version

**Useful scripts for gcu data acquistion (the others are for debugging)**

* BEC_ttc_eye_scan.py: script for TTC eye scan
* BEC_l1a_eye_scan.py: script for L1A trigger eye scan
* BEC_ttc_calibrate.py: script for TTC calibration
* BEC_l1a_calibrate.py: script for L1A trigger calibration
* BEC_timing.py: Lot of different stuff, used for synchronization

**IMPORTANT!**

* Before using any script (besides BEC_ttc_eye_scan.py) run "BEC_ttc_calibrate.py".
* Once "BEC_l1a_eye_scan.py" has run, the sending of the timestamp from BEC to GCU is disabled. To enable run "BEC_l1a_calibrate.py" (One should always run, also for TTC, the calibration script after the eye scan, since the scanning decalibrate the channel)
* GCU channel 1 is on the top left of the BEC

**HOW TO START AN ACQUISTION?**

* (Optional) Run "BEC_ttc_eye_scan.py"
* Run "BEC_ttc_calibrate.py"
* (Optional) Run "BEC_l1a_eye_scan.py" 
* Run "BEC_l1a_calibrate.py"
* Run "BEC_timing.py"; To synchronize, type in order: "3 (set synchronization countdown), 2 (optional, just to make sure to start from gcu 1), 1 (start synchronization process)**

**istructional video**
https://istnazfisnucl-my.sharepoint.com/:v:/g/personal/fmarini_infn_it/EdK7DSscTQZDj8ftVRUxlx8BRP9ebuoYXRDIuX0RChdkNA?e=4jgoqA
