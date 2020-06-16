/*

  $Header: /home/CVS/gab/java_cntrl_vm/CntrlServer.java,v 1.12 2020-01-07 15:57:47 garfield Exp $ 
  $Log: CntrlServer.java,v $
  Revision 1.12  2020-01-07 15:57:47  garfield
  Added code to handle new High Resolution power supply from CAEN. Minor
  changes in PulserControl.java and CntrlServer.java

  Revision 1.11  2019-03-25 14:18:56  bini
  Added options to disable pressure server in CntrlServer

  Revision 1.10  2018-03-14 15:27:02  garfield
  Corrected weblogging

  Revision 1.9  2018-03-02 16:36:53  bini
  Added support for pressure meter server

  Revision 1.8  2018-02-28 10:10:07  bini
  Added a java GUI to remotely control PB5 pulser. In order for the program to play the sounds
  it must be executed locally. Modified CntrServer and Compile to take care of the new program.

  Revision 1.7  2018-01-18 14:11:31  bini
  Added functions to set parameters for whole board /selected channels
  Added Group database save and load
  Corrected some bugs

  Revision 1.6  2018-01-16 10:30:07  garfield
  Re-enabled seaglass LaF, added a sleep in CntrlServer before closing
  the xterms (allows for exit operations to be performed by the servers)

  Revision 1.5  2018-01-12 16:30:26  garfield
  Re-added seaglass LaF to powersupply, changed caenserv_host in
  CntrlServer (to garfctrl).

  Revision 1.4  2018-01-10 21:32:35  garfield
  Changes to CntrlServer and PowerSupplyControl during debug

  Revision 1.3  2018-01-10 11:19:04  bini
  Several changes to CntrlServer and PowerSupplyControl (+ related classes)
  for new HV server (SY4527).

  Revision 1.2  2017-06-15 18:06:28  garfield
  Compile and install script improved.
  No need to be root to run server.

  Revision 1.1.1.1  2017-06-15 16:55:49  garfield
  New module java_cntrl based on Java VM

  Revision 1.30  2012-11-06 19:10:27  garfield
  Updating CVS from garfctrl files before FAZIA 2012 experiment

  Revision 1.29  2009/06/17 17:32:54  bini
  Various bug fixes for threshold and pedestals import.
  Bug fixed when quitting in module unlock.

  Revision 1.28  2009/01/30 15:03:00  bini
  CntrlServer: unlock now accepts commas, semicolons and colons as
  separators.

  Revision 1.27  2009/01/30 14:55:23  bini
  CntrlServer: unlock now accepts multiple indexes on the same line

  Revision 1.26  2009/01/30 14:41:49  bini
  Bug Fixed in CntrlServer: now we send "q" instead of "x" to quit upda_db

  Revision 1.25  2009/01/30 09:34:21  bini
  CntrlServer: "null line from thread" recovered, at least when
   talking to upda_db.

  Revision 1.24  2008/11/06 16:50:31  bini
  Protected CntrlServer when UnknownHostException fires.
  Protected ProgressBar.setValue when getProgress() == null

  Revision 1.23  2008/11/05 13:41:03  bini
  First version with lock files in /var/lock. CntrlServer reads them
  at startup. Handling of edited modules is now done using a
  dedicated class EditedModule instead of a string array.
  Bug fixed in ModuleControl when closing with the X window button
  (the edited modules were not unlocked)

  Revision 1.22  2008/10/30 16:04:51  bini
  Modified ShowInputDialog for changing monitor period: now it shows a
  clickable list of values.
  Removed annoying debug print from Cntrlserver

  Revision 1.21  2008/10/21 16:12:34  bini
  CntrlServer.java and ReadVmeThread.java modified for better
  handling of webLogString (URLEncoder is now called before
  sending the string, unneeded overhead stripped etc.).
  New source added: correct_lecroy.c (standalone program):
  reads the /var/log/CntrlServer.log extracting information
  about Lecroy 8LM in a format useful for sqlite.

  Revision 1.20  2008/10/13 16:01:42  bini
  Removed debug print from CntrlServer weblogstring().
  Added reference to sudo command in PSC_Manual

  Revision 1.19  2008/10/13 15:03:54  bini
  Shorter messages in weblog.
  Manual updated.

  Revision 1.18  2008/10/08 11:03:07  bini
  Modified webLogString to reduce string length (replacing useless
  information with spaces)

  Revision 1.17  2008/10/03 07:35:52  bini
  Bug fixed in CntrlServer.java to avoid memory overflows when
  no weblog server is present.
  PSC manual updated

  Revision 1.16  2008/03/12 08:34:19  bini
  command reset_upda added in controls
  CntrlServer prepared to use reset_upda (for now
  we keep the line commented out)

  Revision 1.15  2008/02/12 09:17:19  bini
  Removed redundant debugging println().
  CntrlServer unlock now more user friendly

  Revision 1.14  2008/02/11 11:27:00  bini
  CntrlServer now has two new commands: startcamac and startcaen
  to restart the servers on vme cpu without restarting CntrlServer

  Revision 1.13  2008/02/11 08:25:54  pasquali
  Configuration files implemented in /etc.
  Logfile in /var.
  N568 modified to speed up operations, check consistency button added.

  Revision 1.12  2008/01/30 14:42:04  bini
  Fixed bugs in Lecroy8LM.
  hexadecimal mode added to GabDocumentFilter and used in cfd modules

  Revision 1.11  2008/01/16 13:16:12  pasquali
  Added graphic interface CAEN N568 Shaper Amp
  Better looking weblog (one entry per access)

  Revision 1.10  2008/01/11 15:02:07  pasquali
  Added remote weblog via http to CntrlServer

  Revision 1.9  2008/01/08 14:33:03  bini
  correzioni per disinhbit crate camac (tolto accelerator da menu)
  in CntrlServer rimesso ppc invece di m68k (ininfluente in realta')

  Revision 1.8  2007/11/06 08:09:35  bini
  Now ReadVMEThread waits for an EOR_VME string from the VME
  server to exit. Removed the interrupt() call in vmeCommand()
  (in CntrlServer) which was causing troubles to ReadVMEThread.

  Revision 1.7  2007/05/28 15:25:39  pasquali
  Prima versione con gruppi CAEN "quasi funzionanti" (ci sono
  problemi con la grafica). Risolte molte situazioni di
  lock nell'accesso ai metodi sincronizzati da dentro
  ActionPerformed().

  Revision 1.6  2007/04/19 16:09:59  pasquali
  Messo Header e Log nei sources.
  Eliminato ogni editing in GroupChannel (JLabel invece
  di JTextField). Modificato get_chanpara(BroupChannel)
  in PowerSupplyControl.java


*/



import  java.net.*;   // networking package (sockets, etc.)
import  java.io.*;   
import  java.text.*;   
import  java.util.*;


class CntrlServer_GCU {
// instance variables
  static CntrlServer_GCU  cserv;     
  static ServerSocket serverSocket;  // why static???
  static int SERVER_PORT = 4444;
  
  static String GCUHOST = "localhost";
  static int GCUPORT = 3512;
  static String GCU_LOGNAME= "gcutest";
  
  
  static String LOGHOST="NONE";
  
  static String logfile_name = "/var/log/CntrlServer_GCU.log";
  static final String newline = "\n";
  static boolean listening = true;
 
  static PrintWriter to_GCU=null;
  
  static Process GCUserver;
  Socket GCUSocket = null;
  BufferedReader from_GCU = null;
  
  static final   String EDITABLE = "editable";
  boolean noconn = true;
//   String[] edit_list = new String[1024];
  
  String webLogString="";
    String tipo;
    Runtime runt;
// constructor
  
  CntrlServer_GCU() {   
    int i;

    // create socket on which to accept connections from Java clients
    try {
            serverSocket = new ServerSocket(SERVER_PORT);
        } catch (IOException e) {
            System.out.println("Could not listen on port: "+SERVER_PORT);
            System.exit(-1);
        }

    startGCU();    
  
  }

   public void catToWebLogString(String chunck){
    if(LOGHOST.equals("none")) return;
	webLogString += chunck;
    }
    
  //-------------------------------------------------------
  public synchronized void vmeCommand(CntrlServerThread thread) {
        String vmeLine;
        String threadLine;
        FileWriter logfile = null;
        ReadVMEThread vmethread = null;
        PrintWriter to_vme = null;
        try{
           logfile = new FileWriter(logfile_name,true);
           logfile.write("\nBEG_COM: "+ DateFormat.getDateTimeInstance().format(new Date())+newline);
           logfile.flush();
//            catToWebLogString("BEG_COM: "+ DateFormat.getDateTimeInstance().format(new Date())+"<br>");
           catToWebLogString("BEG_COM: "+ DateFormat.getDateTimeInstance().format(new Date())+" ");
           System.out.println("In vmeCommand\n");

           threadLine = thread.in.readLine();
           if(threadLine.equals("GCU")){
                vmethread = new ReadVMEThread(GCUSocket, "GCUThread", thread,from_GCU,logfile,this);
                to_vme = to_GCU;
                tipo="GCU";
            }
       

           vmethread.mystart();
           while(true){
	     //                if(thread.socket.getInputStream().available() > 0) {
                  threadLine = thread.in.readLine();
                  if(threadLine == null) {
                         System.out.println("vmeCommand: null line from thread");
                         logfile.write("vmeCommand: null line from thread " + DateFormat.getDateTimeInstance().format(new Date())+newline);
						 logfile.flush();
						 to_vme.println("EOR"); 
						break; 
                  }  // end of stream reached
                  logfile.write("CTRL->VME: "+threadLine+newline);
                  catToWebLogString(" "+threadLine+" ");
                  logfile.flush();
                  System.out.println("vmeCommand: sending line *"+threadLine+"*");
				  to_vme.println(threadLine);     // send command lines to VME
                  System.out.println("vmeCommand: line sent *"+threadLine+"*");
                  if(threadLine.equals("EOR"))  {
                        break;   // EOR=end of request, Module is satisfied
		  }   


		  //                  System.out.println("Sent Line to VME: " +threadLine);
	   }
	        System.out.println("CntrlServer_GCU: joining ReadVMEThread");
            vmethread.join(); // se non aspetto rischio di accettare
            System.out.println("CntrlServer_GCU: after join");
	    } catch(IOException e) {
            e.printStackTrace();
        } catch(InterruptedException ex) {
            ex.printStackTrace();
	}
        
	     System.out.println("Exit from vmeCommand\n");
       
  }
  
  
  //-------------------------------------------------------
// entry point to start the class as a standalone application
  public static void main(String args[]) throws IOException{   
    int i;
    InputThread inthread;
    String inputLine,tok,inpl;
   
	

   System.out.println("USER="+System.getenv("USER"));
   System.out.println("SSH_TTY="+System.getenv("SSH_TTY"));
   try{
       System.out.println("MACHINE="+InetAddress.getLocalHost().getHostName());
   }catch(UnknownHostException ex)
   {  
     ex.printStackTrace();
   }
   System.out.println("TIME="+DateFormat.getDateTimeInstance().format(new Date()));
// //    System.out.println("MACHINE="+java.net.InetAddress.getLocalHost());
// //    System.getProperties().store(System.out, "");

    System.out.printf("Counted %d args\n",args.length);
    for(i=0; i< args.length;i++){
            System.out.println(args[i]);
            if(args[i].equals("-h") || args[i].equals("--help")) {
                  System.out.println("usage: CntrlServer_GCU -server_port num [-gcu host ] [-gcu_port num]\n");
                  Runtime.getRuntime().exit(1);
	    }
            if(args[i].equals("-server_port")) {
                           SERVER_PORT = Integer.valueOf(args[++i]).intValue();
			 continue;
	    }
            if(args[i].equals("-gcu_port")) {
                           GCUPORT = Integer.valueOf(args[++i]).intValue();
			 continue;
	    }
	    if(args[i].equals("-gcu")) {
                           GCUHOST =args[++i];
			 continue;
	    }
        System.out.println("Unrecognized option: "+args[i]);
        System.out.println("usage: CntrlServer_GCU -server_port num [-gcu host ] [-gcu_port num]\n");
        Runtime.getRuntime().exit(1);
	}
	
	cserv  = new CntrlServer_GCU();  // cserv must be static because it must exist

    BufferedReader input = new BufferedReader(new InputStreamReader(System.in));
    // even before the class is instantiated!

      /*  for now we start an infinite loop....here is the basic flow of logic
    for a multiple client server:
      while (true) {
            accept a connection ;
            create a thread to deal with the client ;
        end while
	*/
       i=0;
       inthread = new InputThread(cserv,serverSocket);
       inthread.start();
       System.out.println("BEGIN: "+ DateFormat.getDateTimeInstance().format(new Date()));
       try {
	   while(listening)
    	      {
	          inputLine = input.readLine();
                  if(inputLine.equals("exit") || inputLine.equals("quit")){
                          System.out.println("CntrlServer_GCU received quit request");
                          listening = false;
                          System.out.println("listening set to "+ listening);
                  }
                  if(inputLine.equals("startgcu")) cserv.startGCU();
          }
	     //                 new CntrlServerThread(serverSocket.accept(), "Thread-" + i++, cserv).start();
            } catch (IOException e) {
                 System.out.println("Accept failed: "+ SERVER_PORT);
		 //  System.exit(-1);
            }
            System.out.println("CntrlServer_GCU exiting");
            inthread.ineedyou = false;
            listening = true;
            while(listening){ 
            if(to_GCU != null)
		    {
                    to_GCU.println("q");     
                    to_GCU.close();

		    }
		    listening = false;
	    } 
	    try{
//               wait((long)50);
	         Thread.sleep(2000);
	    } catch(InterruptedException e) {}	    

	   
          System.out.println("CONTROL-C To EXIT: "+ 
                          DateFormat.getDateTimeInstance().format(new Date()));
               BufferedWriter bw= new BufferedWriter(new 
                              OutputStreamWriter(GCUserver.getOutputStream()));
               bw.write("exit\n",0,5);
               bw.close();
               for(int delay=0; delay<1000000;delay++); // se no rsh non torna al prompt
               GCUserver.destroy();      
        
	   
	    try{
                 serverSocket.close();
	    }catch(SocketException e)
		{
		}
            Runtime.getRuntime().exit(1);
  } 

  public void startGCU()
    {
	// check is VME server is already running and ready 
        noconn = true;
        try {
               GCUSocket = new Socket(GCUHOST, GCUPORT);
               to_GCU = new PrintWriter(GCUSocket.getOutputStream(),true);
               from_GCU= new BufferedReader(new InputStreamReader(GCUSocket.getInputStream()));
               noconn = false;
         } catch (UnknownHostException ex) {
               System.err.println("Don't know about host: " + GCUHOST);
               System.exit(1);
         } catch (IOException ex) {
		    //                   System.err.println("Couldn't get I/O for the connection to: g3lxc.");
		   //                   System.exit(1);
                  }

    	// if no success, try to run GCU_server on VME (server for GCU interface )
         if(noconn) {
           System.err.println("I will try to run GCU_server myself...");
           runt = Runtime.getRuntime();
           try {
               GCUserver =runt.exec("xterm -T GCU_test -sb -sl 1000 -bg grey -fg blue -e ssh "+GCUHOST+" -l "+GCU_LOGNAME);
  	   } catch(IOException ex) {
               System.err.println("Couldn't get I/O for running GCU_server");
               System.exit(1);
           }
	    // try to establish connection with said server 
           while(noconn)
               try {
                    GCUSocket = new Socket(GCUHOST, GCUPORT);
                    to_GCU = new PrintWriter(GCUSocket.getOutputStream(),true);
                    from_GCU= new BufferedReader(new InputStreamReader(GCUSocket.getInputStream()));
                    noconn = false;
                  } catch (UnknownHostException ex) {
                   System.err.println("Don't know about host: " + GCUHOST);
		   //                   System.exit(1);
                  } catch (IOException ex) {
		   //	       System.err.println("Couldn't get I/O for the connection to:"+GCUHOST+" on port "+GCUPORT);
		    //                   System.err.println("Couldn't get I/O for the connection to: g3lxc.");
		   //                   System.exit(1);
                  }
	 }
         if(!noconn) System.out.println("Connected to " + GCUHOST + " on port " + GCUPORT);
	
    }
  
  
}
