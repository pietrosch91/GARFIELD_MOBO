// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "tri_mode_ethernet_mac_0_block,Vivado 2018.3.1" *)
module tri_mode_ethernet_mac_0(gtx_clk, gtx_clk90, glbl_rstn, rx_axi_rstn, 
  tx_axi_rstn, rx_statistics_vector, rx_statistics_valid, rx_mac_aclk, rx_reset, 
  rx_axis_mac_tdata, rx_axis_mac_tvalid, rx_axis_mac_tlast, rx_axis_mac_tuser, 
  tx_ifg_delay, tx_statistics_vector, tx_statistics_valid, tx_mac_aclk, tx_reset, 
  tx_axis_mac_tdata, tx_axis_mac_tvalid, tx_axis_mac_tlast, tx_axis_mac_tuser, 
  tx_axis_mac_tready, pause_req, pause_val, speedis100, speedis10100, rgmii_txd, rgmii_tx_ctl, 
  rgmii_txc, rgmii_rxd, rgmii_rx_ctl, rgmii_rxc, inband_link_status, inband_clock_speed, 
  inband_duplex_status, rx_configuration_vector, tx_configuration_vector);
  input gtx_clk;
  input gtx_clk90;
  input glbl_rstn;
  input rx_axi_rstn;
  input tx_axi_rstn;
  output [27:0]rx_statistics_vector;
  output rx_statistics_valid;
  output rx_mac_aclk;
  output rx_reset;
  output [7:0]rx_axis_mac_tdata;
  output rx_axis_mac_tvalid;
  output rx_axis_mac_tlast;
  output rx_axis_mac_tuser;
  input [7:0]tx_ifg_delay;
  output [31:0]tx_statistics_vector;
  output tx_statistics_valid;
  output tx_mac_aclk;
  output tx_reset;
  input [7:0]tx_axis_mac_tdata;
  input tx_axis_mac_tvalid;
  input tx_axis_mac_tlast;
  input [0:0]tx_axis_mac_tuser;
  output tx_axis_mac_tready;
  input pause_req;
  input [15:0]pause_val;
  output speedis100;
  output speedis10100;
  output [3:0]rgmii_txd;
  output rgmii_tx_ctl;
  output rgmii_txc;
  input [3:0]rgmii_rxd;
  input rgmii_rx_ctl;
  input rgmii_rxc;
  output inband_link_status;
  output [1:0]inband_clock_speed;
  output inband_duplex_status;
  input [79:0]rx_configuration_vector;
  input [79:0]tx_configuration_vector;
endmodule
