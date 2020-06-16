`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 	IHEP
// Engineer: 	Hu Jun
// 
// Create Date:    23:10:01 10/15/2018 
// Design Name: 
// Module Name:    ADU_top 
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
module ADU_top#(
	              parameter N = 0 // different ADU have different swaped differential pair
                )
   (
	  /* SYS interface*/
	  input          init_clk,
//    input clk200,
	  input          init_rst,
	  input          test_pulse,
	  output         init_done_out,
	  /* ADU interface */
	  //ADC A
	  input          ADCA_DCLKP,
	  input          ADCA_DCLKN,
	  input [13:0]   ADCA_DP,
	  input [13:0]   ADCA_DN,
	  input          ADCA_SYNCP, //output
	  input          ADCA_SYNCN, //output
	  output         ADCA_SCSB,
	  //ADC B
	  input          ADCB_DCLKP,
	  input          ADCB_DCLKN,
	  input [13:0]   ADCB_DP,
	  input [13:0]   ADCB_DN,
	  input          ADCB_SYNCP, //output
	  input          ADCB_SYNCN, //output
	  output         ADCB_SCSB,
	  //PLL
	  output         PLL_LE, //PLL spi enable
	  //DAC
    //	output DAC_NSYNC,		//DAC spi enable	
	  //common SPI
	  output         SPI_CLK,
	  output         SPI_EN,
	  output         SPI_MOSI,
	  input          SPI_MISO, 
	  //Calibration
	  output         CAL_CTRL, // pluse for calibration/selftest.	
	  /* Register for config */ 
	  // din : IPBus to ADU
	  // dout : ADU to IPBus
	  input          config_din_valid,
	  input [31:0]   config_din_addr,
	  input [31:0]   config_din_data,
	 
	  output         config_dout_valid,
	  output [31:0]  config_dout_addr,
	  output [31:0]  config_dout_data,
	  /* raw data and clock */
	  output         adca_user_clk,
	  output [127:0] adca_raw_data,
	  output         adcb_user_clk,
	  output [127:0] adcb_raw_data,
	  inout [35:0]   cs_control
    );
   ///////////////////////////////////////////
     // register space map
   parameter [31:0] PLL_CONFIG_BASE_ADDR = 32'h0020;
   parameter [31:0] DAC_CONFIG_BASE_ADDR = 32'h0010;
   parameter	[31:0] ADCA_CONFIG_BASE_ADDR = 32'h0040;
   parameter	[31:0] ADCB_CONFIG_BASE_ADDR = 32'h0060;     
   /////////////////////////////////////////////////////////////////////////////////////////////
   // PLL Initializtion
   wire            config_pll_dout_valid;
   wire [31:0]     config_pll_dout_addr;
   wire [31:0]     config_pll_dout_data;
   (* KEEP = "TRUE" *) wire            pll_config_done;
   wire            pll_spi_clk,pll_spi_mosi,pll_spi_miso;

   pll_config#
     ( 	.CONFIG_BASE_ADDR(PLL_CONFIG_BASE_ADDR) 
        )
   lmx2581_config (
                   .clk(init_clk), 
                   .rst(init_rst),
	                 .config_done(pll_config_done),	 
                   .config_din_valid(config_din_valid), 
                   .config_din_addr(config_din_addr),
                   .config_din_data(config_din_data),
                   .config_dout_valid(config_pll_dout_valid),  
		               .config_dout_addr(config_pll_dout_addr),
                   .config_dout_data(config_pll_dout_data),  
                   .pll_spi_ck(pll_spi_clk), 
                   .pll_spi_mosi(pll_spi_mosi), 
                   .pll_spi_miso(SPI_MISO), 
                   .pll_spi_en(PLL_LE)
                   );
	 
   ///////////////////////////////////////////////////////////////////////////////////////////////
   //// DAC Initializtion
   //wire 					config_dac_dout_valid;
   //wire	[31:0] 	config_dac_dout_addr;
   //wire 	[31:0] 	config_dac_dout_data;
   //wire 					dac_config_done;
   //wire 					dac_spi_clk,dac_spi_mosi,dac_spi_miso;
   //
   //dac_config//#
   ////( 	.CONFIG_BASE_ADDR(DAC_CONFIG_BASE_ADDR) 
   ////)
   //ad5064_config (
   //    .clk(init_clk), 
   //    .rst(~pll_config_done), 
   //	  .config_done(dac_config_done),
   //    .config_din_valid(config_din_valid), 
   ////    .config_din_addr(config_din_addr),
   //    .config_din(config_din_data),
   //    .config_dout_valid(config_dac_dout_valid),  
   ////		.config_dout_addr(config_dac_dout_addr),
   //    .config_dout_data(config_dac_dout_data),  
   //    .dac_spi_ck(dac_spi_clk), 
   //    .dac_spi_mosi(dac_spi_mosi), 
   //    .dac_spi_miso(SPI_MISO), 
   //    .dac_spi_syncn(DAC_NSYNC)
   //);

   /////////////////////////////////////////////////////////////////////////////////////////////
   // ADC TOP
   // The adc_top module controls dual channels ADC. 
   // However, TsingHua ADC is signal channel ADC, so only half resource is used.
   // We have 2 ADC on one board, so we instantiate 2 module.
   wire            config_adca_dout_valid;
   wire [31:0]     config_adca_dout_addr;
   wire [31:0]     config_adca_dout_data;
   wire            config_adcb_dout_valid;
   wire [31:0]     config_adcb_dout_addr;
   wire [31:0]     config_adcb_dout_data;

   wire            adca_spi_clk,adca_spi_mosi,adca_spi_miso;
   wire            adcb_spi_clk,adcb_spi_mosi,adcb_spi_miso;

   wire            adca_config_done;
   wire            adcb_config_done;

   wire [255:0]    dataa_from_iserdes;
   wire [255:0]    datab_from_iserdes;
   wire [1:0]      adca_clkdiv;
   wire [1:0]      adcb_clkdiv;

   adc_top#
     ( 	.CONFIG_BASE_ADDR(ADCA_CONFIG_BASE_ADDR),
		    .N(2*N)
        )
   adca_top_i (
  	           .init_clk(init_clk),
  	           .init_rst(~pll_config_done),
 	 	           .adc_config_done(adca_config_done),
               .config_din_valid(config_din_valid), 
               .config_din_addr(config_din_addr),
               .config_din_data(config_din_data),
               .config_dout_valid(config_adca_dout_valid),  
		           .config_dout_addr(config_adca_dout_addr),
               .config_dout_data(config_adca_dout_data),  
              // .clk200(clk200),
              // .idelayctrl_ready(idelayctrl_ready),
  	           .data_from_iserdes(dataa_from_iserdes),
  	           .adc_clkdiv(adca_clkdiv),
  	           .adc_sync_p(ADCA_SYNCP),
  	           .adc_sync_n(ADCA_SYNCN),  	
  	           .adc_in_p({2'b0,14'b0,2'b0,ADCA_DP[13:0]}),
  	           .adc_in_n({2'b0,14'b0,2'b0,ADCA_DN[13:0]}),
 	             .adc_dr_p({1'b0,ADCA_DCLKP}),
  	           .adc_dr_n({1'b0,ADCA_DCLKN}),
  	           .adc_spi_csn(ADCA_SCSB),
  	           .adc_spi_sclk(adca_spi_clk),
   	           .adc_spi_mosi(adca_spi_mosi),
   	           .adc_spi_miso(SPI_MISO)
               );

   // if there is only one ADC
   //wire  ADCB_DCLKP = 0;
   //wire	ADCB_DCLKN = 0;
   //wire	[13:0] ADCB_DP = 0;
   //wire  [13:0] ADCB_DN = 0;
   //wire	ADCB_ORP = 0;
   //wire  ADCB_ORN = 0;

   adc_top#
     ( 	.CONFIG_BASE_ADDR(ADCB_CONFIG_BASE_ADDR),
		    .N(2*N+1)
        )
   adcb_top_i (
  	           .init_clk(init_clk),
	             .init_rst(~adca_config_done),
	             .adc_config_done(adcb_config_done),
               .config_din_valid(config_din_valid), 
               .config_din_addr(config_din_addr),
               .config_din_data(config_din_data),
               .config_dout_valid(config_adcb_dout_valid),  
		           .config_dout_addr(config_adcb_dout_addr),
               .config_dout_data(config_adcb_dout_data),  
               //.clk200(clk200),
               //.idelayctrl_ready(idelayctrl_ready),
	             .data_from_iserdes(datab_from_iserdes),
	             .adc_clkdiv(adcb_clkdiv),
  	           .adc_sync_p(ADCB_SYNCP),
  	           .adc_sync_n(ADCB_SYNCN), 
	             .adc_in_p({2'b0,14'b0,2'b0,ADCB_DP[13:0]}),
	             .adc_in_n({2'b0,14'b0,2'b0,ADCB_DN[13:0]}),
	             .adc_dr_p({1'b0,ADCB_DCLKP}),
	             .adc_dr_n({1'b0,ADCB_DCLKN}),
	             .adc_spi_csn(ADCB_SCSB),
	             .adc_spi_sclk(adcb_spi_clk),
	             .adc_spi_mosi(adcb_spi_mosi),
	             .adc_spi_miso(SPI_MISO)
               );

   generate case(N)
              0: begin
                 assign 	adca_user_clk = adca_clkdiv[0];
                 assign  adca_raw_data = {  // bit 13                   bit 12                      bit11                    bit10                    bit9                   bit8                    bit7                  bit6                     bit5                      bit4                 bit3                      bit2                  bit1                     bit0
                                            2'h0, dataa_from_iserdes[104], dataa_from_iserdes[96],  dataa_from_iserdes[88], dataa_from_iserdes[80], dataa_from_iserdes[72], dataa_from_iserdes[64], dataa_from_iserdes[56], dataa_from_iserdes[48], dataa_from_iserdes[40], dataa_from_iserdes[32], dataa_from_iserdes[24], dataa_from_iserdes[16], dataa_from_iserdes[08], dataa_from_iserdes[00],
                                            2'h0, dataa_from_iserdes[105], dataa_from_iserdes[97],  dataa_from_iserdes[89], dataa_from_iserdes[81], dataa_from_iserdes[73], dataa_from_iserdes[65], dataa_from_iserdes[57], dataa_from_iserdes[49], dataa_from_iserdes[41], dataa_from_iserdes[33], dataa_from_iserdes[25], dataa_from_iserdes[17], dataa_from_iserdes[09], dataa_from_iserdes[01],
                                            2'h0, dataa_from_iserdes[106], dataa_from_iserdes[98],  dataa_from_iserdes[90], dataa_from_iserdes[82], dataa_from_iserdes[74], dataa_from_iserdes[66], dataa_from_iserdes[58], dataa_from_iserdes[50], dataa_from_iserdes[42], dataa_from_iserdes[34], dataa_from_iserdes[26], dataa_from_iserdes[18], dataa_from_iserdes[10], dataa_from_iserdes[02],
                                            2'h0, dataa_from_iserdes[107], dataa_from_iserdes[99],  dataa_from_iserdes[91], dataa_from_iserdes[83], dataa_from_iserdes[75], dataa_from_iserdes[67], dataa_from_iserdes[59], dataa_from_iserdes[51], dataa_from_iserdes[43], dataa_from_iserdes[35], dataa_from_iserdes[27], dataa_from_iserdes[19], dataa_from_iserdes[11], dataa_from_iserdes[03],
                                            2'h0, dataa_from_iserdes[108], dataa_from_iserdes[100],  dataa_from_iserdes[92], dataa_from_iserdes[84], dataa_from_iserdes[76], dataa_from_iserdes[68], dataa_from_iserdes[60], dataa_from_iserdes[52], dataa_from_iserdes[44], dataa_from_iserdes[36], dataa_from_iserdes[28], dataa_from_iserdes[20], dataa_from_iserdes[12], dataa_from_iserdes[04],
                                            2'h0, dataa_from_iserdes[109], dataa_from_iserdes[101],  dataa_from_iserdes[93], dataa_from_iserdes[85], dataa_from_iserdes[77], dataa_from_iserdes[69], dataa_from_iserdes[61], dataa_from_iserdes[53], dataa_from_iserdes[45], dataa_from_iserdes[37], dataa_from_iserdes[29], dataa_from_iserdes[21], dataa_from_iserdes[13], dataa_from_iserdes[05],
                                            2'h0, dataa_from_iserdes[110], dataa_from_iserdes[102],  dataa_from_iserdes[94], dataa_from_iserdes[86], dataa_from_iserdes[78], dataa_from_iserdes[70], dataa_from_iserdes[62], dataa_from_iserdes[54], dataa_from_iserdes[46], dataa_from_iserdes[38], dataa_from_iserdes[30], dataa_from_iserdes[22], dataa_from_iserdes[14], dataa_from_iserdes[06],
                                            2'h0, dataa_from_iserdes[111], dataa_from_iserdes[103],  dataa_from_iserdes[95], dataa_from_iserdes[87], dataa_from_iserdes[79], dataa_from_iserdes[71], dataa_from_iserdes[63], dataa_from_iserdes[55], dataa_from_iserdes[47], dataa_from_iserdes[39], dataa_from_iserdes[31], dataa_from_iserdes[23], dataa_from_iserdes[15], dataa_from_iserdes[07]
                                            };	
                 assign 	adcb_user_clk = adcb_clkdiv[0];
                 assign  adcb_raw_data = {  // bit 13                   bit 12                      bit11                    bit10                    bit9                   bit8                    bit7                  bit6                     bit5                      bit4                 bit3                      bit2                  bit1                     bit0          
                                            2'h0, datab_from_iserdes[104], datab_from_iserdes[96],  datab_from_iserdes[88], datab_from_iserdes[80], datab_from_iserdes[72], datab_from_iserdes[64], datab_from_iserdes[56], datab_from_iserdes[48], datab_from_iserdes[40], datab_from_iserdes[32], datab_from_iserdes[24], ~datab_from_iserdes[16], ~datab_from_iserdes[08], ~datab_from_iserdes[00],  // oldest sample 
                                            2'h0, datab_from_iserdes[105], datab_from_iserdes[97],  datab_from_iserdes[89], datab_from_iserdes[81], datab_from_iserdes[73], datab_from_iserdes[65], datab_from_iserdes[57], datab_from_iserdes[49], datab_from_iserdes[41], datab_from_iserdes[33], datab_from_iserdes[25], ~datab_from_iserdes[17], ~datab_from_iserdes[09], ~datab_from_iserdes[01],
                                            2'h0, datab_from_iserdes[106], datab_from_iserdes[98],  datab_from_iserdes[90], datab_from_iserdes[82], datab_from_iserdes[74], datab_from_iserdes[66], datab_from_iserdes[58], datab_from_iserdes[50], datab_from_iserdes[42], datab_from_iserdes[34], datab_from_iserdes[26], ~datab_from_iserdes[18], ~datab_from_iserdes[10], ~datab_from_iserdes[02],
                                            2'h0, datab_from_iserdes[107], datab_from_iserdes[99],  datab_from_iserdes[91], datab_from_iserdes[83], datab_from_iserdes[75], datab_from_iserdes[67], datab_from_iserdes[59], datab_from_iserdes[51], datab_from_iserdes[43], datab_from_iserdes[35], datab_from_iserdes[27], ~datab_from_iserdes[19], ~datab_from_iserdes[11], ~datab_from_iserdes[03],
                                            2'h0, datab_from_iserdes[108], datab_from_iserdes[100], datab_from_iserdes[92], datab_from_iserdes[84], datab_from_iserdes[76], datab_from_iserdes[68], datab_from_iserdes[60], datab_from_iserdes[52], datab_from_iserdes[44], datab_from_iserdes[36], datab_from_iserdes[28], ~datab_from_iserdes[20], ~datab_from_iserdes[12], ~datab_from_iserdes[04],
                                            2'h0, datab_from_iserdes[109], datab_from_iserdes[101],  datab_from_iserdes[93], datab_from_iserdes[85], datab_from_iserdes[77], datab_from_iserdes[69], datab_from_iserdes[61], datab_from_iserdes[53], datab_from_iserdes[45], datab_from_iserdes[37], datab_from_iserdes[29], ~datab_from_iserdes[21], ~datab_from_iserdes[13], ~datab_from_iserdes[05],
                                            2'h0, datab_from_iserdes[110], datab_from_iserdes[102],  datab_from_iserdes[94], datab_from_iserdes[86], datab_from_iserdes[78], datab_from_iserdes[70], datab_from_iserdes[62], datab_from_iserdes[54], datab_from_iserdes[46], datab_from_iserdes[38], datab_from_iserdes[30], ~datab_from_iserdes[22], ~datab_from_iserdes[14], ~datab_from_iserdes[06],
                                            2'h0, datab_from_iserdes[111], datab_from_iserdes[103],  datab_from_iserdes[95], datab_from_iserdes[87], datab_from_iserdes[79], datab_from_iserdes[71], datab_from_iserdes[63], datab_from_iserdes[55], datab_from_iserdes[47], datab_from_iserdes[39], datab_from_iserdes[31], ~datab_from_iserdes[23], ~datab_from_iserdes[15], ~datab_from_iserdes[07]  // newest sample
                                            };	
              end
              1:begin
                 assign 	adca_user_clk = adca_clkdiv[0];
                 assign  adca_raw_data = {  // bit 13                   bit 12                      bit11                    bit10                    bit9                   bit8                    bit7                  bit6                     bit5                      bit4                 bit3                      bit2                  bit1                     bit0
                                            2'h0, dataa_from_iserdes[104], dataa_from_iserdes[96],  dataa_from_iserdes[88], dataa_from_iserdes[80], dataa_from_iserdes[72], dataa_from_iserdes[64], dataa_from_iserdes[56], ~dataa_from_iserdes[48], dataa_from_iserdes[40], dataa_from_iserdes[32], dataa_from_iserdes[24], ~dataa_from_iserdes[16], dataa_from_iserdes[08], dataa_from_iserdes[00],
                                            2'h0, dataa_from_iserdes[105], dataa_from_iserdes[97],  dataa_from_iserdes[89], dataa_from_iserdes[81], dataa_from_iserdes[73], dataa_from_iserdes[65], dataa_from_iserdes[57], ~dataa_from_iserdes[49], dataa_from_iserdes[41], dataa_from_iserdes[33], dataa_from_iserdes[25], ~dataa_from_iserdes[17], dataa_from_iserdes[09], dataa_from_iserdes[01],
                                            2'h0, dataa_from_iserdes[106], dataa_from_iserdes[98],  dataa_from_iserdes[90], dataa_from_iserdes[82], dataa_from_iserdes[74], dataa_from_iserdes[66], dataa_from_iserdes[58], ~dataa_from_iserdes[50], dataa_from_iserdes[42], dataa_from_iserdes[34], dataa_from_iserdes[26], ~dataa_from_iserdes[18], dataa_from_iserdes[10], dataa_from_iserdes[02],
                                            2'h0, dataa_from_iserdes[107], dataa_from_iserdes[99],  dataa_from_iserdes[91], dataa_from_iserdes[83], dataa_from_iserdes[75], dataa_from_iserdes[67], dataa_from_iserdes[59], ~dataa_from_iserdes[51], dataa_from_iserdes[43], dataa_from_iserdes[35], dataa_from_iserdes[27], ~dataa_from_iserdes[19], dataa_from_iserdes[11], dataa_from_iserdes[03],
                                            2'h0, dataa_from_iserdes[108], dataa_from_iserdes[100],  dataa_from_iserdes[92], dataa_from_iserdes[84], dataa_from_iserdes[76], dataa_from_iserdes[68], dataa_from_iserdes[60], ~dataa_from_iserdes[52], dataa_from_iserdes[44], dataa_from_iserdes[36], dataa_from_iserdes[28], ~dataa_from_iserdes[20], dataa_from_iserdes[12], dataa_from_iserdes[04],
                                            2'h0, dataa_from_iserdes[109], dataa_from_iserdes[101],  dataa_from_iserdes[93], dataa_from_iserdes[85], dataa_from_iserdes[77], dataa_from_iserdes[69], dataa_from_iserdes[61], ~dataa_from_iserdes[53], dataa_from_iserdes[45], dataa_from_iserdes[37], dataa_from_iserdes[29], ~dataa_from_iserdes[21], dataa_from_iserdes[13], dataa_from_iserdes[05],
                                            2'h0, dataa_from_iserdes[110], dataa_from_iserdes[102],  dataa_from_iserdes[94], dataa_from_iserdes[86], dataa_from_iserdes[78], dataa_from_iserdes[70], dataa_from_iserdes[62], ~dataa_from_iserdes[54], dataa_from_iserdes[46], dataa_from_iserdes[38], dataa_from_iserdes[30], ~dataa_from_iserdes[22], dataa_from_iserdes[14], dataa_from_iserdes[06],
                                            2'h0, dataa_from_iserdes[111], dataa_from_iserdes[103],  dataa_from_iserdes[95], dataa_from_iserdes[87], dataa_from_iserdes[79], dataa_from_iserdes[71], dataa_from_iserdes[63], ~dataa_from_iserdes[55], dataa_from_iserdes[47], dataa_from_iserdes[39], dataa_from_iserdes[31], ~dataa_from_iserdes[23], dataa_from_iserdes[15], dataa_from_iserdes[07]
                                            };	
                 assign 	adcb_user_clk = adcb_clkdiv[0];
                 assign  adcb_raw_data = {  // bit 13                   bit 12                      bit11                    bit10                    bit9                   bit8                    bit7                  bit6                     bit5                      bit4                 bit3                      bit2                  bit1                     bit0          
                                            2'h0, ~datab_from_iserdes[104], datab_from_iserdes[96],  datab_from_iserdes[88], datab_from_iserdes[80], ~datab_from_iserdes[72], datab_from_iserdes[64], datab_from_iserdes[56], ~datab_from_iserdes[48], datab_from_iserdes[40], datab_from_iserdes[32], ~datab_from_iserdes[24], ~datab_from_iserdes[16], datab_from_iserdes[08], datab_from_iserdes[00],  // oldest sample 
                                            2'h0, ~datab_from_iserdes[105], datab_from_iserdes[97],  datab_from_iserdes[89], datab_from_iserdes[81], ~datab_from_iserdes[73], datab_from_iserdes[65], datab_from_iserdes[57], ~datab_from_iserdes[49], datab_from_iserdes[41], datab_from_iserdes[33], ~datab_from_iserdes[25], ~datab_from_iserdes[17], datab_from_iserdes[09], datab_from_iserdes[01],
                                            2'h0, ~datab_from_iserdes[106], datab_from_iserdes[98],  datab_from_iserdes[90], datab_from_iserdes[82], ~datab_from_iserdes[74], datab_from_iserdes[66], datab_from_iserdes[58], ~datab_from_iserdes[50], datab_from_iserdes[42], datab_from_iserdes[34], ~datab_from_iserdes[26], ~datab_from_iserdes[18], datab_from_iserdes[10], datab_from_iserdes[02],
                                            2'h0, ~datab_from_iserdes[107], datab_from_iserdes[99],  datab_from_iserdes[91], datab_from_iserdes[83], ~datab_from_iserdes[75], datab_from_iserdes[67], datab_from_iserdes[59], ~datab_from_iserdes[51], datab_from_iserdes[43], datab_from_iserdes[35], ~datab_from_iserdes[27], ~datab_from_iserdes[19], datab_from_iserdes[11], datab_from_iserdes[03],
                                            2'h0, ~datab_from_iserdes[108], datab_from_iserdes[100], datab_from_iserdes[92], datab_from_iserdes[84], ~datab_from_iserdes[76], datab_from_iserdes[68], datab_from_iserdes[60], ~datab_from_iserdes[52], datab_from_iserdes[44], datab_from_iserdes[36], ~datab_from_iserdes[28], ~datab_from_iserdes[20], datab_from_iserdes[12], datab_from_iserdes[04],
                                            2'h0, ~datab_from_iserdes[109], datab_from_iserdes[101],  datab_from_iserdes[93], datab_from_iserdes[85], ~datab_from_iserdes[77], datab_from_iserdes[69], datab_from_iserdes[61], ~datab_from_iserdes[53], datab_from_iserdes[45], datab_from_iserdes[37], ~datab_from_iserdes[29], ~datab_from_iserdes[21], datab_from_iserdes[13], datab_from_iserdes[05],
                                            2'h0, ~datab_from_iserdes[110], datab_from_iserdes[102],  datab_from_iserdes[94], datab_from_iserdes[86], ~datab_from_iserdes[78], datab_from_iserdes[70], datab_from_iserdes[62], ~datab_from_iserdes[54], datab_from_iserdes[46], datab_from_iserdes[38], ~datab_from_iserdes[30], ~datab_from_iserdes[22], datab_from_iserdes[14], datab_from_iserdes[06],
                                            2'h0, ~datab_from_iserdes[111], datab_from_iserdes[103],  datab_from_iserdes[95], datab_from_iserdes[87], ~datab_from_iserdes[79], datab_from_iserdes[71], datab_from_iserdes[63], ~datab_from_iserdes[55], datab_from_iserdes[47], datab_from_iserdes[39], ~datab_from_iserdes[31], ~datab_from_iserdes[23], datab_from_iserdes[15], datab_from_iserdes[07]  // newest sample
                                            };	
              end
              2:begin
                 assign 	adca_user_clk = adca_clkdiv[0];
                 assign  adca_raw_data = {  // bit 13                   bit 12                      bit11                    bit10                    bit9                   bit8                    bit7                  bit6                     bit5                      bit4                 bit3                      bit2                  bit1                     bit0
                                            2'h0, dataa_from_iserdes[104], dataa_from_iserdes[96],  dataa_from_iserdes[88], dataa_from_iserdes[80], dataa_from_iserdes[72], dataa_from_iserdes[64], dataa_from_iserdes[56], dataa_from_iserdes[48], dataa_from_iserdes[40], dataa_from_iserdes[32], ~dataa_from_iserdes[24], dataa_from_iserdes[16], dataa_from_iserdes[08], dataa_from_iserdes[00],
                                            2'h0, dataa_from_iserdes[105], dataa_from_iserdes[97],  dataa_from_iserdes[89], dataa_from_iserdes[81], dataa_from_iserdes[73], dataa_from_iserdes[65], dataa_from_iserdes[57], dataa_from_iserdes[49], dataa_from_iserdes[41], dataa_from_iserdes[33], ~dataa_from_iserdes[25], dataa_from_iserdes[17], dataa_from_iserdes[09], dataa_from_iserdes[01],
                                            2'h0, dataa_from_iserdes[106], dataa_from_iserdes[98],  dataa_from_iserdes[90], dataa_from_iserdes[82], dataa_from_iserdes[74], dataa_from_iserdes[66], dataa_from_iserdes[58], dataa_from_iserdes[50], dataa_from_iserdes[42], dataa_from_iserdes[34], ~dataa_from_iserdes[26], dataa_from_iserdes[18], dataa_from_iserdes[10], dataa_from_iserdes[02],
                                            2'h0, dataa_from_iserdes[107], dataa_from_iserdes[99],  dataa_from_iserdes[91], dataa_from_iserdes[83], dataa_from_iserdes[75], dataa_from_iserdes[67], dataa_from_iserdes[59], dataa_from_iserdes[51], dataa_from_iserdes[43], dataa_from_iserdes[35], ~dataa_from_iserdes[27], dataa_from_iserdes[19], dataa_from_iserdes[11], dataa_from_iserdes[03],
                                            2'h0, dataa_from_iserdes[108], dataa_from_iserdes[100],  dataa_from_iserdes[92], dataa_from_iserdes[84], dataa_from_iserdes[76], dataa_from_iserdes[68], dataa_from_iserdes[60], dataa_from_iserdes[52], dataa_from_iserdes[44], dataa_from_iserdes[36], ~dataa_from_iserdes[28], dataa_from_iserdes[20], dataa_from_iserdes[12], dataa_from_iserdes[04],
                                            2'h0, dataa_from_iserdes[109], dataa_from_iserdes[101],  dataa_from_iserdes[93], dataa_from_iserdes[85], dataa_from_iserdes[77], dataa_from_iserdes[69], dataa_from_iserdes[61], dataa_from_iserdes[53], dataa_from_iserdes[45], dataa_from_iserdes[37], ~dataa_from_iserdes[29], dataa_from_iserdes[21], dataa_from_iserdes[13], dataa_from_iserdes[05],
                                            2'h0, dataa_from_iserdes[110], dataa_from_iserdes[102],  dataa_from_iserdes[94], dataa_from_iserdes[86], dataa_from_iserdes[78], dataa_from_iserdes[70], dataa_from_iserdes[62], dataa_from_iserdes[54], dataa_from_iserdes[46], dataa_from_iserdes[38], ~dataa_from_iserdes[30], dataa_from_iserdes[22], dataa_from_iserdes[14], dataa_from_iserdes[06],
                                            2'h0, dataa_from_iserdes[111], dataa_from_iserdes[103],  dataa_from_iserdes[95], dataa_from_iserdes[87], dataa_from_iserdes[79], dataa_from_iserdes[71], dataa_from_iserdes[63], dataa_from_iserdes[55], dataa_from_iserdes[47], dataa_from_iserdes[39], ~dataa_from_iserdes[31], dataa_from_iserdes[23], dataa_from_iserdes[15], dataa_from_iserdes[07]
                                            };	
                 assign 	adcb_user_clk = adcb_clkdiv[0];
                 assign  adcb_raw_data = {  // bit 13                   bit 12                      bit11                    bit10                    bit9                   bit8                    bit7                  bit6                     bit5                      bit4                 bit3                      bit2                  bit1                     bit0          
                                            2'h0, datab_from_iserdes[104], datab_from_iserdes[96],  datab_from_iserdes[88], datab_from_iserdes[80], datab_from_iserdes[72], datab_from_iserdes[64], ~datab_from_iserdes[56], datab_from_iserdes[48], ~datab_from_iserdes[40], datab_from_iserdes[32], datab_from_iserdes[24], ~datab_from_iserdes[16], ~datab_from_iserdes[08], ~datab_from_iserdes[00],  // oldest sample 
                                            2'h0, datab_from_iserdes[105], datab_from_iserdes[97],  datab_from_iserdes[89], datab_from_iserdes[81], datab_from_iserdes[73], datab_from_iserdes[65], ~datab_from_iserdes[57], datab_from_iserdes[49], ~datab_from_iserdes[41], datab_from_iserdes[33], datab_from_iserdes[25], ~datab_from_iserdes[17], ~datab_from_iserdes[09], ~datab_from_iserdes[01],
                                            2'h0, datab_from_iserdes[106], datab_from_iserdes[98],  datab_from_iserdes[90], datab_from_iserdes[82], datab_from_iserdes[74], datab_from_iserdes[66], ~datab_from_iserdes[58], datab_from_iserdes[50], ~datab_from_iserdes[42], datab_from_iserdes[34], datab_from_iserdes[26], ~datab_from_iserdes[18], ~datab_from_iserdes[10], ~datab_from_iserdes[02],
                                            2'h0, datab_from_iserdes[107], datab_from_iserdes[99],  datab_from_iserdes[91], datab_from_iserdes[83], datab_from_iserdes[75], datab_from_iserdes[67], ~datab_from_iserdes[59], datab_from_iserdes[51], ~datab_from_iserdes[43], datab_from_iserdes[35], datab_from_iserdes[27], ~datab_from_iserdes[19], ~datab_from_iserdes[11], ~datab_from_iserdes[03],
                                            2'h0, datab_from_iserdes[108], datab_from_iserdes[100], datab_from_iserdes[92], datab_from_iserdes[84], datab_from_iserdes[76], datab_from_iserdes[68], ~datab_from_iserdes[60], datab_from_iserdes[52], ~datab_from_iserdes[44], datab_from_iserdes[36], datab_from_iserdes[28], ~datab_from_iserdes[20], ~datab_from_iserdes[12], ~datab_from_iserdes[04],
                                            2'h0, datab_from_iserdes[109], datab_from_iserdes[101],  datab_from_iserdes[93], datab_from_iserdes[85], datab_from_iserdes[77], datab_from_iserdes[69], ~datab_from_iserdes[61], datab_from_iserdes[53], ~datab_from_iserdes[45], datab_from_iserdes[37], datab_from_iserdes[29], ~datab_from_iserdes[21], ~datab_from_iserdes[13], ~datab_from_iserdes[05],
                                            2'h0, datab_from_iserdes[110], datab_from_iserdes[102],  datab_from_iserdes[94], datab_from_iserdes[86], datab_from_iserdes[78], datab_from_iserdes[70], ~datab_from_iserdes[62], datab_from_iserdes[54], ~datab_from_iserdes[46], datab_from_iserdes[38], datab_from_iserdes[30], ~datab_from_iserdes[22], ~datab_from_iserdes[14], ~datab_from_iserdes[06],
                                            2'h0, datab_from_iserdes[111], datab_from_iserdes[103],  datab_from_iserdes[95], datab_from_iserdes[87], datab_from_iserdes[79], datab_from_iserdes[71], ~datab_from_iserdes[63], datab_from_iserdes[55], ~datab_from_iserdes[47], datab_from_iserdes[39], datab_from_iserdes[31], ~datab_from_iserdes[23], ~datab_from_iserdes[15], ~datab_from_iserdes[07]  // newest sample
                                            };	
              end
            endcase
   endgenerate
   ////////////////////////
                   //  For chosen from 2 ADCs' data, we should shift the iserdes to sync this 2 ADCs
   //  Add the logic here. Now both ADC'data are output to data processing but we can use only one.
   // g
   //
   ////////////////////////
   assign SPI_EN = ~init_rst;  
   assign SPI_CLK = pll_spi_clk | adca_spi_clk | adcb_spi_clk;
   assign SPI_MOSI = pll_spi_mosi | adca_spi_mosi | adcb_spi_mosi;
   
   assign config_dout_valid = config_pll_dout_valid | config_adca_dout_valid | config_adcb_dout_valid;
   assign config_dout_addr = config_pll_dout_valid? config_pll_dout_addr : config_adca_dout_valid? config_adca_dout_addr : config_adcb_dout_valid? config_adcb_dout_addr : 0;
   assign config_dout_data = config_pll_dout_valid? config_pll_dout_data : config_adca_dout_valid? config_adca_dout_data : config_adcb_dout_valid? config_adcb_dout_data : 0;

   assign init_done_out = adcb_config_done;

   // CALBRATION
   reg 	[20:0] 	cal;
   always @(posedge init_clk)
     begin
        cal = {test_pulse, cal[20:1]};
     end
   
   assign CAL_CTRL = |cal;


   //wire [255:0] debug_adu;
   //ila Inst_ILA_adu_top
   //(
   //    .CONTROL(cs_control),
   //    .CLK(adcb_user_clk),
   //    .TRIG0(debug_adu)
   //);
   //
   //assign debug_adu[0] = init_rst;
   //assign debug_adu[1] = adca_config_done;
   //assign debug_adu[2] = adcb_config_done;
   //assign debug_adu[3+:16] = adcb_raw_data[15:0];


endmodule
