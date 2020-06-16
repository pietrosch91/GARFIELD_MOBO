`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   09:31:35 11/18/2013
// Design Name:   resource_sharing_control
// Module Name:   D:/WorkSpace/Work/DarkMatter/ISE/DarkMatterNIM/DaughterBoard/src/ev10aq190/DDR/RESOURCE_SHARING_CONTROL_tb.v
// Project Name:  DM_NIM_DB
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: resource_sharing_control
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module RESOURCE_SHARING_CONTROL_tb;

// Inputs
reg clk;
reg rst;
reg training_start;
reg data_aligned;

// Outputs
wire [3:0] chan_sel;
wire start_align;
wire all_channels_aligned;

parameter clk_freq = 200000000;
parameter clk_period = 1000000000/clk_freq;
initial begin
  clk <= 0;
  forever begin
    clk <= 1'b0;
    #(clk_period/2);
    clk <= 1'b1;
    #(clk_period/2);
  end
end

// Instantiate the Unit Under Test (UUT)
resource_sharing_control uut (
  .clk(clk),
  .rst(rst),
  .training_start(training_start),
  .data_aligned(data_aligned),
  .chan_sel(chan_sel),
  .start_align(start_align),
  .all_channels_aligned(all_channels_aligned)
);

integer i;

initial begin
  // Initialize Inputs
  clk = 0;
  rst = 1;
  training_start = 0;
  data_aligned = 0;

  // Wait 100 ns for global reset to finish
  #110;
  rst = 0;
  // Add stimulus here
  @(posedge clk) training_start = 1'b1;
  @(posedge clk) training_start = 1'b0;

  for(i=0;i<10;i=i+1) begin
    #1000;
    @(posedge clk) data_aligned = 1'b1;
    @(posedge clk) data_aligned = 1'b0;
  end

  #10;

  @(posedge clk) training_start = 1'b1;
  @(posedge clk) training_start = 1'b0;

  for(i=0;i<10;i=i+1) begin
    #1000;
    @(posedge clk) data_aligned = 1'b1;
    @(posedge clk) data_aligned = 1'b0;
  end

end

endmodule

