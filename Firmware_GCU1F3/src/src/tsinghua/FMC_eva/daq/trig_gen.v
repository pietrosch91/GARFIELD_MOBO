`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:22:24 04/02/2018 
// Design Name: 
// Module Name:    trig_gen 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module trig_gen(
    input init_clk,
    input reset_i,
    input trigger_stun,
    input [15:0] trigger_reg,
    input [2:0] overth,
    input trig_in,
    output trig_out,
    output cyctrig_pls
    );

wire extrig_en = trigger_reg[1:0] == 2'b00;
wire cyctrig_en = trigger_reg[1:0] == 2'b01;
wire Nhittrig_en = trigger_reg[1:0] == 2'b11;

wire [3:0] cyctrig_period = trigger_reg[15:12];
reg trig_out_r;
reg [9:0] trig_out_r2;
//assign trig_out = |trig_out_r2;
assign trig_out = |trig_out_r2 & ~trig_out_r2[9];

reg [31:0] cnt;  //counter
always @ (posedge init_clk) begin
	if(reset_i)  cnt <= 32'h0;
	else cnt <= cnt + 1'b1;
end
assign cyctrig_pls = cnt[cyctrig_period+4] == 1;

reg cyctrig_pls_r;
always @ (posedge init_clk) begin
	if(reset_i)  cyctrig_pls_r <= 1'b0;
	else cyctrig_pls_r <= cyctrig_pls;
end

reg [255:0] reset_delay64_r; //block 2us trggier from reset
wire reset_delay64 = |reset_delay64_r;
always @ (posedge init_clk) begin 
	reset_delay64_r <= {reset_delay64_r[254:0],reset_i};
end

reg [1:0] overth_cnt;  //count the overth channels
always @ (posedge init_clk) begin
	if(reset_i)  overth_cnt <= 2'h0;
	else overth_cnt <= overth[0] + overth[1] + overth[2];
end	

always @ (posedge init_clk) begin
	if(reset_delay64 | trigger_stun)
		trig_out_r <= 1'b0;
	else if(extrig_en) 
		trig_out_r <= trig_in;
	else if(cyctrig_en)
		trig_out_r <= cyctrig_pls & ~cyctrig_pls_r;// cnt[18]~ 256 cnt[16]~1K, cnt[10]~ 61K, cnt[0]~62.5M
	else if(Nhittrig_en)
		trig_out_r <= overth_cnt >= trigger_reg[5:4];
	else 
		trig_out_r <= 1'b0;
end		

always @ (posedge init_clk) begin
	if(reset_i)  trig_out_r2 <= 10'h0;
	else		trig_out_r2 <= {trig_out_r2[8:0],trig_out_r};
end	
endmodule
