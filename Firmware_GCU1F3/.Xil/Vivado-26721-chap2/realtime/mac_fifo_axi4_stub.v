// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_3,Vivado 2018.3.1" *)
module mac_fifo_axi4(m_aclk, s_aclk, s_aresetn, s_axis_tvalid, 
  s_axis_tready, s_axis_tdata, s_axis_tlast, s_axis_tuser, m_axis_tvalid, m_axis_tready, 
  m_axis_tdata, m_axis_tlast, m_axis_tuser);
  input m_aclk;
  input s_aclk;
  input s_aresetn;
  input s_axis_tvalid;
  output s_axis_tready;
  input [7:0]s_axis_tdata;
  input s_axis_tlast;
  input [0:0]s_axis_tuser;
  output m_axis_tvalid;
  input m_axis_tready;
  output [7:0]m_axis_tdata;
  output m_axis_tlast;
  output [0:0]m_axis_tuser;
endmodule
