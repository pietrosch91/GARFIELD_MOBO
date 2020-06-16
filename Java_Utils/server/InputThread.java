// import  java.text.*;   
// import  java.util.*;
import java.io.*;
import java.net.*;

public class InputThread extends Thread {
    CntrlServer_GCU cserv;
    volatile boolean ineedyou = true;
    ServerSocket serverSocket;  

    public  InputThread(CntrlServer_GCU serve, ServerSocket socket) {
        super("InputThread");
        this.cserv = serve;
        this.ineedyou = true;
        this.serverSocket = socket;
    }

  //    public void stop()  {
  //          ineedyou = false;
  //         System.out.println("InputThread: in stop method");
  //  }
    public void run()  {
       int i;
 
        i=0;

        try{
         while(ineedyou)
                  new CntrlServerThread(serverSocket.accept(), "Thread-" + i++, cserv).start();
	} catch(IOException e) {
            e.printStackTrace();
	}
    }
}
