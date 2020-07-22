
#ifndef GCU_DSP
#define GCU_DSP



#include <math.h>
#include <stdlib.h>     
#include <unistd.h>

#include <errno.h>
#include <unistd.h>

#ifndef __CINT__
#include <ctype.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#endif

#include "TObject.h"
#include "TH1.h"
#include "TF1.h"
#include "TFile.h"
#include "TCanvas.h"
#include "TRandom.h"
#include "TVirtualPad.h"
#include "TPad.h"
#include "TLine.h"
#include "TText.h"
#include "TArray.h" 
#include "TArrayI.h" 
#include "TString.h"

#include "FGCUDspBoard.h"

#define RED         1
#define GREEN       2
#define YELLOW      3
#define BLUE        4
#define NORMAL      0

class FGCUDsp: public TObject{

public: 

  FGCUDsp(){};

  FGCUDsp(FGCUDspBoard *board, int dspch){
    myboard=board;
	board_addr = myboard->GetBoardAddr();
    dspchan = dspch;
    board->AddChild(this);
    ProgNamePath = new TString();
	dsp_hw=myboard->GetDspDevice(dspchan);
	mH=myboard->GetDevice();
  };

  ~FGCUDsp(){};

  void Reset();
  int GetDspAddr(TString *Variable);
  int LoadExe_Dsp_Prog(TString ProgName,int print=0);
  int Write_Data_Mem(unsigned short *data, int start_addr, int how_many_words);
  int Write_Prog_Mem(unsigned int *data, int start_addr, int how_many_words);
  virtual TArrayI* Read_Prog_Mem(unsigned short start_addr, int n_word);
  virtual TArrayI* Read_UData_Mem(unsigned short start_addr, int n_word, TArrayI *buffer=NULL );
  virtual TArrayI* Read_Data_Mem(unsigned short start_addr, int n_word, TArrayI *buffer=NULL);
  virtual TArrayI* UnZip_Signal(unsigned short *buf, TArrayI *buffer=NULL );

/*
  virtual TArrayI* Read_Signal_Mem(unsigned short start_addr, int n_word);
  virtual TArrayI* Read_CompSigns_Mem(unsigned short start_addr, int *n_samp);
  virtual TArrayI* Read_Comp1_Mem(unsigned short start_addr, int *n_samp);
*/
  int Read_noDma_Data_Mem(unsigned short start_addr,unsigned short *buffer, Int_t n_word);
  
  void Dump_Data_Mem(unsigned short first, Int_t nwords);
  void Dump_Prog_Mem(unsigned short first, Int_t nwords);

  void Send_DSP_IrqE();
  void Send_IRQ1();
  int CompileDSPCode(TString ProgName);
  int AssembleDSPCode(TString ProgName,Int_t f2181_2191=1);
//  int CreateGUIforDSP(TString ProgName);
  int poll_FL0(int time_out);
  int poll_FL1(int time_out);
  void ClearStatus();
  
  void SetGain(int value);
  void SetOffsetBo(int value);
  void SetGainBo(float value);
  void SetGainBo(int value);
  void SetRangeBo(int value);
  void SetRFBo();
  void Set_Tau_Trap(unsigned int value);
  void Set_RiseTime_Trap(unsigned short value);
  void Set_RiseFlatTime_Trap(unsigned short value);
  void Set_Shift_Trap(unsigned short value);
  void Set_Cut_Trap(unsigned short value);
  void Set_Peak_Trap(unsigned short value);
  void Set_RiseTime_Trig(unsigned short value);
  void Set_RiseFlatTime_Trig(unsigned short value);
  void Set_Threshold_Trig(unsigned int value);
  void Set_Bl_Delay_Trig(unsigned short value);
  void Set_Bl_Length_Trig(unsigned short value);
  void Set_Holdoff_Trig(unsigned short value);
  void Set_Bologna_PretrigBl(unsigned short);
  void Set_Bologna_Polarity(short value);
  void Set_Bologna_Phase(unsigned short value);
  void Set_Bologna_Resolv_Time(unsigned short value);
  void Set_Bologna_Check_Window(unsigned short value);
  void Set_Bologna_Shaper(unsigned int *value);
  void Set_Bologna_FShaper(unsigned int *value);
  void Set_Bologna_BsplineShift(unsigned short);
  void Set_Bologna_AvLsel(unsigned short);
  void Set_Bologna_InterpSignedSig(unsigned short);
  void Set_Bologna_CalcRecCoeffs(int,int );
  void WriteRecCoeffs(unsigned short *); 
  void Set_Bologna_CalcInterpCoeffs(int);
  void WriteInterpCoeffs(unsigned short *);
  void Get_Trap_Pars();
  int Get_Trap_Energy(unsigned short);
  void Soft_trigger();
  void StreamMemory(unsigned short,unsigned short);
  void ReadADCRegister(unsigned short);
  void WriteADCRegister(unsigned short,unsigned short,int type=0);
  int AutomaticPhaseChecking(int type=0);
  void Fifo_Select_Data(unsigned short);
  void Trig_Select(unsigned short value);
  void WriteRegister(unsigned short Register,unsigned short Data);
  void ReadRegister(unsigned short Register);
  unsigned short ReadRegister(unsigned short Register,unsigned short);
  void ReloadFPGA();
  int FPGAReadSectorFast(unsigned char *byte);
  void FPGAReadSector(unsigned char *byte);
  int  FPGACheckRBF(char *file_rbf,unsigned int address);
  void FPGAWriteSector(unsigned char *byte,unsigned short *data);
  int  FPGAReadRBFPage(FILE * rbf_file, unsigned short *buf);
  unsigned char  FPGAReverseBits(unsigned char b);
  int FPGAWriteRBF(char *file_rbf, unsigned int address);
  void FPGAEraseSector(unsigned char *byte);
  void FPGAEraseFlash();
  void FPGADisableFlash();
  void FPGAEnableFlash();
  
//  int  Set_Bo_Trig_Source(unsigned short val);
//  int  Set_Bo_Trig_Out(unsigned short val);


  void SetThreshold(int nthres, int value);




  //int Signal2DM(FSignal *sig_in, int addr);
//  FSignal* DM16BIT2Signal(int addr, int nsamples, double tau_clk);
 // FSignal* DM32BIT2Signal(int addr, int nsamples, double tau_clk);
  
  int CheckDspProg();
   int LoadDsp(const char *filename,int print);
  int Comp_Dsp_File(TString filename);
 
  
 
  inline int GetChan(){return dspchan;};






  inline FGCUDspBoard* GetDspBoard(){return myboard;};
 // int  dma_read(FVmeControl *vme ,FVmeDMA *dma,unsigned int from_vme_addr,char *to_buffer,int n);

  

  FGCUDspBoard *myboard;
 
protected:
  HwInterface *mH;
  string dsp_hw; 
  TString *ProgNamePath;
  char * board_addr; // indirizzo VME della mother board
  int dspchan;          // id del canale DSP che ci interessa
  void colore(int A);
  
  void IssueDspCommand(int CMD, int DATA=0);
  ClassDef(FGCUDsp,1) // FIASCO: Class for storing and manipulating ADC events
    
  int idma_read();
  void idma_write(int dato);
  void idma_write(unsigned int dato);
  void address_latch(unsigned short address);
  void mem_address_latch(unsigned short address);

};

/***************************************************************************/
#endif
