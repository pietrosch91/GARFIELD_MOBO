

import java.awt.*;
import java.util.*;
import java.awt.event.*;
import javax.swing.*;
import javax.swing.event.*;
import javax.swing.text.*;
import javax.swing.undo.*;
import java.io.*;


import java.io.*;
import java.net.*;
import java.util.*;
import java.text.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.lang.*;
import javax.swing.border.*;



public class NodeEntry extends JPanel implements ActionListener {
    static final int bw=800;
    static final int rw=20;
    static final int bh=30;
    GCU_Client gcu=null;
    int Target_ID;
    int BLSIZE;
    int currentGP;
    int sz;
    int md;
    int rwp;
    
    JLabel IDField;
    JSpinner ValField;
    JButton ReadBt,WriteBt,TestBt,ResetBt;
    static final String nl="\n";
    
    static final String EOR = "EOR";
//     static final String CER = "CER\nUPDA";
    static final String GCU = "GCU";
    
     public void ApplySize(JComponent target,int dimx,int dimy){
		Dimension d=new Dimension(dimx,dimy);
		target.setMinimumSize(d);
		target.setMaximumSize(d);
		target.setPreferredSize(d);
		target.setSize(d);
		target.setFocusable(false);
	}
	
	public long getMax(long mask){
        while((mask & 1)==0) mask=mask >>1;
        return mask & 0x7FFFFFFF;
    }
 
    public NodeEntry(String ID,int iID,int Size,int Layer,int nsons,int RW, int MODE,long MASK,int BlkSize){
        super();
        BLSIZE=BlkSize;
        rwp=RW;
        md=MODE;
        sz=Size;
        Target_ID=iID;
        if(nsons!=0){
             //Simple case This is parent of something
             setLayout(new GridBagLayout());
             GridBagConstraints c=new GridBagConstraints();
             c.gridx=0;
             c.gridy=0;
             c.gridheight=1;
             currentGP=1;
             if(Layer>0) add( new JLabel(ID,SwingConstants.LEFT),c);
             ApplySize(this,bw-Layer*rw,Size*bh);
             setBorder(new LineBorder(Color.BLACK));
        }
        else{
            if(MODE==0){
                //allocate
                setLayout(new GridLayout(1,4,5,5));
                setBorder(new LineBorder(Color.BLACK));
                IDField=new JLabel(ID,SwingConstants.CENTER);
                add(IDField);
            
                ValField=new JSpinner();
                ValField.setModel(new SpinnerNumberModel(0,0,(int)getMax(MASK),1));
                add(ValField);
            
                ReadBt=new JButton("Read");
                ReadBt.setActionCommand("Read");
                ReadBt.addActionListener(this);
                add(ReadBt);
            
                WriteBt=new JButton("Write");
                WriteBt.setActionCommand("Write");
                WriteBt.addActionListener(this);
                add(WriteBt);
                if(RW==2) ReadBt.setEnabled(false);
                else if(RW==1)  WriteBt.setEnabled(false);
            }
            else if(MODE==1){//MEM_BLOCK
                //allocate
                setLayout(new GridLayout(1,4,5,5));
                setBorder(new LineBorder(Color.BLACK));
                IDField=new JLabel(ID,SwingConstants.CENTER);
                add(IDField);
            
                /*ValField=new JSpinner();
                ValField.setModel(new SpinnerNumberModel(0,0,(int)getMax(MASK),1));
                add(ValField);*/
            
                TestBt=new JButton("Test");
                TestBt.setActionCommand("Test");
                TestBt.addActionListener(this);
                add(TestBt);
            
                ResetBt=new JButton("Reset");
                ResetBt.setActionCommand("Reset");
                ResetBt.addActionListener(this);
                add(ResetBt);
                //if(RW==2) TestBt.setEnabled(false);
                
                ReadBt=new JButton("Read");
                ReadBt.setActionCommand("Readblk");
                ReadBt.addActionListener(this);
                add(ReadBt);
                if(RW==2){
                    ReadBt.setEnabled(false);
                }
                if(RW==1){
                    ResetBt.setEnabled(false);
                    TestBt.setEnabled(false);
                }
            }
            else{
                setLayout(new GridLayout(1,2,5,5));
                setBorder(new LineBorder(Color.BLACK));
                IDField=new JLabel(ID,SwingConstants.CENTER);
                add(IDField);
                add(new JLabel("Not Managed",SwingConstants.CENTER));
            }            
            ApplySize(this,bw-Layer*rw,bh-2);		
        }
    }


    public synchronized void actionPerformed(ActionEvent evt) {
        System.out.printf("Inside action command\n");
        gcu.commandExecutionRequest();
        
        if(evt.getActionCommand().equals("Write")){
            gcu.out.println(GCU);
            gcu.out.println(String.format("WRITE %d %d",Target_ID,((int)ValField.getValue()) & 0xFFFFFFFF));
        }
        else if(evt.getActionCommand().equals("Read")){
            gcu.out.println(GCU);
            gcu.out.println(String.format("READ %d",Target_ID));
            try{
                String resp=gcu.in.readLine();
                 long num = Long.valueOf(resp) & 0xffffffff;
                ValField.setValue((int)num);
            }catch(IOException e){}
           
        }
        else if(evt.getActionCommand().equals("Reset")){
             gcu.out.println(GCU);
             String cmd=String.format("WRITEBLK %d %d",Target_ID,BLSIZE);
             for(int i=0;i<BLSIZE;i++) cmd+=" 0";
             gcu.out.println(cmd);
             if(rwp!=2){//not writeonly
                cmd=String.format("READBLK %d %d",Target_ID,BLSIZE);
                gcu.out.println(cmd);
                try{
                    String resp=gcu.in.readLine();
                    StringTokenizer tok=new StringTokenizer(resp);
                    int ok=0;
                    for(int i=0;i<BLSIZE;i++){
                        if(Integer.valueOf(tok.nextToken())==0) continue;
                        else{
                            ok=1;
                            break;
                        }
                    }       
                    if(ok==0) JOptionPane.showMessageDialog(this,"Reset OK");
                    else JOptionPane.showMessageDialog(this,"Reset FAILED");
                }catch(IOException e){}
                
            }
            else{
                JOptionPane.showMessageDialog(this,"Write only, cannot check");
            }
        }
        else if(evt.getActionCommand().equals("Test")){
             gcu.out.println(GCU);
             String cmd=String.format("WRITEBLK %d %d",Target_ID,BLSIZE);
             for(int i=0;i<BLSIZE;i++) cmd+=String.format(" %d",i+1);
             gcu.out.println(cmd);
             if(rwp!=2){//not writeonly
                cmd=String.format("READBLK %d %d",Target_ID,BLSIZE);
                gcu.out.println(cmd);
                try{
                    String resp=gcu.in.readLine();
                    StringTokenizer tok=new StringTokenizer(resp);
                    int ok=0;
                    for(int i=0;i<BLSIZE;i++){
                        if(Integer.valueOf(tok.nextToken())==i+1) continue;
                        else{
                            ok=1;
                            break;
                        }
                    }       
                    if(ok==0) JOptionPane.showMessageDialog(this,"Test OK");
                    else JOptionPane.showMessageDialog(this,"Test FAILED");
                }catch(IOException e){}
                
            }
            else{
                JOptionPane.showMessageDialog(this,"Write only, cannot check");
            }
        }
        else if(evt.getActionCommand().equals("Readblk")){
             gcu.out.println(GCU);
             String cmd=String.format("READBLK %d %d",Target_ID,BLSIZE);
             gcu.out.println(cmd);
             try{
                String resp=gcu.in.readLine();
                JOptionPane.showMessageDialog(this,resp);
            }catch(IOException e){}
                
        }
        
        gcu.endOfRequest();
     }
    

//   public int mvvalue(String decval){
//            int decimal,i_nsval;
// 
//            decimal = Integer.valueOf(decval).intValue();
//            i_nsval = -(decimal+1);
//            return i_nsval;
//   } 


    public void Read(){
        if(md>2) return;
        if(BLSIZE>32) return;
        if(ReadBt==null) return;
        if(ReadBt.isEnabled()) ReadBt.doClick();
    }

    public void setGCU(GCU_Client mod) {
        gcu = mod;
        
    }

}


