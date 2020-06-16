`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:33:42 10/21/2018
// Design Name:   data_mux
// Module Name:   E:/Myproject/ISE14/GCU1F3ch/src/daq/data_mux_tb.v
// Project Name:  GCU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: data_mux
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module data_mux_tb;

	// Inputs
	reg init_clk;
	reg reset_i;
	reg [95:0] sample_count_value;
	reg [2:0] adu_en;
	reg [95:0] ingress_fifo_out;
	reg [5:0] ingress_fifo_empty;
	reg egress_fifo_full;

	// Outputs
	wire [5:0] ingress_fifo_rd_en;
	wire [15:0] egress_fifo_din;
	wire egress_fifo_wren;

	// Instantiate the Unit Under Test (UUT)
	data_mux uut (
		.init_clk(init_clk), 
		.reset_i(reset_i), 
		.sample_count_value(sample_count_value), 
		.adu_en(adu_en), 
		.ingress_fifo_rd_en(ingress_fifo_rd_en), 
		.ingress_fifo_out(ingress_fifo_out), 
		.ingress_fifo_empty(ingress_fifo_empty), 
		.egress_fifo_din(egress_fifo_din), 
		.egress_fifo_wren(egress_fifo_wren), 
		.egress_fifo_full(egress_fifo_full)
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
		sample_count_value = 96'h0042_0042_0042_0042_0042_0042;
		adu_en = 3'b100;
		ingress_fifo_out = 0;
		ingress_fifo_empty = 0;
		egress_fifo_full = 0;

		// Wait 100 ns for global reset to finish
		#100;
    	reset_i = 0;    
		// Add stimulus here

	end
      
endmodule

