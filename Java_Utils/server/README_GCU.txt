Dove trovare i pacchetti

	Il firmware della GCU si trova in /home/bini/gcu4garfield/Firmware_GCU1F3/
	per compilarlo va eseguito il comando "make all"

Per utilizzare l'acquisizione
	->Collegare l'ethernet ad una delle porte del PC
	->Attivare l'interfaccia con IP sulla rete 10.10.10.0/24
	->Come SU utilizzare il comando "rarpd #iface" col nome dell'interfaccia ethernet. Se si vogliono cambiare gli IP va editato il file /etc/ethers (non fare)
	->Controllare che tutto funzioni pingando l'ip 10.10.10.16
	->Avviare il ControlHub con il comando controlhub-start
	->A questo punto si può partire con gli script di acq situati in gcu4garfield/gcu1f3/gcu_v1_scripts
	->Si può lanciare alternativamente gcu_readout.py col comando:
		python gcu_readout.py -c gcu1_ch0.ini -t True -p True
	oppure
		python gui_control_1.py
	Il primo programma è totalmente passivo, il secondo invece permette di forzare il trigger e acquisire linee di base (visualizzate in ASCII in modo fighissimo).

	->Finito tutto si può fermare il controlhub con controlhub-stop
