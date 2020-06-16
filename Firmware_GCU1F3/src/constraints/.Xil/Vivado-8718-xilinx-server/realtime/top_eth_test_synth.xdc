set_property SRC_FILE_INFO {cfile:/home/antonio/projects/gcu_eth_test_raw/src/constraints/tri_mode_ethernet_mac_0_example_design.xdc rfile:../../../tri_mode_ethernet_mac_0_example_design.xdc id:1} [current_design]
set_property src_info {type:XDC file:1 line:15 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS25 [get_ports board_clk]
set_property src_info {type:XDC file:1 line:22 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS18 [get_ports rst]
set_property src_info {type:XDC file:1 line:28 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS18 [get_ports led]
set_property src_info {type:XDC file:1 line:30 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS18 [get_ports activity_led]
set_property src_info {type:XDC file:1 line:83 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_rxd[3]}]
set_property src_info {type:XDC file:1 line:84 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_rxd[2]}]
set_property src_info {type:XDC file:1 line:85 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_rxd[1]}]
set_property src_info {type:XDC file:1 line:86 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_rxd[0]}]
set_property src_info {type:XDC file:1 line:92 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_txd[3]}]
set_property src_info {type:XDC file:1 line:93 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_txd[2]}]
set_property src_info {type:XDC file:1 line:94 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_txd[1]}]
set_property src_info {type:XDC file:1 line:95 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_txd[0]}]
set_property src_info {type:XDC file:1 line:99 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_tx_ctl]
set_property src_info {type:XDC file:1 line:100 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_txc]
set_property src_info {type:XDC file:1 line:103 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_rx_ctl]
set_property src_info {type:XDC file:1 line:106 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_rxc]
set_property src_info {type:XDC file:1 line:115 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS18 [get_ports uart_rx]
set_property src_info {type:XDC file:1 line:117 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS18 [get_ports uart_tx]
set_property src_info {type:XDC file:1 line:119 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS25 [get_ports spi_clk]
set_property src_info {type:XDC file:1 line:121 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS25 [get_ports spi_miso]
set_property src_info {type:XDC file:1 line:123 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS25 [get_ports spi_mosi]
set_property src_info {type:XDC file:1 line:125 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS25 [get_ports spi_cs_n]
set_property src_info {type:XDC file:1 line:127 export:INPUT save:INPUT read:READ} [current_design]
set_property IOSTANDARD LVCMOS25 [get_ports sja_rst_n]
set_property src_info {type:XDC file:1 line:143 export:INPUT save:INPUT read:READ} [current_design]
set_property IODELAY_GROUP tri_mode_ethernet_mac_iodelay_grp [get_cells tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_idelayctrl_common_i]
set_property src_info {type:XDC file:1 line:153 export:INPUT save:INPUT read:READ} [current_design]
create_clock -period 8.000 -name board_clk [get_ports board_clk]
set_property src_info {type:PI file:{} line:-1 export:INPUT save:INPUT read:READ} [current_design]
create_generated_clock -name clkfbout -source [get_pins top_1/clock_manager_1/disconnect_clk_manager.clock_man_1/pll_base_inst/CLKIN1] -multiply_by 1 -add -master_clock board_clk [get_pins top_1/clock_manager_1/disconnect_clk_manager.clock_man_1/pll_base_inst/CLKFBOUT]
set_property src_info {type:PI file:{} line:-1 export:INPUT save:INPUT read:READ} [current_design]
create_generated_clock -name clkout0 -source [get_pins top_1/clock_manager_1/disconnect_clk_manager.clock_man_1/pll_base_inst/CLKIN1] -edges {1 2 3} -edge_shift {0.000 1.000 2.000} -add -master_clock board_clk [get_pins top_1/clock_manager_1/disconnect_clk_manager.clock_man_1/pll_base_inst/CLKOUT0]
set_property src_info {type:PI file:{} line:-1 export:INPUT save:INPUT read:READ} [current_design]
create_generated_clock -name clkfbout_1 -source [get_pins tri_mode_eth_mac_v5_5_example_design_1/example_clocks/clock_generator/mmcm_adv_inst/CLKIN1] -multiply_by 1 -add -master_clock board_clk [get_pins tri_mode_eth_mac_v5_5_example_design_1/example_clocks/clock_generator/mmcm_adv_inst/CLKFBOUT]
set_property src_info {type:PI file:{} line:-1 export:INPUT save:INPUT read:READ} [current_design]
create_generated_clock -name clkout0_1 -source [get_pins tri_mode_eth_mac_v5_5_example_design_1/example_clocks/clock_generator/mmcm_adv_inst/CLKIN1] -multiply_by 1 -add -master_clock board_clk [get_pins tri_mode_eth_mac_v5_5_example_design_1/example_clocks/clock_generator/mmcm_adv_inst/CLKOUT0]
set_property src_info {type:PI file:{} line:-1 export:INPUT save:INPUT read:READ} [current_design]
create_generated_clock -name clkout1 -source [get_pins tri_mode_eth_mac_v5_5_example_design_1/example_clocks/clock_generator/mmcm_adv_inst/CLKIN1] -edges {1 2 3} -edge_shift {0.000 1.000 2.000} -add -master_clock board_clk [get_pins tri_mode_eth_mac_v5_5_example_design_1/example_clocks/clock_generator/mmcm_adv_inst/CLKOUT1]
set_property src_info {type:PI file:{} line:-1 export:INPUT save:INPUT read:READ} [current_design]
create_generated_clock -name clkout2 -source [get_pins tri_mode_eth_mac_v5_5_example_design_1/example_clocks/clock_generator/mmcm_adv_inst/CLKIN1] -edges {1 2 3} -edge_shift {0.000 -1.500 -3.000} -add -master_clock board_clk [get_pins tri_mode_eth_mac_v5_5_example_design_1/example_clocks/clock_generator/mmcm_adv_inst/CLKOUT2]
set_property src_info {type:PI file:{} line:-1 export:INPUT save:INPUT read:READ} [current_design]
create_generated_clock -name clkfbout_2 -source [get_pins tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_clocking_i/mmcm_adv_inst/CLKIN1] -multiply_by 1 -add -master_clock clkout0_1 [get_pins tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_clocking_i/mmcm_adv_inst/CLKFBOUT]
set_property src_info {type:PI file:{} line:-1 export:INPUT save:INPUT read:READ} [current_design]
create_generated_clock -name clkout0_2 -source [get_pins tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_clocking_i/mmcm_adv_inst/CLKIN1] -multiply_by 1 -add -master_clock clkout0_1 [get_pins tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_clocking_i/mmcm_adv_inst/CLKOUT0]
set_property src_info {type:PI file:{} line:-1 export:INPUT save:INPUT read:READ} [current_design]
create_generated_clock -name clkout1_1 -source [get_pins tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_clocking_i/mmcm_adv_inst/CLKIN1] -edges {1 2 3} -edge_shift {2.000 2.000 2.000} -add -master_clock clkout0_1 [get_pins tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_clocking_i/mmcm_adv_inst/CLKOUT1]
set_property src_info {type:XDC file:1 line:213 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -to [get_pins [list tri_mode_eth_mac_v5_5_example_design_1/example_clocks/mmcm_reset_gen/reset_sync0/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_clocks/mmcm_reset_gen/reset_sync1/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_clocks/mmcm_reset_gen/reset_sync2/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_clocks/mmcm_reset_gen/reset_sync3/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_clocks/mmcm_reset_gen/reset_sync4/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/chk_reset_gen/reset_sync0/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/chk_reset_gen/reset_sync1/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/chk_reset_gen/reset_sync2/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/chk_reset_gen/reset_sync3/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/chk_reset_gen/reset_sync4/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/glbl_reset_gen/reset_sync0/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/glbl_reset_gen/reset_sync1/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/glbl_reset_gen/reset_sync2/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/glbl_reset_gen/reset_sync3/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/glbl_reset_gen/reset_sync4/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/gtx_reset_gen/reset_sync0/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/gtx_reset_gen/reset_sync1/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/gtx_reset_gen/reset_sync2/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/gtx_reset_gen/reset_sync3/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/gtx_reset_gen/reset_sync4/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/vector_reset_gen/reset_sync0/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/vector_reset_gen/reset_sync1/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/vector_reset_gen/reset_sync2/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/vector_reset_gen/reset_sync3/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/vector_reset_gen/reset_sync4/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/rx_mac_reset_gen/reset_sync0/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/rx_mac_reset_gen/reset_sync1/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/rx_mac_reset_gen/reset_sync2/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/rx_mac_reset_gen/reset_sync3/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/rx_mac_reset_gen/reset_sync4/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/gtx_mmcm_reset_gen/reset_sync0/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/gtx_mmcm_reset_gen/reset_sync1/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/gtx_mmcm_reset_gen/reset_sync2/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/gtx_mmcm_reset_gen/reset_sync3/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/gtx_mmcm_reset_gen/reset_sync4/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/idelayctrl_reset_gen/reset_sync0/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/idelayctrl_reset_gen/reset_sync1/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/idelayctrl_reset_gen/reset_sync2/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/idelayctrl_reset_gen/reset_sync3/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/idelayctrl_reset_gen/reset_sync4/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/tx_mac_reset_gen/reset_sync0/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/tx_mac_reset_gen/reset_sync1/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/tx_mac_reset_gen/reset_sync2/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/tx_mac_reset_gen/reset_sync3/PRE \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/tx_mac_reset_gen/reset_sync4/PRE]]
set_property src_info {type:XDC file:1 line:214 export:INPUT save:INPUT read:READ} [current_design]
set_false_path -to [get_pins [list tri_mode_eth_mac_v5_5_example_design_1/config_vector_controller/upspeed_sync/data_sync_reg0/D \
          tri_mode_eth_mac_v5_5_example_design_1/config_vector_controller/upspeed_sync/data_sync_reg1/D \
          tri_mode_eth_mac_v5_5_example_design_1/config_vector_controller/upspeed_sync/data_sync_reg2/D \
          tri_mode_eth_mac_v5_5_example_design_1/config_vector_controller/upspeed_sync/data_sync_reg3/D \
          tri_mode_eth_mac_v5_5_example_design_1/config_vector_controller/upspeed_sync/data_sync_reg4/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_clocks/lock_sync/data_sync_reg0/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_clocks/lock_sync/data_sync_reg1/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_clocks/lock_sync/data_sync_reg2/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_clocks/lock_sync/data_sync_reg3/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_clocks/lock_sync/data_sync_reg4/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_clocks/mmcm_reset_gen/reset_sync0/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_clocks/mmcm_reset_gen/reset_sync1/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_clocks/mmcm_reset_gen/reset_sync2/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_clocks/mmcm_reset_gen/reset_sync3/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_clocks/mmcm_reset_gen/reset_sync4/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/chk_reset_gen/reset_sync0/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/chk_reset_gen/reset_sync1/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/chk_reset_gen/reset_sync2/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/chk_reset_gen/reset_sync3/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/chk_reset_gen/reset_sync4/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/dcm_sync/data_sync_reg0/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/dcm_sync/data_sync_reg1/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/dcm_sync/data_sync_reg2/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/dcm_sync/data_sync_reg3/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/dcm_sync/data_sync_reg4/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/glbl_reset_gen/reset_sync0/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/glbl_reset_gen/reset_sync1/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/glbl_reset_gen/reset_sync2/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/glbl_reset_gen/reset_sync3/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/glbl_reset_gen/reset_sync4/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/gtx_reset_gen/reset_sync0/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/gtx_reset_gen/reset_sync1/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/gtx_reset_gen/reset_sync2/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/gtx_reset_gen/reset_sync3/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/gtx_reset_gen/reset_sync4/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/vector_reset_gen/reset_sync0/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/vector_reset_gen/reset_sync1/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/vector_reset_gen/reset_sync2/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/vector_reset_gen/reset_sync3/D \
          tri_mode_eth_mac_v5_5_example_design_1/example_resets/vector_reset_gen/reset_sync4/D \
          tri_mode_eth_mac_v5_5_example_design_1/rx_stats_sync/data_sync_reg0/D \
          tri_mode_eth_mac_v5_5_example_design_1/rx_stats_sync/data_sync_reg1/D \
          tri_mode_eth_mac_v5_5_example_design_1/rx_stats_sync/data_sync_reg2/D \
          tri_mode_eth_mac_v5_5_example_design_1/rx_stats_sync/data_sync_reg3/D \
          tri_mode_eth_mac_v5_5_example_design_1/rx_stats_sync/data_sync_reg4/D \
          tri_mode_eth_mac_v5_5_example_design_1/rx_stats_toggle_sync_reg_reg/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/rx_mac_reset_gen/reset_sync0/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/rx_mac_reset_gen/reset_sync1/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/rx_mac_reset_gen/reset_sync2/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/rx_mac_reset_gen/reset_sync3/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/rx_mac_reset_gen/reset_sync4/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/gtx_mmcm_reset_gen/reset_sync0/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/gtx_mmcm_reset_gen/reset_sync1/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/gtx_mmcm_reset_gen/reset_sync2/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/gtx_mmcm_reset_gen/reset_sync3/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/gtx_mmcm_reset_gen/reset_sync4/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/idelayctrl_reset_gen/reset_sync0/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/idelayctrl_reset_gen/reset_sync1/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/idelayctrl_reset_gen/reset_sync2/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/idelayctrl_reset_gen/reset_sync3/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/idelayctrl_reset_gen/reset_sync4/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/lock_sync/data_sync_reg0/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/lock_sync/data_sync_reg1/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/lock_sync/data_sync_reg2/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/lock_sync/data_sync_reg3/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_support_resets_i/lock_sync/data_sync_reg4/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/tx_mac_reset_gen/reset_sync0/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/tx_mac_reset_gen/reset_sync1/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/tx_mac_reset_gen/reset_sync2/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/tx_mac_reset_gen/reset_sync3/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/tx_mac_reset_gen/reset_sync4/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/rx_fifo_i/resync_wr_store_frame_tog/data_sync_reg0/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/rx_fifo_i/resync_wr_store_frame_tog/data_sync_reg1/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/rx_fifo_i/resync_wr_store_frame_tog/data_sync_reg2/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/rx_fifo_i/resync_wr_store_frame_tog/data_sync_reg3/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/rx_fifo_i/resync_wr_store_frame_tog/data_sync_reg4/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/rx_fifo_i/sync_rd_addr_tog/data_sync_reg0/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/rx_fifo_i/sync_rd_addr_tog/data_sync_reg1/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/rx_fifo_i/sync_rd_addr_tog/data_sync_reg2/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/rx_fifo_i/sync_rd_addr_tog/data_sync_reg3/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/rx_fifo_i/sync_rd_addr_tog/data_sync_reg4/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/rx_fifo_i/update_addr_tog_sync_reg_reg/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_fif_valid_tog/data_sync_reg0/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_fif_valid_tog/data_sync_reg1/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_fif_valid_tog/data_sync_reg2/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_fif_valid_tog/data_sync_reg3/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_fif_valid_tog/data_sync_reg4/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_rd_tran_frame_tog/data_sync_reg0/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_rd_tran_frame_tog/data_sync_reg1/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_rd_tran_frame_tog/data_sync_reg2/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_rd_tran_frame_tog/data_sync_reg3/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_rd_tran_frame_tog/data_sync_reg4/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_rd_txfer_tog/data_sync_reg0/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_rd_txfer_tog/data_sync_reg1/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_rd_txfer_tog/data_sync_reg2/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_rd_txfer_tog/data_sync_reg3/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_rd_txfer_tog/data_sync_reg4/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_wr_frame_in_fifo/data_sync_reg0/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_wr_frame_in_fifo/data_sync_reg1/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_wr_frame_in_fifo/data_sync_reg2/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_wr_frame_in_fifo/data_sync_reg3/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_wr_frame_in_fifo/data_sync_reg4/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_wr_frames_in_fifo/data_sync_reg0/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_wr_frames_in_fifo/data_sync_reg1/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_wr_frames_in_fifo/data_sync_reg2/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_wr_frames_in_fifo/data_sync_reg3/D \
          tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/user_side_FIFO/tx_fifo_i/resync_wr_frames_in_fifo/data_sync_reg4/D \
          tri_mode_eth_mac_v5_5_example_design_1/tx_stats_sync/data_sync_reg0/D \
          tri_mode_eth_mac_v5_5_example_design_1/tx_stats_sync/data_sync_reg1/D \
          tri_mode_eth_mac_v5_5_example_design_1/tx_stats_sync/data_sync_reg2/D \
          tri_mode_eth_mac_v5_5_example_design_1/tx_stats_sync/data_sync_reg3/D \
          tri_mode_eth_mac_v5_5_example_design_1/tx_stats_sync/data_sync_reg4/D \
          tri_mode_eth_mac_v5_5_example_design_1/tx_stats_toggle_sync_reg_reg/D]]
set_property src_info {type:TCL file:{} line:-1 export:INPUT save:INPUT read:READ} [current_design]
set_property DONT_TOUCH true [get_cells tri_mode_eth_mac_v5_5_example_design_1/trimac_fifo_block/trimac_sup_block/tri_mode_ethernet_mac_i]
