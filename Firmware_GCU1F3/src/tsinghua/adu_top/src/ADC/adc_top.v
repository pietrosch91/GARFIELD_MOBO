`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company:         IHEP
// Engineer:        Zhang Jie, Hu Jun
//
// Create Date:    15:05:04 11/20/2013
// Design Name:
// Module Name:    adc_top
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
//  This adc_top is designed for dual channels ADC like ADS5409,
// while Tsinghua ADC is single channel ADC, so the second channle is disabled.
// Be careful the bit width of the signals is dobule of the one channle ADC.
// The module also contain iodelay (option) that can adjust fine phase between 
// clock and data. It should be used when data is hard to alignment with clock.
////////////////////////////////////////////////////////////////////////////////
module adc_top#(
parameter [31:0] CONFIG_BASE_ADDR = 32'h0040,
parameter N = 0
) 
(
  input           init_clk,
  input           init_rst,
  output          adc_config_done,
  // Bus interface
  input           config_din_valid,
	input	[31:0] 		config_din_addr,
	input	[31:0] 		config_din_data,
	
  output          config_dout_valid,
	output [31:0] 	config_dout_addr,
	output [31:0] 	config_dout_data,
  // data output
  output  [255:0] data_from_iserdes,
  output  [1:0]   adc_clkdiv,
  // ADC Interface
//  output  [1:0]   adc_sync,     // Synchronization signal
	input	[1:0] adc_sync_p,
	input	[1:0] adc_sync_n,	
  input   [31:0]  adc_in_p,     // Differential digital data
  input   [31:0]  adc_in_n,
  input   [1:0]   adc_dr_p,     // Data ready clock in DDR mode
  input   [1:0]   adc_dr_n,
  output          adc_spi_csn,  // SPI interface (24bit)
  output          adc_spi_sclk,
  output          adc_spi_mosi,
  input           adc_spi_miso
);


//////////////////////////////////////////////////////////////////////////////////////////
// DDR data capture
wire [1:0] adc_manual_enable, adc_manual_inc, adc_manual_dec,adc_manual_bitslip, adc_manual_idly_rst;
wire [7:0] adc_manual_chan_sel;
wire [1:0] training_start, training_done;
wire [159:0] tap;
wire [1:0] rxdataisgood;
wire [1:0] adc_sync_in;
wire [1:0] adc_rst;genvar i;
generate
for(i=0;i<=0;i=i+1) begin : ddr_8to1_16chan_rx_proc

   IBUFDS #(
      .DIFF_TERM("TRUE"),       // Differential Termination
      .IBUF_LOW_PWR("TRUE"),     // Low power="TRUE", Highest performance="FALSE" 
      .IOSTANDARD("LVDS_25")     // Specify the input I/O standard
   ) IBUFDS_inst (
      .O(adc_sync_in),  // Buffer output
      .I(adc_sync_p[i]),  // Diff_p buffer input (connect directly to top-level port)
      .IB(adc_sync_n[i]) // Diff_n buffer input (connect directly to top-level port)
   );
   
   
//   OBUFDS #(
//      .IOSTANDARD("LVDS_25"), // Specify the output I/O standard
//      .SLEW("Fast")           // Specify the output slew rate
//   ) OBUFDS_inst (
//      .O(adc_sync_p),     // Diff_p output (connect directly to top-level port)
//      .OB(adc_sync_n),   // Diff_n output (connect directly to top-level port)
//      .I(adc_sync)      // Buffer input 
//   );
//   
    
  Signal_CrossDomain signal_rx_rst (
    .SignalIn_clkA(init_rst),
    .clkB(adc_clkdiv[i]),
    .SignalOut_clkB(adc_rst[i])
  );

ddr_8to1_16chan_rx_gcu #(
    .USE_BUFIO(0),
    .IDELAY_INITIAL_VALUE(0),
    .N(N)
  ) chan_rx (
    // adc interface
    .data_rx_p(adc_in_p[16*i+15:16*i]),
    .data_rx_n(adc_in_n[16*i+15:16*i]),
    .clock_rx_p(adc_dr_p[i]),
    .clock_rx_n(adc_dr_n[i]),
    // rxclkdiv domain
    .rxclk(),
    .rxclkdiv(adc_clkdiv[i]),
    .rxrst(adc_rst[i]),
    .manual_enable(adc_manual_enable[i]),
    .manual_chan_sel(adc_manual_chan_sel[4*i+3:4*i]),
    .manual_inc(adc_manual_inc[i]),
    .manual_dec(adc_manual_dec[i]),
    .manual_bitslip(adc_manual_bitslip[i]),
    .manual_idly_rst(adc_manual_idly_rst[i]),
    .training_start(training_start[i]),
    .training_done(training_done[i]),
    .tap(tap[80*i+79:80*i]),
    .rxdataisgood(rxdataisgood[i]),
    .data_from_iserdes_r(data_from_iserdes[128*i+127:128*i])
);
end
endgenerate  

assign training_done[1] = 1'b1;
assign rxdataisgood[1] = 1'b1;

//////////////////////////////////////////////////////////////////////////////////////////
// ADC configuration
adc_config#
( .CONFIG_BASE_ADDR(CONFIG_BASE_ADDR) 
)
adc_config_i(
  // init_clk domain
  .clk(init_clk),
  .rst(init_rst),
  .config_done(adc_config_done),
  .config_din_valid(config_din_valid),
  .config_din_addr(config_din_addr),
  .config_din_data(config_din_data),
  .config_dout_valid(config_adcb_dout_valid),  
	.config_dout_addr(config_adcb_dout_addr),
  .config_dout_data(config_adcb_dout_data), 
  // rxclkdiv domain
  .adc_clkdiv(adc_clkdiv),
  .training_start(training_start),
  .training_done(training_done),
  .tap(tap),
  .idly_enable(adc_manual_enable),
  .idly_chan_sel(adc_manual_chan_sel),
  .idly_inc(adc_manual_inc),
  .idly_dec(adc_manual_dec),
  .idly_bitslip(adc_manual_bitslip),
  .idly_rst(adc_manual_idly_rst),
  .adc_sync(adc_sync),
  // adc interface
  .adc_spi_ck(adc_spi_sclk),
  .adc_spi_mosi(adc_spi_mosi),
  .adc_spi_miso(adc_spi_miso),
  .adc_spi_csn(adc_spi_csn)
);


endmodule
