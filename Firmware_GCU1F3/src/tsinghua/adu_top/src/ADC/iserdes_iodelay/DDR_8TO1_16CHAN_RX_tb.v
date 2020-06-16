`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   09:43:47 11/18/2013
// Design Name:   ddr_1to8_10chan_rx
// Module Name:   D:/WorkSpace/Work/DarkMatter/ISE/DarkMatterNIM/DaughterBoard/src/ev10aq190/DDR/DDR_1TO8_10CHAN_RX_tb.v
// Project Name:  DM_NIM_DB
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: ddr_1to8_10chan_rx
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module DDR_8TO1_16CHAN_RX_tb;

// Inputs
reg [15:0] data_rx_p;
wire [15:0] data_rx_n;
reg clock_rx_p;
wire clock_rx_n;
reg manual_enable;
reg [3:0] manual_chan_sel;
reg manual_inc;
reg manual_dec;
reg manual_bitslip;
reg training_start;
reg rst;
reg idly_rst;
reg clk200;

// Outputs
wire [127:0] data_from_iserdes;
wire rxclk;
wire rxclkdiv;
wire training_done;

parameter clk_freq = 200000000;
parameter clk_period = 1000000000/clk_freq;
initial begin
  clk200 <= 0;
  forever begin
    clk200 <= 1'b0;
    #(clk_period/2);
    clk200 <= 1'b1;
    #(clk_period/2);
  end
end

parameter xdr_freq = 625000000;
parameter xdr_period = 1000000000/clk_freq;
initial begin
  clock_rx_p <= 0;
  forever begin
    clock_rx_p <= 1'b0;
    #(xdr_period/2);
    clock_rx_p <= 1'b1;
    #(xdr_period/2);
  end
end
assign clock_rx_n = ~clock_rx_p;

integer i;
initial begin
  data_rx_p = 0;
  forever begin
    for(i=0;i<7;i=i+1) begin
      @(posedge clock_rx_n) data_rx_p = #(xdr_period/4) 10'h0;
      @(negedge clock_rx_n) data_rx_p = #(xdr_period/4) 10'h0;
    end
    @(posedge clock_rx_n) data_rx_p = #(xdr_period/4) 10'h0;
    @(negedge clock_rx_n) data_rx_p = #(xdr_period/4) 10'h3FF;
  end
end
assign data_rx_n = ~data_rx_p;

// Instantiate the Unit Under Test (UUT)
ddr_8to1_16chan_rx uut (
  .data_rx_p(data_rx_p),
  .data_rx_n(data_rx_n),
  .clock_rx_p(clock_rx_p),
  .clock_rx_n(clock_rx_n),
  .manual_enable(manual_enable),
  .manual_chan_sel(manual_chan_sel),
  .manual_inc(manual_inc),
  .manual_dec(manual_dec),
  .manual_bitslip(manual_bitslip),
  .training_start(training_start),
  .rxrst(rst),
  .manual_idly_rst(idly_rst),
  .data_from_iserdes(data_from_iserdes),
  .rxclk(rxclk),
  .rxclkdiv(rxclkdiv),
  .training_done(training_done)
);

initial begin
  // Initialize Inputs
  manual_enable = 0;
  manual_chan_sel = 0;
  manual_inc = 0;
  manual_dec = 0;
  manual_bitslip = 0;
  training_start = 0;
  rst = 1;
  idly_rst = 0;

  // Wait 100 ns for global reset to finish
  #110;
  rst = 0;
  // Add stimulus here
  @(posedge rxclkdiv) training_start = 1'b1;
  @(posedge rxclkdiv) training_start = 1'b0;

  wait(training_done);

  #100;
  $stop;
end

endmodule

