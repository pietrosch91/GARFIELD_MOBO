
//import java.lang.*;
import java.io.*;
//import java.net.*;
import java.util.*;

//import javax.swing.*;
//import javax.swing.undo.*;
//import java.io.*;

//import java.awt.*;
//import java.awt.event.*;
import javax.swing.*;
//import javax.swing.border.*;
//import javax.swing.event.*;
//import javax.swing.text.*;

public class ErrBufferedReader extends BufferedReader {
  public ErrBufferedReader(Reader in){
             super(in);
  }

  public String readLine() throws IOException {
              String inline,token;
             
              inline = super.readLine();

              if(inline.length() > 0){
				  System.out.println(inline);
                 StringTokenizer st = new StringTokenizer(inline);
                 token = st.nextToken();
                 if(token.equals("ERROR:")) {
		/*                      JOptionPane.showMessageDialog(null, inline, "ERROR OCCURED", 0); */
                      System.out.println("SERVER ERROR: "+inline); 
                      return null;
	         }
                 if(token.equals("ERRORDIAL:")) {
                      JOptionPane.showMessageDialog(null, inline, "ERROR OCCURED", 0); 
                      return null;
  	         }
	      }
              return inline;
  }

}
