

#ifndef ROOT_DSP_ASM 
#  warning "ROOT_DSP_ASM not defined: using /lavoro/bini/dsp_asm/ ..."
#  define ROOT_DSP_ASM "/lavoro/bini/dsp_asm/"
#endif

#ifndef __CINT__
#include <sys/ioctl.h>
#endif



// 
//=======================
//////////////////////////////////////////////////////////////////////////
//                                                                     
//                                                                     
//////////////////////////////////////////////////////////////////////////
#include "FGCUDsp.h"

#define FL0   ((1 << dspchan) << 8)
#define FL1    (1 << dspchan)





//#define DEBUG
ClassImp(FGCUDsp);

void delay(int tempo)
{
  int j,s;
  s = 0;
  for (j = 0 ; j < tempo*100 ; j++)
    s += j;
  return;
}

/***************************************************************************/
//#define DEBUG 1

//definition of internal mapped registers
#define DSP_INT_OPCODE	"opcode"
#define DSP_INT_DATA	"data"
#define DSP_INT_START   "cmd_start"
#define DSP_INT_BUSY	"dsp_busy"
#define DSP_IDMA_DATA	"idma_data"

//opcode definitions
#define OP_SPE 0x1
#define OP_BOOT	0x2
#define OP_IAL 0x3
#define OP_IDMA_WR 0x5
#define OP_IDMA_RD 0x6
#define OP_CLR	0x4
#define OP_END	0x0

//operations (mutuated from FVmeDsp
#define dsp_IORD()          IssueDspCommand(OP_IDMA_RD)
#define dsp_IOWR(val)       IssueDspCommand(OP_IDMA_WR,(int) val)		

#define dsp_BOOT()          IssueDspCommand(OP_BOOT)
#define dsp_IAL(val)        IssueDspCommand(OP_IAL,(int)val)
#define dsp_SPE()           IssueDspCommand(OP_SPE)
#define dsp_CLR()           IssueDspCommand(OP_CLR)
#define dsp_END()           IssueDspCommand(OP_END)


void FGCUDsp::IssueDspCommand(int CMD, int DATA){
	mH->getNode(dsp_hw).getNode(DSP_INT_OPCODE).write(CMD);
	mH->getNode(dsp_hw).getNode(DSP_INT_DATA).write(DATA);
	mH->getNode(dsp_hw).getNode(DSP_INT_START).write(1);
	//maybe useless...
	ValWord< uint32_t > mem;
	while(1){
		 mem=mH->getNode(dsp_hw).getNode (DSP_INT_BUSY).read();
		 if(mem.value()==0) break;
	}
}

int FGCUDsp::idma_read(){
    IssueDspCommand(OP_IDMA_RD);
	ValWord<uint32_t> mem=mH->getNode(dsp_hw).getNode (DSP_IDMA_DATA).read();    
	return (int)mem.value();
}
    
void FGCUDsp::idma_write(int dato){
    IssueDspCommand(OP_IDMA_WR,dato);    
}

void FGCUDsp::idma_write(unsigned int dato){
    IssueDspCommand(OP_IDMA_WR,(int)dato);    
}

void FGCUDsp::address_latch(unsigned short address){
    IssueDspCommand(OP_IAL,(int)address);
}

void FGCUDsp::mem_address_latch(unsigned short address){
    IssueDspCommand(OP_IAL,(int)address | 0x4000);
}
  
void FGCUDsp::Reset(){
  IssueDspCommand(OP_BOOT);
  delay(100);
  IssueDspCommand(OP_BOOT);
  return;

}

int FGCUDsp::GetDspAddr(TString *Variable)
{
  FILE *fp;
  TString symFile;
  char nome_entry[100],svalue[8];
  /* if data memory 0x4000 will be added */
  int memory_add=0;
  if (ProgNamePath->IsNull())
    return -1;
  else
    //   symFile=ProgNamePath->Replace(ProgNamePath->Sizeof()-4,3,"sym");
    symFile=*ProgNamePath+".sym";
  if ((fp = fopen(symFile.Data(),"r")) == NULL)
    {
     printf("can't open file %s\n",symFile.Data());
     return -1;
    }
  while(fscanf(fp,"%s%s",nome_entry,svalue) != EOF)
    if(!Variable->CompareTo(nome_entry,Variable->kExact))
      { int value;
	if(svalue[strlen(svalue)-1]=='d')
            	   memory_add=0x4000;
        svalue[strlen(svalue)-1]=' ';
        sscanf(svalue,"%x",&value);
        if(value < 0x8000)    /* this takes into account dsp2191 data */
          value+=memory_add;
        else
          value-=0x8000;
        fclose(fp);
        return value; 
      }   
  fclose(fp);
  return -2;
}

void FGCUDsp::colore(int A)
{
   
     /*-- questi codici li ho presi da /etc/init.d/functions: */
     /*sono quelli che appaiono allo startup.                 */
     if(A>0)
         printf("\033[1;3%dm",(int)A);
     else
         printf("\033[0;39m");
     fflush(0);
   
}


int FGCUDsp::LoadExe_Dsp_Prog(TString ProgName,int print)
{
    //int j;
    //    int init_addr = 0;
    FILE *fp;
  //  char linea[100];
  //  for (j = 0 ; j < 100 ; linea[j++] = 0);
    this->CompileDSPCode(ProgName);
    TString FileName = ROOT_DSP_ASM;
    *ProgNamePath = (ROOT_DSP_ASM + ProgName + "/" + ProgName + ".asm");
    FileName += (ProgName + "/" + ProgName + ".asm.exe");
#ifdef DEBUG
    printf("Loading %s\n",FileName.Data());
#endif
    if ((fp = fopen(FileName.Data(),"r")) == NULL)
     {
      printf("can't open file %s\n",FileName.Data());
      return -1;
     }
    fclose(fp);
    LoadDsp(FileName.Data(),print);

     return 0;
}




int FGCUDsp::Write_Data_Mem(unsigned short *data, int start_addr, int how_many_words)
{
  mem_address_latch(start_addr);
  for (int j = 0 ; j < how_many_words ; j++)  idma_write(data[j]);
  return 0;
}

int FGCUDsp::Write_Prog_Mem(unsigned int *data, int start_addr, int how_many_words)
{
  address_latch(start_addr);
  for (int j = 0 ; j < how_many_words ; j++){
      unsigned int dato_short;
      dato_short = data[j] >> 8;  
      idma_write(dato_short);
      dato_short = data[j] & 0xff;  
      idma_write(dato_short);
    }
  return 0;
}


TArrayI* FGCUDsp::Read_Prog_Mem(unsigned short start_addr, int n_word)
{
  //  unsigned short dummy;
   TArrayI* b = new TArrayI(n_word);
   address_latch(start_addr);
   //  idma_read(&dummy);
   for (int n_d = 0; n_d < n_word ; n_d++){
       unsigned short buf[2];
       unsigned int word=0;
       buf[0]=(unsigned short)(idma_read() &0xff);
	   buf[1]=(unsigned short)(idma_read() &0xff);
       word=(buf[0] << 8);
       word|=buf[1];
       // printf("%4.4x  %4.4x  %8.8x\n",(unsigned int)buf[0],(unsigned int)buf[1],word);
       b->AddAt(word,n_d);
     }
   return b;
}

TArrayI* FGCUDsp::Read_UData_Mem(unsigned short start_addr, Int_t n_word,  TArrayI*b)
{
   if(b==NULL)
     b= new TArrayI(n_word);
   else
     b->Set(n_word);
   mem_address_latch(start_addr);
   for (int n_d = 0; n_d < n_word ; n_d++)
     {
       unsigned short buf;
       buf=(unsigned short)(idma_read() &0xff);
       b->AddAt(buf,n_d);
     }
   return b;
}

TArrayI* FGCUDsp::Read_Data_Mem(unsigned short start_addr, Int_t n_word, TArrayI *b)
{
   if(b==NULL)
     b = new TArrayI(n_word);
   else
     b->Set(n_word);
   mem_address_latch(start_addr);
   int *data=b->GetArray();
  for (int n_d = 0; n_d < n_word ; n_d++)
     {
       short buf;
       buf=(short)(idma_read() & 0xff);
        //       b->AddAt(buf,n_d);
      data[n_d]=buf;
     }
   return b;
}



TArrayI* FGCUDsp::UnZip_Signal(unsigned short *buffer,TArrayI *b)
{/* reads zipped data CPU  memory  */
  /* will do the inverse of comp1 routine in DSP program */
   unsigned short *lbuf=buffer;
   if (b==NULL)
     b = new TArrayI();
   int k=0;
   short chan_p=0;
   int n_el_tot=0;
   while(1)
     { 
       unsigned short buf;
       buf=*lbuf; lbuf++;
       if(!buf) break;
       int n_elem=(buf&0x1FFF);
       n_el_tot+=n_elem;
       //       printf("n_elem=%d\n",n_elem);
       b->Set(n_el_tot);
       if(buf &(1<<15))  /* one nibble one sample */
	{ int i=0;
          while(1)
	   {
	     buf=*lbuf; lbuf++;
             short chan_n=buf;
	     // printf("1.. chan_n=%x chan_p=%x\n",chan_n,chan_p);
             chan_n=chan_p-(chan_n>>12);
             b->AddAt(chan_n,k++);
             i++;
             chan_p=chan_n;
             if (i>=n_elem) break;
             chan_n=(buf<<4);
             //printf("2.. chan_n=%x chan_p=%x\n",chan_n,chan_p);
             chan_n=chan_p-(chan_n>>12);
             b->AddAt(chan_n,k++);
             i++;
             chan_p=chan_n;
             if (i>=n_elem) break;
             chan_n=(buf<<8);
             //printf("3.. chan_n=%x chan_p=%x\n",chan_n,chan_p);
             chan_n=chan_p-(chan_n>>12);
             b->AddAt(chan_n,k++);
             i++;
             chan_p=chan_n;
             if (i>=n_elem) break;
             chan_n=(buf<<12);
             //printf("4.. chan_n=%x chan_p=%x\n",chan_n,chan_p);
             chan_n=chan_p-(chan_n>>12);
             b->AddAt(chan_n,k++);
             i++;
             chan_p=chan_n;
             if (i>=n_elem) break;
	   }
        }
       else if (buf &(1<<14))  /* one byte one sample */
	{ int i=0;
          while(1)
	   {
	     buf=*lbuf; lbuf++;
             short chan_n=buf;
             //printf("5.. chan_n=%x chan_p=%x\n",chan_n,chan_p);
             chan_n=chan_p-(chan_n>>8);
             b->AddAt(chan_n,k++);
             i++;
             chan_p=chan_n;
             if (i>=n_elem) break;
             chan_n=(buf<<8);
             //printf("6.. chan_n=%x chan_p=%x\n",chan_n,chan_p);
             chan_n=chan_p-(chan_n>>8);
             b->AddAt(chan_n,k++);
             i++;
             chan_p=chan_n;
             if (i>=n_elem) break;
	   }

        }
       else if (buf &(1<<13)) /* two byte one sample */
	{ int i=0;
          while(1)
	   {
	     buf=*lbuf; lbuf++;
             short chan_n=buf;
             //printf("7.. chan_n=%x chan_p=%x\n",chan_n,chan_p);
             chan_n=chan_p-chan_n;
             b->AddAt(chan_n,k++);
             i++;
             chan_p=chan_n;
             if (i>=n_elem) break;
           }
        }
     }
   // *n_samp=k;
   return b;
}

/*
TArrayI* FGCUDsp::Read_Signal_Mem(unsigned short start_addr, Int_t n_word)
{
  //
  // this method will include FL1 test, to be sure the signal is there
  //
#define TIME_OUT 100000
  while(1)
    {
      if (!poll_FL1(TIME_OUT))
         break;
      else
	printf("time_out expired\n");
    }
   TArrayI* b = new TArrayI(n_word);
   mem_address_latch(start_addr);
   for (int n_d = 0; n_d < n_word ; n_d++)
     {
       unsigned short buf;
       idma_read(&buf);
       b->AddAt(buf,n_d);
     }
#ifdef DEBUG
   for (int nx = 0 ; nx < 24 ; nx++)
       printf("%08x%c",b->At(nx),(nx%8 == 7) ? '\n' : ' ');
       printf("\n");
#endif

   // now we send a command code 0x80 (that means the signal is read)
#define READ_DONE_CODE 0x80
#define DSP_CMD_ADDRESS 0x3000
   unsigned short cmd_code = READ_DONE_CODE;
   this->Write_Data_Mem(&cmd_code,DSP_CMD_ADDRESS,1);
   this->Send_DSP_IrqE();
   return b;
}*/

/*
TArrayI* FGCUDsp::Read_CompSigns_Mem(unsigned short start_addr, Int_t *n_samp)
{
   //reads zipped data directly from DSP 2181 memory  
   TArrayI* b = new TArrayI();
   mem_address_latch(start_addr);
   int k=0;
   short chan_p=0;
   int n_el_tot=0;
   while(1)
     { 
       short buf;
       idma_read(&buf);
       if(!buf) break;
       int n_elem=(buf&0x1FFF);
       n_el_tot+=n_elem;
       //       printf("n_elem=%d\n",n_elem);
       b->Set(n_el_tot);
       if(buf &(1<<15))
	{ int i=0;
          while(1)
	   {
	     idma_read(&buf);
             short chan_n=buf;
	     // printf("1.. chan_n=%x chan_p=%x\n",chan_n,chan_p);
             chan_n=chan_p-(chan_n>>12);
             b->AddAt(chan_n,k++);
             i++;
             chan_p=chan_n;
             if (i>=n_elem) break;
             chan_n=(buf<<4);
             //printf("2.. chan_n=%x chan_p=%x\n",chan_n,chan_p);
             chan_n=chan_p-(chan_n>>12);
             b->AddAt(chan_n,k++);
             i++;
             chan_p=chan_n;
             if (i>=n_elem) break;
             chan_n=(buf<<8);
             //printf("3.. chan_n=%x chan_p=%x\n",chan_n,chan_p);
             chan_n=chan_p-(chan_n>>12);
             b->AddAt(chan_n,k++);
             i++;
             chan_p=chan_n;
             if (i>=n_elem) break;
             chan_n=(buf<<12);
             //printf("4.. chan_n=%x chan_p=%x\n",chan_n,chan_p);
             chan_n=chan_p-(chan_n>>12);
             b->AddAt(chan_n,k++);
             i++;
             chan_p=chan_n;
             if (i>=n_elem) break;
	   }
        }
       else if (buf &(1<<14))
	{ int i=0;
          while(1)
	   {
	     idma_read(&buf);
             short chan_n=buf;
             //printf("5.. chan_n=%x chan_p=%x\n",chan_n,chan_p);
             chan_n=chan_p-(chan_n>>8);
             b->AddAt(chan_n,k++);
             i++;
             chan_p=chan_n;
             if (i>=n_elem) break;
             chan_n=(buf<<8);
             //printf("6.. chan_n=%x chan_p=%x\n",chan_n,chan_p);
             chan_n=chan_p-(chan_n>>8);
             b->AddAt(chan_n,k++);
             i++;
             chan_p=chan_n;
             if (i>=n_elem) break;
	   }

        }
       else if (buf &(1<<13))
	{ int i=0;
          while(1)
	   {
	     idma_read(&buf);
             short chan_n=buf;
             //printf("7.. chan_n=%x chan_p=%x\n",chan_n,chan_p);
             chan_n=chan_p-chan_n;
             b->AddAt(chan_n,k++);
             i++;
             chan_p=chan_n;
             if (i>=n_elem) break;
           }
        }
     }
   *n_samp=k;
   return b;
}*/

/*
TArrayI* FGCUDsp::Read_Comp1_Mem(unsigned short start_addr, Int_t *n_samp)
{
// reads data directly from DSP 2181 memory         
#define N_A 100
   TArrayI* b = new TArrayI(N_A);
   mem_address_latch(start_addr);
   int k=0;
   short chan_p=0;
   int n_el_tot=N_A;
   while(1)
     { 
       short buf;
       idma_read(&buf);
       if(!buf) break;       
       if (buf&(1<<15))
	 {
	   short chan_n=(buf<<1);
           chan_n=chan_p-(chan_n>>9);
           b->AddAt(chan_n,k++);
           chan_p=chan_n;
           if (buf&(1<<7))
	     {
              short chan_n=(buf<<9);
              chan_n=chan_p-(chan_n>>9);
              b->AddAt(chan_n,k++);              
              chan_p=chan_n;
	     }
	 }
       else
	 {
       	   short chan_n=(buf<<1);
           chan_n=chan_p-(chan_n>>1);
           b->AddAt(chan_n,k++);
           chan_p=chan_n;
         }
       if(k >= (n_el_tot-1))
        {
	  n_el_tot+=N_A;
          b->Set(n_el_tot);
         }
     }
   *n_samp=k;
   return b;
}*/




int  FGCUDsp::Read_noDma_Data_Mem(unsigned short start_addr,unsigned short *buffer, Int_t n_word )
{  
  mem_address_latch(start_addr);
    
  for (int n_d = 0; n_d < n_word ; n_d++)
     {
       short dato;
	   dato=(short)(idma_read() & 0xff);
       //       b->AddAt(buf,n_d);
      buffer[n_d]=dato;
     }
   return n_word*2;
}



void FGCUDsp::Dump_Data_Mem(unsigned short first, Int_t nwords)
{
  int last_line;
  TArrayI *dm;
  if (nwords%16!=0) nwords=((nwords+16)/16)*16;
  last_line = (nwords/16);
  printf("first=%x nwords=%x last_line=%x\n",first,nwords,last_line);
  dm = this->Read_UData_Mem(first,nwords);
  printf("\n--DM DM DM DM DM DM DM------\n");

  for(int i=0; i< last_line;i++) {
      printf("DM%4.4x: ", i*16+first);
      for(int j=0; j< 16;j++){ 
          printf("%4.4x ", dm->At(i*16+j));
      }
        printf("\n");
      }
  delete dm;
}


void FGCUDsp::Dump_Prog_Mem(unsigned short first, Int_t nwords)
{
  int last_line;
  TArrayI *pm;
if (nwords%16!=0) nwords=((nwords+16)/16)*16;
  last_line = (nwords/16);
  printf("first=%x nwords=%x last_line=%x\n",first,nwords,last_line);
   pm = this->Read_Prog_Mem(first,nwords);
  printf("\n---PM PM PM PM PM PM PM ----\n");
  for(int i=0; i< last_line;i++) {
      printf("PM%6.6x: ", first+i*16);
      for(int j=0; j< 16;j++){ 
          printf("%6.6x ", pm->At(i*16+j));
      }
        printf("\n");
      }
  delete pm;
}

void FGCUDsp::Send_DSP_IrqE()
{
  dsp_SPE();
}

void FGCUDsp::Send_IRQ1()
{
  dsp_END();
}




#define ASM_EXE ".asm.exe:"
#define ASM ".asm"
#define EOT \004 
#define MAKE "; make"

int FGCUDsp::CompileDSPCode(TString ProgName)
{
  TString s = "cd ";
  s += ( ROOT_DSP_ASM + ProgName + MAKE ) ;
  TString s1 = ("echo \"" + s +"\"");
#ifdef DEBUG
  printf("...\n%s....\n",s1.Data());  
#endif
  system(s1.Data());
  /*  s = "#!/bin/tcsh;"; */
  int ret = system(s.Data());
#ifdef DEBUG
  printf("%d %s\n",ret,s.Data());
#endif
  return ret;
} 

#define ASS2181 "/usr/bin/ass21 "
#define ASS2191 "/usr/bin/ass2191 "

int FGCUDsp::AssembleDSPCode(TString ProgName,Int_t f2181_2191)
{ 
  TString s;
  if (f2181_2191)
    s = ASS2181 + ProgName;
  else
    s = ASS2191 + ProgName;
  TString s1 = ("echo \"" + s +"\"");
  system(s1.Data());
  int ret = system(s.Data());
  printf("%d %s\n",ret,s.Data());
  return ret;  
}


/*
int FGCUDsp::CreateGUIforDSP(TString ProgName)
{
  FILE *f;
  char stringa[256];
  char dummy[4],param[32],name[32],unit[16],label[32],interrupt[16];
  float calmin=0.,calmax=0.,def=0.;
  int addr=0,nmin=0,nmax=0,nstep=0;

  TString s = "";
  s += ( ROOT_DSP_ASM + ProgName + "/"+ProgName+".def" ) ;
  TString s1 = ("echo \"" + s +"\"");
  printf("...\n%s....\n",s1.Data());  
  system(s1.Data());
  //  s = "#!/bin/tcsh;"; 
  f = fopen(s.Data(),"ro");
  fscanf(f,"%[^\n]s",stringa);
  sscanf(stringa ,"%s %s %s %d %d %d %d %f %f %f %s %s %s",dummy,param,name,&addr,&nmin,&nmax,&nstep,&calmin,&calmax,&def,unit,interrupt,label);
  printf("param=%s name=%s\n",param,name);
  printf("addr=%d nmin=%d nmax=%d nstep=%d\n",addr, nmin,nmax,nstep);
  printf("calmin=%f calmax=%f def=%f\n",calmin,calmax,def);
  printf("unit=%s inter=%s label=%s\n",unit,interrupt,label);

  //  this->AddParam(name,addr,nmin,nmax,nstep,calmin,calmax,def,unit,interrupt,label);

  return 0;

} */


/***************************************************************************/

int FGCUDsp::poll_FL1(int time_out)
{
  volatile unsigned short status;
  status= myboard->ReadStatus();

  //  printf("status %4.4x\n",status);
  while((!(status & FL1)) && time_out--) {
          status= myboard->ReadStatus();
	  //	  printf("status=%4.4x  FL1=%x\n",status,FL1);
  }
  if (!(time_out+1))
    return -1;
  else
    {
      //    printf("poll_FL1: status=%4.4x\n",status);
    return 0;
    }
}

int FGCUDsp::poll_FL0(int time_out)
{
  unsigned short status;
  status = myboard->ReadStatus();

  //  printf("status %4.4x\n",status);
  while((!(status & FL0)) && time_out--) {
        status= myboard->ReadStatus();
	//        printf("status %4.4x\n",status);
  }
  if (!(time_out+1))
    return -1;
  else
    {
      //    printf("poll_FL0: status=%4.4x\n",status);
    return 0;
    }
}


void FGCUDsp::ClearStatus()
{
  dsp_CLR();

}



/************************************************************/
/*******************************************************************/
#define CMD_AMPLI_GAIN   0x0001
#define CMD_DISC1_THRS   0x0002
#define CMD_DISC2_THRS   0x0003
#define CMD_WRITE_DM     0x0020
#define CMD_WRITE_PM     0x0021



// =======
#define CMD_SET_TIMER    0x0004

#define CMD_OFFSET_BO   0x0005
#define CMD_GAIN_BO     0x0006
#define CMD_RANGE_BO    0x0007
//#define PRINT

void FGCUDsp::SetGain(int value)
{
  unsigned short command[10];
  
  command[0]=CMD_AMPLI_GAIN;
  command[1]=(value & 0xFF);
#ifdef PRINT  
  printf("Setting Gain to %d\n",value & 0xFF);
#endif  
  Write_Data_Mem(command, 0x3E00,2);
  Send_DSP_IrqE();  
}


void FGCUDsp::SetOffsetBo(int value)
{
  unsigned short command[10];
  
  command[0]=CMD_OFFSET_BO;
  command[1]=(value & 0xFFF);
#ifdef PRINT  
  printf("Setting OFFSET(Bo) to %x\n",value & 0xFFF);
#endif  
  Write_Data_Mem(command, 0x3E00,2);
  Send_DSP_IrqE();  
}

void FGCUDsp::SetGainBo(int ndac)
{
  unsigned short command[10];
  command[0]=CMD_GAIN_BO;
  command[1]=(ndac );
#ifdef PRINT  
  printf("Setting GAIN(Bo) to %x\n",ndac);
#endif  
  Write_Data_Mem(command, 0x3E00,2);
  Send_DSP_IrqE();  
}

void FGCUDsp::SetGainBo(float value)
{
  unsigned short command[10];
  /*   l'ampli (sono due ma solo uno viene usato a seconda
       del range) va da -600mV a +600mV lineare da 0 a 24dB
       se il range e' 0 va da 1 a 16 
                      1 va da 0.2x1 a 0.2x16
  */
  int ndac;
  if(value > .2 && value < 3.)
    {
      SetRangeBo(1);
      //      ndac=log10(value/.2)*20./24.*4096.;
      ndac=log10(value/.2)*20./24.*1972.+1062.;
    }
  else if (value < 16.)
    {
      SetRangeBo(0);
      //      ndac=log10(value)*20./24.*4096.;
      ndac=log10(value)*20./24.*1972.+1062.;
    }
  else
    {
      printf("gain out of range (.2 - 16.) %f\n",value);
      return;
    }
  if(ndac < 0 || ndac > 0xFFF)
    {
      printf("ndac value=%d out of range\n",ndac);
      return;
    }
  command[0]=CMD_GAIN_BO;
  command[1]=(ndac );
#ifdef PRINT  
  printf("Setting GAIN(Bo) to %x\n",ndac);
#endif  
  Write_Data_Mem(command, 0x3E00,2);
  Send_DSP_IrqE();  
}

void FGCUDsp::SetRangeBo(int value)
{
  unsigned short command[10];
  /* if 0 High Gain  if 1 Low Gain */
  //   if(value != 0 && value != 1)
  if((value < 0) || (value > 2))
     {
      printf("%d  -- Only 0 (High gain), 1 (low gain) or 2 (RF) accepted\n",value);
      printf("no action taken\n");
      return;
     }
  if(value == 2)
    printf("RF selected-------------------------------\n");
  command[0]=CMD_RANGE_BO;
  command[1]=(value & 0xFFF);
#ifdef PRINT  
  printf("Setting RANGE(Bo) to %d\n",value & 0xFFF);
#endif  
  Write_Data_Mem(command, 0x3E00,2);
  Send_DSP_IrqE();  
}

void FGCUDsp::SetRFBo()
{
  unsigned short command[10];
  /* if 0 High Gain  if 1 Low Gain */
  int value = 2;
  command[0]=CMD_RANGE_BO;
  command[1]=(value & 0xFFF);
#ifdef PRINT  
  printf("Setting RANGE(Bo) to %d\n",value & 0xFFF);
#endif  
  Write_Data_Mem(command, 0x3E00,2);
  Send_DSP_IrqE();  
}

void FGCUDsp::SetThreshold(int nthres, int value)
{
  // 1=low
  //2=high

  unsigned short command[10];

  command[0]=CMD_DISC1_THRS+(nthres-1);
  command[1]=(value & 0xFF);
#ifdef PRINT
  printf("Setting Threshold %d to %d\n",nthres,value & 0xFF);
#endif
  Write_Data_Mem(command, 0x3E00,2);
  Send_DSP_IrqE();  
}
// =======
/*======== routines for Bologna schedina ================== */
#define CMD_READ_SECT_FAST 0x0009
#define CMD_ENABLE_FLASH 0x000A
#define CMD_DISABLE_FLASH 0x000B
#define CMD_WRITE_SECTOR 0x000C
#define CMD_READ_SECTOR  0x000D
#define CMD_ERASE_SECTOR 0x000E
#define CMD_ERASE_FLASH  0x000F
#define CMD_RELOAD_FPGA 0x0010
#define CMD_READ_REGISTER 0xFFFF
#define CMD_WRITE_REGISTER 0x0008
void FGCUDsp::FPGAEnableFlash()
{
  unsigned short command[10];
     command[0]=CMD_ENABLE_FLASH;
#ifdef PRINT  
  printf("Enable Flash\n");
#endif  
  Write_Data_Mem(command, 0x3E00,1);
  Send_DSP_IrqE();  
  usleep(500);
}
void FGCUDsp::FPGADisableFlash()
{
  unsigned short command[10];
  command[0]=CMD_DISABLE_FLASH;
#ifdef PRINT  
  printf("Disable Flash\n");
#endif  
  Write_Data_Mem(command, 0x3E00,1);
  Send_DSP_IrqE();  
  usleep(500);
}
void FGCUDsp::FPGAEraseFlash()
{
  unsigned short command[10];
  command[0]=CMD_ERASE_FLASH;
#ifdef PRINT  
  printf("Erasing Flash\n");
#endif  
  Write_Data_Mem(command, 0x3E00,1);
  Send_DSP_IrqE(); 
  usleep(50000000);
#ifdef PRINT  
  printf("Flash Erased\n");
#endif  
}

void FGCUDsp::FPGAEraseSector(unsigned char *byte)
{
  unsigned short command[10];
  command[0]=CMD_ERASE_SECTOR;
#ifdef PRINT  
  printf("Erase Sector %2.2x%2.2x%2.2x\n",byte[0],byte[1],byte[2]);
#endif  
  command[1]=byte[0];
  command[2]=byte[1];
  command[3]=byte[2];
  Write_Data_Mem(command, 0x3E00,4);
  Send_DSP_IrqE();
  usleep(4000);
}


#define PAGE_LENGTH 256

int FGCUDsp::FPGAWriteRBF(char *file_rbf, unsigned int address)
{
  //TArrayI* read_buf=new TArrayI(PAGE_LENGTH/2);
  unsigned short buf[PAGE_LENGTH/2];
  FILE * frbf = fopen(file_rbf, "r");
  int count=0;
  unsigned char epcs_addr[3];
  int addr_qui = address;
  //unsigned short readWord;
  int check_result=0;
  int serror=0;
  //int i;
  printf("Erasing Flash\n");
  FPGAEnableFlash();
  FPGAEraseFlash();
  epcs_addr[2]= (addr_qui & 0xFF);
  epcs_addr[1]= (addr_qui >>8) & 0XFF;
  epcs_addr[0]= (addr_qui >> 16) & 0xFF;
  printf("Flash Erased\nStart writing program\n");
  do{
    printf("\rSector 0x%4.4x of 0x15ed, Completed %lf%%",addr_qui,100.*(double)addr_qui/(double)0x15ed00);
    FPGAEnableFlash();
    count = FPGAReadRBFPage(frbf, buf);
    FPGAWriteSector(epcs_addr, buf);
    serror=FPGAReadSectorFast(epcs_addr);
    if(serror!=0) printf("\rERROR!! Found %d errors in sector %2.2x%2.2x%2.2x\n",serror,epcs_addr[0],epcs_addr[1],epcs_addr[2]);
    check_result+=serror;
#ifdef PRINT
    printf("Error count=%d\n",check_result);
#endif
    //  Read_UData_Mem(0,PAGE_LENGTH/2,read_buf);
    //  for(i=0;i<PAGE_LENGTH/2;i++){
    //    readWord=(unsigned short)(read_buf->At(i) & 0xFFFF);
    //  if(buf[i]!=readWord){
    //#ifdef PRINT
    //	printf("%4.4x\t%4.4x\n",readWord,buf[i]);
    //#endif
    //	check_result++; 
    //#ifdef PRINT
	//	printf("%d\n",check_result);
    //#endif
      //   }
    //}
    //Dump_Data_Mem(0x3ea0,16,0);
    /*Read_UData_Mem(0x3E95,1,read_buf);
    check_result+=read_buf->At(0);
#ifdef PRINT
    printf("Sector Errors=%d\t Total=%d\n",read_buf->At(0),check_result);
#endif
    */
    addr_qui += PAGE_LENGTH;
    epcs_addr[2]= (addr_qui & 0xFF);
    epcs_addr[1]= (addr_qui >>8) & 0XFF;
    epcs_addr[0]= (addr_qui >> 16) & 0xFF;
   }while(count == PAGE_LENGTH); 
  printf("\n");
  
  fclose(frbf);
  return(check_result);

}

unsigned char FGCUDsp::FPGAReverseBits(unsigned char b) {
   b = (b & 0xF0) >> 4 | (b & 0x0F) << 4;
   b = (b & 0xCC) >> 2 | (b & 0x33) << 2;
   b = (b & 0xAA) >> 1 | (b & 0x55) << 1;
   return b;
}

int FGCUDsp::FPGAReadRBFPage(FILE * rbf_file, unsigned short *buf)
{
  unsigned char charbuf[PAGE_LENGTH];
  int count;
  count = fread((void *)charbuf,1, PAGE_LENGTH,rbf_file);
  if(count < PAGE_LENGTH)
    {
      for(int i=count; i< PAGE_LENGTH; i++) charbuf[i] = 0xFF;
    }
  
  for(int i=0; i< PAGE_LENGTH/2; i++)
    {
      unsigned short byte1 =  FPGAReverseBits(charbuf[2*i]);
      unsigned short byte2 =  FPGAReverseBits(charbuf[2*i+1]);
      buf[i] =  (byte1<<8) | byte2; 
    }

  return count;

}

void FGCUDsp::FPGAWriteSector(unsigned char *byte,unsigned short *data)
{
  unsigned short command[144];
  command[0]=CMD_WRITE_SECTOR;
#ifdef PRINT  
  printf("Write Sector %2.2x%2.2x%2.2x\n",byte[0],byte[1],byte[2]);
#endif  
  command[1]=byte[0];
  command[2]=byte[1];
  command[3]=byte[2];
  for(int j=0; j<128 ; j++)
    command[j+4]=data[j];
  Write_Data_Mem(command, 0x3E00,132);
  Send_DSP_IrqE();
  usleep(15000);
}



int FGCUDsp::FPGACheckRBF(char *file_rbf,unsigned int address)
{
  unsigned short readWord;
  int i;
  int check_result=0;
  unsigned short buf[PAGE_LENGTH/2];
  TArrayI* read_buf=new TArrayI(PAGE_LENGTH/2);
  FILE * frbf = fopen(file_rbf,"r");
  int count=0;
  int serror=0;
  unsigned char epcs_addr[3];
  int addr_qui = address;
  epcs_addr[2]= (addr_qui & 0xFF);
  epcs_addr[1]= (addr_qui >>8) & 0XFF;
  epcs_addr[0]= (addr_qui >> 16) & 0xFF;
  do{
    //   printf("\rSector 0x%6.6x of 0x15ed00, Completed %lf%%",addr_qui,100.*(double)addr_qui/(double)0x15ed00);
#ifdef PRINT
    printf("Reading Page\n");
#endif
    count = FPGAReadRBFPage(frbf, buf);
 #ifdef PRINT
    printf("Reading Sector\n");
#endif
    FPGAReadSector(epcs_addr);
 #ifdef PRINT
    printf("Read Sector Completed\n");
#endif
    addr_qui += PAGE_LENGTH;
    epcs_addr[2]= (addr_qui & 0xFF);
    epcs_addr[1]= (addr_qui >>8) & 0XFF;
    epcs_addr[0]= (addr_qui >> 16) & 0xFF;
    Read_UData_Mem(0,PAGE_LENGTH/2,read_buf);
    serror=0;
    for(i=0;i<PAGE_LENGTH/2;i++){
      readWord=(unsigned short)(read_buf->At(i) & 0xFFFF);
      if(buf[i]!=readWord){
	serror++; 
#ifdef PRINT
	printf("%d\n",check_result);
#endif
      }
    }
    if(serror!=0) printf("\rERROR!! Found %d errors in sector %2.2x%2.2x%2.2x\n",serror,epcs_addr[0],epcs_addr[1]-1,epcs_addr[2]);
    check_result+=serror;
  }while(count == PAGE_LENGTH);  
  printf("\n");
  fclose(frbf);
  return check_result;
}

int FGCUDsp::FPGAReadSectorFast(unsigned char *byte)
{
  unsigned short command[10];
  command[0]=CMD_READ_SECT_FAST;
#ifdef PRINT  
  printf("Read Sector %2.2x%2.2x%2.2x\n",byte[0],byte[1],byte[2]);
#endif  
  command[1]=byte[0];
  command[2]=byte[1];
  command[3]=byte[2];
  Write_Data_Mem(command, 0x3E00,4);
  Send_DSP_IrqE();
  usleep(4000);
  TArrayI *err=new TArrayI(1);
  Read_UData_Mem(0x3E95,1,err);
  return err->At(0);
}

void FGCUDsp::FPGAReadSector(unsigned char *byte)
{
  unsigned short command[10];
  command[0]=CMD_READ_SECTOR;
#ifdef PRINT  
  printf("Read Sector %2.2x%2.2x%2.2x\n",byte[0],byte[1],byte[2]);
#endif  
  command[1]=byte[0];
  command[2]=byte[1];
  command[3]=byte[2];
  Write_Data_Mem(command, 0x3E00,4);
  Send_DSP_IrqE();
  usleep(4000);
}

void FGCUDsp::ReloadFPGA()
{
  unsigned short command[10];
  command[0]=CMD_RELOAD_FPGA;
#ifdef PRINT
  printf("Reloading FPGA Firmware from EPCS\n");
#endif
  Write_Data_Mem(command, 0x3E00,1);
  Send_DSP_IrqE();
}

void FGCUDsp::ReadRegister(unsigned short Register)
{
  unsigned short command[10];
  command[0]=CMD_READ_REGISTER;
#ifdef PRINT
  // printf("Reading Register From FPGA\n");
#endif
  command[1]=Register;
  if (Register>0x0FFF) printf("ERROR INVALID REGISTER! (0<=reg<=FFF)\n");
  else{
#ifdef PRINT
    printf("Read FPGA register %4.4x \n ",Register);
#endif
    Write_Data_Mem(command, 0x3E00,2);
    Send_DSP_IrqE();
    usleep(1000);
    TArrayI *Data;
    Data=Read_UData_Mem(0x3e90,2);
#ifdef PRINT
    printf("Register Value= %d\t0x%4.4x\n",Data->At(1),Data->At(1));
#endif
    delete Data;
  }
}


unsigned short FGCUDsp::ReadRegister(unsigned short Register,unsigned short dsp_reg_addr)
{
  unsigned short value=0;
  unsigned short command[10];
  command[0]=CMD_READ_REGISTER;

  command[1]=Register;
  if (Register>0x0FFF) printf("ERROR INVALID REGISTER! (0<=reg<=FFF)\n");
  else{
    Write_Data_Mem(command, 0x3E00,2);
    Send_DSP_IrqE();
	mem_address_latch(dsp_reg_addr);
    value=(unsigned short)(idma_read() & 0xff);
	
#ifdef PRINT
     printf("Reading Register %4.4x From FPGA=%4.4x\n",Register,value);
#endif
  }
  return value;
}

void FGCUDsp::WriteRegister(unsigned short Register,unsigned short Data)
{
  unsigned short command[10];
  command[0]=CMD_WRITE_REGISTER;
#ifdef PRINT
  printf("Writing Register 0x%x   data=0x%x  On FPGA\n",(unsigned int)Register,(unsigned int)Data);
#endif
  command[1]=Register;
  command[2]=Data;
  if (Register>0x0FFF) printf("ERROR INVALID REGISTER! (0<=reg<=FFF)\n");
  else if (Data>0x0FFF) printf("ERROR INVALID DATA! (0<=data<=FFF)\n");
  else{
    Write_Data_Mem(command, 0x3E00,3);
    Send_DSP_IrqE();
  }
}

//Trapezoidal filter functions 
#define CMD_SET_TAU_TRAP   0x0020
#define CMD_SET_RT_TRAP	   0x0021
#define CMD_SET_RTFT_TRAP  0x0022
#define CMD_SET_SHIFT_TRAP 0x0023
#define CMD_GET_TRAP_PARS  0x0024
#define CMD_SOFTWARE_TRIG  0x0025
#define CMD_STREAM_MEM 0x0026
#define CMD_ADC_READ 0x0027
#define CMD_ADC_WRITE 0x0028




// /* registers inside Bo schedina FPGA  */

// #define TRAP_SHIFT         0x10
// #define TRAP_RT            0x11
// #define TRAP_RTFT          0x12
// #define TRAP_TAU0          0x13
// #define TRAP_TAU1          0x14
// #define TRAP_TAU2          0x15
// #define TRAP_TAU3          0x16
// #define TRAP_IN0           0x18  /* inverted */
// #define TRAP_IN1           0x17
// #define TRAP_CUT           0x19   /* shift to get MSB */
// #define TRAP_PEAK          0x31
// #define TRIG_RTFT                 0x21
// #define TRIG_RT                   0x20
// #define TRIG_BL_DELAY             0x23
// #define TRIG_BL_LENGTH            0x24
// #define TRIG_TH_VALUE0            0x25
// #define TRIG_TH_VALUE1            0x26
// #define TRIG_TH_VALUE2            0x27
// #define TRIG_TH_VALUE3            0x28
// #define TRIG_HOLDOFF0             0x29
// #define TRIG_HOLDOFF1             0x2B
// #define TRIG_SEL                  0x34

/* registers inside Bo schedina FPGA  */
#define READ_FIFO          0x0  /* to read signal data to be used on DSP code */
#define DAC_OFFSET         0x1
#define DAC_GAIN           0x2
#define RANGE_SEL          0x3
#define BASE_LEN           0x4  /* not yet implemented */

#define TRAP_SHIFT         0x10
#define TRAP_RT            0x11
#define TRAP_RTFT          0x12
#define TRAP_TAU0          0x13
#define TRAP_TAU1          0x14
#define TRAP_TAU2          0x15
#define TRAP_TAU3          0x16
#define TRAP_IN0           0x18  /* inverted */
#define TRAP_IN1           0x17
#define TRAP_CUT           0x19   /* shift to get MSB */
#define TRAP_LEAK          0x1A   /* interval time to base line restoration */
#define TRAP_OUT           0x1B   /* which signal comes out on FIFO do not use */ 
#define TRIG_RTFT                 0x21
#define TRIG_RT                   0x20
#define TRIG_LEAK                 0x22 /* as TRAP_LEAK */
#define TRIG_BL_DELAY             0x23
#define TRIG_BL_LENGTH            0x24
#define TRIG_TH_VALUE0            0x25
#define TRIG_TH_VALUE1            0x26
#define TRIG_TH_VALUE2            0x27
#define TRIG_TH_VALUE3            0x28
#define TRIG_HOLDOFF0             0x29
#define TRIG_HOLDOFF1             0x2A
#define ZERO_CROSSING_OUT         0x2B /* as zero crossing do not use */
#define FAST_TRAP_OUT             0x2C          /* as TRAP_OUT do not use */
#define POLARITY                  0x34  /* 0 polarity +  1 polarity -  */
#define TRAP_PEAK                 0x31   
#define TRAP_ENERGY1              0x32  /* peak energy MSB */
#define TRAP_ENERGY0              0x33  /* peak energy LSB*/
#define REG_SOURCE                0x40  /* see Fazia trig box */
#define REG_MODE                  0x41 
#define REG_SCE_OUT               0x42  /* to get out trigger signal */      
#define FIFO_SELECT               0x30  /* which formed signal is stored ina a special FIFO do not use*/
#define PEAK_OUT                  0x36  /*selects wich signal exits from peaking time calculation, do not use*/
#define PEAK_TRIG                 0x37  /*selects trigger to be used for starting peaking time (0-internal trigger,1-local trigger)*/
#define ID_BO                     0x35  /* 0x424F  = BO */
#define PHASE_VALUE               0x50  /* Do not use !!!!! */
#define PHASE_DATA                0x53  /* phase output Ronly reg*/
#define BSPLINE_SHIFT             0x60  /*Shifts the BSpline Coefficients to better fit the range of 16 bits*/
#define BSPLINE_OUT               0x61  /* selects wich signal exits from BSpline direct Filter. Not implemented.*/
#define INTERP_OUT                0x62  /*Selects wich signal exits from interpolating filter. Not implemented*/
#define INTERP_SIGNED_SIG         0x63  /*Choose how the signal is interpreted by interpolating filter (1-unsigned,0-signed)*/
#define CHECK_WINDOW              0x64  /*Interval of time (in clk cycles) in wich the maximum of interpolated signal is searched*/
#define CURRENT_IN0               0x65  /*LSW of the maximum value of the interpolated signal*/
#define CURRENT_IN1               0x66  /*MSW of the maximum value of the interpolated signal*/
#define TRAP_ENERGY_EXT0          0x67  /* peak energy LSB external trigger  R/W  */
#define TRAP_ENERGY_EXT1          0x68  /* peak energy MSB external trigger  R/W  */
#define AV_LSEL                   0x69  /* average level select              R/W  -------    */
#define RESOLVING_TIME            0x70  /*sets the delay between local trigger and internal veto assertion*/
#define TRAP_ACCU1                0x90  /* 6 refgisters: 3 samples (MSB, LSB) accu1 slow trap   R  */
#define TRAP_ACCU2                0x96  /* 4 registers: 2 samples (MSB,LSB) accu2 slow trap     R  */
#define TRIG_MA_VALUE             0x9A  /* 4 registers: 4 samples from moving average in trig block R   */
#define BS_MA_VALUE               0x9E  /* 2 register: 2 samples from moving average in spline block R  */
#define REC_COEFFS                0x180 /* 80 register: 40 coeff LSB, MSB for upsampling   R/W ----- */
#define INTERP_COEFFS             0x280 /* 32 register: 16 coeff LSB,MSB for interpolation R/W ----- */

 int  FGCUDsp::Get_Trap_Energy(unsigned short dsp_reg_addr)
 { unsigned short Energy1,Energy0;
    Energy0=ReadRegister((unsigned short)TRAP_ENERGY0, dsp_reg_addr);
    Energy1=ReadRegister((unsigned short)TRAP_ENERGY1, dsp_reg_addr);
    printf("Energy without BL subtracted=%d\n",((unsigned int)Energy1<<16)|Energy0);
    return ((unsigned int)Energy1<<16)|Energy0;    
 }


 void FGCUDsp::Fifo_Select_Data(unsigned short value)

 {
   /* 
      0 output of slow shaper signal
      1 output of fast shaper signal
      2 as 1 with  subtracted baseline
   
      the output is on dsp memory
      check dsp_program!!!!
    */
   WriteRegister((unsigned short)FIFO_SELECT,value);
}


 void FGCUDsp::Trig_Select(unsigned short value)

 {
   /* 
     see FAZIA fpga trigger box   
        1   digital trigger out then cfdin in 
        2   digital trigger in (internal trigger)
        3   cfdin trigger in (external trigger from ECL connector)
   */
   if (value==1)
     {
      WriteRegister((unsigned short)REG_SOURCE,0x3);
      WriteRegister((unsigned short)REG_MODE,0x11);
      WriteRegister((unsigned short)REG_SCE_OUT,0);
     }
   else if (value==2)
     {
      WriteRegister((unsigned short)REG_SOURCE,0x3);
      WriteRegister((unsigned short)REG_MODE,0x30);
      WriteRegister((unsigned short)REG_SCE_OUT,0);
     }
   else if (value==3)
     {
      WriteRegister((unsigned short)REG_SOURCE,0x2);
      WriteRegister((unsigned short)REG_MODE,0x30);
      WriteRegister((unsigned short)REG_SCE_OUT,0);
     }
   else
     printf("no trigger selected...!!\n");

}


void FGCUDsp::Set_Tau_Trap(unsigned int value)
{
  unsigned  char byte[4];
  for(int i=0;i<4;i++)
      byte[i]=((value>>(i*8))&0xFF);
  WriteRegister((unsigned short)TRAP_TAU3,(unsigned short)byte[3]);
  WriteRegister((unsigned short)TRAP_TAU2,(unsigned short)byte[2]);
  WriteRegister((unsigned short)TRAP_TAU1,(unsigned short)byte[1]);
  WriteRegister((unsigned short)TRAP_TAU0,(unsigned short)byte[0]);

}
 void FGCUDsp::Set_RiseTime_Trap(unsigned short value)
 {
   WriteRegister((unsigned short)TRAP_RT,value);
}

void FGCUDsp::Set_RiseFlatTime_Trap(unsigned short value)
{
   WriteRegister((unsigned short)TRAP_RTFT,value);
}

void FGCUDsp::Set_Shift_Trap(unsigned short value)
{
   WriteRegister((unsigned short)TRAP_SHIFT,value);
}

void FGCUDsp::Set_Cut_Trap(unsigned short value)
{
   WriteRegister((unsigned short)TRAP_CUT,value);
}

void FGCUDsp::Set_Peak_Trap(unsigned short value)
{
   WriteRegister((unsigned short)TRAP_PEAK,value);
}


 void FGCUDsp::Set_RiseTime_Trig(unsigned short value)
 {
   WriteRegister((unsigned short)TRIG_RT,value);
}

void FGCUDsp::Set_RiseFlatTime_Trig(unsigned short value)
{
   WriteRegister((unsigned short)TRIG_RTFT,value);
}

void FGCUDsp::Set_Threshold_Trig(unsigned int value)
{
  unsigned  char byte[4];
  for(int i=0;i<4;i++)
      byte[i]=((value>>(i*8))&0xFF);
  WriteRegister((unsigned short)TRIG_TH_VALUE3,(unsigned short)byte[3]);
  WriteRegister((unsigned short)TRIG_TH_VALUE2,(unsigned short)byte[2]);
  WriteRegister((unsigned short)TRIG_TH_VALUE1,(unsigned short)byte[1]);
  WriteRegister((unsigned short)TRIG_TH_VALUE0,(unsigned short)byte[0]);

}

 void FGCUDsp::Set_Bl_Delay_Trig(unsigned short value)
 {
   WriteRegister((unsigned short)TRIG_BL_DELAY,value);
}

void FGCUDsp::Set_Bl_Length_Trig(unsigned short value)
{
   WriteRegister((unsigned short)TRIG_BL_LENGTH,value);
}

void FGCUDsp::Set_Bologna_Polarity(short value)
{
  if(value>=0)
    {
     WriteRegister((unsigned short)POLARITY,0);
     printf("set positive polarity\n");
    }
  else
    {
     WriteRegister((unsigned short)POLARITY,1);
     printf("set negative polarity\n");
    }
}
void FGCUDsp::Set_Bologna_PretrigBl(unsigned short value)
{
     WriteRegister((unsigned short)BASE_LEN,value);
}

void FGCUDsp::Set_Bologna_Phase(unsigned short value)
{
  unsigned short valr=value;
  if (valr>=80) {
    valr=valr%80;
    printf("Phase between 0 and 79. Choosen Equivalent Value. ");
  }
  WriteRegister((unsigned short)PHASE_VALUE,valr);
  printf("Set Phase to %i\n",valr);
}

void FGCUDsp::Set_Bologna_Resolv_Time(unsigned short value)
{
  WriteRegister((unsigned short)RESOLVING_TIME,value & 0x3FF);
}

void FGCUDsp::Set_Bologna_Check_Window(unsigned short value)
{
  WriteRegister((unsigned short)CHECK_WINDOW,value & 0x3FF);
}

void FGCUDsp::Set_Holdoff_Trig(unsigned short value)
{
  unsigned  char byte[2];
  for(int i=0;i<2;i++)
      byte[i]=((value>>(i*8))&0xFF);
  WriteRegister((unsigned short)TRIG_HOLDOFF1,(unsigned short)byte[1]);
  WriteRegister((unsigned short)TRIG_HOLDOFF0,(unsigned short)byte[0]);

}


void FGCUDsp::Set_Bologna_Shaper(unsigned int *value)
{
  /* 
    5 32bit values (32bit are necessary for the coefficient)
    rise time (TCLOCK_BO unit)
    rise time + flat top (TCLOCK_BO unit)
    cut     (bit)
    peaking time (TCLOCK_BO unit)
    coefficient of zero pole (exp(-TCLOCK_BO/tau))
   */
  Set_RiseTime_Trap((unsigned short)value[0]);  
  Set_RiseFlatTime_Trap((unsigned short)value[1]);
  Set_Cut_Trap((unsigned short)value[2]);
  Set_Peak_Trap((unsigned short)value[3]);
  Set_Tau_Trap(value[4]);
}
void FGCUDsp::Set_Bologna_FShaper(unsigned int *value)
{
  /* 
    6 32bit values (32bit are not necessary )
    rise time (TCLOCK_BO unit)
    rise time + flat top (TCLOCK_BO unit)
    cut     (bit) (always 0)
    peaking time (TCLOCK_BO unit)
    coefficient of zero pole (exp(-TCLOCK_BO/tau))
   */
  Set_RiseTime_Trig((unsigned short)value[0]);  
  Set_RiseFlatTime_Trig((unsigned short)value[1]);
  Set_Threshold_Trig(value[3]);
  Set_Holdoff_Trig((unsigned short)value[4]);
  Set_Bl_Delay_Trig((unsigned short)value[5]);
  Set_Bl_Length_Trig((unsigned short)value[6]);
}


void FGCUDsp::Set_Bologna_BsplineShift(unsigned short nval)
{
  WriteRegister(BSPLINE_SHIFT,nval);	
}

void FGCUDsp::Set_Bologna_AvLsel(unsigned short nval)
{ 
  /*
    nval=0  no average
        =1  2^1 (2 average)
        =2  2^2 (4 average)
        =3  2^3 (8 average)
   */
  short value;
  if(nval)
    value=(short)nval-1;
  else	
	value=4;  
  WriteRegister(AV_LSEL,(unsigned short)value);	
}

void FGCUDsp::Set_Bologna_InterpSignedSig(unsigned short nval)
{/*   always set nval=0  */
  WriteRegister(INTERP_SIGNED_SIG,nval);	
}
		  /*
		   * interp_signed_sig set 0
		   * check_window   set 1023
		   * resolving time set 1023
		   */

void FGCUDsp::Set_Bologna_CalcRecCoeffs(int rec_type,int nanotau)
{
  /*
   rec_type=0 only derivation
   rec_type=1 derivation with PZC
  */
#define NWORD_UPSAMPLING 40
  short rec_coeffs[NWORD_UPSAMPLING]; 
  int i;
  int nbits_rec=16;
  double xi;
  if(rec_type==0 || !nanotau)
   {
    for(i=0;i<10;i++)
     {
      xi=(double)i/10;
      rec_coeffs[i]=(int)(floor(pow(xi,2)*pow(2,nbits_rec-1)/2.+0.5));
      rec_coeffs[10+i]=(int)(floor((-3*pow(xi,2)/2.+xi+0.5)*pow(2,nbits_rec-1)+0.5));
      rec_coeffs[20+i]=(int)(floor((3*pow(xi,2)/2.-2*xi)*pow(2,nbits_rec-1)+0.5));
      rec_coeffs[30+i]=(int)(floor(-pow(1-xi,2)*pow(2,nbits_rec-1)/2.+0.5));
     }
   }
  else
   {
    double k=8./(double)nanotau;
    for(i=0;i<10;i++)
	 {
      xi=(double)i/10;
      rec_coeffs[i]=(int)(floor((pow(xi,2)/2.+k*pow(xi,3)/6.)*pow(2,nbits_rec-1)+0.5));
      rec_coeffs[10+i]=(int)(floor((-3*pow(xi,2)/2.+xi+0.5+k*(-pow(xi,3)/2.+pow(xi,2)/2.+xi/2.+1./6.))*pow(2,nbits_rec-1)+0.5));
      rec_coeffs[20+i]=(int)(floor((3*pow(xi,2)/2.-2*xi+k*(pow(xi,3)/2.-pow(xi,2)+2./3.))*pow(2,nbits_rec-1)+0.5));
      rec_coeffs[30+i]=(int)(floor((-pow(1-xi,2)/2.+k*pow(1-xi,3)/6.)*pow(2,nbits_rec-1)+0.5));
     }
   }
  // PRINT_DEBUG("upsampling coeff\n"); 
  // for(i=0;i<NWORD_UPSAMPLING;i++) PRINT_DEBUG("%4.4x%c", (unsigned short)rec_coeffs[i],i%10==9 ? '\n' : ' ');
   WriteRecCoeffs((unsigned short *)rec_coeffs);	
}

void FGCUDsp::WriteRecCoeffs(unsigned short *value)
{
/* first LSB then MSB */	
  unsigned  char byte[2];
  int i,j;
  int Reg_num=REC_COEFFS;
  for(j=0;j<NWORD_UPSAMPLING;j++)
  {
    for(i=0;i<2;i++)
      byte[i]=((value[j]>>(i*8))&0xFF);
    WriteRegister((unsigned short)Reg_num++,(unsigned short)byte[0]);
    WriteRegister((unsigned short)Reg_num++,(unsigned short)byte[1]);
  }
 }



		  
		  /*
		   * calculate rec_type coefficients 0 , 1
		   */
		  /*
		   * calculate interp_type 0,1,2,3 
		   */


void FGCUDsp::Set_Bologna_CalcInterpCoeffs(int interp_type)
{
#define NWORD_INTERP 16
  unsigned short interp_coeffs[NWORD_INTERP];
  int i;
  FILE *fcoeff;
  fcoeff=fopen("interpcoeff.txt","r");
  if(!fcoeff)
    {
      printf("FILE  ./interpcoeff.txt MISSING!! Copy it !!\n");
      return;
    }   
  for(i=0;i<NWORD_INTERP;i++)
  {
	unsigned int cf[4];
/*
 * interp_type  0           1          2           3
            no smooth , smooth 0.5, smooth 1.0, snooth 2.0
 */
	fscanf(fcoeff,"%x%x%x%x",&cf[0],&cf[1],&cf[2],&cf[3]);
 //   PRINT_DEBUG("  ---  %4.4x   %4.4x   %4.4x   %4.4x\n",cf[0],cf[1],cf[2],cf[3]);
	interp_coeffs[i]=cf[interp_type];
  }
  //   PRINT_DEBUG("interpolation coeff\n");
  // for(i=0;i<NWORD_INTERP;i++) PRINT_DEBUG("%4.4x%c", interp_coeffs[i],i%8==7 ? '\n' : ' ');
   WriteInterpCoeffs(interp_coeffs);
}
void FGCUDsp::WriteInterpCoeffs(unsigned short *value)
{
/* first LSB then MSB */	
  unsigned  char byte[2];
  int i,j;
  int Reg_num=INTERP_COEFFS;
  for(j=0;j<NWORD_INTERP;j++)
  {
    for(i=0;i<2;i++)
      byte[i]=((value[j]>>(i*8))&0xFF);
    WriteRegister((unsigned short)Reg_num++,(unsigned short)byte[0]);
    WriteRegister((unsigned short)Reg_num++,(unsigned short)byte[1]);
  }
 }


	  /* for debug */

void FGCUDsp::Get_Trap_Pars()
{
  unsigned short command[10];
  command[0]=CMD_GET_TRAP_PARS;
  Write_Data_Mem(command,0x3E00,1);
  Send_DSP_IrqE();
}
/*  da controllare   */
void FGCUDsp::Soft_trigger()
{
  /* 
    only for debugging do not use!!!!!
 */
  unsigned short command[10];
  command[0]=CMD_SOFTWARE_TRIG;
  Write_Data_Mem(command,0x3E00,1);
  Send_DSP_IrqE();
}

void FGCUDsp::StreamMemory(unsigned short start_addr,unsigned short num_reg){
   unsigned short command[10];
   command[0]=CMD_STREAM_MEM;
   command[1]=start_addr;
   command[2]=num_reg;
   Write_Data_Mem(command,0x3E00,3);
  Send_DSP_IrqE();
}

void FGCUDsp::ReadADCRegister(unsigned short Address){
   unsigned short command[10];
   command[0]=CMD_ADC_READ;
   command[1]=Address;
   Write_Data_Mem(command,0x3E00,2);
   Send_DSP_IrqE();
}

void FGCUDsp::WriteADCRegister(unsigned short Address,unsigned short value,int type){
  unsigned short command[10];
  unsigned short temp;
  command[0]=CMD_ADC_WRITE;
  if(type==0){
    temp=Address & 0xFF;
    temp<<=8;
    command[1]=temp;
    temp=value & 0xFF;
    command[1]|=temp;
    Write_Data_Mem(command,0x3E00,2);
  }
  else{
    command[1]=Address & 0xFF;
    command[2]=value & 0xFF;
    Write_Data_Mem(command,0x3E00,3);
  }
  Send_DSP_IrqE();
}

int FGCUDsp::AutomaticPhaseChecking(int type){
  if(type==1){
    //Set ADC test mode
    WriteADCRegister(0x0D,4);
    usleep(100);
    WriteADCRegister(0xFF,1);
    usleep(100);
    //Resets and restarts phase state machine on FPGA
    WriteRegister(0x54,0);
    usleep(100);
    WriteRegister(0x52,0);
  }
  else{
   unsigned short command[10];
   command[0]=0x0030;
   Write_Data_Mem(command,0x3E00,1);
   Send_DSP_IrqE();
  }
  usleep(100000);
  // Dump_Data_Mem(0,16,0);
  //Reads output
  // int res=0;
  // TArrayI *Data;
  // ReadRegister(0x52);
  // Dump_Data_Mem(0,16,0);
  //Data=Read_UData_Mem(0,1);
  //res=(Data->At(0))&(0xFFFF);
  // usleep(100);
  // ReadRegister(0x53);
  //Dump_Data_Mem(0,16,0);
  //Data=Read_UData_Mem(0,1);
  //res|=((Data->At(0))&(0xFFFF))<<16;
  // int i;
  //for(i=0;i<5;i++){
  //ReadRegister(0x59-i);
  //  Dump_Data_Mem(0,16,0);
  //}
  //Reset ADC normal Mode
  if(type==1){
    WriteADCRegister(0x0D,0);
    usleep(100);
    WriteADCRegister(0xFF,1);
    usleep(100);
  }
  return 0;
}

/*
int FGCUDsp::Set_Bo_Trig_Source(unsigned short val)
{ 
// value = 0 trigger off
  //         = 1 Ext trigger
   //        = 2 Cfdin
     //      = 3 FPGA shaper
       //    = 0x10 Ext trigger | trigger off = Ext trigger
        //   = 0x11 Ext trigger | Ext trigger = Not useful
         //  = 0x12 Ext trigger | Cfdin
          // = 0x13 Ext trigger | FPGA shaper 
           //= 0x40 Forced trigger | FPGA pulser generated 
  unsigned short uno=1,zero=0,valx;
  if ((val > 0x23) && (val != 0x40) )
    { 
      printf("wrong Trigger %2.2x : possible values: 0,1,2,3,0x10,0x12,0x13,0x20,0x21,0x22,0x23,0x40\n",val);
      return -1;
    }
  unsigned short value=val&0xf;
  if (value == 0)
    printf("Trigger off\n");
  else if (value == 1)
    printf("External TRIGGER\n");
  else if (value == 2)
    printf("TRIGGER CFDIN\n");
  else if (value == 3)
    printf("FPGA Shaper TRIGGER\n");
  else
    return -1;
  WriteRegister((unsigned short)TRIG_SOURCE,value); 
  if (val & 0x10)
      valx=uno|TRIG_MODE_VAL_DSP;
  else 
      valx=zero|TRIG_MODE_VAL_DSP;
  // to get forced trigger output
   //  give val=0x40
  
  if (val & 0x20)
    valx |= TRIG_MODE_VAL_EN_SOURCE_OUT;
  if (val & 0x40)
    valx |= TRIG_MODE_FORCE;
  WriteRegister((unsigned short)TRIG_MODE,valx);
  return val;
}

int FGCUDsp::Set_Bo_Trig_Out(unsigned short value)
{ 
  if (value == 0)
    printf("Selected Trigger + 100ns monostable\n");
  else if (value == 1)
    printf("Local Trigger\n");
  else if (value == 2)
    printf("Pulsed arm\n");
  else if (value == 3)
    printf("pulsed force\n");
  else if (value == 4)
    printf("pulsed source\n");
  else if (value == 5)
    printf("pulsed trig arm\n");
  else if (value == 6)
    printf("Pulsed cfdin\n");
  else if (value == 7)
    printf("Pulsed cfdin || pulsed trig ext\n");
  else
    return -1;
  WriteRegister((unsigned short)TRIG_OUT,value);
  return value;
}
*/


#define AddrDM ((unsigned short)0x3E80)
#define AddrCmd ((unsigned short)(0x4000|0x3E00))
#define Cmd_Write_DM ((unsigned short)0x20)

/*
int FGCUDsp::Signal2DM(FSignal *sig_in, int addr){
    int nsamples;
    nsamples = sig_in->GetNSamples();
    unsigned short signal[nsamples];

    for(int i=0; i<sig_in->GetNSamples(); i++){
	signal[i] = (unsigned short)sig_in->At(i);
      }
    Write_Data_Mem(signal,addr,nsamples);
    return 0;
}
*/

int FGCUDsp::CheckDspProg()
{
          /* we do a check of the program loading correctness */  
  //  static  char up[4] = {0x1B,'[','A',0};
   int flag_ret;
   unsigned short numis;
   unsigned short numrand;
   unsigned short numrandgot;
//   dsp_IAL(dspchan,(AddrDM|0x4000));
//   numis=dsp_IORD(dspchan);
   numrand=random();
//   dsp_IAL(dspchan, AddrCmd);
//   dsp_IOWR(dspchan,Cmd_Write_DM);
//   dsp_IOWR(dspchan,1);
//   dsp_IOWR(dspchan,AddrDM);
//   dsp_IOWR(dspchan,numrand);
//   dsp_SPE(dspchan,1);
//   dsp_IAL(dspchan,(AddrDM|0x4000));
//   numrandgot=dsp_IORD(dspchan);
   mem_address_latch(AddrDM);
   numis=(unsigned short)(idma_read() & 0xff);
  
   unsigned short command[10];

   command[0]=CMD_WRITE_DM;
   command[1]=1;
   command[2]=AddrDM;
   command[3]=numrand;
   Write_Data_Mem(command, 0x3E00,4);
   Send_DSP_IrqE();  
   usleep(5000);
  
   mem_address_latch(AddrDM);
   numrandgot=(unsigned short)(idma_read() & 0xff);
   

  if (numrand == numrandgot)
   {
    colore(GREEN);
    printf("%p  chan=%d    %4.4x    %4.4x   %4.4x\n",this->myboard,dspchan,numis,numrand,numrandgot);
    flag_ret=0;
   }
  else
   {
    colore(RED);
    printf("\n******ERROR****** %p  chan=%d   %4.4x    %4.4x   %4.4x\n",this->myboard,dspchan,numis,numrand,numrandgot);
    flag_ret=1;
   }
  colore(NORMAL);
  return flag_ret;
}




int FGCUDsp::LoadDsp(const char *filename,int print)
  {
    int flag_pm, flag_start;
    int ret,j;
    int init_addr=0;
    unsigned int save_start_instr;
    FILE *fp;
    char linea[100];
    for (j = 0 ; j < 100 ; linea[j++] = 0);
    if ((fp = fopen(filename,"r")) == NULL)
     {
      printf("can't open file %s\n",filename);
      return -1;
     }
    flag_pm = 0;
    flag_start = 0;
    save_start_instr = 0;
    while((ret = fscanf(fp,"\n%[^\n]",linea)) != EOF)
     {
      unsigned int   l_address;
      unsigned short address;
      unsigned int dato_instr;
      if (print) printf("%d %s\n",ret,linea);
      if (!strcmp(linea,"\e\ei"))
	continue; 
      if (!strcmp(linea,"\e\eo"))
	break; 
      if (linea[0] == '@') 
       {
	 if (linea[1] == 'P') /* program write */
	   {
            fscanf(fp,"%x",&l_address);
            address = l_address;
            if (print) printf("P.... %04x\n",address); 
            if (!address)
	      {
                fscanf(fp,"%x",&save_start_instr);
                if (print) printf("save_instr %x\n",save_start_instr);
                flag_start = 1;
                address++; 
	      }
	      
			dsp_IAL(address);
			
            if (print) printf("addr_latch %04x\n",address);
            init_addr = address;
            flag_pm = 1;
           }
         else if (linea[1] == 'D') /* memory write */
           {
            fscanf(fp,"%x",&l_address);
            address = l_address;
            if (print) printf("D.... %04x\n",address);
            address |= 0x4000;
			dsp_IAL(address);
		    flag_pm = 0;
           }
         continue;
       }
      if (strcmp(linea,"#123123123123"))
       { 
        if (flag_pm)
         {
          unsigned short dato_instr_short;
          sscanf(linea,"%x",&dato_instr);
          if (print) printf("Pmemory....%08x  %08x\n",init_addr,dato_instr);
	  //	  indirizzo_scritto[init_addr]=init_addr;
	  //	  dato_scritto[init_addr]=dato_instr;
          init_addr++;
          dato_instr_short = (dato_instr >> 8);
          dsp_IOWR(dato_instr_short);
	      dato_instr_short = (dato_instr & 0xff);
          dsp_IOWR(dato_instr_short);
	     }
        else
	 {
           unsigned int l_dato;
           unsigned short dato;
			sscanf(linea,"%x",&l_dato);
           dato = l_dato;
           dsp_IOWR(dato);
         }        
        }
/*     printf("end while %x\n",linea[0]);*/
     }
     if (flag_start)
        {
	 unsigned short address;
         unsigned short dato_instr_short;
         address = 0;
         dsp_IAL( address);
         if (print) printf("Pmemory last.... %08x\n",save_start_instr);
         dato_instr_short = save_start_instr >> 8;
         dsp_IOWR(dato_instr_short);
		 dato_instr_short = (save_start_instr & 0xff);
         dsp_IOWR( dato_instr_short);
		}
     fclose(fp);
     return 0;
  }

int FGCUDsp::Comp_Dsp_File(TString filename)
  {
    int flag_pm, flag_start;
    int ret,j;
    int init_addr=0;
    unsigned int save_start_instr;
    FILE *fp;
    char linea[100];
    for (j = 0 ; j < 100 ; linea[j++] = 0);
    TString FileName = ROOT_DSP_ASM;
    FileName += (filename + "/" + filename + ".asm.exe");
    printf("Checking %s\n",FileName.Data());
    if ((fp = fopen(FileName.Data(),"r")) == NULL)
     {
      printf("can't open file %s\n",FileName.Data());
      return 2;
     }
    flag_pm = 0;
    flag_start = 0;
    save_start_instr = 0;
    while((ret = fscanf(fp,"\n%[^\n]",linea)) != EOF)
     {
      unsigned int   l_address;
      unsigned short address;
      unsigned int dato_instr;


      if (!strcmp(linea,"\e\ei"))
	continue; 
      if (!strcmp(linea,"\e\eo"))
	break; 
      if (linea[0] == '@') 
       {
	 if (linea[1] == 'P') /* program write */
	   {
            fscanf(fp,"%x",&l_address);
            address = l_address;
            if (!address)
	      {
                fscanf(fp,"%x",&save_start_instr);
                flag_start = 1;
                address++; 
	      }
		dsp_IAL( address);
            init_addr = address;
            flag_pm = 1;
           }
         else if (linea[1] == 'D') /* memory write */
           {
            fscanf(fp,"%x",&l_address);
            address = l_address;
            address |= 0x4000;
            dsp_IAL( address);
			flag_pm = 0;
           }
         continue;
       }
      if (strcmp(linea,"#123123123123"))
       { 
        if (flag_pm)
         {
          unsigned short dato_instr_short, read_data;
          sscanf(linea,"%x",&dato_instr);
	  //	  indirizzo_scritto[init_addr]=init_addr;
	  //	  dato_scritto[init_addr]=dato_instr;
          init_addr++;
          dato_instr_short = (dato_instr >> 8);
          read_data=(unsigned short)(idma_read() & 0xff);		 
          if(read_data!=dato_instr_short) {
	      printf("%8.8x %6.6x %6.6x\n",dato_instr,dato_instr_short,read_data );
              return 1;
	  }else
 	    printf("%8.8x %6.6x %6.6x\n",dato_instr,dato_instr_short,read_data );

          dato_instr_short = (dato_instr & 0xff);
		  read_data=(unsigned short)(idma_read() & 0xff);	
	  if(read_data!=dato_instr_short) {
	      printf("%8.8x %6.6x %6.6x\n",dato_instr,dato_instr_short,read_data );
              return 1;
	  }else
 	    printf("%8.8x %6.6x %6.6x\n   ",dato_instr,dato_instr_short,read_data );


         }
        else
	 {
           unsigned int l_dato;
           unsigned short dato,read_data;
	   sscanf(linea,"%x",&l_dato);
           dato = l_dato;
		   read_data=(unsigned short)(idma_read() & 0xff);	
           if(read_data!=dato) {
 	            printf("%4.4x %4.4x\n",dato,read_data);
                   return 1;
	   }else
              printf("%4.4x %4.4x\n",dato,read_data);

         }        
        }
     }
    if (flag_start)
        {
	 unsigned short address;
         unsigned short dato_instr_short;
		 unsigned short read_data;
         address = 0;
	 dsp_IAL( address);
	     dato_instr_short = save_start_instr >> 8;
		read_data=(unsigned short)(idma_read() & 0xff);	
        if(read_data!=dato_instr_short) return 1;
         dato_instr_short = (save_start_instr & 0xff);
		read_data=(unsigned short)(idma_read() & 0xff);	
         if(read_data!=dato_instr_short) return 1;
        }
     fclose(fp);
     return 0;
  }

/*

FSignal *FGCUDsp::DM16BIT2Signal(int addr, int nsamples, double tau_clk){

    FSignal *sig = new FSignal();
    TArrayI *dm = Read_UData_Mem(addr,nsamples);
    sig->SetNSamples(nsamples);
    sig->SetTauClk(tau_clk);
 
    sig->Fill(dm,tau_clk,nsamples);
    delete dm;
    return sig;
}

FSignal *FGCUDsp::DM32BIT2Signal(int addr, int nsamples, double tau_clk){

    FSignal *sig = new FSignal();
    TArrayI *dm = Read_UData_Mem(addr,2*nsamples);
    sig->SetNSamples(nsamples);
    sig->SetTauClk(tau_clk);

    TArrayI dmD;
    dmD.Set(nsamples);

    for(int j=0; j<nsamples; j++){
     dmD.AddAt((dm->At(2*j)<<16) | (0x0000ffff & dm->At(2*j+1)),j);
    }
    sig->Fill(&dmD,tau_clk,nsamples);
    delete dm;
    return sig;
}*/
