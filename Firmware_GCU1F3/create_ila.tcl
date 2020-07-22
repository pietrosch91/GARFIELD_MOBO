create_debug_core u_ila_0 ila
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_manager_1/clock_generator/clk_out5 ]]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[0]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[1]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[2]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[3]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[4]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[5]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[6]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[7]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[8]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[9]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[10]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[11]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[12]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[13]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[14]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[15]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[16]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[17]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[18]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[19]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[20]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[21]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[22]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[23]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[24]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[25]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[26]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[27]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[28]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[29]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[30]} {network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/FIFO_DATA_wr[31]} ]]
create_debug_port u_ila_0 probe
set_property port_width 16 [get_debug_ports u_ila_0/probe1]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/D_FROM_DSP[0]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/D_FROM_DSP[1]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/D_FROM_DSP[2]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/D_FROM_DSP[3]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/D_FROM_DSP[4]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/D_FROM_DSP[5]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/D_FROM_DSP[6]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/D_FROM_DSP[7]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/D_FROM_DSP[8]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/D_FROM_DSP[9]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/D_FROM_DSP[10]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/D_FROM_DSP[11]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/D_FROM_DSP[12]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/D_FROM_DSP[13]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/D_FROM_DSP[14]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/D_FROM_DSP[15]} ]]
create_debug_port u_ila_0 probe
set_property port_width 16 [get_debug_ports u_ila_0/probe2]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/D_FROM_DSP[0]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/D_FROM_DSP[1]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/D_FROM_DSP[2]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/D_FROM_DSP[3]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/D_FROM_DSP[4]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/D_FROM_DSP[5]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/D_FROM_DSP[6]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/D_FROM_DSP[7]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/D_FROM_DSP[8]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/D_FROM_DSP[9]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/D_FROM_DSP[10]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/D_FROM_DSP[11]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/D_FROM_DSP[12]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/D_FROM_DSP[13]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/D_FROM_DSP[14]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/D_FROM_DSP[15]} ]]
create_debug_port u_ila_0 probe
set_property port_width 8 [get_debug_ports u_ila_0/probe3]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspsim/idma_sim/address[0]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspsim/idma_sim/address[1]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspsim/idma_sim/address[2]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspsim/idma_sim/address[3]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspsim/idma_sim/address[4]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspsim/idma_sim/address[5]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspsim/idma_sim/address[6]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspsim/idma_sim/address[7]} ]]
create_debug_port u_ila_0 probe
set_property port_width 8 [get_debug_ports u_ila_0/probe4]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/rcnt[0]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/rcnt[1]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/rcnt[2]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/rcnt[3]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/rcnt[4]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/rcnt[5]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/rcnt[6]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/rcnt[7]} ]]
create_debug_port u_ila_0 probe
set_property port_width 16 [get_debug_ports u_ila_0/probe5]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/DSP_IAD_int[0]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/DSP_IAD_int[1]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/DSP_IAD_int[2]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/DSP_IAD_int[3]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/DSP_IAD_int[4]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/DSP_IAD_int[5]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/DSP_IAD_int[6]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/DSP_IAD_int[7]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/DSP_IAD_int[8]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/DSP_IAD_int[9]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/DSP_IAD_int[10]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/DSP_IAD_int[11]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/DSP_IAD_int[12]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/DSP_IAD_int[13]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/DSP_IAD_int[14]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/DSP_IAD_int[15]} ]]
create_debug_port u_ila_0 probe
set_property port_width 8 [get_debug_ports u_ila_0/probe6]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/rcnt[0]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/rcnt[1]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/rcnt[2]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/rcnt[3]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/rcnt[4]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/rcnt[5]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/rcnt[6]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/rcnt[7]} ]]
create_debug_port u_ila_0 probe
set_property port_width 16 [get_debug_ports u_ila_0/probe7]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/DSP_IAD_int[0]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/DSP_IAD_int[1]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/DSP_IAD_int[2]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/DSP_IAD_int[3]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/DSP_IAD_int[4]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/DSP_IAD_int[5]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/DSP_IAD_int[6]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/DSP_IAD_int[7]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/DSP_IAD_int[8]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/DSP_IAD_int[9]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/DSP_IAD_int[10]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/DSP_IAD_int[11]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/DSP_IAD_int[12]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/DSP_IAD_int[13]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/DSP_IAD_int[14]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/DSP_IAD_int[15]} ]]
create_debug_port u_ila_0 probe
set_property port_width 8 [get_debug_ports u_ila_0/probe8]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspsim/idma_sim/address[0]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspsim/idma_sim/address[1]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspsim/idma_sim/address[2]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspsim/idma_sim/address[3]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspsim/idma_sim/address[4]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspsim/idma_sim/address[5]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspsim/idma_sim/address[6]} {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspsim/idma_sim/address[7]} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/DSP_AD_bit} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/DSP_AD_bit} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list network_interface_i/payload_1/ipbus_subsys_i/ipbus_merge/ipbus_slave_1/fifo_wr ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/fifo_wr_en} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/fifo_wr_en} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/nIACK} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/nIACK} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/nIAL} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/nIAL} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe18]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[0].dspiface/dsp_cntrl/nRD_int} ]]
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe19]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/gen_dsp[1].dspiface/dsp_cntrl/nRD_int} ]]
