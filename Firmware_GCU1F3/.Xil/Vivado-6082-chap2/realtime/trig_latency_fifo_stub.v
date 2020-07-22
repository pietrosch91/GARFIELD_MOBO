// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_3,Vivado 2018.3.1" *)
module trig_latency_fifo(clk, rst, din, wr_en, rd_en, dout, full, empty, 
  data_count, wr_rst_busy, rd_rst_busy);
  input clk;
  input rst;
  input [127:0]din;
  input wr_en;
  input rd_en;
  output [127:0]dout;
  output full;
  output empty;
  output [10:0]data_count;
  output wr_rst_busy;
  output rd_rst_busy;
endmodule
