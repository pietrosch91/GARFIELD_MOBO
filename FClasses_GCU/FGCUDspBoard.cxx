
#include "FGCUDspBoard.h"
#include "FGCUDsp.h"




//LIST OF DEFINES OF REGISTER ACCESS NAMES

#define STATUSREG "dsp.status"
#define DSPBASE "dsp.dsp_interface"

using namespace uhal;
using namespace std;


ClassImp(FGCUDspBoard);

string FGCUDspBoard::GetDspDevice(int chan){
	if(hw==nullptr) return 0;
	char nodename[200];
	sprintf(nodename,"%s%d",DSPBASE,chan);
	return string(nodename);
}

/***************************************************************************/

void FGCUDspBoard::Send_DSP_Irq1(){  //may be further improved to rehabilitate all DSP at once (broadcast communication....
	for(int i=0;i<8;i++){
	  if(children[i]!=nullptr) children[i]->Send_IRQ1();
	}
}

int FGCUDspBoard::GetFL1Chan(int time_out)
{
  volatile unsigned short FL1_status;
  if ((FL1_status=this->ReadStatus()) == FL1_latch)
    {
      FL1_latch = 0;
      return 8;
    }
  FL1_status &= 0xff;
  
  //  printf("status %4.4x\n",status);
  while((!(FL1_status)) && time_out--) {
          FL1_status= (this->ReadStatus()) & 0xff;
	  //	  printf("status=%4.4x  FL1=%x\n",status,FL1);
  }
  if (!(time_out+1))
    return -1;
  else
    {
      //    printf("poll_FL1: status=%4.4x\n",status);
      int i=0;
      while (!(FL1_status & 1<<i)) i++;
      FL1_latch |= 1<<(i+8);
      return i;
    }
}



unsigned short FGCUDspBoard::ReadStatus(){
	ValWord< uint32_t > mem = hw->getNode (STATUSREG).read();
    hw->dispatch();
    //printf("Register %s value = %u\n",nd[nodeID]->getID().c_str(),mem.value());
    return (unsigned short) mem.value();   
}

void FGCUDspBoard::AddChild(FGCUDsp *dsp){
      children[dsp->GetChan() ]=dsp;
};
