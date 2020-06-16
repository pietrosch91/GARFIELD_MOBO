`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   08:57:20 11/17/2013
// Design Name:   bit_align_machine
// Module Name:   D:/WorkSpace/Work/DarkMatter/ISE/DarkMatterNIM/DaughterBoard/src/ev10aq190/DDR/BIT_ALIGN_MACHINE_tb.v
// Project Name:  DM_NIM_DB
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: bit_align_machine
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module BIT_ALIGN_MACHINE_tb;

// Inputs
reg clk;
reg rst;
reg [7:0] rxdata;
reg start_align;

// Outputs
wire [4:0] state;
wire inc;
wire ice;
wire bitslip;
wire data_aligned;

reg [8*14:1] string_value;

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
bit_align_machine uut (
  .rxclkdiv(clk),
  .rst(rst),
  .rxdata(rxdata),
  .start_align(start_align),
  .inc(inc),
  .ice(ice),
  .bitslip(bitslip),
  .data_aligned(data_aligned)
);

integer i;

initial begin
  // Initialize Inputs
  rst = 1;
  rxdata = 8'h55;
  start_align = 0;
  string_value = "Hello, World!";

  // Wait 100 ns for global reset to finish
  #110;
  rst = 0;
  // Add stimulus here
  @(posedge clk)  start_align = 1;
  @(posedge clk)  start_align = 0;

  string_value = "1";
  data_gen(8'h55);

  string_value = "2";
  data_gen(8'h55);

  string_value = "3";
  data_gen(8'hab);

  string_value = "4";
  data_gen(8'hab);

  string_value = "5";
  data_gen(8'haa);

  for (i = 0; i < 1; i=i+1)   begin
    string_value = "6";
    data_gen(8'haa);
  end

  string_value = "7";
  data_gen(8'h55);

  string_value = "8";
  rxdata = 8'haa;

  string_value = "9";


  string_value = "10";
  @(posedge clk) rxdata = 8'haa;

  #100
  @(posedge clk)  start_align = 1;
  @(posedge clk)  start_align = 0;

end

task data_gen;
  input [7:0] data;
  begin: proc_task
    while(1) begin
      @(posedge clk) rxdata = data;
      if(ice) disable proc_task;
//      @(posedge clk) rxdata = 8'h0;
//      if(ice) disable proc_task;
    end
  end
endtask

endmodule

