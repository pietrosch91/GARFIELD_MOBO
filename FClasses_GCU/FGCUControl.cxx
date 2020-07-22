#include <uhal/uhal.hpp>
#include <FGCUControl.h>

using namespace uhal;
using namespace std;

ClassImp(FGCUControl);

FGCUControl::FGCUControl(){
	manager=new ConnectionManager("file://connections.xml");
}

FGCUControl::FGCUControl(char* filename){
	manager=new ConnectionManager(filename);
}
 

FGCUControl::~FGCUControl(){ 
	delete manager;
}

HwInterface* FGCUControl::GetDevice(char* name){
	return new HwInterface(manager->getDevice (name));	
}
