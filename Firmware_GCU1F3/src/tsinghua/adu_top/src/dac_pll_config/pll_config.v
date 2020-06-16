`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  IHEP
// Engineer: HuJun
// 
// Create Date:    17:15:30 07/12/2016 
// Design Name: 
// Module Name:    pll_config 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// 16.10.27 modify the config map to IPbus
// Additional Comments: 
// Generate the 1GHz clock for ADC.
// Register 0~15
// XXXX XXXX X010 XXXX
//////////////////////////////////////////////////////////////////////////////////
module pll_config#
(parameter [31:0] CONFIG_BASE_ADDR = 32'h0020)
(
  input           clk,
  input           rst,
  output          config_done,
  // General bus interface
  input           config_din_valid,
	input	[31:0] 		config_din_addr,
	input	[31:0] 		config_din_data,

	output					config_dout_valid,
	output [31:0] 	config_dout_addr,
	output [31:0] 	config_dout_data,
  // SPI
  output          pll_spi_ck,
  output          pll_spi_mosi,
  input           pll_spi_miso,
  output          pll_spi_en
);
// Define the total number of configuration registers
parameter NUM_TO_CONFIG = 19;

// internal signals
wire [31:0] spi_tx_d;
wire spi_tx_d_valid;
wire [31:0] spi_rx_d;
wire spi_rx_d_valid;

reg auto_config_tx_d_valid;
reg [31:0] auto_config_tx_d;
reg auto_config_done;

reg [1:0] pll_spi_en_r;
always @(posedge clk)   // delay for SEN low duration, 160ns at least
  pll_spi_en_r <= {pll_spi_en_r[0], pll_spi_en};

reg [5:0] count;
wire count_inc = auto_config_tx_d_valid;
reg count_clr;
always @(posedge clk) begin
  if(rst | count_clr) count <= 0;
  else if(count_inc) count <= count + 1'b1;
end

reg [23:0] wait_count;
reg wait_count_clr;
always @(posedge clk) begin
  if(rst | count_inc) wait_count <= 0;
  else wait_count <= wait_count + 1'b1;
end

reg [3:0] current_state, next_state;
localparam
  INIT  = 0,
  IDLE  = 1,
  WRITE = 2,
  DATA  = 3,
  WAIT  = 4,
  R0 = 5;
// State Machine
always @(posedge clk)
  if (rst) current_state <= INIT;
  else current_state <= next_state;

always @(*) begin
  next_state = IDLE;
  count_clr = 0;
  auto_config_tx_d_valid = 0;
  auto_config_done = 0;
  case(current_state)
    INIT: begin
      count_clr = 1;
      if(wait_count[10]) next_state = WRITE;
			else  next_state = INIT;
    end
    WRITE: begin
      next_state = DATA;
      auto_config_tx_d_valid = 1;
    end
    DATA: begin
      if(spi_rx_d_valid) next_state = WAIT;
      else next_state = DATA;
    end
    WAIT: begin  // gap between 2 config
      if(count == NUM_TO_CONFIG) next_state = IDLE;
      else begin
        if(~pll_spi_en_r[1]) next_state = WAIT;
        else if(count == 6'd15 || count == 6'd16 || count == NUM_TO_CONFIG-1) next_state = R0;
        else next_state = WRITE;
      end
    end
    R0:begin  // the last R0 config need long time waiting
    	if(wait_count == 24'hFFFFFF) next_state = WRITE;
    	else next_state = R0;
    end
	 	IDLE: begin
			next_state = IDLE;
			auto_config_done = 1;
    end	 
    default: next_state = IDLE;
  endcase
end

always @(posedge clk) begin
  case(count) // 125MHz -> 1GHz
    // write the RST Strobe Reg, Soft Reset
   6'h0  :auto_config_tx_d <= 32'h00000015;  // Reset(R5[4] = 1)
   6'h1  :auto_config_tx_d <= 32'h40870010;  // INIT?
	 6'h2  :auto_config_tx_d <= 32'h021FEA0F;  // RF
	 6'h3  :auto_config_tx_d <= 32'h4080410D;  // RD
	 6'h4  :auto_config_tx_d <= 32'h210050CA;	 // RA
	 6'h5  :auto_config_tx_d <= 32'h03C7C039;	 // R9		 
	 6'h6  :auto_config_tx_d <= 32'h207DDBF8;	 // R8	 
	 6'h7  :auto_config_tx_d <= 32'h00062317;	 // R7
	 6'h8  :auto_config_tx_d <= 32'h000004C6;	 // R6	 
	 6'h9  :auto_config_tx_d <= 32'h0120A805;	 // R5
	 6'ha  :auto_config_tx_d <= 32'h00000004;	 // R4
	 6'hb  :auto_config_tx_d <= 32'h2000F3C3;	 // R3
	 6'hc  :auto_config_tx_d <= 32'h0C000012;  // R2
	 6'hd  :auto_config_tx_d <= 32'hC0000021;	 // R1  C0000011
	 6'he  :auto_config_tx_d <= 32'h60200000;	 // R0	60100000
	 6'hf  :auto_config_tx_d <= 32'h60200000;	 // R0	60100000
	 6'h10  :auto_config_tx_d <= 32'h70200000;	 // R0	70100000
	 6'h11  :auto_config_tx_d <= 32'h0120AC05;	 // R5	 	 
	 6'h12  :auto_config_tx_d <= 32'h70100000;	 // R0	70080000
   default: auto_config_tx_d <= 32'h000004c6; // Just read the chipID
  endcase
end

///////////////////////////////////////////////////////////////////////////////
wire spi_ssel;
SimpleSPIMaster #(
  .N(32),
  .CPOL(0),
  .CPHA(1),
  .SPI_2X_CLK_DIV(10)    // 62.5/5 MHz SPI
) pll_spi (
  .clk(clk),
  .rst(rst),
  .din(spi_tx_d),
  .wr(spi_tx_d_valid),
  .ready(),
  .dout_valid(spi_rx_d_valid),
  .dout(spi_rx_d),
  .spi_cs(spi_ssel),
  .spi_sck(pll_spi_ck),
  .spi_mosi(pll_spi_mosi),
  .spi_miso(pll_spi_miso)
);
assign pll_spi_en = spi_ssel;
assign config_done = auto_config_done;

assign spi_tx_d = config_din_valid? config_din_data : auto_config_tx_d;
assign spi_tx_d_valid = (config_din_valid & (config_din_addr[7:4] == CONFIG_BASE_ADDR[7:4])) | auto_config_tx_d_valid;

assign config_dout_data = spi_rx_d;
assign config_dout_valid = spi_rx_d_valid;
assign config_dout_addr = config_din_addr;

endmodule
