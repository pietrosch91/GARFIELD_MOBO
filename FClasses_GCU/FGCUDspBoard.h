#ifndef GCU_DSP_BOARD
#define GCU_DSP_BOARD

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

#include "FGCUControl.h"


// #include <FVmeDsp.h>

class FGCUDsp;

class FGCUDspBoard: public TObject{


#define DSPBOARD_SIZE  0x1000

public: 
  FGCUDspBoard(){};
  
  FGCUDspBoard(char* name, FGCUControl *ctrl){
    this->ctrl=ctrl;
    sprintf(board_addr,"%s",name);
	hw=ctrl->GetDevice(name);
  };
   
   
  void AddChild(FGCUDsp *dsp);

  ~FGCUDspBoard(){
	delete hw;
  };

  void Send_DSP_Irq1();  //-->REARM  --reimplement in FGCUDsp
  
  unsigned short ReadStatus(); //read status
  
  char* GetBoardAddr(){
	  return board_addr;
  }
  
  int GetFL1Chan(int time_out);
  
  string GetDspDevice(int chan);
  HwInterface *GetDevice(){
	  return hw;
  }

  //unsigned int phys_addr;
  FGCUControl *ctrl;


  FGCUDsp *children[8];


protected:
	int FL1_latch;
  char  board_addr[200];
  HwInterface *hw;
  ClassDef(FGCUDspBoard,1) // FIASCO: Class for storing and manipulating ADC events
};

/***************************************************************************/
#endif

