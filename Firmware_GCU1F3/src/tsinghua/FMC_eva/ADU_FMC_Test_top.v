`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  IHEP
// Engineer: Hu Jun
// 
// Create Date:    15:25:07 10/16/2018 
// Design Name: 
// Module Name:    ADU_FMC_Test_top 
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
//  2018.10.10 £º mac_select
//////////////////////////////////////////////////////////////////////////////////
module ADU_FMC_Test_top#(
	parameter [7:0] 	FPGA_VER 		= 	8'h10,
	parameter [31:0]  BASE_IP_ADDR  	= 	32'hC0A8_0A10 // 192.168.10.16
)(
	//SYS
	input	INIT_CLK_IN,
	input RESET_IN,
	//FEC
	output ADC_GCL,
	output ADC_GCM,
	output ADC_GCH,
	//ADC A
	input [3-1:0] ADCA_DCLKP,
	input	[3-1:0] ADCA_DCLKN,
	input	[14*3-1:0] ADCA_DP,
	input [14*3-1:0] ADCA_DN,
	input	[3-1:0] ADCA_ORP,
	input	[3-1:0] ADCA_ORN,
	output [3-1:0] ADCA_SCSB,
	//ADC B
	input [3-1:0] ADCB_DCLKP,
	input	[3-1:0] ADCB_DCLKN,
	input	[14*3-1:0] ADCB_DP,
	input [14*3-1:0] ADCB_DN,
	input	[3-1:0] ADCB_ORP,
	input	[3-1:0] ADCB_ORN,
	output [3-1:0] ADCB_SCSB,

	//PLL
	output [3-1:0] PLL_LE,
//	//DAC

	output DAC_SCLK,
	output DAC_NSYNC,
	output DAC_DIN, 	
	output DAC_LDAC, 
	output DAC_CLR,	
	output DAC_POR, 	
	
	//SPI
	output	[3-1:0] SPI_CLK,
	output 	[3-1:0] SPI_EN,
	output	[3-1:0] SPI_MOSI,
//	input		SPI_MISO,
	
	//
	output	[3-1:0] EXT_CLK, // 50Hz ref clkout to mezzanine
	output	[3-1:0] CAL_CTRL,// pluse for calibration/selftest.

  // SFP
	output          SFP_TXP,    	// Tx signal line
	output          SFP_TXN,    	//
	input           SFP_RXP,    	// Rx signal line
	input           SFP_RXN,     	//

	//DEBUG
	output	[1:0] 	LED,
	output	TRIG_OUT,
	input  	TRIG_IN,
	
	input [2:0] SW
	
	
    );

wire [35:0] cs_control0,cs_control1,cs_control2;

/////////////////////////////////////////////////////////////////////////////////////////////
// clock & reset
wire clk125_sys,clk200,clk125,gtpclkin,extout125;
wire locked;
wire idelayctrl_ready;
wire init_rst = ~locked;
wire manual_sys_rst;
//wire  ADCB_DCLKP = 0;
//wire	ADCB_DCLKN = 0;
//wire	[13:0] ADCB_DP = 0;
//wire  [13:0] ADCB_DN = 0;
//wire	ADCB_ORP = 0;
//wire  ADCB_ORN = 0;


clkin_gen clkin_gen_i
   (// Clock in ports
    .CLK_IN1(INIT_CLK_IN),    // IN
    // Clock out ports
    .CLK_OUT1(clk125_sys),     // OUT
    .CLK_OUT2(clk200),     // OUT
    .CLK_OUT3(clk125),     // OUT	
	  .CLK_OUT4(gtpclkin),
	  .CLK_OUT5(extout125),
    // Status and control signals
    .RESET(RESET_IN),// IN
    .LOCKED(locked));      // OUT
    
assign EXT_CLK[0] = extout125;
assign EXT_CLK[1] = extout125;  
assign EXT_CLK[2] = extout125;  
/////////////////////////////////////////////////////////////////////////////////////////////
// FEC Initializtion
assign ADC_GCL = 1'b1;
assign ADC_GCM = 1'b1;
assign ADC_GCH = 1'b0;

///////////////////////////////////////////////////////////////////////////////////////////////
//// DAC Initializtion
wire 				config_din_valid,config_dac_dout_valid;
wire 	[31:0] 	config_din_data,config_din_addr,config_dac_dout_data,config_dac_dout_addr;
wire dac_config_done;
//wire dac_spi_clk,dac_spi_mosi,dac_spi_miso;
//
//wire [31:0] dac_config_data;
//wire dac_config_data_valid;
//
dac_config ad5064_config (
    .clk(clk125_sys), 
    .rst(init_rst), 
	  .config_done(dac_config_done),	  
	  .config_din_valid(config_din_valid), 
    .config_din_addr(config_din_addr), 
    .config_din_data(config_din_data), 
    .config_dout_valid(config_dac_dout_valid), //nc
    .config_dout_addr(config_dac_dout_addr), //nc
    .config_dout_data(config_dac_dout_data), //nc
    .dac_spi_ck(DAC_SCLK), 
    .dac_spi_mosi(DAC_DIN), 
    .dac_spi_miso(), 
    .dac_spi_syncn(DAC_NSYNC),
    .dac_ldac(DAC_LDAC)//
    );
//assign  DAC_LDAC = 1'b1; 
assign  DAC_CLR = 1'b1; 	
assign  DAC_POR = 1'b1;
//assign  DAC_NSYNC = 1'b1;  
//	 
///////////////////////////////////////////////////////////////////////////////////////////////
//// ADC Management
//// The adc_management module controls dual channels ADC. 
//// However, TsingHua ADC is signal channel ADC, so only half resource is used.
//// We have 2 ADC on one board, so we instantiate 2 module.
//wire 				config_adca2c_valid;
//wire 	[31:0] 	config_adca2c;
//wire 				config_adcb2c_valid;
//wire 	[31:0] 	config_adcb2c;
//
//wire adca_spi_clk,adca_spi_mosi,adca_spi_miso;
//wire adcb_spi_clk,adcb_spi_mosi,adcb_spi_miso;
//
//wire				adca_config_done;
//wire				adcb_config_done;
//wire  [1:0] 	adca_sync;
//wire  [1:0] 	adcb_sync;
//

/////////////////////////////////////////////////////////////////////////////////////////////
// ADU module
wire [3-1:0] adu_en;

wire trig_genout;
wire [3-1:0] daq_rst;
wire reset_i = | (adu_en&daq_rst) | manual_sys_rst;


wire [3-1:0] config_adu_dout_valid,config_daq_dout_valid;
wire [32*3-1:0] config_adu_dout_data,config_daq_dout_data;
wire [32*3-1:0] config_adu_dout_addr,config_daq_dout_addr;

wire [2*3-1:0] data_channel_fifo_rd_en;
wire [32*3-1:0] data_channel_fifo_out;
wire [2*3-1:0] data_channel_fifo_full;
wire [2*3-1:0] data_channel_fifo_empty;
wire [3-1:0] overthd_count_8ns_channel; //  over threshold flag

wire [16*3-1:0] sample_count_value;
wire [3-1:0] trigger_stun;
wire trigger_stun_all = 0;// |(adu_en&trigger_stun);
wire [16*3-1:0] trigger_reg;
wire cyctrig_pls;

generate
genvar i; //generate 8 samll fifo for in_data[i] 8X72
for(i=0; i<3; i=i+1) begin: ADU_chi
wire test_pulse;	
wire adu_done_out;
wire adca_user_clk;
wire [127:0] adca_raw_data;
wire adcb_user_clk;
wire [127:0] adcb_raw_data;

ADU_top#
( 	.N(i) 
) adu (
    .init_clk(clk125_sys), 
    .init_rst(~dac_config_done), 
    .test_pulse(test_pulse), 
    .init_done_out(adu_done_out), 
    .ADCA_DCLKP(ADCA_DCLKP[i]), 
    .ADCA_DCLKN(ADCA_DCLKN[i]), 
    .ADCA_DP(ADCA_DP[14*i+13:14*i]), 
    .ADCA_DN(ADCA_DN[14*i+13:14*i]), 
    .ADCA_SYNCP(ADCA_ORP[i]), 
    .ADCA_SYNCN(ADCA_ORN[i]), 
    .ADCA_SCSB(ADCA_SCSB[i]), 
    .ADCB_DCLKP(ADCB_DCLKP[i]), 
    .ADCB_DCLKN(ADCB_DCLKN[i]), 
    .ADCB_DP(ADCB_DP[14*i+13:14*i]), 
    .ADCB_DN(ADCB_DN[14*i+13:14*i]), 
    .ADCB_SYNCP(ADCB_ORP[i]), 
    .ADCB_SYNCN(ADCB_ORN[i]), 
    .ADCB_SCSB(ADCB_SCSB[i]), 
    .PLL_LE(PLL_LE[i]), 
    .SPI_CLK(SPI_CLK[i]), 
    .SPI_EN(SPI_EN[i]), 
    .SPI_MOSI(SPI_MOSI[i]), 
//    .SPI_MISO(SPI_MISO[0]), 
    .CAL_CTRL(CAL_CTRL[i]), 
    .config_din_valid(config_din_valid), 
    .config_din_addr(config_din_addr), 
    .config_din_data(config_din_data), 
    .config_dout_valid(config_adu_dout_valid[i]), //nc
    .config_dout_addr(config_adu_dout_addr[32*i+31:32*i]), //nc
    .config_dout_data(config_adu_dout_data[32*i+31:32*i]), //nc
    .adca_user_clk(adca_user_clk), 
    .adca_raw_data(adca_raw_data), 
    .adcb_user_clk(adcb_user_clk), 
    .adcb_raw_data(adcb_raw_data), 
    .cs_control()
    );

//////////////////////////////////////////////////////////////////////////////////////////
// self-test

//assign CAL_CTRL = ~trig_genout;
//assign TRIG_OUT = trig_genout;
assign test_pulse = ~cyctrig_pls & trigger_reg[16*i+2];


//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
// Data Assembling


//wire reset_adu_chi = ~adcb_config_done|tcp_rst;

data_assembly data_assembly_i(
    .init_clk(clk125_sys), 
    .reset_i(~adu_done_out | manual_sys_rst),
    .trig_in(trig_genout),
    .trig_out(overthd_count_8ns_channel[i]),
    .daq_rst(daq_rst[i]),
  	.sample_count_value(sample_count_value[16*i+15:16*i]),
  	.trigger_stun(trigger_stun[i]),
    .config_din_valid(config_din_valid),
    .config_din_addr(config_din_addr),
    .config_din_data(config_din_data),
    .config_dout_valid(config_daq_dout_valid[i]),     
    .config_dout_addr(config_daq_dout_addr[32*i+31:32*i]),
    .config_dout_data(config_daq_dout_data[32*i+31:32*i]),
    .adc_raw_data({adcb_raw_data,adca_raw_data}), 
    .adc_user_clk({adcb_user_clk,adca_user_clk}), 
    
    .data_channel_fifo_rd_en(data_channel_fifo_rd_en[2*i+1:2*i]), 
    .data_channel_fifo_out(data_channel_fifo_out[32*i+31:32*i]), 
    .data_channel_fifo_full(data_channel_fifo_full[2*i+1:2*i]), 
    .data_channel_fifo_empty(data_channel_fifo_empty[2*i+1:2*i]),

    .trigger_reg(trigger_reg[16*i+15:16*i])
    );

end
endgenerate

assign TRIG_OUT = trig_genout;

//////////////////////////////////////////////////////////////////////////////////////////
// Trigger generator
wire          tcp_open;
trig_gen trig_gen_i (
    .init_clk(clk125_sys), 
    .reset_i(reset_i),
    .trigger_stun(trigger_stun_all),//|~tcp_open),
    .trigger_reg(trigger_reg[15:0]),
    .overth(overthd_count_8ns_channel), 
    .trig_in(TRIG_IN), 
    .trig_out(trig_genout),
    .cyctrig_pls(cyctrig_pls)
    );
    
//////////////////////////////////////////////////////////////////////////////////////////
// SiTCP interface
wire          clk125_remote;
//wire          tcp_open;
wire          tcp_error;
wire          tcp_rst;
wire          tcp_close;

wire          tcp_rx_wr;
wire  [7:0]   tcp_rx_data;
wire  [15:0]  tcp_rx_wc;

wire          tcp_tx_wr;
wire  [7:0]   tcp_tx_data;
wire          tcp_tx_full;

wire  [31:0]  rbcp_addr;
wire          rbcp_we;
wire  [7:0]   rbcp_wd;
wire          rbcp_re;
wire          rbcp_act;
wire          rbcp_ack;
wire  [7:0]   rbcp_rd;

SiTCP#(
  .BASE_IP_ADDR(BASE_IP_ADDR)
) SiTCP_inst (
    .RST(init_rst), 
    .CLK(clk125_remote),  //clk125
    .CLK200(clk200), 
    .CLKOUT(clk125_remote), 
    .MAC_SELECT({1'b0,SW}), 
    .IP_SELECT({1'b0,SW}), 
    .TIM_1US(), 
    .TIM_1MS(), 
    .TIM_1S(), 
    .TIM_1M(), 
    .TCP_OPEN(tcp_open), 
    .TCP_ERROR(tcp_error), 
    .TCP_RST(tcp_rst), 
    .TCP_CLOSE(tcp_close), 
    .TCP_RX_WC(tcp_rx_wc), 
    .TCP_RX_WR(tcp_rx_wr), 
    .TCP_RX_DATA(tcp_rx_data), 
    .TCP_TX_FULL(tcp_tx_full), 
    .TCP_TX_WR(tcp_tx_wr), 
    .TCP_TX_DATA(tcp_tx_data), 
    .RBCP_ADDR(rbcp_addr), 
    .RBCP_WE(rbcp_we), 
    .RBCP_WD(rbcp_wd), 
    .RBCP_RE(rbcp_re), 
    .RBCP_ACT(rbcp_act), 
    .RBCP_ACK(rbcp_ack), 
    .RBCP_RD(rbcp_rd), 
    .GTREFCLK(gtpclkin), 
    .SFP_TXP(SFP_TXP), 
    .SFP_TXN(SFP_TXN), 
    .SFP_RXP(SFP_RXP), 
    .SFP_RXN(SFP_RXN)
    );

wire [31:0] cfg_32_data,cfg_32_addr;
wire cfg_32_valid;

reg_config reg_config_i(
	// system
	.sitcp_user_clk(clk125_remote),
	.aurora_user_clk(clk125_sys),
	.rst(init_rst),
	// sitcp udp 
	.RBCP_ACT(rbcp_act),
	.RBCP_ADDR(rbcp_addr),
	.RBCP_WE(rbcp_we),
	.RBCP_WD(rbcp_wd),
	.RBCP_RE(rbcp_re),
	.RBCP_RD(rbcp_rd),
	.RBCP_ACK(rbcp_ack),
	
	// congfig fifo
	.cfg_32_data(cfg_32_data),
	.cfg_32_addr(cfg_32_addr),
	.cfg_32_valid(cfg_32_valid)
);


/////////////////////////////////////////////////////
// cfg fifo : forward cfg data to mb and db.

wire cfg0_fifo_full;
 
dfifo_32x32_16 cfg0_fifo(
  .wr_clk(clk125),
  .rd_clk(clk125_sys),
  .rst(init_rst),  // && !channel_up //if sfp disconnect , clear all config data
  .din({cfg_32_addr,cfg_32_data}),
  .wr_en(cfg_32_valid),
  .full(cfg0_fifo_full),
  .rd_en(~cfg0_fifo_empty),
  .dout({config_din_addr,config_din_data}),
  .valid(config_din_valid),
  .empty(cfg0_fifo_empty)
);
	 
//////////////////////////////////////////////////////////////////////////////////
// SiTCP fifo
wire sitcp_fifo_full, sitcp_fifo_empty, sitcp_fifo_rden,sitcp_fifo_error_full;
wire [15:0]  sitcp_fifo_din;
wire sitcp_fifo_wren;

sitcp_fifo fifo16x4096 (
//  .rst(reset_i | ~tcp_open), // input rst
	.rst(reset_i), // input rst  
  .wr_clk(clk125_sys), // input wr_clk
  .rd_clk(clk125), // input rd_clk
  .din(sitcp_fifo_din), // input [15 : 0] din
  .wr_en(sitcp_fifo_wren), // input wr_en
  .rd_en(sitcp_fifo_rden), // input rd_en
  .dout(tcp_tx_data), // output [7 : 0] dout
  .full(sitcp_fifo_error_full), // output full
  .prog_full(sitcp_fifo_full),
  .empty(sitcp_fifo_empty), // output empty
  .valid(tcp_tx_wr), // output valid
  .rd_data_count(tcp_rx_wc[12:0]) // output [13 : 0] rd_data_count
);
assign  tcp_rx_wc[15:13]  = 3'b111;
//assign  sitcp_fifo_rden = ~tcp_tx_full & ~sitcp_fifo_empty;
assign  sitcp_fifo_rden = ~sitcp_fifo_empty;

//////////////////////////////////////////////////////////////////////////////////
// data_mux
data_mux #(
  .N(6)
)chsNin1 (
    .init_clk(clk125_sys), 
    .reset_i(reset_i), 
    .sample_count_value(sample_count_value),
    .adu_en(adu_en),
    .ingress_fifo_rd_en(data_channel_fifo_rd_en), 
    .ingress_fifo_out(data_channel_fifo_out), 
    .ingress_fifo_empty(data_channel_fifo_empty), 
    .egress_fifo_din(sitcp_fifo_din), 
    .egress_fifo_wren(sitcp_fifo_wren), 
    .egress_fifo_full(sitcp_fifo_full),
    .cs_control(cs_control2)
);

//always @(posedge clk125_sys) begin
//  if(init_rst) begin
//    config_sys2c <= 0;
//    config_sys2c_valid <= 0;
//  end
//  else begin
//    config_sys2c_valid <= 0;
//    if(config_c2d_valid) begin
//      config_sys2c_valid <= 1;
//      case (config_c2d[31:24])
//        // 8'b1111_xxxx for write, 8'b0111_xxxx for read
//        8'hF0: begin // RST, auto clear
//			 config_sys2c <= config_c2d;
//        end
//        8'h71: begin // read only
////          config_sys2c <= {config_c2d[31:24], err_count[0:7],
////            4'b0, frame_err, soft_err, hard_err, channel_up,
////            3'b0, adc_config_done, 3'b0, sampleclk_pll_locked};
//				config_sys2c <= {config_c2d[31:24],23'b0,adu0_done_out};
//        end
////        8'h72: begin
////          config_sys2c <= {config_c2d[31:24], 14'b0, sample_delay_value_r};
////        end
////        8'hF2: begin
////          sample_delay_value_r <= config_c2d[9:0];
////        end
//        default: begin
////          sample_delay_value_r <= sample_delay_value_r;
//          config_sys2c <= config_sys2c;
//          config_sys2c_valid <= 0;
//        end
//      endcase
//    end
//  end
//end

//////////////////////////////////////////////////////
// manual_sys_rst
// 
//wire manual_sys_rst;
//reg [127:0] manual_sys_rst_r;
//always@(posedge sitcp_user_clk) begin
//    if(rst) manual_sys_rst_r  <= 127'h0;
//	 else begin    
//      if(cfg_32_valid) begin
//				case(cfg_32_data[31:16])
//					24'h01F0: manual_sys_rst_r <= cfg_32_data[0]; //soft reset
//					// add other defination
//				endcase
//		end
//		else
//			manual_sys_rst_r <= manual_sys_rst_r<<1;
//	 end
//end
//
//assign manual_sys_rst = ~(|manual_sys_rst_r);
//


//////////////////////////////////////////////////////////////////////////////////////////
// Debug

wire [3:0] vio_async_out;
wire [127:0] ila_top;

icon icon_i (
    .CONTROL0(cs_control0), // INOUT BUS [35:0]
		.CONTROL1(cs_control1),
		.CONTROL2(cs_control2)
);

vio vio_i (
    .CONTROL(cs_control0), // INOUT BUS [35:0]
    .ASYNC_OUT(vio_async_out) // IN BUS [32:0]
);

assign manual_sys_rst = ~vio_async_out[3];
assign adu_en = vio_async_out[2:0];

ila ila_i(
    .CONTROL(cs_control1), // INOUT BUS [35:0]
    .CLK(clk125_sys), // IN
    .TRIG0(ila_top) // IN BUS [127:0]
);


assign ila_top[0] = reset_i;
assign ila_top[1+:16] = sitcp_fifo_din;
assign ila_top[17] = sitcp_fifo_wren;
assign ila_top[18] = sitcp_fifo_rden;
assign ila_top[19+:6] = data_channel_fifo_empty;
assign ila_top[25+:6] = data_channel_fifo_rd_en;
assign ila_top[31+:3] = daq_rst;
assign ila_top[34+:3] = trigger_stun;
assign ila_top[37] = sitcp_fifo_full;
assign ila_top[38+:3] = adu_en;
assign ila_top[41] = trig_genout;

//assign dac_config_data = sync_out[31:0];
//reg sync_out_valid_r;
//always@(posedge clk125_sys)
//	sync_out_valid_r <= sync_out[32];
//	
//assign dac_config_data_valid = ~sync_out_valid_r & sync_out[32];

reg [27:0] cnt0,cnt1,cnt2,cnt3,cnt4,cnt5;
always @(posedge clk125_sys) begin
  if(init_rst) cnt0 <= 0;
  else cnt0 <= cnt0 + 1'b1;
end
assign LED[0] = cnt0[26];

always @(posedge ADU_chi[0].adca_user_clk) begin
  if(init_rst) cnt1 <= 0;
  else cnt1 <= cnt1 + 1'b1;
end
//assign LED[0] = cnt1[26];

always @(posedge ADU_chi[2].adcb_user_clk) begin
  if(init_rst) cnt2 <= 0;
  else cnt2 <= cnt2 + 1'b1;
end
assign LED[1] = cnt2[26];


endmodule
