
#create_clock -period 8.000 -name sys_board_clk [get_ports board_clk]
#set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets board_clk]


create_clock -period 2.000 -name  adca_c0 [get_ports adca_dclkp[0]]
create_clock -period 2.000 -name  adca_c1 [get_ports adca_dclkp[1]]
create_clock -period 2.000 -name  adca_c2 [get_ports adca_dclkp[2]]



create_clock -period 2.000 -name  adcb_c0 [get_ports adcb_dclkp[0]]
create_clock -period 2.000 -name  adcb_c1 [get_ports adcb_dclkp[1]]
create_clock -period 2.000 -name  adcb_c2 [get_ports adcb_dclkp[2]]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets adca_dclkp[0]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets adca_dclkp[1]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets adca_dclkp[2]]


set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets adcb_dclkp[0]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets adcb_dclkp[1]]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets adcb_dclkp[2]]

#set_property LOC BUFMRCE_X0Y11 [get_cells adu_instances[0].adu_top_wrapper_1/adu_top_1/adca_top_i/ddr_8to1_16chan_rx_proc[0].chan_rx/rx_clk_bufmrce]
