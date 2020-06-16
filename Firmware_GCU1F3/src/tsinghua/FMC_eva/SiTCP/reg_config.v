`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:59:46 04/18/2014 
// Design Name: 
// Module Name:    reg_config 
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
/////////////////////////////////////	  
// 4 cycle config data(32bit) state machine	 
// bit[31] : read--0 or write--1
// bit[28:24] : boards address -- 0: global 1: PCIE Board 2: MB1; 3: DB1; 4: DB2; 5:MB2..... -- equal to user_mem_8_addr
// bit[23:16] : config ADC, PLL or other components address
// bit[15:0]  : config data
//////////////////////////////////////////////////////////////////////////////////
module reg_config(
	// system
	input 			sitcp_user_clk,
	input				aurora_user_clk,
	input 			rst,
	// sitcp udp 
	input           RBCP_ACT,
	input   [31:0]  RBCP_ADDR,
	input           RBCP_WE,
	input   [7:0]   RBCP_WD,
	input           RBCP_RE,
	output  reg [7:0]   RBCP_RD,
	output          RBCP_ACK,
	
	// congfig fifo
	output reg [31:0] cfg_32_data,
	output reg [31:0]  cfg_32_addr,
	output reg cfg_32_valid
    );
//////////////////////////
// rx

reg [2:0] cfg_next_state;
reg  [2:0] cfg_current_state;
reg  [7:0] cfg_data0;
reg  [7:0] cfg_data1;
reg  [7:0] cfg_data2;
reg  [7:0] cfg_data3;

reg udp_wr_ack;
always @ (posedge sitcp_user_clk) begin
		udp_wr_ack <= RBCP_WE;
end

assign  RBCP_ACK = udp_wr_ack;

localparam 
IDLE = 0, 
ADDR = 1, 
DATA_1 = 2, 
DATA_2 = 3, 
DATA_3 = 4, 
DONE = 5;


always @ (posedge sitcp_user_clk) begin
	if(rst)
		cfg_current_state <= IDLE;
	else
		cfg_current_state <= cfg_next_state;
end

always @ (*) begin
	if(rst)
		cfg_next_state = IDLE;
	else 
	case(cfg_current_state) 
		IDLE:if(RBCP_WE)
						cfg_next_state = ADDR;
				else
						cfg_next_state = IDLE;			
		ADDR:if(RBCP_WE)
						cfg_next_state = DATA_1;					
			  else
						cfg_next_state = ADDR;
		DATA_1:if(RBCP_WE)	
						cfg_next_state = DATA_2;									
				else
						cfg_next_state = DATA_1;	
		DATA_2:if(RBCP_WE)
						cfg_next_state = DATA_3;								
				else
						cfg_next_state = DATA_2;					
		DATA_3:
				cfg_next_state = DONE;
		DONE:
				cfg_next_state = IDLE;
		default:
				cfg_next_state = IDLE;
	endcase
end

always @ (posedge sitcp_user_clk) begin
	if(rst) begin
		cfg_32_addr  <= 0;
		cfg_data0 <= 0;
		cfg_data1 <= 0;
		cfg_data2 <= 0;		
		cfg_data3 <= 0;
		cfg_32_valid <= 0;
		cfg_32_data <= 0;		
	end else 
	case(cfg_next_state) 
		IDLE:
				cfg_32_valid <= 1'b0;
		ADDR:if(RBCP_WE) begin
				cfg_32_addr  <= RBCP_ADDR;
				cfg_data0 <= RBCP_WD;
				end
			else begin
				cfg_32_addr  <= cfg_32_addr;
				cfg_data0 <= cfg_data0;
				end
		DATA_1:if(RBCP_WE)
				cfg_data1 <= RBCP_WD;
			else
				cfg_data1 <= cfg_data1;
		DATA_2:if(RBCP_WE)
				cfg_data2 <= RBCP_WD;	
			else
				cfg_data2 <= cfg_data2;				
		DATA_3:if(RBCP_WE)
				cfg_data3 <= RBCP_WD;	
			else
				cfg_data3 <= cfg_data3;				
		DONE: begin
				cfg_32_data <= {cfg_data0,cfg_data1,cfg_data2,cfg_data3};
				cfg_32_valid <= 1'b1;
			end
		default: begin
			cfg_32_addr <= cfg_32_addr;
			cfg_data1 <= cfg_data1;
			cfg_data2 <= cfg_data2;
			cfg_data3 <= cfg_data3;
			cfg_32_valid <= 1'b0;
			cfg_32_data <= 32'b0;
		end
	endcase
end

endmodule