import java.io.*;
import java.net.*;
import  java.util.*;
import  java.text.*;   

public class ReadVMEThread extends Thread {
    public Socket socket = null;
    PrintWriter out;
    BufferedReader in;
    CntrlServerThread modthread;
    CntrlServer_GCU ctrlserv;
    BufferedReader from_upda = null;
    private volatile boolean ineedyou;
    FileWriter logfile;
    PrintWriter to_log;
    static final String newline = "\n";

    public  ReadVMEThread(Socket socket, String name, CntrlServerThread thread, BufferedReader vmeread,FileWriter logfile,CntrlServer_GCU ctrl) {
        super(name);
        this.socket = socket;
        this.modthread = thread;
        this.from_upda = vmeread;
        this.logfile = logfile;
        this.ctrlserv = ctrl;
	ineedyou = false;
    }

    public void mystart()  {
        ineedyou=true;
        start();
        
    }

    public void mystop()  {
           ineedyou = false;
//            System.out.println("ReadVMEThread: in stop method");
    }

    public void run()  {
        String vmeLine;

        try{
         while(ineedyou)
	  {
// 	    System.out.println("ReadVmeThread: 1");
            vmeLine = from_upda.readLine();  // problema! se arriva qui mentre il thread sta morendo, il thread non muore!
// 	    System.out.println("ReadVmeThread: 2");
            logfile.write("VME->CTRL: "+vmeLine+newline);
//             ctrlserv.catToWebLogString("CntrlServer: VME_to_CTRL: "+vmeLine+"<br>");
            ctrlserv.catToWebLogString(" "+vmeLine+" ");
            logfile.flush();
// 	    System.out.println("ReadVmeThread: 3");
            if(vmeLine == null) {
                  System.out.println("vmeCommand: null line from VME");
                  break; 
            }    // end of stream reached
            System.out.println("ReadVMEThread received: "+vmeLine);
            if(vmeLine.equals("EOR_VME")){
 	        System.out.println("ReadVmeThread: exiting");
                logfile.write("END_COM: "+ DateFormat.getDateTimeInstance().format(new Date())+newline);
//                 ctrlserv.catToWebLogString("END_COM: "+ DateFormat.getDateTimeInstance().format(new Date())+"<br>");
                ctrlserv.catToWebLogString("END_COM: "+ DateFormat.getDateTimeInstance().format(new Date()));
                //ctrlserv.writeWebLog();
                logfile.flush();
                logfile.close();
                ineedyou = false;
                modthread.out.println("EOR_SERVER");
		return;
	    }
            if(!vmeLine.equals("EOC")){
// 	          System.out.println("Line from VME: " +vmeLine+" modthread="+modthread);
                  modthread.out.println(vmeLine);   // send the line to the module connected
		                                 // to thread
// 	          System.out.println("ReadVmeThread: dopo modthread");
 	    }
	  }
          logfile.write("END_COM: "+ DateFormat.getDateTimeInstance().format(new Date())+newline);
          logfile.flush();
          logfile.close();
	} catch(InterruptedIOException e) {
// 	    System.out.println("Ricevuto interrupt durante lettura");
	    try{
                logfile.write("END_COM: "+ DateFormat.getDateTimeInstance().format(new Date())+newline);
                logfile.flush();
	        }
               catch(IOException ex) {
                      ex.printStackTrace();
                }

	}
         catch(IOException e) {
                  e.printStackTrace();
	}


    }


    public void setModThread(CntrlServerThread newth)
    {
        this.modthread = newth;
    }
}

