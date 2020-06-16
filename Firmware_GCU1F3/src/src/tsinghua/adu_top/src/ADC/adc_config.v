`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company:         IHEP
// Engineer:        Zhang jie
//
// Create Date:     15:43:41 11/09/2013
// Design Name:
// Module Name:     adc_config
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
//
//  Modified by:  Hu Jun @ IHEP   
//		   Date:  1/10/16
//	Modified by:  Hu Jun @ IHEP   
//		   Data:  2/23/16
// Register 0~15
// ADC1 XXXX XXXX X10X XXXX
// ADC2 XXXX XXXX X11x XXXX
////////////////////////////////////////////////////////////////////////////////
module adc_config#
(parameter [31:0] CONFIG_BASE_ADDR = 32'h0040) 
(
  input           clk,
  input           rst,
  output		      config_done,        // TsingHuaADC is successfully configured
  // Bus interface
	input						config_din_valid,
	input	[31:0] 		config_din_addr,
	input	[31:0] 		config_din_data,
	
	output					config_dout_valid,
	output [31:0] 	config_dout_addr,
	output [31:0] 	config_dout_data,
  // ADC channel control, clock domain: adc_clkdiv[x]
  input   [1:0]   adc_clkdiv,
  output  [1:0]   training_start,
  input   [1:0]   training_done,
  input   [159:0] tap,                // idelay tap value
  output  [1:0]   idly_enable,        // manual control
  output  [7:0]   idly_chan_sel,
  output  [1:0]   idly_inc,
  output  [1:0]   idly_dec,
  output  [1:0]   idly_bitslip,
  output  [1:0]   idly_rst,
  output  [1:0]   adc_sync,           // clock domain: adc_clkdiv[0]
  // SPI port
  output          adc_spi_ck,
  output          adc_spi_mosi,
  input           adc_spi_miso,
  output          adc_spi_csn
);
genvar i;

wire [1:0] training_done_r;
generate
for(i=0;i<=1;i=i+1) begin : flag_training_done_proc
  Signal_CrossDomain flag_training_done (
    .SignalIn_clkA(training_done[i]),
    .clkB(clk),
    .SignalOut_clkB(training_done_r[i])
  );
end
endgenerate

wire [15:0] spi_rx_d;
wire spi_rx_d_valid;
wire [23:0] spi_tx_d;
wire spi_tx_d_valid;
reg auto_config_done;

reg adc_spi_valid;
always @(posedge clk) begin
  if(rst|spi_tx_d_valid) adc_spi_valid <= 0;
  else if(spi_rx_d_valid) adc_spi_valid <= 1;
end
///////////////////////////////////////////////////////////////////////////////
// State Machine
reg [7:0] init_count;
reg init_count_en;
always @(posedge clk) begin
  if(rst) init_count <= 0;
  else
    if(init_count_en) init_count <= init_count + 1'b1;
    else init_count <= 0;
end

reg [4:0] current_state, next_state;
localparam
  INIT = 0,
  WRITE_SPIMODE_REG = 1,
  WRITE_SPIMODE_REG_WAIT = 2,

  WRITE_TEST_REG = 5,
  WRITE_TEST_REG_WAIT = 6,
  
  SYNC = 11,
  SYNC_WAIT = 12,
  TRAINING_START = 13,
  TRAINING_START_WAIT = 14,

  WRITE_TEST_REG_BACK = 17,
  WRITE_TEST_REG_BACK_WAIT = 18,   
  IDLE = 23;
always @(posedge clk)
  if (rst) current_state <= INIT;
  else current_state <= next_state;

reg auto_config_tx_d_valid;
reg [23:0] auto_config_tx_d;
reg auto_config_sync;
reg training_start_r;
always @(*) begin
  next_state = IDLE;
  init_count_en = 0;
  auto_config_tx_d = 0;
  auto_config_tx_d_valid = 0;
  auto_config_sync = 0;
  training_start_r = 0;
  auto_config_done = 0;
  case(current_state)
    INIT: begin
      if(init_count == 8'hFF) next_state = WRITE_TEST_REG;
      else next_state = INIT;
      init_count_en = 1;
    end 
    WRITE_TEST_REG: begin
      next_state = WRITE_TEST_REG_WAIT;
      // auto_config_tx_d = 24'h007000;
      // auto_config_tx_d_valid = 1;
    end
    WRITE_TEST_REG_WAIT: begin
      if(1) next_state = SYNC;//adc_spi_valid
      else next_state = WRITE_TEST_REG_WAIT;
    end
 
    SYNC: begin
      next_state = SYNC_WAIT;
      auto_config_sync = 1'b1;
    end
    SYNC_WAIT: begin
      if(init_count == 8'hFF) next_state = TRAINING_START;
      else next_state = SYNC_WAIT;
      init_count_en = 1;
    end
    TRAINING_START: begin
      next_state = TRAINING_START_WAIT;
      training_start_r = 1'b1;
    end
    TRAINING_START_WAIT: begin
      if(&training_done_r) next_state = WRITE_TEST_REG_BACK;
      else next_state = TRAINING_START_WAIT;
    end
 
    WRITE_TEST_REG_BACK: begin   // normal mode
      next_state = WRITE_TEST_REG_BACK_WAIT;
			// auto_config_tx_d = 24'h00f000;
			// auto_config_tx_d_valid = 1;
    end
    WRITE_TEST_REG_BACK_WAIT: begin
      if(1) next_state = IDLE;//adc_spi_valid
      else next_state = WRITE_TEST_REG_BACK_WAIT;
    end
 
    IDLE: begin
      next_state = IDLE;
      auto_config_done = 1'b1;
    end
    default: next_state = IDLE;
  endcase
end

reg auto_config_sync_r;
always @(posedge clk)
  if(rst) auto_config_sync_r <= 0;
  else auto_config_sync_r <= auto_config_sync;

reg training_start_r_r;
always @(posedge clk)
  if(rst) training_start_r_r <= 0;
  else training_start_r_r <= training_start_r;
generate
for(i=0;i<=0;i=i+1) begin : flag_training_start_proc
  Flag_CrossDomain flag_training_start (
    .clkA(clk),
    .FlagIn_clkA(training_start_r_r),
    .clkB(adc_clkdiv[i]),
    .FlagOut_clkB(training_start[i])
  );
end
endgenerate

////////////////////////////////////////////////////////////////////////////////
wire [7:0] addr = config_din_addr[4:0];

// write reg with signal
reg [1:0]   idly_enable_r;
reg [7:0]  idly_chan_sel_r;
// write reg with flag, auto clear
reg         adc_sync_f;
reg [1:0]   idly_inc_f;
reg [1:0]   idly_dec_f;
reg [1:0]   idly_bitslip_f;
reg [1:0]   idly_rst_f;
// read reg
reg [23:0] reg_dout_r;
reg reg_dout_valid_r;
// to spi interface
reg spi_tx_d_valid_r;
always @(posedge clk) begin
  if(rst) begin
    idly_enable_r <= 0;
    idly_chan_sel_r <= 0;
    adc_sync_f <= 0;
    idly_inc_f <= 0;
    idly_dec_f <= 0;
    idly_bitslip_f <= 0;
    idly_rst_f <= 0;
    reg_dout_r <= 0;
    reg_dout_valid_r <= 0;
    spi_tx_d_valid_r <= 0;
  end
  else begin
    adc_sync_f <= 0;
    idly_inc_f <= 0;
    idly_dec_f <= 0;
    idly_bitslip_f <= 0;
    idly_rst_f <= 0;
    reg_dout_r <= 0;
    reg_dout_valid_r <= 0;
    spi_tx_d_valid_r <= 0;
    if(config_din_valid & config_din_addr[6:5] == CONFIG_BASE_ADDR[6:5]) begin
      reg_dout_valid_r <= 1;
      case (addr[3:0])
        // 4'b1xxx for write, 4'b0xxx for read // ADC chip spi use 0x10, ADC other reg(reserve for test) use 0x00~0x0F,
        4'b0000: begin // SYNC, auto clear
          adc_sync_f <= config_din_data[0];
        end
        4'b0001: begin // read only
          reg_dout_r <= {2'b10,16'habcd, training_done_r[1:0], 3'b0, config_done};
        end
        // ADC A
//        4'bxxxx: begin
//          reg_dout_r[0] <= idly_enable_r[0];
//          reg_dout_r[7:4] <= idly_chan_sel_r[3:0];
//        end
        4'b0010: begin // idelay manual control
          idly_enable_r[0] <= config_din_data[0];
          idly_chan_sel_r[3:0] <= config_din_data[7:4];
        end
        4'b0011: begin // auto clear
          idly_inc_f[0] <= config_din_data[0];
          idly_dec_f[0] <= config_din_data[4];
          idly_bitslip_f[0] <= config_din_data[8];
          idly_rst_f[0] <= config_din_data[12];
        end
        4'b0100: begin // tap, untreated as clock domain crossing
          reg_dout_r <= {3'b0, tap[14:10], 3'b0, tap[9:5], 3'b0, tap[4:0]};
        end
        4'b0101: begin // tap, untreated as clock domain crossing
          reg_dout_r <= {3'b0, tap[29:25], 3'b0, tap[24:20], 3'b0, tap[19:15]};
        end
        4'b0110: begin // tap, untreated as clock domain crossing
          reg_dout_r <= {3'b0, tap[44:40], 3'b0, tap[39:35], 3'b0, tap[34:30]};
        end
        4'b0111: begin // tap, untreated as clock domain crossing
          reg_dout_r <= {3'b0, tap[59:55], 3'b0, tap[54:50], 3'b0, tap[49:45]};
        end
//        // ADC B
////        4'bxxxx: begin
////          reg_dout_r[0] <= idly_enable_r[1];
////          reg_dout_r[7:4] <= idly_chan_sel_r[7:4];
////        end
//        4'b1010: begin // idelay manual control
//          idly_enable_r[1] <= config_din_data[0];
//          idly_chan_sel_r[7:4] <= config_din_data[7:4];
//        end
//        4'b1011: begin // auto clear
//          idly_inc_f[1] <= config_din_data[0];
//          idly_dec_f[1] <= config_din_data[4];
//          idly_bitslip_f[1] <= config_din_data[8];
//          idly_rst_f[1] <= config_din_data[12];
//        end
//        4'b1100: begin // tap, untreated as clock domain crossing
//          reg_dout_r <= {3'b0, tap[94:90], 3'b0, tap[89:85], 3'b0, tap[84:80]};
//        end
//        4'b1101: begin // tap, untreated as clock domain crossing
//          reg_dout_r <= {3'b0, tap[109:105], 3'b0, tap[104:100], 3'b0, tap[99:95]};
//        end
//        4'b1110: begin // tap, untreated as clock domain crossing
//          reg_dout_r <= {3'b0, tap[124:120], 3'b0, tap[119:115], 3'b0, tap[114:110]};
//        end
//        4'b1111: begin // tap, untreated as clock domain crossing
//          reg_dout_r <= {3'b0, tap[139:135], 3'b0, tap[134:130], 3'b0, tap[129:125]};
//        end
        default: begin
          idly_enable_r <= idly_enable_r;
          idly_chan_sel_r <= idly_chan_sel_r;
          adc_sync_f <= 0;
          idly_inc_f <= 0;
          idly_dec_f <= 0;
          idly_bitslip_f <= 0;
          idly_rst_f <= 0;
          reg_dout_r <= reg_dout_r;
          reg_dout_valid_r <= 0;
          if(config_din_addr[4]==1'b1) spi_tx_d_valid_r <= 1'b1;
        end
      endcase
    end
  end
end
generate
for(i=0;i<=0;i=i+1) begin : signal_idly_proc
Signal_CrossDomain signal_idly_enable (
  .SignalIn_clkA(idly_enable_r[i]),
  .clkB(adc_clkdiv[i]),
  .SignalOut_clkB(idly_enable[i])
);
Signal_CrossDomain signal_idly_chan_sel0 (
  .SignalIn_clkA(idly_chan_sel_r[4*i]),
  .clkB(adc_clkdiv[i]),
  .SignalOut_clkB(idly_chan_sel[4*i])
);
Signal_CrossDomain signal_idly_chan_sel1 (
  .SignalIn_clkA(idly_chan_sel_r[4*i+1]),
  .clkB(adc_clkdiv[i]),
  .SignalOut_clkB(idly_chan_sel[4*i+1])
);
Signal_CrossDomain signal_idly_chan_sel2 (
  .SignalIn_clkA(idly_chan_sel_r[4*i+2]),
  .clkB(adc_clkdiv[i]),
  .SignalOut_clkB(idly_chan_sel[4*i+2])
);
Signal_CrossDomain signal_idly_chan_sel3 (
  .SignalIn_clkA(idly_chan_sel_r[4*i+3]),
  .clkB(adc_clkdiv[i]),
  .SignalOut_clkB(idly_chan_sel[4*i+3])
);
end
endgenerate

generate
for(i=0;i<=0;i=i+1) begin : flag_idly_proc
  Flag_CrossDomain flag_adc_sync (
    .clkA(clk),
    .FlagIn_clkA(adc_sync_f|auto_config_sync_r),
    .clkB(adc_clkdiv[i]),
    .FlagOut_clkB(adc_sync[i])
  );
  Flag_CrossDomain flag_idly_inc (
    .clkA(clk),
    .FlagIn_clkA(idly_inc_f[i]),
    .clkB(adc_clkdiv[i]),
    .FlagOut_clkB(idly_inc[i])
  );
  Flag_CrossDomain flag_idly_dec (
    .clkA(clk),
    .FlagIn_clkA(idly_dec_f[i]),
    .clkB(adc_clkdiv[i]),
    .FlagOut_clkB(idly_dec[i])
  );
  Flag_CrossDomain flag_idly_bitslip (
    .clkA(clk),
    .FlagIn_clkA(idly_bitslip_f[i]),
    .clkB(adc_clkdiv[i]),
    .FlagOut_clkB(idly_bitslip[i])
  );
  Flag_CrossDomain flag_idly_rst (
    .clkA(clk),
    .FlagIn_clkA(idly_rst_f[i]),
    .clkB(adc_clkdiv[i]),
    .FlagOut_clkB(idly_rst[i])
  );
end
endgenerate

////////////////////////////////////////////////////////////////////////////////
// ADC SPI Interface
SimpleSPIMaster #(
  .N(16),
  .CPOL(0),
  .CPHA(1),
  .DLY_BEF_SCK(0),
  .DLY_BET_CON_TRA(0),
  .SPI_2X_CLK_DIV(10)
) adc_spi (
  .clk(clk),
  .rst(rst),
  .din(spi_tx_d[23:8]),
  .wr(spi_tx_d_valid),
  .ready(),
  .dout_valid(spi_rx_d_valid),
  .dout(spi_rx_d),
  .spi_cs(adc_spi_csn),
  .spi_sck(adc_spi_ck),
  .spi_mosi(adc_spi_mosi),
  .spi_miso(adc_spi_miso)
);
//assign adc_rstn = ~rst;
assign config_done = auto_config_done;

assign spi_tx_d = (spi_tx_d_valid_r)? config_din_data[23:0]: auto_config_tx_d;
assign spi_tx_d_valid = spi_tx_d_valid_r | auto_config_tx_d_valid;

///////////////////////////////////////////////////////////////////////////////
// bus out
assign config_dout = (spi_rx_d_valid)? {16'b0, spi_rx_d}: {addr, reg_dout_r};
assign config_dout_valid = spi_rx_d_valid | reg_dout_valid_r;
assign config_dout_addr = config_din_addr;

endmodule

