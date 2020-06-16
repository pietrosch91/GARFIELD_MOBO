README COMPLETO GCU

*COMPILAZIONE E CARICAMENTO DEL FIRMWARE KINTEX 7
    -Aprire la cartella Adapted_for_GARFIELD/Firmware_GCU1F3
    -lanciare il comando make all
    -terminata la compilazione lanciare vivado e selezionare l'opzione "Open Hardware Manager"
    -utilizzare la funzione "Autoconnect" nel pannello "Hardware" sulla sinistra, se il cavo micro-USB è correttamente collegato dovrebbe comparire la lista delle due FPGA, selezionare xc7k325t_1 e nel pannello inferiore cliccare per selezionare il file da caricare
    -il file da caricare è nella sottocartella "results" e si chiama "firmware_01.bit"
    -caricare la FPGA
    
*INIZIALIZZAZIONE della GCU
    -Alimentare la GCU a 24V (entrambi i connettori verdi vanno bene, controllare l'accensione dei led rossi vicino alla Kintex7
    -Collegare la presa ethernet al PC (attualmente chap2) e verificare che si accendano i led accanto al connettore ethernet
    -individuare il nome dell'interfaccia (#iface da qui in poi) cui è collegato il cavo ed eseguire con sudo:
        ifconfig #iface 10.10.10.100 netmask 255.255.255.0 up
        rarpd #iface
    -per controllare che la scheda sia inizializzata correttamente provare a fare ping all'indirizzo ip 10.10.10.16
    -prima di eseguire qualsiasi programma di interfaccia con la GCU ricordarsi di avviare il "controlhub" col comando controlhub_start
    
*AGGIUNTA/MODIFICA REGISTRI INTERFACCIA IPBUS
    -La mappa dei registri accessibili è definita all'interno di un file xml (in Firmware_GCU1F3/uhal_py/gcu1f3.xml) che viene utilizzato sia per generare il VHDL del master dell'ipbus. Difatti questo file genera solo un'interfaccia primaria a cui poi vanno collegati i vari ipbus slave che implementano de-facto la memoria del firmware.
    -Il sorgente VHDL può essere generato utilizzando il comando "gen_ipbus_addr_decode #file" passandogli il file xml con la lista di registri. Per la formattazione del file si fa riferimento alla user-guide di IPBUS reperibile al link https://ipbus.web.cern.ch/ipbus/doc/user/html/ e prende il nome ipbus_decode_#file.vhdl
    -Il file prodotto va messo nella cartella Firmware_GCU1F3/src/user/ipbus_utils al posto del file ipbus_decode_gcu1f3.vhdl
    -Per ogni struttura di memoria definita nell'xml deve essere implementato un ipbus slave. L'implementazione va fatta manualmente (perchè ciascuno slave contiene al suo interno codice dell'utente). Per il momento ogni slave  ha il suo sorgente dedicato nella cartella src/user (in varie sottocartelle)
    -I vari Ipbus slave vanno allocati nel file Firmware_GCU1F3/src/user/ipbus_utils/ipbus_subsys.vhd
    -Ricordarsi sempre di aggiungere eventuali nuovi file *vhd alla lista dei file utilizzati dal compilatore (Firmware_GCU1F3/create_bitstream.tcl)
    
*CREAZIONE DI UN NUOVO IPBUS SLAVE
    -Ogni ipbus slave è un blocco di codice VHDL con l'interfaccia per l'ipbus. A titolo di esempio si può prendere il file Firmware_GCU1F3/src/user/ipbus_Trigger_Manager/ipbus_trigger_manager.vhd
    -A parte l'interfaccia con ipbus, tutto il funzionamento dello slave è a discrezione dell'utente
    
*Script utili
    -In Firmware_GCU1F3 c'è lo script per generare il vhdl del master level. Si lancia con ./Regen_IPBUS_MASTER.sh #file, dove #file rappresenta un file xml che deve stare nella cartella uhal_py. Lo script genera il *vhd e lo sostituisce al sorgente (dopo aver creato un backup locale) in modo da poter compilare direttamente senza altre operazioni dell'utente.
    -Nella stessa cartella lo script InitGCU.sh esegue in sequenza le operazioni iniziali per il setup della GCU. Si lancia con ./InitGCU.sh #iface, passandogli il nome dell'interfaccia cui è collegato il device
