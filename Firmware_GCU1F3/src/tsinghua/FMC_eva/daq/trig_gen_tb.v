`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   03:51:52 10/20/2018
// Design Name:   trig_gen
// Module Name:   E:/Myproject/ISE14/GCU1F3ch/src/daq/trig_gen_tb.v
// Project Name:  GCU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: trig_gen
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module trig_gen_tb;

	// Inputs
	reg init_clk;
	reg reset_i;
	reg trigger_stun;
	reg [15:0] trigger_reg;
	reg [2:0] overth;
	reg trig_in;

	// Outputs
	wire trig_out;
	wire cyctrig_pls;

	// Instantiate the Unit Under Test (UUT)
	trig_gen uut (
		.init_clk(init_clk), 
		.reset_i(reset_i), 
		.trigger_stun(trigger_stun), 
		.trigger_reg(trigger_reg), 
		.overth(overth), 
		.trig_in(trig_in), 
		.trig_out(trig_out),
		.cyctrig_pls(cyctrig_pls)
	);

parameter clk_freq = 125000000;
parameter clk_period = 1000000000/clk_freq;
initial begin
  init_clk <= 0;
  forever begin
    init_clk <= 1'b0;
    #(clk_period/2);
    init_clk <= 1'b1;
    #(clk_period/2);
  end
end


	initial begin
		// Initialize Inputs
		reset_i = 1;
		trigger_stun = 0;
		trigger_reg = 16'hE005;
		overth = 0;
		trig_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
     reset_i = 0;
		// Add stimulus here

	end
      
endmodule

