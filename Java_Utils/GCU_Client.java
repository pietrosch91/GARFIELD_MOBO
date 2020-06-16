
// Main Object for CAMAC controls
// import java.lang.*;
import java.io.*;
import java.net.*;
import java.util.*;
import java.text.*; // nedeed by DateFormat

 import java.awt.*;
 import java.awt.event.*;
 import javax.swing.*;
import javax.swing.tree.*;
 import javax.swing.tree.TreeSelectionModel;
import javax.swing.event.TreeSelectionEvent;
import javax.swing.event.TreeSelectionListener;
import javax.swing.UIManager.*;

import java.io.*;
import java.net.*;
import java.util.*;
import java.text.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.lang.*;
import javax.swing.border.*;

//import com.seaglasslookandfeel.*;
//import swingwt.awt.*;
//import swingwt.awt.event.*;
// import swingwtx.accessibility.*;
//import swingwtx.swing.*;
//import swingwtx.swing.tree.*;
// import swingwtx.swing.tree.TreeSelectionModel;
//import swingwtx.swing.event.TreeSelectionEvent;
//import swingwtx.swing.event.TreeSelectionListener;



public class GCU_Client extends JFrame 
     implements WindowListener  {


    static Runtime runt;
    static Process browser;
    JFrame frame;
    static String CNTRLSERVER = "localhost"; 
    static String WEBLOG_SERVER = "localhost"; 
     static String USER = "bini";
    static String MACHINE = "";
    static String TTY = "";
    static int    CNTRLSERVERPORT = 4444; 
    static int    WEBLOG_PORT = 80; 

    static Socket mySocket = null;
    static PrintWriter out = null;
    static BufferedReader in = null;
    
    Process gcu;
    JTabbedPane splitPane;
    String newline = "\n";
    
    NodeEntry [] nodes=new NodeEntry[1000];
    int nNodes;
    

    public GCU_Client() {

        super();	
	
		try {
             for (LookAndFeelInfo info : UIManager.getInstalledLookAndFeels()) {
       			   System.out.println(info.getName());
                           if ("Nimbus".equals(info.getName())) {
                           UIManager.setLookAndFeel(info.getClassName());
			   System.out.println("Nimbus LaF!");
                          // break;
                   }
        }
        } catch (Exception ex) {
        // If Nimbus is not available, you can set the GUI to another look and feel.
	  try{
	    UIManager.setLookAndFeel("com.seaglasslookandfeel.SeaGlassLookAndFeel");
	   }catch(UnsupportedLookAndFeelException e){
	   }
	   catch(ClassNotFoundException e){
	    System.out.println(e);
	  }
	  catch(InstantiationException e){
   	  }
	  catch(IllegalAccessException e){
	  }
        }



        this.frame = this;

        addWindowListener(this);

        Container contentPane = getContentPane();


        splitPane = new JTabbedPane();
        contentPane.add(splitPane, BorderLayout.CENTER);

       LoadData();


       
    }
/*      *************     */

/** required by windowListener */

public void windowOpened(WindowEvent e){}
public void windowClosing(WindowEvent e){
    System.out.println("GCU_CLIENT: in window closing");
    //                  this.close_menu.doClick(); 
	    }
public void windowClosed(WindowEvent e){
    System.out.println("GCU_CLIENT: in window closed");
   // this.menu_quit.doClick(); 
  System.exit(-1);
}
public void windowIconified(WindowEvent e){}
public void windowDeiconified(WindowEvent e){}
public void windowActivated(WindowEvent e){}
public void windowDeactivated(WindowEvent e){}


/*      *************     */


/*! This is the main entry point of Module Control
 *    We read a configuration file from /etc folder, we parse the command string
 *     and we create the ModuleControl object (there is only one of such
 *    objects 
*/

    public static void main(String[] args) {

        GCU_Client window_qui;
        String tok, inpl;
        boolean debug_main=false;


 

        USER=System.getenv("USER");
        TTY=System.getenv("SSH_TTY");
        try {
            MACHINE=InetAddress.getLocalHost().getHostName();
        }catch(UnknownHostException ex){
               ex.printStackTrace();
        }


        window_qui = new GCU_Client();
        window_qui.ReadAll();

	//            System.out.println("son qui 2");
        window_qui.setTitle("GCU_Client");
        window_qui.setSize(800, 900);
        window_qui.setVisible(true);
        
    }


/*         *******************         */



public void ReadAll(){
    for(int i=0;i<nNodes;i++) nodes[i].Read();
}

public void LoadData(){

    //Get number of nodes
        commandExecutionRequest();
        out.println("GCU");
        out.println("NC");
        String readline;
        try{
            readline= in.readLine();
            nNodes=Integer.valueOf(readline);
            endOfRequest();
            System.out.printf("Found %d nodes\n",nNodes);
        
            for(int i=0;i<nNodes;i++){
                commandExecutionRequest();
                out.println("GCU");
                out.printf("NI %d\n",i);
                readline = in.readLine();
                System.out.printf("Received Line %s\n",readline);
                StringTokenizer tok=new StringTokenizer(readline);
                //  sprintf(res,"%s %d %d %d %d %d %d %u\n",NodeID.c_str(),intID,parent,size,layer,RW,MODE,MASK);
                String IDs=tok.nextToken();
                int iID=Integer.valueOf(tok.nextToken());
                int parID=Integer.valueOf(tok.nextToken());
                int sz=Integer.valueOf(tok.nextToken());
                int lr=Integer.valueOf(tok.nextToken());
                int ns=Integer.valueOf(tok.nextToken());
                int rw=Integer.valueOf(tok.nextToken());
                int md=Integer.valueOf(tok.nextToken());
                long msk=Long.valueOf(tok.nextToken());
                int bsiz=Integer.valueOf(tok.nextToken());
                nodes[i]=new NodeEntry(IDs,iID,sz,lr,ns,rw,md,msk,bsiz);
                nodes[i].setGCU(this);
               
                if(lr==0) splitPane.addTab(IDs,nodes[i]);
                else{
                    GridBagConstraints c=new GridBagConstraints();
                    c.gridx=0;
                    c.gridy= nodes[parID].currentGP;
                    c.gridheight=sz;
                    nodes[parID].add(nodes[i],c);
                    nodes[parID].currentGP+=sz;
                }
                endOfRequest();
            }
        }catch(IOException e){}
    }


static public boolean commandExecutionRequest()
{
    boolean no_socket;
    no_socket = true;

    while(no_socket){
      try {
	    //            if(isDebug())System.out.println("son qui 30");
              mySocket = new Socket(CNTRLSERVER, CNTRLSERVERPORT);
              out = new PrintWriter(mySocket.getOutputStream(),true);
              in = new BufferedReader(new InputStreamReader(mySocket.getInputStream()));
               no_socket = false;
       } catch (UnknownHostException ex) {
              System.err.println("Don't know about host: " + CNTRLSERVER);
              Object[] options = {"Retry",
                    "Quit program"};
              int n = JOptionPane.showOptionDialog(null,
                   "Can't access the server "+CNTRLSERVER+" on port "+CNTRLSERVERPORT,
                         "Unknown Host",
                         JOptionPane.YES_NO_OPTION,
                         JOptionPane.QUESTION_MESSAGE,
                         null,
                         options,
                         options[0]);
                     if(n==1) System.exit(1);

//               JOptionPane.showMessageDialog(null, "Don't know about host: " + CNTRLSERVER, "Error connecting to server",0); 
//               System.exit(1);
       } catch (IOException ex) {

                  System.err.println("Couldn't get I/O for the connection to: " + CNTRLSERVER + " on port " + CNTRLSERVERPORT);
              Object[] options = {"Retry",
                    "Quit program"};
              int n = JOptionPane.showOptionDialog(null,
                   "Can't access the server "+CNTRLSERVER+" on port "+CNTRLSERVERPORT,
                         "IO Exception",
                         JOptionPane.YES_NO_OPTION,
                         JOptionPane.QUESTION_MESSAGE,
                         null,
                         options,
                         options[0]);              
                     if(n==1) System.exit(1);
//                   JOptionPane.showMessageDialog(null, "Can't access the server "+CNTRLSERVER+" on port "+CNTRLSERVERPORT,"Error connecting to server",0); 
//                    System.exit(1);
       }
     }
     out.println("CER"); 
     return true;
}

static public boolean endOfRequest()
{
     String readline;
     out.println("EOR"); // unlock module
     try {
        while(!(readline=in.readLine()).equals("EOR_SERVER")); 
        mySocket.close();
    } catch (IOException ex) {
    }
     return true;
}


}

