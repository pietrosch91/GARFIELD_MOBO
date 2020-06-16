#include <uhal/uhal.hpp>

using namespace uhal;
    HwInterface *hw;
    
    void try_dispatch(){
       //execute a uhal dispatch in a try/except
         hw->dispatch();
    }
            
   void acquire_fifo_lock(){
        //acquire the lock on the 2 stage fifo
        hw->getNode("ipbus_fifo_0.ctrl.lock").write(1);
        hw->dispatch();
    }

    void release_fifo_lock(){
       // release the lock on the 2 stage fifo
       hw->getNode("ipbus_fifo_0.ctrl.lock").write(0);
       hw->dispatch();
    }

    int get_fifo_count(){
       // return the count (uhal object) of valid data
       // read cycle from ipbus daq fifo
       ValWord< uint32_t > count = hw->getNode("ipbus_fifo_0.status.count").read();
       hw->dispatch();
       return count.value();
    }

    void read_from_daq_fifo(int size,int *data){
        //read from ipbus daq fifo <size> elements
        ValVector< uint32_t > mem = hw->getNode ( "ipbus_fifo_0.data" ).readBlock (size);
        hw->dispatch();
        for(int i=0;i<size;i++) data[i]=mem[i];
    }

    int get_fifo_occupation(){
       // get the current fifo occupation
        ValWord< uint32_t > occupied = hw->getNode("ipbus_fifo_0.occupied").read();
        hw->dispatch();
        return occupied.value();
    }

    int get_fifo_control(){
        //get the control register value
        ValWord< uint32_t >  control = hw->getNode("ipbus_fifo_0.ctrl").read();
        hw->dispatch();
        return control.value();
    }


void PrintTabs(int num){
    for(int i=0;i<num;i++) printf("\t");
}

std::string GetNodePermission(HwInterface *hh,std::string aid){
    int perm=hh->getNode(aid).getPermission();
    if(perm==uhal::defs::NodePermission::WRITE) return "W";
    else if(perm==uhal::defs::NodePermission::READ) return "R";
    else return "RW";
}

std::string GetNodeMode(HwInterface *hh,std::string aid){
    int perm=hh->getNode(aid).getMode();
    if(perm==uhal::defs::BlockReadWriteMode::SINGLE) return "Single";
    else if(perm==uhal::defs::BlockReadWriteMode::INCREMENTAL) return "Incremental";
    else if(perm==uhal::defs::BlockReadWriteMode::NON_INCREMENTAL) return "Non Incremental";
    else return "HIERARCHICAL";
}

int countp(std::string inp){
    int res=0;
    for(uint i=0;i<inp.length();i++){
        if(inp[i]=='.') res++;
    }
    return res;
}

void PrintInterface(HwInterface *hh){
    std::vector<std::string> subnodes=hh->getNodes();
    printf("%s\n",hh->getNode().getId().c_str());
    for(uint i=0;i<subnodes.size();i++){
        int nlayer=countp(subnodes[i])+1;
        PrintTabs(nlayer);
        std::string nametrim=subnodes[i];
        if(nlayer>1) nametrim=subnodes[i].substr(subnodes[i].find_last_of('.')+1);
        printf("%s ( %s , %s , %8.8x)\n",nametrim.c_str(),GetNodePermission(hh,subnodes[i]).c_str(),GetNodeMode(hh,subnodes[i]).c_str(),hh->getNode(subnodes[i]).getMask());
    }
    
   
}






int main(int argc,char *argv[]){
    ConnectionManager manager ( "file://connections.xml" );
    hw=new HwInterface(manager.getDevice ("GCU1F3_1"));
    
    //Dump of memory
    PrintInterface(hw);
    
    
    
    hw->getNode("test_reg").write(123);
	hw->dispatch();
    
    ValWord< uint32_t > mem = hw->getNode ("test_reg").read();
    hw->dispatch();
    std::cout << "test_reg = " << mem.value() << std::endl;
    hw->getNode("test_reg").write(321);
	hw->dispatch();
    
   /* 
    hw->getNode("l1_cache_0.trigger_window").write(512);
    hw->dispatch();

    hw->getNode("l1_cache_0.trigger_threshold").write(10);
    hw->dispatch();
            
    hw->getNode("trigger_manager.auto_trigger_mode.trigger_path_selection").write(0);
    hw->dispatch();
    
    mem = hw->getNode ("test_reg").read();
    hw->dispatch();
    std::cout << "test_reg = " << mem.value() << std::endl;
    int size=512;
    while(true){
        hw->getNode("trigger_manager.auto_trigger_mode.force_trigger_ch0").write(1);
        hw->dispatch();
        sleep(1);
        int data[2000];
        printf("Start reading\n");
        acquire_fifo_lock();
        printf("Start reading\n");
        int occupied=get_fifo_occupation();
        printf("Fifo Occupation %d\n",occupied);
        printf("Reading Data\n");
        read_from_daq_fifo(size,data);
        for(int i=0;i<size;i++) printf("Data[%d]=%d\n",i,data[i]);
        int count=get_fifo_count();
        int control = get_fifo_control();
        release_fifo_lock();
        printf("Received Data %d\n",count);  
        getchar();
    }
    */
    
    
    
    
    
    
    hw->getNode("counter").getNode("reset_counter").write(0);
	hw->dispatch();
    
    mem = hw->getNode("counter").getNode ("read_counter").read();
    hw->dispatch();
    std::cout << "counter = " << mem.value() << std::endl;
    int answ,val;
    while(true){
        std::cout << "Next operation (0=Quit, 1=Reset, 2=Add, 3=Subtract) : ";
        std::cin >> answ;
        if(answ==0) break;
        else if(answ==1){
                hw->getNode("counter").getNode("reset_counter").write(0);
                hw->dispatch();
        }
        else if (answ==2){
              std::cout << "Increment : ";
              std::cin >> val;
              hw->getNode("counter").getNode("inc_counter").write(val);
              hw->dispatch();
        }
        else if (answ==3){
              std::cout << "Decrement : ";
              std::cin >> val;
              hw->getNode("counter").getNode("dec_counter").write(val);
              hw->dispatch();
        }
        else continue;
        
        mem = hw->getNode("counter").getNode ("read_counter").read();
        hw->dispatch();
        std::cout << "counter = " << mem.value() << std::endl;  
    
    }
    
    return 0;
}




/*

while True:
        try:
           # print "Dentro While"
            time.sleep(delay)
            data = []
            # gain lock to the second stage fifo
            my_gcu.acquire_fifo_lock()
            # get 2nd stage Fifo occupation
            occupied = my_gcu.get_fifo_occupation()
#            my_gcu.try_dispatch()
#            occupied_current = occupied.value()
           # print "OCCUPATION FIfo", occupied_current
            fifo = my_gcu.read_from_daq_fifo(size)
            count = my_gcu.get_fifo_count()
           # print "Count" , count.value()
            control = my_gcu.get_fifo_control()
            # release lock to the second stage Fifo
            my_gcu.release_fifo_lock()
            my_gcu.try_dispatch()
            data = fifo.value()  # incoming data from ipbus Fifo
            # File dump section
            list_of_lists = []
            if count.value() != 0:
                print "Received Data" , count.value()
                map(list_of_lists.append, map(get_2_words, data[:count.value()]))
                d_buf = [val for sublist in list_of_lists for val in sublist]
                # Log incoming fifo metadata
                # dump to file all the *valid* data read from ipbus Fifo
                map(outfile.write, map(add_newline, map(hex_pretty_print,
                                                        d_buf)))
                if (check_incoming_packet):
                    # # accumulate incoming data in a buffer
                    map(buf.append, d_buf)
                    # extact track/s to plot
                    while(len(buf) > BUFFER_TRESHOLD):
                        trailer_idx_a = seq_in_seq(trailer, list(buf))
                        #print "trailer_idx_a: ", trailer_idx_a
                        if not trailer_idx_a:
                            continue
                        else:
                            trailer_idx_b = seq_in_seq(
                                trailer, (list(buf)[trailer_idx_a + 10:]))
                            if not trailer_idx_b:
                                continue
                            else:
                                trailer_idx_b = trailer_idx_b + trailer_idx_a
                                data_to_plot = list(buf)[
                                    trailer_idx_a + 16: trailer_idx_b - 8]
				data_mean = int(mean(data_to_plot))
				data_std  = int(std(data_to_plot))
                                abs_time = buf[trailer_idx_a + 10]
                                trig_num = buf[trailer_idx_a + 11]
                                channel_num = buf[trailer_idx_a + 9]
                                time_stamp = []
                                time_stamp.append(buf[trailer_idx_a + 12])
                                time_stamp.append(buf[trailer_idx_a + 13])
                                time_stamp.append(buf[trailer_idx_a + 14])
                                time_stamp.append(buf[trailer_idx_a + 15])
                                time_stamp_scalar = time_stamp[0] * (2 ** (16 * 3)) + \
                                    time_stamp[1] * (2 ** (16 * 2)) + \
                                    time_stamp[2] * (2 ** (16)) + time_stamp[3]
                                if (trig_num - trig_num_old) != 1 and trig_num_old != 0:
                                    print ANSI_COLOR_RED + "-ERROR-********************************************\
                                    *******************************************************" + ANSI_COLOR_RESET
                                    # outfile.write("GCU Daq readout END: " +
                                    #              strftime("%Y-%m-%d %H:%M:%S", gmtime()) + '\n')
                                    # outfile.close()
                                    # sys.exit()
                                trig_num_old = trig_num
                        [buf.popleft() for _i in range(trailer_idx_b - 8)]
                        plot_count = plot_count + 1
                        if ((plot_count % plot_selector) == 0):
                        # remanining data into the buffer
                            if(ascii_plot_trace):
                                os.system('clear')
                            print "trailer_idx_a: ", trailer_idx_a
                            print "trailer_idx_b: ", trailer_idx_b
                            print"time_stamp_scalar:", time_stamp_scalar
		            print "Abs Time" , abs_time
                            print "trig_num:", trig_num
                            print "Channel_num:", channel_num 
                            print "BUF LEN:", len(buf)
			    print "Mean" , data_mean
			    print "Sigma", data_std
                        if(ascii_plot_trace):
                            print "Inside ASCII PLOT"
                            cfg = {}
                            cfg['height'] = 40
                            if ((plot_count % plot_selector) == 0):
                                print asciichart.plot(data_to_plot, cfg)
        except Exception as e:
            print e
            print "IPBUS ERR"
*/
