#include <uhal/uhal.hpp>

#include <sys/types.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/file.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <sys/time.h>
#include <math.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <unistd.h>

#define DIAG    if (verbose) printf
#define DIAGV	if (verbose) printf

#define PORTGCU   3512

#define TEST_IDMA


using namespace uhal;
using namespace std;


//static int l_loop = 0;

uint32_t readreg;

int deepest_layer;

int verbose =0;
/* socket definitions */
int sd=0;
int ns=0; 
int nw=0; //for writing in tastiera mode....

int max_buf_sock;
char buff[256];


int GetParent(string pname);

int countp(std::string inp){
    int res=0;
    for(uint i=0;i<inp.length();i++){
        if(inp[i]=='.') res++;
    }
    return res;
}

void PrintTabs(int num){
    for(int i=0;i<num;i++) printf("\t");
}


std::string GetNodePermission(int idP){
    int perm=idP;
    if(perm==uhal::defs::NodePermission::WRITE) return "W";
    else if(perm==uhal::defs::NodePermission::READ) return "R";
    else return "RW";
}

std::string GetNodeMode(int idP){
    int perm=idP;
    if(perm==uhal::defs::BlockReadWriteMode::SINGLE) return "Single";
    else if(perm==uhal::defs::BlockReadWriteMode::INCREMENTAL) return "Incremental";
    else if(perm==uhal::defs::BlockReadWriteMode::NON_INCREMENTAL) return "Non Incremental";
    else return "HIERARCHICAL";
}

class NodeData{
private:
    string NodeID;
    string lastID;
    int number_sons;
    int parent;
    int size;
    int BSIZE;
    int layer;
    int intID;
    int RW; 
    int MODE;
    uint32_t MASK;
public: 
    string getINFO(){
        char res[2000];
        sprintf(res,"%s %d %d %d %d %d %d %d %u %d\n",lastID.c_str(),intID,parent,size,layer,number_sons,RW,MODE,MASK,BSIZE);
        return string(res);
    }
        
    
    string getID(){
        return NodeID;
    }
    
    bool checkID(string id){
        return (!strcmp(id.c_str(),NodeID.c_str()));
    }
    
    void AddSon(){
        number_sons++;
    }
    
    bool has_sons(){
        return number_sons!=0;
    }
    
    bool is_writeable(){
        return (RW==uhal::defs::NodePermission::WRITE) || (RW==uhal::defs::NodePermission::READWRITE);
    }
    
    bool is_readable(){
        return (RW==uhal::defs::NodePermission::READ) || (RW==uhal::defs::NodePermission::READWRITE);
    }
    
    bool is_single(){
        return MODE==uhal::defs::BlockReadWriteMode::SINGLE;
    }
    
     bool is_inc(){
        return MODE==uhal::defs::BlockReadWriteMode::INCREMENTAL;
    }
    
    bool is_port(){
         return MODE==uhal::defs::BlockReadWriteMode::NON_INCREMENTAL;
    }
    
    bool is_managed(){
        return is_single() || is_inc();
    }
    
    int getSize(){
        return size;
    }
    
    int getParent(){
        return parent;
    }
    
    int getLayer(){
        return layer;
    }
    
    void addSize(int vv){
        size+=vv;
    }
    
    NodeData(HwInterface *h,string nodeid,int ID){
        BSIZE=0;
        NodeID=nodeid;
        lastID=nodeid.substr(nodeid.find_last_of('.')+1);
        number_sons=0;
        intID=ID;
        RW=h->getNode(nodeid).getPermission();
        MODE=h->getNode(nodeid).getMode();
        if(is_inc()){
            BSIZE=(uint32_t)h->getNode(nodeid).getSize();
        }
        MASK=h->getNode(nodeid).getMask();
        layer=countp(nodeid);
        if(layer>deepest_layer) deepest_layer=layer;
        if(layer==0) {
            parent=-1;
            size=0;
        }
        else{
            parent=GetParent(nodeid.substr(0,nodeid.find_last_of('.')));        
            size=1;
        }
    }
    
    void Print(){
        PrintTabs(layer);
        if(parent>=0){
            printf("[%d]%s ( %s , %s , %8.8x, bsize=%d) Nsons=%d, Parent=%d Size=%d Layer=%d\n",intID,lastID.c_str(),GetNodePermission(RW).c_str(),GetNodeMode(MODE).c_str(),MASK,BSIZE,number_sons,parent,size,layer);
        }
        else{
            printf("[%d]%s ( %s , %s , %8.8x, bsize=%d) Nsons=%d Size=%d Layer=%d\n",intID,lastID.c_str(),GetNodePermission(RW).c_str(),GetNodeMode(MODE).c_str(),MASK,BSIZE,number_sons,size,layer);
        }
    }
};

NodeData **nd;
int NodeCount;



int GetParent(string pname){
    for(int i=0;i<NodeCount;i++){
        if(nd[i]->checkID(pname)){
            nd[i]->AddSon();
            return i;
        }
    }    
    return -1;
}

int GetNodeID(string pname){
    for(int i=0;i<NodeCount;i++){
        if(nd[i]->checkID(pname)){
           return i;
        }
    }    
    return -1;
}

int OpWrite(HwInterface *h,int nodeID,uint32_t value){
    if(nd[nodeID]->has_sons()){
        printf("Register is not Writeable");
        return-1;
    }
    if(!nd[nodeID]->is_writeable()){
        printf("Register is not Writeable");
        return-1;
    }
    if(!nd[nodeID]->is_managed()){
        printf("Not able of handling non-single registers");
        return-1;
    }
    h->getNode(nd[nodeID]->getID()).write(value);
    h->dispatch();
    return 0;
}

int OpWrite_BLK(HwInterface *h,int nodeID,int Size,uint32_t *values){
    if(nd[nodeID]->has_sons()){
        printf("Register is not Writeable");
        return-1;
    }
    if(!nd[nodeID]->is_writeable()){
        printf("Register is not Writeable");
        return-1;
    }
    if(!nd[nodeID]->is_managed()){
        printf("Not able of handling non-single registers");
        return-1;
    }
    std::vector<uint32_t> dt;
    for(int i=0;i<Size;i++) dt.push_back(values[i]);
    h->getNode(nd[nodeID]->getID()).writeBlock(dt);
    h->dispatch();
    return 0;
}


int OpRead(HwInterface *h,int nodeID){
    if(nd[nodeID]->has_sons()){
        printf("Register is not Readable\n");
        return -1;
    }
    if(!nd[nodeID]->is_readable()){
        printf("Register is not Readable\n");
        return -1;
    }
    if(!nd[nodeID]->is_managed()){
        printf("Not able of handling non-single registers\n");
        return -1;
    }
    ValWord< uint32_t > mem = h->getNode (nd[nodeID]->getID()).read();
    h->dispatch();
    printf("Register %s value = %u\n",nd[nodeID]->getID().c_str(),mem.value());
    readreg=mem.value();
//    return mem.value();
    return 0;
}

int OpRead_BLK(HwInterface *h,int nodeID,int Size,std::vector<uint32_t> *values){
     if(nd[nodeID]->has_sons()){
        printf("Register is not Readable\n");
        return -1;
    }
    if(!nd[nodeID]->is_readable()){
        printf("Register is not Readable\n");
        return -1;
    }
    if(!nd[nodeID]->is_managed()){
        printf("Not able of handling non-single registers\n");
        return -1;
    }
    ValVector< uint32_t > mem = h->getNode (nd[nodeID]->getID()).readBlock(Size);
    h->dispatch();
    values->clear();
    for(int i=0;i<Size;i++) values->push_back(mem[i]);
    return 0;
}
    
#ifdef TEST_IDMA
int IDMA_BASEADD;
#define BUS 1
#define nWR 3
#define nRD 4
#define nIAL 5
#define nIS 6
#define nIACK 7
#define LOCK 8
#define ADDR 9
#define IDMA(c) IDMA_BASEADD+c

void SetIDMAAddress(HwInterface *h,uint32_t addr){
        //Acquire lock
        OpWrite(h,IDMA(LOCK),1);
        //Enable chip select
        OpWrite(h,IDMA(nIS),0);
        //wait IACK low
        OpRead(h,IDMA(nIACK));
        while(readreg==1){
            OpRead(h,IDMA(nIACK));
        }
        //Set Address and start IAL
        OpWrite(h,IDMA(BUS),addr);
        OpWrite(h,IDMA(nIAL),0);
        usleep(20);
        //release IAL,chip select and lock
        OpWrite(h,IDMA(nIAL),1);
        OpWrite(h,IDMA(nIS),1);
        OpWrite(h,IDMA(LOCK),0);
        //Verify address
        usleep(10);
        OpRead(h,IDMA(ADDR));
        if(readreg==addr) printf("Address latch successfull\n");
}


void WriteIDMA(HwInterface *h,uint32_t size,std::vector<uint32_t> data){
        //Acquire lock
        OpWrite(h,IDMA(LOCK),1);
        //Enable chip select
        OpWrite(h,IDMA(nIS),0);
        for(uint i=0;i<size;i++){
            //wait IACK low
            OpRead(h,IDMA(nIACK));
            while(readreg==1){
                OpRead(h,IDMA(nIACK));
            }
            //Set data and start WR
            OpWrite(h,IDMA(BUS),data[i]);
            OpWrite(h,IDMA(nWR),0);
            usleep(20);
            //close WR cicle
            OpWrite(h,IDMA(nWR),1);
        }
        //release select and lock
        OpWrite(h,IDMA(nIS),1);
        OpWrite(h,IDMA(LOCK),0);       
}

void IDMAInit(HwInterface *h,uint32_t size){
    SetIDMAAddress(h,0);
    std::vector<uint32_t> data;
    for(uint i=0;i<size;i++)data.push_back(i+1);
    WriteIDMA(h,size,data);
    SetIDMAAddress(h,0);
}

void ReadIDMA(HwInterface *h,uint32_t size,std::vector<uint32_t> *data){
        //Acquire lock
        OpWrite(h,IDMA(LOCK),1);
        //Enable chip select
        OpWrite(h,IDMA(nIS),0);
        data->clear();
        for(uint i=0;i<size;i++){
            //wait IACK low
            OpRead(h,IDMA(nIACK));
            while(readreg==1){
                OpRead(h,IDMA(nIACK));
            }
            //Read data
            OpRead(h,IDMA(BUS));
            data->push_back(readreg);
            //simulate read cicle
            OpWrite(h,IDMA(nRD),0);
            usleep(20);
            //close WR cicle
            OpWrite(h,IDMA(nRD),1);
        }
        //release select and lock
        OpWrite(h,IDMA(nIS),1);
        OpWrite(h,IDMA(LOCK),0);       
}

//IDMA test through interface
//operation
#define IDMA_IAL 0x3
#define IDMA_WR  0x5
#define IDMA_RD  0x6

int IDMA_I_BASE;
#define IDMA_DATA_ADDR 2 
#define IDMA_OPCODE 3
#define IDMA_CMD_VALID 4
#define IDMA_DATA_READ 12
#define IDMA_I(c) IDMA_I_BASE+c


void SetIDMAAddress_I(HwInterface *h,uint32_t addr){
        //Release lock
        OpWrite(h,IDMA(LOCK),0);
        //Write addr and opcode
        OpWrite(h,IDMA_I(IDMA_DATA_ADDR),addr);
        OpWrite(h,IDMA_I(IDMA_OPCODE),IDMA_IAL);
        //Start op
        OpWrite(h,IDMA_I(IDMA_CMD_VALID),1);
        usleep(1);
        //End op
        OpWrite(h,IDMA_I(IDMA_CMD_VALID),0);
}

void WriteIDMA_I(HwInterface *h,uint32_t size,std::vector<uint32_t> data){
        //Release lock
        OpWrite(h,IDMA(LOCK),0);
        //Write
        OpWrite(h,IDMA_I(IDMA_OPCODE),IDMA_WR);
        for(uint i=0;i<size;i++){
            //Set data and start op
            OpWrite(h,IDMA_I(IDMA_DATA_ADDR),data[i]);
            OpWrite(h,IDMA_I(IDMA_CMD_VALID),1);
            usleep(1);
            //close WR cicle
            OpWrite(h,IDMA_I(IDMA_CMD_VALID),0);
        }        
}

void ReadIDMA_I(HwInterface *h,uint32_t size,std::vector<uint32_t> *data){
        //Release lock
        OpWrite(h,IDMA(LOCK),0);
        data->clear();
        //Write
        OpWrite(h,IDMA_I(IDMA_OPCODE),IDMA_RD);        
        for(uint i=0;i<size;i++){
            OpWrite(h,IDMA_I(IDMA_CMD_VALID),1);
            usleep(1);
            OpRead(h,IDMA_I(IDMA_DATA_READ));
            data->push_back(readreg);
            OpWrite(h,IDMA_I(IDMA_CMD_VALID),0);
        }        
}

void IDMAInit_I(HwInterface *h,uint32_t size){
    SetIDMAAddress_I(h,0);
    std::vector<uint32_t> data;
    for(uint i=0;i<size;i++)data.push_back(i+1);
    WriteIDMA_I(h,size,data);
    SetIDMAAddress_I(h,0);
}
#endif





/* ********************** */
/* *****INPUT-OUTPUT***** */
/* *******FUNCTIONS****** */
/* ********************** */

void sd_scanf(int ns_qui,char* buffer){
     int i,ngetdata;
     DIAGV("Entro in sd_scanf: ns_qui=%d\n",ns_qui);
     buffer[0] = 0;
      i = ngetdata = 0;
     fflush(stdout);
     for(;;){
		while (ngetdata <= 0){
			errno = 0;
            		ngetdata = read(ns_qui,&buffer[i],1);
			DIAGV("ngetdat=%d\n",ngetdata);
            		if(errno)DIAGV("sd_scanf: errno=%d reading from ns_cs\n",errno);
	}
		DIAGV("%2.2x ",(unsigned char)buffer[i]);
		if(buffer[i] == '\n') break;
		ngetdata = 0;
		i++;
     }
     buffer[i]=0;
     DIAGV("\n scanf: buffer = %s\n",buffer);
     DIAGV("sd_scanf: esco con buffer=%s\n\n",buffer);
}

void sd_printf(int ns_qui, char* buffer){
	int i,ndata;
 
    DIAGV("Entro in sd_printf: ns_qui=%d buffer=%s\n",ns_qui,buffer);
    i = ndata = 0;
    fflush(stdout);
    i = ndata = 0;
    for(;;){
		while (ndata <= 0){
			errno = 0;
            ndata = write(ns_qui,&buffer[i],1);
	        if(errno) DIAGV("\nsd_printf: errno = %d buffer=%s i=%d\n",errno,buffer,i);
	   }
	   DIAGV("%2.2x ",(unsigned char)buffer[i]);
       if(buffer[i] == '\n') break;
       ndata = 0;
       i++;
	}
    DIAGV("\nsd_printf: buffer=%s\n",buffer); 
    DIAGV("sd_printf: esco con buffer=%s\n",buffer);
} 
    
    
    
    
    
    
int main(int argc,char *argv[]){
    ConnectionManager manager ( "file://connections.xml" );
    HwInterface *hw=new HwInterface(manager.getDevice ("GCU1F3_1"));
    deepest_layer=0;
    
    vector<string> thenodes=hw->getNodes();
    int totnodes=thenodes.size();
    NodeCount=0;
    nd=new NodeData*[totnodes];
    for(int i=0;i<totnodes;i++){
        nd[i]=new NodeData(hw,thenodes[i],i);
        NodeCount++;
    }
    for(int i=deepest_layer;i>0;i--){
        for(int j=0;j<NodeCount;j++){
            if(nd[j]->getLayer()==i) nd[nd[j]->getParent()]->addSize(nd[j]->getSize());
        }
    }
    
    for(int i=0;i<NodeCount;i++) nd[i]->Print();
    
#ifdef TEST_IDMA
    IDMA_BASEADD=GetNodeID("dsp_sim");
    cout<<"IDMA_BASEADD "<<IDMA_BASEADD<<"\n";
#endif
    
    //int value;
	char stringa[80];
	int iopt;  
    int IDREG;
    uint32_t REGVAL;
    uint32_t REGBLK[200];
    int REGSIZE;
	
   // extern void exit_loop();
	
    char command[32];
	int listening;
    
    /*socket handling*/
    struct sockaddr sockaddr; 
	struct sockaddr_in name_in;
	struct sockaddr *name;
	socklen_t fromlen=0;

    printf("STATUS: You are running: source=GCU_server.cxx  exe=GCU_server\n");
  
	iopt = 1;
	while (iopt < argc)  {
		char option[12];
		int  numjob;
 
		sscanf(argv[iopt++],"%s",option);
		DIAG("STATUS: option=%s\n",option);
		if (!strcmp(option,"-verbose")){//enables debug
			verbose = 1;
		}
		if (!strcmp(option,"-h")) {//Help
           printf("USAGE: GCU_server [-socket PORT]  [-verbose] \n");
           exit(1);
		}

		if (!strcmp(option,"-socket")){
			struct  hostent *hostent;
			char hostname[80];
			sscanf(argv[iopt++],"%d",&numjob);
			if (numjob == PORTGCU) { /* andrebbe reso automatico!! */
				gethostname(hostname,sizeof(hostname));
				hostent = gethostbyname(hostname);
				printf("%x\n", *(int*)(hostent->h_addr));
				name_in.sin_addr.s_addr = htonl(INADDR_ANY);  
			}
			else{
				printf("ERROR: port number wrong ; no connection \n");
				exit(1);
			}
			name_in.sin_port = htons(numjob);  
			printf("STATUS: addr=0x%08x port=%d\n",name_in.sin_addr,numjob);
			name_in.sin_family = AF_INET;
			errno = 0; 
			name = (struct sockaddr *)&name_in;
			sd = socket(AF_INET,SOCK_STREAM,0);
			max_buf_sock = 32*1024;
			{
				int on=1;
				setsockopt(sd,SOL_SOCKET,SO_REUSEADDR,&on,sizeof(on));
			}
			errno = 0;
			while (bind(sd,name,16) == -1){
				if (errno != 48){
					perror("bind:\n");
					exit(1);
				}
			}
			listen(sd,1);
			errno = 0;
			{
				//int pid;
				ns = 0;
				errno = 0;
				while ( ns <= 0) {
				   printf("prima di accept\n");
				   printf("sd=%d %d\n",sd,fromlen);
				   ns = accept(sd,&sockaddr,&fromlen);
				   perror("accept\n");
				   printf("dopo accept ns=%d\n",ns);
				}			   
			}
			printf("STATUS: Accepting commands from socket ns=%d sd=%d\n",ns,sd);
		}
	}

    
	if(!ns) printf("STATUS: Accepting commands from keyboard \n");
	
	nw=ns;
	if(nw==0) nw=1; //std output....
	
    //signal(SIGINT,(void *)exit_loop);

	errno = 0;
    
    //loop di ascolto
    printf("\nSTATUS: -----------READY-----------\n");
	listening = 1;
	while(listening){ //Main loop
		//PrintCommands();
		sd_scanf(ns,buff);
		sscanf(buff,"\n%[^\n]",stringa);
		sscanf(stringa,"%s",command);
		printf("INPUT: %s\n",stringa);
		//int net_id;
        
        if(!strcmp(command,"WRITE")){
            sscanf(stringa,"%s %d %u",command,&IDREG,&REGVAL);
            OpWrite(hw,IDREG,REGVAL);
        }
        
        if(!strcmp(command,"WRITEBLK")){
            sscanf(stringa,"%s %d %d",command,&IDREG,&REGSIZE);
            int nmax=REGSIZE;
            std::istringstream iss(stringa);
            iss>>command>>IDREG>>REGSIZE;
            for(int i=0;i<nmax;i++) iss>> REGBLK[i];
            OpWrite_BLK(hw,IDREG,REGSIZE,REGBLK);
        }
        
        else if(!strcmp(command,"READ")){
            sscanf(stringa,"%s %d",command,&IDREG);
            OpRead(hw,IDREG);
            sprintf(buff,"%u\n",readreg); sd_printf(nw,buff); 
        }
         else if(!strcmp(command,"READBLK")){
            sscanf(stringa,"%s %d %d",command,&IDREG,&REGSIZE);
            std::vector<uint32_t> data;
            OpRead_BLK(hw,IDREG,REGSIZE,&data);
            for(int i=0;i<REGSIZE;i++) std::cout<<data[i]<<"\n";
            sprintf(buff,"%u",data[0]);
            for(int i=1;i<REGSIZE;i++) sprintf(buff,"%s %u",buff,data[i]);
            sprintf(buff,"%s\n",buff);
            sd_printf(nw,buff); 
            //sprintf(buff,"%u\n",readreg); sd_printf(nw,buff); 
        }
        else if(!strcmp(command,"NC")){
            sprintf(buff,"%d\n",NodeCount); sd_printf(nw,buff); 
        }
        else if(!strcmp(command,"NI")){
            sscanf(stringa,"%s %d",command,&IDREG);
            sprintf(buff,"%s",nd[IDREG]->getINFO().c_str()); sd_printf(nw,buff); 
        }
        else if(!strcmp(command,"EOR"))  {
			printf("\n\nSTATUS ...invio EOR_VME...\n\n");
            sprintf(buff,"EOR_VME\n"); sd_printf(nw,buff); 
		}
		else if(!strcmp(command,"PRINT"))  {
             for(int i=0;i<NodeCount;i++) nd[i]->Print();
        }
		else if(!strcmp(command,"quit")) listening= 0;
		else if(!strcmp(command,"exit")) listening= 0;
		else if(!strcmp(command,"bye"))  listening= 0;
		else if(!strcmp(command,"die"))  listening= 0;
#ifdef TEST_IDMA
        else if(!strcmp(command,"IAL")){
            sscanf(stringa,"%s %d",command,&IDREG);
            SetIDMAAddress(hw,IDREG);
        }
        else if(!strcmp(command,"IWR")){
            sscanf(stringa,"%s %d",command,&REGSIZE);
            std::vector<uint32_t> data;
            int nmax=REGSIZE;
            std::istringstream iss(stringa);
            iss>>command>>REGSIZE;
            for(int i=0;i<nmax;i++){
                iss>> IDREG;
                data.push_back(IDREG);
            }            
            WriteIDMA(hw,(uint32_t)nmax,data);
        }
        else if(!strcmp(command,"IRD")){
            sscanf(stringa,"%s %d",command,&REGSIZE);
            std::vector<uint32_t> data;
            ReadIDMA(hw,REGSIZE,&data);
            for(int i=0;i<REGSIZE;i++) std::cout<<data[i]<<"\n";
        }
        else if(!strcmp(command,"IINIT")){
            IDMAInit(hw,256);
        }
        else if(!strcmp(command,"IAL_I")){
            sscanf(stringa,"%s %d",command,&IDREG);
            SetIDMAAddress_I(hw,IDREG);
        }
        else if(!strcmp(command,"IWR_I")){
            sscanf(stringa,"%s %d",command,&REGSIZE);
            std::vector<uint32_t> data;
            int nmax=REGSIZE;
            std::istringstream iss(stringa);
            iss>>command>>REGSIZE;
            for(int i=0;i<nmax;i++){
                iss>> IDREG;
                data.push_back(IDREG);
            }            
            WriteIDMA_I(hw,(uint32_t)nmax,data);
        }
        else if(!strcmp(command,"IRD_I")){
            sscanf(stringa,"%s %d",command,&REGSIZE);
            std::vector<uint32_t> data;
            ReadIDMA_I(hw,REGSIZE,&data);
            for(int i=0;i<REGSIZE;i++) std::cout<<data[i]<<"\n";
        }
        else if(!strcmp(command,"IINIT_I")){
            IDMAInit_I(hw,256);
        }
#endif        
    }
    close(ns);
}
       /* 
        
        
        
        
    
    
    int answ,val,id;
    while(true){
        std::cout << "Next operation (0=Quit, 1=Read, 2=Write) : ";
        std::cin >> answ;
        if(answ==0) break;
        std::cout << "Register ID :";
        std::cin >> id;
        if(answ==2){
            std::cout << "Value to Write :";
            std::cin >> val;
            OpWrite(hw,id,val);
        }
        else if(answ==1){
            OpRead(hw,id);
        }        
        else continue;   
    }
    
    return 0;
}

*/


