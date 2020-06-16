`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:30:34 03/22/2018 
// Design Name: 
// Module Name:    data_mux 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//  multi-channel(ingress_fifo) to one channel(egress_fifo)
// 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module data_mux#(
	parameter N = 6
)
(
	input init_clk,
	input reset_i,
	input [47:0] sample_count_value,
	input [2:0] adu_en,
	output [N-1:0] ingress_fifo_rd_en,
	input [16*N-1:0] ingress_fifo_out,
	input [N-1:0] ingress_fifo_empty,
	output reg [15:0] egress_fifo_din,
	output reg egress_fifo_wren,
	input egress_fifo_full,
	inout [35:0] cs_control
      );


// find the end of one frame 
// chx_rd_count is byte number
reg [3:0] chan_sel;
reg [32*N-1:0] chN_rd_count;
wire [N-1:0] ch_end;
always @ (posedge init_clk) begin
	if(reset_i | chan_sel == 4'h0)											chN_rd_count <= 0;			
	else if(chan_sel == 4'h1 & ingress_fifo_rd_en[0])		chN_rd_count <= {160'h0,chN_rd_count[31:0] + 2'h2};		
	else if(chan_sel == 4'h3 & ingress_fifo_rd_en[1])		chN_rd_count <= {128'h0,chN_rd_count[63:32] + 2'h2,32'h0};			
	else if(chan_sel == 4'h5 & ingress_fifo_rd_en[2])		chN_rd_count <= {96'h0,chN_rd_count[95:64] + 2'h2,64'h0};				
	else if(chan_sel == 4'h7 & ingress_fifo_rd_en[3])		chN_rd_count <= {64'h0,chN_rd_count[127:96] + 2'h2,96'h0};						
	else if(chan_sel == 4'h9 & ingress_fifo_rd_en[4])		chN_rd_count <= {32'h0,chN_rd_count[159:128] + 2'h2,128'h0};			
	else if(chan_sel == 4'hb & ingress_fifo_rd_en[5])		chN_rd_count <= {chN_rd_count[191:160] + 2'h2,160'h0};
	else		chN_rd_count <= 0;		
end

assign ch_end[0] = chN_rd_count[31:0]		 == {sample_count_value[15:0],4'b0000};
assign ch_end[1] = chN_rd_count[63:32]	 == {sample_count_value[15:0],4'b0000};
assign ch_end[2] = chN_rd_count[95:64]	 == {sample_count_value[31:16],4'b0000};
assign ch_end[3] = chN_rd_count[127:96]	 == {sample_count_value[31:16],4'b0000};
assign ch_end[4] = chN_rd_count[159:128]	 == {sample_count_value[47:32],4'b0000};
assign ch_end[5] = chN_rd_count[191:160]	 == {sample_count_value[47:32],4'b0000};

//switch channels

always @ (posedge init_clk) begin
	if(reset_i)		
		if		 (adu_en[0]) chan_sel <= 4'h0;
		else if(adu_en[1]) chan_sel <= 4'h4;	
		else if(adu_en[2]) chan_sel <= 4'h8;			
		else  						 chan_sel <= 4'hF;				
	else case(chan_sel)
		4'h0: if(~ingress_fifo_empty[0]) chan_sel <= 4'h1;
				 else chan_sel <= 4'h0;
		4'h1: if(ch_end[0])  chan_sel <= 4'h2;//2'b00: only one channel //2'b10; both 2 channels											  
					 else chan_sel <= 4'h1;
		4'h2: if(~ingress_fifo_empty[1]) chan_sel <= 4'h3;
				 else chan_sel <= 4'h2;
		4'h3: if(ch_end[1]) 
						if(adu_en[1]) 				chan_sel <= 4'h4;//2'b00: only one channel //2'b10; both 2 channels
						else if	(adu_en[2])		chan_sel <= 4'h8;							
						else chan_sel <= 4'h0;
				 else chan_sel <= 4'h3;

		4'h4: if(~ingress_fifo_empty[2]) chan_sel <= 4'h5;
				 else chan_sel <= 4'h4;
		4'h5: if(ch_end[2])  chan_sel <= 4'h6;//2'b00: only one channel //2'b10; both 2 channels											  
					 else chan_sel <= 4'h5;
		4'h6: if(~ingress_fifo_empty[3]) chan_sel <= 4'h7;
				 else chan_sel <= 4'h6;
		4'h7: if(ch_end[3]) 
						if(adu_en[2]) 				chan_sel <= 4'h8;//2'b00: only one channel //2'b10; both 2 channels
						else if	(adu_en[0])		chan_sel <= 4'h0;							
						else chan_sel <= 4'h4;
				 else chan_sel <= 4'h7;
				 
		4'h8: if(~ingress_fifo_empty[4]) chan_sel <= 4'h9;
				 else chan_sel <= 4'h8;
		4'h9: if(ch_end[4])  chan_sel <= 4'ha;//2'b00: only one channel //2'b10; both 2 channels											  
					 else chan_sel <= 4'h9;
		4'ha: if(~ingress_fifo_empty[5]) chan_sel <= 4'hb;
				 else chan_sel <= 4'ha;
		4'hb: if(ch_end[5]) 
						if(adu_en[0]) 				chan_sel <= 4'h0;//2'b00: only one channel //2'b10; both 2 channels
						else if	(adu_en[1])		chan_sel <= 4'h4;							
						else chan_sel <= 4'h8;
				 else chan_sel <= 4'hb;
		
		default : chan_sel <= 4'hF;
	endcase
end

///////only high gain chans
//always @ (posedge init_clk) begin
//	if(reset_i)		
//		if		 (adu_en[0]) chan_sel <= 4'h0;
//		else if(adu_en[1]) chan_sel <= 4'h4;	
//		else if(adu_en[2]) chan_sel <= 4'h8;			
//		else  						 chan_sel <= 4'hF;				
//	else case(chan_sel)
//		4'h0: if(~ingress_fifo_empty[0]) chan_sel <= 4'h1;
//				 else chan_sel <= 4'h0;
//		4'h1: if(ch_end[0])
//						if(adu_en[1]) 				chan_sel <= 4'h4;//2'b00: only one channel //2'b10; both 2 channels
//						else if	(adu_en[2])		chan_sel <= 4'h8;							
//						else chan_sel <= 4'h0;
//				 else chan_sel <= 4'h1;
//
//		4'h4: if(~ingress_fifo_empty[2]) chan_sel <= 4'h5;
//				 else chan_sel <= 4'h4;
//		4'h5: if(ch_end[2])
//						if(adu_en[2]) 				chan_sel <= 4'h8;
//						else if	(adu_en[0])		chan_sel <= 4'h0;							
//						else chan_sel <= 4'h4;
//				 else chan_sel <= 4'h5;
//				 
//		4'h8: if(~ingress_fifo_empty[4]) chan_sel <= 4'h9;
//				 else chan_sel <= 4'h8;
//		4'h9: if(ch_end[4])
//						if(adu_en[0]) 				chan_sel <= 4'h0;
//						else if	(adu_en[1])		chan_sel <= 4'h4;							
//						else chan_sel <= 4'h8;
//				 else chan_sel <= 4'h9;
//				
//		default : chan_sel <= 4'hF;
//	endcase
//end
		
assign ingress_fifo_rd_en[0] =  ~egress_fifo_full & chan_sel == 4'h1 & ~ch_end[0];//~ingress_fifo_empty[0];
assign ingress_fifo_rd_en[1] =  ~egress_fifo_full & chan_sel == 4'h3 & ~ch_end[1];
assign ingress_fifo_rd_en[2] =  ~egress_fifo_full & chan_sel == 4'h5 & ~ch_end[2];
assign ingress_fifo_rd_en[3] =  ~egress_fifo_full & chan_sel == 4'h7 & ~ch_end[3];
assign ingress_fifo_rd_en[4] =  ~egress_fifo_full & chan_sel == 4'h9 & ~ch_end[4];
assign ingress_fifo_rd_en[5] =  ~egress_fifo_full & chan_sel == 4'hb & ~ch_end[5];

reg [N-1:0] ingress_fifo_valid;
always@(posedge init_clk) begin
	ingress_fifo_valid <= ingress_fifo_rd_en;
	if(ingress_fifo_valid[0]) begin
		egress_fifo_wren <= 1'b1;
		egress_fifo_din <= ingress_fifo_out[15:0];
	end
	else if(ingress_fifo_valid[1]) begin
		egress_fifo_wren <= 1'b1;
		egress_fifo_din <= ingress_fifo_out[31:16];
	end
	else if(ingress_fifo_valid[2]) begin
		egress_fifo_wren <= 1'b1;
		egress_fifo_din <= ingress_fifo_out[47:32];
	end
	else if(ingress_fifo_valid[3]) begin
		egress_fifo_wren <= 1'b1;
		egress_fifo_din <= ingress_fifo_out[63:48];
	end
	else if(ingress_fifo_valid[4]) begin
		egress_fifo_wren <= 1'b1;
		egress_fifo_din <= ingress_fifo_out[78:64];
	end
	else if(ingress_fifo_valid[5]) begin
		egress_fifo_wren <= 1'b1;
		egress_fifo_din <= ingress_fifo_out[95:80];				
	end		
	else begin
		egress_fifo_wren <= 1'b0;
		egress_fifo_din <= 15'h0;
	end
end

wire [127:0] ila_mux;
ila ila_muxi(
    .CONTROL(cs_control), // INOUT BUS [35:0]
    .CLK(init_clk), // IN
    .TRIG0(ila_mux) // IN BUS [79:0]
);


assign ila_mux[0] = reset_i;
assign ila_mux[1+:6] = ch_end;
assign ila_mux[7+:6] = ingress_fifo_rd_en;
assign ila_mux[13] = egress_fifo_full;
assign ila_mux[14+:4] = chan_sel;
assign ila_mux[18+:64] = chN_rd_count[191:128];
assign ila_mux[82+:16] = sample_count_value[47:32];

endmodule
