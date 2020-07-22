// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3.1 (lin64) Build 2489853 Tue Mar 26 04:18:30 MDT 2019
// Date        : Mon Jul  6 12:28:57 2020
// Host        : chap2 running 64-bit Debian GNU/Linux 9.3 (stretch)
// Command     : write_verilog -force -mode synth_stub
//               /home/bini/GARFIELD_MOBO/fifo_prj/fifo_prj.srcs/sources_1/ip/trig_header_fifo/trig_header_fifo_stub.v
// Design      : trig_header_fifo
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_3,Vivado 2018.3.1" *)
module trig_header_fifo(clk, srst, din, wr_en, rd_en, dout, full, empty, valid, 
  prog_full)
/* synthesis syn_black_box black_box_pad_pin="clk,srst,din[31:0],wr_en,rd_en,dout[31:0],full,empty,valid,prog_full" */;
  input clk;
  input srst;
  input [31:0]din;
  input wr_en;
  input rd_en;
  output [31:0]dout;
  output full;
  output empty;
  output valid;
  output prog_full;
endmodule
