/*  this is a thread object. Here we deal with connections to CntrlClients
   and serve their requests  */


import java.net.*;
import java.io.*;

public class CntrlServerThread extends Thread {
    public Socket socket = null;
    PrintWriter out;
    BufferedReader in;
    CntrlServer_GCU server;
    public CntrlServerThread(Socket socket, String name, CntrlServer_GCU server) {
        super(name);
        this.socket = socket;
        this.server = server;
    }

    public void run()  {
        String inputLine, outputLine;

        System.out.println("Thread " + Thread.currentThread().getName() + " started!");

        try {
            out = new PrintWriter(socket.getOutputStream(), true);
            in = new BufferedReader(
                                    new InputStreamReader(
                                    socket.getInputStream()));

            while ((inputLine = in.readLine()) != null) {
                System.out.println(Thread.currentThread().getName() + ":"+inputLine);
		 if(inputLine.equals("MCX")) {  // module control quitting, stop thread
                       return;
		   }		
		 if(inputLine.equals("CER"))   // command exec request
		  {
                    System.out.println(Thread.currentThread().getName() + " calling vmeCommand");
                    server.vmeCommand(this);
		  }
            }

        } 
        catch (IOException e) {
            e.printStackTrace();
        } 
        finally {
          try {
	      System.out.println("CntrlServerThread: closing");
               out.close();
               in.close();
               socket.close();
               } catch (IOException e) {
                  e.printStackTrace();
               }
	}
    }
}
