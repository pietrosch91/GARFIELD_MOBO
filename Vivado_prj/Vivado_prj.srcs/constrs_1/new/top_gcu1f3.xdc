

create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_manager_1/clock_generator/clk_out5]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 16 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/DSP_IAD_int[0]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/DSP_IAD_int[1]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/DSP_IAD_int[2]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/DSP_IAD_int[3]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/DSP_IAD_int[4]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/DSP_IAD_int[5]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/DSP_IAD_int[6]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/DSP_IAD_int[7]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/DSP_IAD_int[8]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/DSP_IAD_int[9]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/DSP_IAD_int[10]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/DSP_IAD_int[11]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/DSP_IAD_int[12]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/DSP_IAD_int[13]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/DSP_IAD_int[14]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/DSP_IAD_int[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 8 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/rcnt[0]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/rcnt[1]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/rcnt[2]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/rcnt[3]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/rcnt[4]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/rcnt[5]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/rcnt[6]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/rcnt[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 16 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/D_FROM_DSP[0]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/D_FROM_DSP[1]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/D_FROM_DSP[2]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/D_FROM_DSP[3]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/D_FROM_DSP[4]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/D_FROM_DSP[5]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/D_FROM_DSP[6]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/D_FROM_DSP[7]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/D_FROM_DSP[8]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/D_FROM_DSP[9]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/D_FROM_DSP[10]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/D_FROM_DSP[11]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/D_FROM_DSP[12]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/D_FROM_DSP[13]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/D_FROM_DSP[14]} {network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/D_FROM_DSP[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 8 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {network_interface_i/payload_1/ipbus_subsys_i/dspsim1/idma_sim/address[0]} {network_interface_i/payload_1/ipbus_subsys_i/dspsim1/idma_sim/address[1]} {network_interface_i/payload_1/ipbus_subsys_i/dspsim1/idma_sim/address[2]} {network_interface_i/payload_1/ipbus_subsys_i/dspsim1/idma_sim/address[3]} {network_interface_i/payload_1/ipbus_subsys_i/dspsim1/idma_sim/address[4]} {network_interface_i/payload_1/ipbus_subsys_i/dspsim1/idma_sim/address[5]} {network_interface_i/payload_1/ipbus_subsys_i/dspsim1/idma_sim/address[6]} {network_interface_i/payload_1/ipbus_subsys_i/dspsim1/idma_sim/address[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 1 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/DSP_AD_bit]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/fifo_wr_en]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/nIACK]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/nIAL]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list network_interface_i/payload_1/ipbus_subsys_i/dspiface1/dsp_cntrl/nRD_int]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets cdrclk_o_3125]
