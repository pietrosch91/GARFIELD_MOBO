#ifndef GCU_CNTRL
#define GCU_CNTRL

#include <TObject.h>
#include "uhal/uhal.hpp"


using namespace uhal;
using namespace std;

class FGCUControl: public TObject{

public: 
/* 
   returned value   -1 open not permitted
                    -2 ioctl wrong value
            vme_handle  ok some other program has  done
                        tundra programming
            vme_handle  ok this program does tundra setting

   inbound window is set firmly to 0
*/

  FGCUControl();
  virtual ~FGCUControl();


  FGCUControl(char* filename);
  HwInterface * GetDevice(char* name);
  



protected:
  ConnectionManager *manager; // --provider of data structure
	

  ClassDef(FGCUControl,1) // FIASCO: Class for storing and manipulating ADC events
};

/***************************************************************************/

#endif
