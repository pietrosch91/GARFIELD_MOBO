#Define target part and create output directory
set partNum xc7k325tffg900-2
set outputDir ./results
set topentityname top_gcu1f3
set bitstreamname_01 firmware_01.bit
set bitstreamname_02 firmware_02.bit
set bitstreamname_03 firmware_03.bit
set flash_bitstreamname firmware.mcs
file mkdir $outputDir


# IPBUS core controller related source files
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/ipbus_package.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/ipbus_fabric_sel.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/ipbus_trans_decl.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_ipaddr_block.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_rarp_block.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_build_arp.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_build_payload.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_build_ping.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_build_resend.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_build_status.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_status_buffer.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_byte_sum.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_do_rx_reset.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_packet_parser.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_rxram_mux.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_dualportram.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_buffer_selector.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_rxram_shim.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_dualportram_rx.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_dualportram_tx.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_rxtransactor_if_simple.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_tx_mux.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_txtransactor_if_simple.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_clock_crossing_if.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/udp_if_flat.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/trans_arb.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/transactor_if.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/transactor_sm.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/transactor_cfg.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/transactor.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/ipbus_ctrl.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_core/firmware/hdl/ipbus_shim.vhd

# ipbus demo slavess
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_slaves/firmware/hdl/ipbus_reg_types.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_slaves/firmware/hdl/ipbus_ctrlreg_v.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_slaves/firmware/hdl/ipbus_reg_v.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_slaves/firmware/hdl/ipbus_ram.vhd
read_vhdl -library usrDefLib externals/ipbus-firmware/components/ipbus_slaves/firmware/hdl/ipbus_peephole_ram.vhd

# ipbus infrastructure
read_vhdl -library usrDefLib src/user/ipbus_utils/payload.vhd
read_vhdl -library usrDefLib src/user/ipbus_utils/ipbus_subsys.vhd
read_vhdl -library usrDefLib src/user/ipbus_utils/ipbus_decode_gcu1f3.vhd
read_vhdl -library usrDefLib src/user/ipbus_utils/ipbus_debug.vhd

# ipbus DAQ slave
read_vhdl -library usrDefLib [glob src/user/ipbus_daq/*.vhd]

# ipbus DSP simulator
read_vhdl -library usrDefLib [glob src/user/ipbus_dspsim/*.vhd]

# ipbus DSP interface
read_vhdl -library usrDefLib [glob src/user/ipbus_dsp_interface/*.vhd]

# ipbus data merge
read_vhdl -library usrDefLib [glob src/user/ipbus_data_merge/*.vhd]

# ipbus DSP loader
read_vhdl -library usrDefLib [glob src/user/ipbus_dsp_loader/*.vhd]

#ipbus DSP readout
read_vhdl -library usrDefLib [glob src/user/ipbus_dsp_readout/*.vhd]

#ipbus Trigger manager
read_vhdl -library usrDefLib [glob src/user/ipbus_trigger_manager/*.vhd]

#ipbus Test Register and counter
read_vhdl -library usrDefLib [glob src/user/ipbus_test/*.vhd]

# ipbus read only registers
read_vhdl -library usrDefLib src/user/ipbus_utils/ipbus_fw_data.vhd

# ipbus ADU manager
read_vhdl -library usrDefLib [glob src/user/ipbus_adu_manager/*.vhd]

#ipbus interface for Data Assembly
read_vhdl -library usrDefLib [glob src/user/ipbus_data_assembly/*.vhd]

#ipbus gpios
read_vhdl -library usrDefLib [glob src/user/ipbus_gpio/*.vhd]

# synch link sources
read_vhdl -library usrDefLib  [glob src/user/synch/*vhd]

# ADU source files
#vhdl wrapper and the verilog code below
read_vhdl    -library usrDefLib src/tsinghua/adu_top/src/adu_top_wrapper.vhd
read_verilog -library usrDefLib src/tsinghua/adu_top/src/ADU_top.v
read_verilog -library usrDefLib src/tsinghua/adu_top/src/ADC/adc_top.v
read_verilog -library usrDefLib src/tsinghua/adu_top/src/ADC/adc_config.v
read_verilog -library usrDefLib src/tsinghua/adu_top/src/ADC/iserdes_iodelay/DDR_8TO1_16CHAN_RX_GCU.v
read_verilog -library usrDefLib src/tsinghua/adu_top/src/ADC/iserdes_iodelay/RESOURCE_SHARING_CONTROL.v
read_verilog -library usrDefLib src/tsinghua/adu_top/src/dac_pll_config/pll_config.v

#vhdl wrapper and the verilog code below
read_vhdl    -library usrDefLib src/tsinghua/adu_top/src/dac_pll_config/dac_config_wrapper.vhd
read_verilog -library usrDefLib src/tsinghua/adu_top/src/dac_pll_config/dac_config.v
read_verilog -library usrDefLib src/tsinghua/adu_top/src/element/Flag_CrossDomain.v
read_verilog -library usrDefLib src/tsinghua/adu_top/src/element/Signal_CrossDomain.v
read_verilog -library usrDefLib src/tsinghua/adu_top/src/element/SimpleSPIMaster.v


#import_ip -files {../fifo_prj/fifo_prj.srcs/sources_1/ip/channel_fifo/}


#VHDL  source files
read_vhdl -library usrDefLib [ glob src/eth_mac/*.vhd ]
read_vhdl -library usrDefLib [ glob src/user/*.vhd ]

#picoblaze hardocoded rom
read_vhdl -library usrDefLib src/picoblaze/asm/rom.vhd

#include the pre-synthesized ethernet ip core
read_checkpoint src/ip_cores/eth_ip/tri_mode_ethernet_mac_0.dcp
read_checkpoint src/ip_cores/mac_fifo_axi4/mac_fifo_axi4.dcp
# IP cores for the Data Assembly module
read_checkpoint src/ip_cores/data_channel_fifo/data_channel_fifo.dcp
#read_checkpoint .srcs/sources_1/ip/channel_fifo/channel_fifo.dcp
read_ip ../fifo_prj/fifo_prj.srcs/sources_1/ip/channel_fifo/channel_fifo.xci
read_ip ../fifo_prj/fifo_prj.srcs/sources_1/ip/global_fifo/global_fifo.xci

read_checkpoint src/ip_cores/trig_latency/trig_latency_fifo.dcp

#Run Synthesis
synth_design -top $topentityname   -part $partNum
write_checkpoint -force $outputDir/post_synth.dcp

# add ila core
source  create_ila.tcl

#report_timing_summary -file $outputDir/post_synth_timing_summary.rpt
#report_utilization -file $outputDir/post_synth_util.rpt
# constraints
#read_xdc [glob src/constraints/*.xdc]
source  src/constraints/board_costraints.tcl
source  src/constraints/adu_pinout.tcl
#source  timing_constr.tcl
#clocks workaround
#source src/constraints/clock_rules.tcl
#source constr_wizard.tcl
#synch link port definitions
source src/constraints/synch_link.tcl
#run optimization
opt_design

#create debug probes file
write_debug_probes -force debug_probes.ltx


# workaround forn ADC B channels
#set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets adu_instances[2].adu_top_wrapper_1/adu_top_1/adcb_top_i/ddr_8to1_16chan_rx_proc[0].chan_rx/clock_rx_buf] 
#set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets clk_manager_xtal/clock_generator/clk_out0_in]
#set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets clk_manager_xtal/clock_generator/clk_out2_in]
#set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets clk_manager_xtal/clock_generator/clk_out3_in]
#set_property CLOCK_DEDICATED_ROUTE ANY_CMT_COLUMN [get_nets clk_manager_xtal/clock_generator/clk_out4_in]

#run place
place_design
#report_clock_utilization -file $outputDir/clock_util.rpt

#get timing violations and run optimizations if needed
if {[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]] < 0} {
 puts "Found setup timing violations => running physical optimization"
 phys_opt_design -retime
}
write_checkpoint -force $outputDir/post_place.dcp
#report_utilization -file $outputDir/post_place_util.rpt
#report_timing_summary -file $outputDir/post_place_timing_summary.rpt

#Route design and generate bitstream
route_design -directive Explore
write_checkpoint -force $outputDir/post_route.dcp

# change input delay  for the RGMII pins

set_property IDELAY_VALUE 0 [get_cells {network_interface_i/tri_mode_ethernet_mac_0_1/U0/rgmii_interface/delay_rgmii_rx_ctl}]
set_property IDELAY_VALUE 0 [get_cells {network_interface_i/tri_mode_ethernet_mac_0_1/U0/rgmii_interface/rxdata_bus[0].delay_rgmii_rxd}]
set_property IDELAY_VALUE 0 [get_cells {network_interface_i/tri_mode_ethernet_mac_0_1/U0/rgmii_interface/rxdata_bus[1].delay_rgmii_rxd}]
set_property IDELAY_VALUE 0 [get_cells {network_interface_i/tri_mode_ethernet_mac_0_1/U0/rgmii_interface/rxdata_bus[2].delay_rgmii_rxd}]
set_property IDELAY_VALUE 0 [get_cells {network_interface_i/tri_mode_ethernet_mac_0_1/U0/rgmii_interface/rxdata_bus[3].delay_rgmii_rxd}]



#report_route_status -file $outputDir/post_route_status.rpt
report_timing_summary -file $outputDir/post_route_timing_summary.rpt
#report_power -file $outputDir/post_route_power.rpt
#report_drc -file $outputDir/post_imp_drc.rpt
#write_verilog -force $outputDir/cpu_impl_netlist.v -mode timesim -sdf_anno true
# set the MAC address for the current bitstream
# GCU  1
set_property BITSTREAM.CONFIG.USR_ACCESS 0x00011511 [current_design]
#                                             ^^
#                                             ||
#                                        GCU ID MAC ADDRESS ( last 16 bit ) 
# genderate a smaller bitstream
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
write_bitstream -force $outputDir/$bitstreamname_01
# GCU  2
set_property BITSTREAM.CONFIG.USR_ACCESS 0x00021514 [current_design]
#                                             ^^
#                                             ||
#                                        GCU ID MAC ADDRESS ( last 16 bit ) 
# genderate a smaller bitstream
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
write_bitstream -force $outputDir/$bitstreamname_02
# GCU  3
set_property BITSTREAM.CONFIG.USR_ACCESS 0x00031513 [current_design]
#                                             ^^
#                                             ||
#                                        GCU ID MAC ADDRESS ( last 16 bit ) 
# genderate a smaller bitstream
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
write_bitstream -force $outputDir/$bitstreamname_03
