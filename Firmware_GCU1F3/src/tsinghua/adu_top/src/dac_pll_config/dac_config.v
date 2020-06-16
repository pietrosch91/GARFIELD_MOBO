`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         IHEP
// Engineer:        Zhang Jie, Hu Jun
//
// Create Date:     08:59:30 11/01/2013
// Design Name:
// Module Name:     dac_config
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
// Generate 4 voltage for amp&adc bias adjusted, self pulse amplitude.
// Register 0~3
// XXXX XXXX X001 XXXX
//////////////////////////////////////////////////////////////////////////////////
module dac_config#
(parameter [31:0] CONFIG_BASE_ADDR = 32'h0010)
(
  input           clk,
  input           rst,
  output					config_done,
  // Bus interface
  input           config_din_valid,
	input	[31:0] 		config_din_addr,
	input	[31:0] 		config_din_data,
	
  output          config_dout_valid,
	output [31:0] 	config_dout_addr,
	output [31:0] 	config_dout_data,
  // SPI port 
  output          dac_spi_ck,
  output          dac_spi_mosi,
  input           dac_spi_miso,
  output          dac_spi_syncn,
  output					dac_ldac

);
// Define the total number of configuration registers
parameter NUM_TO_CONFIG = 7;

// internal signals
wire [95:0] spi_tx_d;
wire spi_tx_d_valid;
wire [95:0] spi_rx_d;
wire spi_rx_d_valid;

reg auto_config_tx_d_valid;
reg [95:0] auto_config_tx_d;
reg auto_config_done;

(*KEEP = "TRUE"*)reg [3:0] current_state, next_state;
localparam
  INIT  = 0,
  IDLE  = 1,
  WRITE = 2,
  DATA  = 3,
  WAIT  = 4,
  LDAC = 5;
    
wire dac_spi_en;
reg dac_ldac_r;
reg [1:0] dac_spi_en_r;
always @(posedge clk)   //
  dac_spi_en_r <= {dac_spi_en_r[0], dac_spi_en};
reg [9:0] dac_spi_en_d;  
always @(posedge clk) begin
	if(dac_spi_en)
		dac_spi_en_d <= 10'h0;
	else
		dac_spi_en_d <= dac_spi_en_d + 1'b1;
end

reg [5:0] count;
wire count_inc = auto_config_tx_d_valid;
reg count_clr;
reg [23:0] wait_count;
always @(posedge clk) begin
  if(rst | count_clr) count <= 0;
  else if(count_inc) count <= count + 1'b1;
end
always @(posedge clk) begin
  if(rst || count_inc) wait_count <= 0;
  else wait_count <= wait_count + 1'b1;
end

// State Machine
always @(posedge clk)
  if (rst) current_state <= INIT;
  else current_state <= next_state;

always @(*) begin
  next_state = IDLE;
  count_clr = 0;
  auto_config_tx_d_valid = 0;
  auto_config_done = 0;  
	dac_ldac_r = 1'b1;
  case(current_state)
    INIT: begin
			count_clr = 1;
			if(wait_count[10]) next_state = WRITE;
			else next_state = INIT;
    end
    WRITE: begin
      next_state = DATA;
      auto_config_tx_d_valid = 1;
    end
    DATA: begin
      if(spi_rx_d_valid) next_state = LDAC;
      else next_state = DATA;
    end
    WAIT: begin
      if(count == NUM_TO_CONFIG) next_state = IDLE;
//      else begin
//        if(dac_spi_en_d != 10'h3ff) next_state = WAIT;
      else next_state = WRITE;
//      end
    end
    LDAC:begin
    	if(wait_count == 16'hFFFF) next_state = WAIT; // LDAC need 8us after last aync rising
    	else next_state = LDAC;
    	if(wait_count > 16'hFFF0)	dac_ldac_r = 1'b0; // LDAC need 20ns width at least
    end
	 	IDLE: begin
			next_state = IDLE;
			auto_config_done = 1;
    end	
    default: next_state = IDLE;
  endcase
end

always @(posedge clk) begin
  case(count)
    6'h0  :auto_config_tx_d <= {4'h0,4'h8,4'h0, 16'h0000, 4'h2,4'h0,4'h8,4'h0, 16'h0000, 4'h2,4'h0,4'h8,4'h0, 16'h0000, 4'h2}; //enable daisy-chain mode
    6'h1  :auto_config_tx_d <= {4'h0,4'h8,4'h0, 16'h0000, 4'h2,4'h0,4'h8,4'h0, 16'h0000, 4'h2,4'h0,4'h8,4'h0, 16'h0000, 4'h2}; //enable daisy-chain mode
    6'h2  :auto_config_tx_d <= {4'h0,4'h8,4'h0, 16'h0000, 4'h2,4'h0,4'h8,4'h0, 16'h0000, 4'h2,4'h0,4'h8,4'h0, 16'h0000, 4'h2}; //enable daisy-chain mode
            
    6'h3  :auto_config_tx_d <= {4'h0,4'h0,4'h0, 16'h9c00, 4'h0,4'h0,4'h0,4'h0, 16'h9c00, 4'h0,4'h0,4'h0,4'h0, 16'h9c00, 4'h0}; //2.5V FFFF  //
    6'h4  :auto_config_tx_d <= {4'h0,4'h0,4'h1, 16'h9c00, 4'h0,4'h0,4'h0,4'h1, 16'h9c00, 4'h0,4'h0,4'h0,4'h1, 16'h9c00, 4'h0}; //2V  CCCC  //
    6'h5  :auto_config_tx_d <= {4'h0,4'h0,4'h2, 16'h2500, 4'h0,4'h0,4'h0,4'h2, 16'h2500, 4'h0,4'h0,4'h0,4'h2, 16'h2500, 4'h0}; //1.25V 8000//
    6'h6  :auto_config_tx_d <= {4'h0,4'h0,4'h3, 16'hFFFF, 4'h0,4'h0,4'h0,4'h3, 16'hFFFF, 4'h0,4'h0,4'h0,4'h3, 16'hFFFF, 4'h0}; //2V  CCCC  //
    default: auto_config_tx_d <= {96'h0};
  endcase
end

///////////////////////////////////////////////////////////////////////////////
wire spi_ssel;
SimpleSPIMaster #(
  .N(96),
  .CPOL(0),
  .CPHA(0),
  .SPI_2X_CLK_DIV(40)    // 125/80MHz SPI
) dac_spi (
  .clk(clk),
  .rst(rst),
  .din(spi_tx_d),
  .wr(spi_tx_d_valid),
  .ready(),
  .dout_valid(spi_rx_d_valid),
  .dout(spi_rx_d),
  .spi_cs(spi_ssel),
  .spi_sck(dac_spi_ck),
  .spi_mosi(dac_spi_mosi),
  .spi_miso(dac_spi_miso)
);
assign dac_spi_en = ~spi_ssel;
assign dac_spi_syncn = ~dac_spi_en;
assign dac_ldac = dac_ldac_r;
assign config_done = auto_config_done;

//assign spi_tx_d = (config_din_valid)? {4'h0,4'h0,config_din[19:16],config_din[15:0],4'h0} : auto_config_tx_d;
//assign spi_tx_d_valid = (config_din_valid & (config_din[22] == 1'b1)) | auto_config_tx_d_valid;
assign spi_tx_d = config_din_valid? {config_din_data, config_din_data, config_din_data}: auto_config_tx_d;
assign spi_tx_d_valid = (config_din_valid & (config_din_addr[6:4] == CONFIG_BASE_ADDR[6:4])) | auto_config_tx_d_valid;

assign config_dout_data = spi_rx_d;
assign config_dout_valid = spi_rx_d_valid;
assign config_dout_addr = config_din_addr;


endmodule
