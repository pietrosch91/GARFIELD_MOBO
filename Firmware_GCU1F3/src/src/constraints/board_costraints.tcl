# PART is xc7k325tffg900-2

#
####
#######
##########
#############
#################
## System level constraints


########## GENERAL IO CONSTRAINTS ##########
set_property PACKAGE_PIN AD23 [get_ports board_clk]
set_property IOSTANDARD LVCMOS25 [get_ports board_clk]

set_property PACKAGE_PIN AA18 [get_ports rst]
set_property IOSTANDARD LVCMOS18 [get_ports rst]
#set_false_path -from [get_ports rst]

set_property PACKAGE_PIN AE16 [get_ports DIP2]
set_property IOSTANDARD LVCMOS18 [get_ports DIP2]

set_property PACKAGE_PIN AG15 [get_ports DIP3]
set_property IOSTANDARD LVCMOS18 [get_ports DIP3]

set_property PACKAGE_PIN AD17 [get_ports ext_trigger]
set_property IOSTANDARD LVCMOS18 [get_ports ext_trigger]

#### Module LEDs_8Bit constraints
set_property PACKAGE_PIN Y18 [get_ports led]
set_property IOSTANDARD LVCMOS18 [get_ports led]
set_property PACKAGE_PIN AB17 [get_ports activity_led]
set_property IOSTANDARD LVCMOS18 [get_ports activity_led]


########## RGMII SPECIFIC IO CONSTRAINTS ##########

set_property PACKAGE_PIN AJ24 [get_ports {rgmii_rxd[3]}]
set_property PACKAGE_PIN AK24 [get_ports {rgmii_rxd[2]}]
set_property PACKAGE_PIN AF25 [get_ports {rgmii_rxd[1]}]
set_property PACKAGE_PIN AK25 [get_ports {rgmii_rxd[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_rxd[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_rxd[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_rxd[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_rxd[0]}]

set_property PACKAGE_PIN AH20 [get_ports {rgmii_txd[3]}]
set_property PACKAGE_PIN AJ21 [get_ports {rgmii_txd[2]}]
set_property PACKAGE_PIN AK21 [get_ports {rgmii_txd[1]}]
set_property PACKAGE_PIN AH21 [get_ports {rgmii_txd[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_txd[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_txd[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_txd[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_txd[0]}]

set_property PACKAGE_PIN AK20 [get_ports rgmii_tx_ctl]
set_property PACKAGE_PIN AE23 [get_ports rgmii_txc]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_tx_ctl]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_txc]

set_property PACKAGE_PIN AK23 [get_ports rgmii_rx_ctl]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_rx_ctl]

set_property PACKAGE_PIN AF23 [get_ports rgmii_rxc]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_rxc]


## Picoblaze constraints
set_property PACKAGE_PIN AH19 [get_ports uart_rx]
set_property IOSTANDARD LVCMOS18 [get_ports uart_rx]
set_property PACKAGE_PIN AJ12 [get_ports uart_tx]
set_property IOSTANDARD LVCMOS18 [get_ports uart_tx]
set_property PACKAGE_PIN AA20 [get_ports sja1105_spi_clk]
set_property IOSTANDARD LVCMOS25 [get_ports sja1105_spi_clk]
set_property PACKAGE_PIN AC21 [get_ports sja1105_spi_miso]
set_property IOSTANDARD LVCMOS25 [get_ports sja1105_spi_miso]
set_property PACKAGE_PIN AA22 [get_ports sja1105_spi_mosi]
set_property IOSTANDARD LVCMOS25 [get_ports sja1105_spi_mosi]
set_property PACKAGE_PIN AA23 [get_ports sja1105_spi_cs_n]
set_property IOSTANDARD LVCMOS25 [get_ports sja1105_spi_cs_n]
set_property PACKAGE_PIN AC20 [get_ports sja1105_sja_rst_n]
set_property IOSTANDARD LVCMOS25 [get_ports sja1105_sja_rst_n]

# UART RS-485 for HV


set EXCLUDED {
    set_property PACKAGE_PIN   AB25    [get_ports  hv_rx_en]
    set_property PACKAGE_PIN   AC27    [get_ports  hv_tx_en]
    set_property PACKAGE_PIN   AD28    [get_ports  hv_tx_0]
    set_property PACKAGE_PIN   AB27    [get_ports  hv_rx_0]
    set_property PACKAGE_PIN   AF27    [get_ports  hv_tx_1]
    set_property PACKAGE_PIN   AF26    [get_ports  hv_rx_1]
    set_property PACKAGE_PIN   AJ29    [get_ports  hv_tx_2]
    set_property PACKAGE_PIN   AH27    [get_ports  hv_rx_2]

    set_property IOSTANDARD LVCMOS33  [get_ports  hv_rx_en]
    set_property IOSTANDARD LVCMOS33  [get_ports  hv_tx_en]
    set_property IOSTANDARD LVCMOS33  [get_ports  hv_tx_0]
    set_property IOSTANDARD LVCMOS33  [get_ports  hv_rx_0]
    set_property IOSTANDARD LVCMOS33  [get_ports  hv_tx_1]
    set_property IOSTANDARD LVCMOS33  [get_ports  hv_rx_1]
    set_property IOSTANDARD LVCMOS33  [get_ports  hv_rx_2]
    set_property IOSTANDARD LVCMOS33  [get_ports  hv_tx_2]
    # I/O for HV
    set_property PACKAGE_PIN    AA27  [get_ports hv_gpi_0]
    set_property PACKAGE_PIN    W27   [get_ports hv_gpo_0]
    set_property PACKAGE_PIN    AD26  [get_ports hv_gpi_1]
    set_property PACKAGE_PIN    AC26  [get_ports hv_gpo_1]
    set_property PACKAGE_PIN    AG27  [get_ports hv_gpi_2]
    set_property PACKAGE_PIN    AG28  [get_ports hv_gpo_2]

    set_property IOSTANDARD LVCMOS33 [get_ports hv_gpi_0]
    set_property IOSTANDARD LVCMOS33 [get_ports hv_gpo_0]
    set_property IOSTANDARD LVCMOS33 [get_ports hv_gpi_1]
    set_property IOSTANDARD LVCMOS33 [get_ports hv_gpo_1]
    set_property IOSTANDARD LVCMOS33 [get_ports hv_gpi_2]
    set_property IOSTANDARD LVCMOS33 [get_ports hv_gpo_2]

    # I2C bus for MAC address eprom

    set_property PACKAGE_PIN  G12   [get_ports mac_scl]
    set_property PACKAGE_PIN  L12   [get_ports mac_sda]

    set_property IOSTANDARD  LVCMOS25 [get_ports mac_scl]
    set_property IOSTANDARD  LVCMOS25 [get_ports mac_sda]
}

# SPI 
#
####
#######
##########
#############
#################
#EXAMPLE DESIGN CONSTRAINTS

############################################################
# Associate the IDELAYCTRL in the support level to the I/Os
# in the core using IODELAYs
############################################################
#set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp [get_cells  {tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_idelayctrl_common_i}]
#set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp [get_cells  {tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_idelayctrl_common_i}]

############################################################
# Clock Period Constraints                                 #
############################################################

############################################################
# TX Clock period Constraints                              #
############################################################
# Transmitter clock period constraints: please do not relax
create_clock -period 8.000 -name board_clk [get_ports board_clk]
set_input_jitter board_clk 0.050

#set to use clock backbone - this uses a long route to allow the MMCM to be placed in the other half of the device
#set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets -of [get_pins example_clocks/clkin1_buf/O]]



############################################################
# Get auto-generated clock names                           #
############################################################

############################################################
# Input Delay constraints
############################################################
# these inputs are alll from either dip switchs or push buttons
# and therefore have no timing associated with them
#set_false_path -from [get_ports config_board]
#set_false_path -from [get_ports pause_req_s]
#set_false_path -from [get_ports reset_error]
#set_false_path -from [get_ports mac_speed[0]]
#set_false_path -from [get_ports mac_speed[1]]
#set_false_path -from [get_ports gen_tx_data]
#set_false_path -from [get_ports chk_tx_data]

# no timing requirements but want the capture flops close to the IO
#set_max_delay -from [get_ports update_speed] 4 -datapath_only


# Ignore pause deserialiser as only present to prevent logic stripping
#set_false_path -from [get_ports pause_req*]
#set_false_path -from [get_cells pause_req* -filter {IS_SEQUENTIAL}]
#set_false_path -from [get_cells pause_val* -filter {IS_SEQUENTIAL}]


############################################################
# Output Delay constraints
############################################################

#set_false_path -to [get_ports frame_error]
#set_false_path -to [get_ports frame_errorn]
#set_false_path -to [get_ports tx_statistics_s]
#set_false_path -to [get_ports rx_statistics_s]

## no timing associated with output
#set_false_path -from [get_cells -hier -filter {name =~ *phy_resetn_int_reg}] -to [get_ports phy_resetn]

############################################################
# Example design Clock Crossing Constraints                          #
############################################################

# control signal is synched over clock boundary separately
#set_false_path -from [get_cells -hier -filter {name =~ rx_stats_reg[*]}] -to [get_cells -hier -filter {name =~ rx_stats_shift_reg[*]}]

############################################################
# Ignore paths to resync flops
############################################################
#set_false_path -to [get_pins -hier -filter {NAME =~ */reset_sync*/PRE}]
set_false_path -to [get_pins -hier -filter {NAME =~ */*_sync*/D}]
#set_max_delay -from [get_cells rx_stats_toggle_reg] -to [get_cells rx_stats_sync/data_sync_reg0] 6 -datapath_only



#
####
#######
##########
#############
#################
#FIFO BLOCK CONSTRAINTS

############################################################
# FIFO Clock Crossing Constraints                          #
############################################################

# control signal is synched separately so this is a false path
#set_max_delay -from [get_cells -hier -filter {name =~ *rx_fifo_i/rd_addr_reg[*]}]                         -to [get_cells -hier -filter {name =~ *fifo*wr_rd_addr_reg[*]}] 3.2 -datapath_only
#set_max_delay -from [get_cells -hier -filter {name =~ *rx_fifo_i/wr_store_frame_tog_reg}]                 -to [get_cells -hier -filter {name =~ *fifo_i/resync_wr_store_frame_tog/data_sync_reg0}] 3.2 -datapath_only
#set_max_delay -from [get_cells -hier -filter {name =~ *rx_fifo_i/update_addr_tog_reg}]                    -to [get_cells -hier -filter {name =~ *rx_fifo_i/sync_rd_addr_tog/data_sync_reg0}] 3.2 -datapath_only
#set_max_delay -from [get_cells -hier -filter {name =~ *tx_fifo_i/rd_addr_txfer_reg[*]}]                   -to [get_cells -hier -filter {name =~ *fifo*wr_rd_addr_reg[*]}] 3.2 -datapath_only
#set_max_delay -from [get_cells -hier -filter {name =~ *tx_fifo_i/wr_frame_in_fifo_reg}]                   -to [get_cells -hier -filter {name =~ *tx_fifo_i/resync_wr_frame_in_fifo/data_sync_reg0}] 3.2 -datapath_only
#set_max_delay -from [get_cells -hier -filter {name =~ *tx_fifo_i/wr_frames_in_fifo_reg}]                  -to [get_cells -hier -filter {name =~ *tx_fifo_i/resync_wr_frames_in_fifo/data_sync_reg0}] 3.2 -datapath_only
#set_max_delay -from [get_cells -hier -filter {name =~ *tx_fifo_i/frame_in_fifo_valid_tog_reg}]            -to [get_cells -hier -filter {name =~ *tx_fifo_i/resync_fif_valid_tog/data_sync_reg0}] 3.2 -datapath_only
#set_max_delay -from [get_cells -hier -filter {name =~ *tx_fifo_i/rd_txfer_tog_reg}]                       -to [get_cells -hier -filter {name =~ *tx_fifo_i/resync_rd_txfer_tog/data_sync_reg0}] 3.2 -datapath_only
#set_max_delay -from [get_cells -hier -filter {name =~ *tx_fifo_i/rd_tran_frame_tog_reg}]                  -to [get_cells -hier -filter {name =~ *tx_fifo_i/resync_rd_tran_frame_tog/data_sync_reg0}] 3.2 -datapath_only

set_power_opt -exclude_cells [get_cells -hierarchical -filter { PRIMITIVE_TYPE =~ *.bram.* }]
