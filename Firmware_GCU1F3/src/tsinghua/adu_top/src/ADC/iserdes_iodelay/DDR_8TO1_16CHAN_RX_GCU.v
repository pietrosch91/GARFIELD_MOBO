`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////
//
//    File Name:  DDR_8TO1_16CHAN_RX.v
//      Version:  1.0
//         Date:  05/19/06
//        Model:  XAPP855 LVDS Receiver Module
//
//      Company:  Xilinx
//  Contributor:  APD Applications Group
//
//  Modified by:  Zhang Jie @ IHEP
//         Date:  11/11/13
//  Modified by:  Hu Jun @ IHEP
//         Date:  1/6/16
///////////////////////////////////////////////////////////////////////////////
//
// Summary: This file is modified from DDR_8TO1_16CHAN_RX.v
//
// This module contains 16 channels of LVDS data, one channel of LVDS clock, a
// clock/data alignment algorithm, control circuit to share the alignment
// machine among all 16 data channels, and tap counters that keep track of the
// IDELAY tap setting of all data channels.
//
//----------------------------------------------------------------

module ddr_8to1_16chan_rx_gcu #(
  parameter USE_BUFIO     = 0,
  parameter IDELAY_INITIAL_VALUE = 0,
  parameter CHAN = 14,
  parameter N = 0
)(
  // adc interface
  input   [15:0]   data_rx_p,        // serial side rx data (P)
  input   [15:0]   data_rx_n,        // serial side rx data (N)
  input           clock_rx_p,       // forwarded clock from tx (P)
  input           clock_rx_n,       // forwarded clock from tx (N)
  // rxclkdiv domain
  output          rxclk,            // forwarded clock from tx (bufio output)
  output          rxclkdiv,         // parallel side rx clock (divided from rxclk)
  input           rxrst,
  input           manual_enable,    // manual enable, sync to rxclkdiv
  input   [3:0]   manual_chan_sel,  // manual select channel
  input           manual_inc,       // flag: manual increment to data delay
  input           manual_dec,       // flag: manual decrement to data delay
  input           manual_bitslip,   // flag: manual bitslip to data
  input           manual_idly_rst,  // flag: idelay tap reset
  input           training_start,   // flag: start to make data alignment
  output          training_done,    // alignment of all channels complete
  output  [79:0]  tap,              // idelay tap count (0-31)
  output          rxdataisgood,     // indicate rxdata is good, output for chipscope
  output reg [127:0]  data_from_iserdes_r // parallel side rx data
);

wire clock_rx_buf;
IBUFGDS #(
  .DIFF_TERM("TRUE"),
  .IOSTANDARD("LVDS_25")
) source_sync_clock_in (  // source synchronous clock input
  .O(clock_rx_buf),
  .I(clock_rx_p),
  .IB(clock_rx_n)
);

	wire rxclk0,rxclk1,rxclk2,rxclkdiv0,rxclkdiv1,rxclkdiv2;
	reg [255:0] data_from_iserdes_temp;
	wire [127:0] data_from_iserdes;
assign rxclk = rxclk0;
assign rxclkdiv = rxclkdiv0;
generate
if (N == 0 || N ==1) begin
  wire clock_rx_iserdes_out,rxclk_mr;

	
  IDELAYE2 #(
      .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
      .DELAY_SRC("IDATAIN"),           // Delay input (IDATAIN, DATAIN)
      .HIGH_PERFORMANCE_MODE("TRUE"), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
      .IDELAY_TYPE("FIXED"),           // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
      .IDELAY_VALUE(IDELAY_INITIAL_VALUE),                // Input delay tap setting (0-31)
      .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
      .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0).
      .SIGNAL_PATTERN("CLOCK")          // DATA, CLOCK input signal
   )
   IDELAYE2_inst (
      .CNTVALUEOUT(), // 5-bit output: Counter value output
      .DATAOUT(clock_rx_iserdes_out),         // 1-bit output: Delayed data output
      .C(1'b0),                     // 1-bit input: Clock input
      .CE(1'b0),                   // 1-bit input: Active high enable increment/decrement input
      .CINVCTRL(1'b0),       // 1-bit input: Dynamic clock inversion input
      .CNTVALUEIN(5'b0),   // 5-bit input: Counter value input
      .DATAIN(1'b0),           // 1-bit input: Internal delay data input
      .IDATAIN(clock_rx_buf),         // 1-bit input: Data input from the I/O
      .INC(1'b0),                 // 1-bit input: Increment / Decrement tap delay input
      .LD(0),   // rxrst               // 1-bit input: Load IDELAY_VALUE input
      .LDPIPEEN(1'b0),       // 1-bit input: Enable PIPELINE register to load data input
      .REGRST(0)   //rxrst         // 1-bit input: Active-high reset tap-delay input
   );

   BUFMRCE #(
      .CE_TYPE("SYNC"), // SYNC, ASYNC
      .INIT_OUT(0)      // Initial output and stopped polarity, (0-1)
   )
   rx_clk_bufmrce (
      .O(rxclk_mr),   // 1-bit output: Clock output (connect to BUFIOs/BUFRs)
      .CE(1'b1), // 1-bit input: Active high buffer enable
      .I(clock_rx_iserdes_out)    // 1-bit input: Clock input (Connect to IBUF)
   );






  BUFIO rx_clk_bufio0 (  // clock buffer for serial side clock
    .O(rxclk0),
    .I(rxclk_mr)
  );
  
  BUFR #(
    .BUFR_DIVIDE("4"),
	 .SIM_DEVICE("7SERIES") 
  ) RX_CLK_BUFR0 (       // clock buffer/divider for parallel side clock
    .O(rxclkdiv0),
    .CE(1'b1),
    .CLR(1'b0),
    .I(rxclk_mr)
  );
  
  BUFIO rx_clk_bufio1 (  // clock buffer for serial side clock
    .O(rxclk1),
    .I(rxclk_mr)
  );
  
  BUFR #(
    .BUFR_DIVIDE("4"),
	 .SIM_DEVICE("7SERIES") 
  ) RX_CLK_BUFR1 (       // clock buffer/divider for parallel side clock
    .O(rxclkdiv1),
    .CE(1'b1),
    .CLR(1'b0),
    .I(rxclk_mr)
  );
  
    BUFIO rx_clk_bufio2 (  // clock buffer for serial side clock
    .O(rxclk2),
    .I(rxclk_mr)
  );
  
  BUFR #(
    .BUFR_DIVIDE("4"),
	 .SIM_DEVICE("7SERIES") 
  ) RX_CLK_BUFR2 (       // clock buffer/divider for parallel side clock
    .O(rxclkdiv2),
    .CE(1'b1),
    .CLR(1'b0),
    .I(rxclk_mr)
  );
	
end
else  begin
  wire rxclkn,clk2_buf, clk0_buf, clkdv_buf;
  wire        clkfbout;
  wire        clkfbout_buf;
  
     MMCME2_BASE #(
      .BANDWIDTH("OPTIMIZED"),   // Jitter programming (OPTIMIZED, HIGH, LOW)
      .CLKFBOUT_MULT_F(2.0),     // Multiply value for all CLKOUT (2.000-64.000).
      .CLKFBOUT_PHASE(0.0),      // Phase offset in degrees of CLKFB (-360.000-360.000).
      .CLKIN1_PERIOD(2.0),       // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
      // CLKOUT0_DIVIDE - CLKOUT6_DIVIDE: Divide amount for each CLKOUT (1-128)
      .CLKOUT1_DIVIDE(8),
      .CLKOUT0_DIVIDE_F(2.0),    // Divide amount for CLKOUT0 (1.000-128.000).
		.CLKOUT2_DIVIDE(2),
      // CLKOUT0_DUTY_CYCLE - CLKOUT6_DUTY_CYCLE: Duty cycle for each CLKOUT (0.01-0.99).
      .CLKOUT0_DUTY_CYCLE(0.5),
      .CLKOUT1_DUTY_CYCLE(0.5),
		.CLKOUT2_DUTY_CYCLE(0.5),
      // CLKOUT0_PHASE - CLKOUT6_PHASE: Phase offset for each CLKOUT (-360.000-360.000).
      .CLKOUT0_PHASE(0.0),
      .CLKOUT1_PHASE(0.0),
		.CLKOUT2_PHASE(180.0),
      .DIVCLK_DIVIDE(1),         // Master division value (1-106)
      .REF_JITTER1(0.0),         // Reference input jitter in UI (0.000-0.999).
      .STARTUP_WAIT("FALSE")     // Delays DONE until MMCM is locked (FALSE, TRUE)
   )
   MMCME2_BASE_inst (
      // Clock Outputs: 1-bit (each) output: User configurable clock outputs
      .CLKOUT0(clk0_buf),     // 1-bit output: CLKOUT0
      .CLKOUT1(clkdv_buf),     // 1-bit output: CLKOUT1
      // Feedback Clocks: 1-bit (each) output: Clock feedback ports
      .CLKFBOUT(clkfbout),   // 1-bit output: Feedback clock
      // Status Ports: 1-bit (each) output: MMCM status ports
      .LOCKED(locked),       // 1-bit output: LOCK
      // Clock Inputs: 1-bit (each) input: Clock input
      .CLKIN1(clock_rx_buf),       // 1-bit input: Clock
      // Control Ports: 1-bit (each) input: MMCM control ports
      .PWRDWN(0),       // 1-bit input: Power-down
      .RST(1'b0),             // 1-bit input: Reset
      // Feedback Clocks: 1-bit (each) input: Clock feedback ports
      .CLKFBIN(clkfbout_buf)      // 1-bit input: Feedback clock
   );

  BUFG clkf_buf
   (.O (clkfbout_buf),
    .I (clkfbout));

  BUFG CLK0_BUFG_INST (
    .I(clk0_buf),
    .O(rxclk0)
  );
  BUFG CLKDV_BUFG_INST (
    .I(clkdv_buf),
    .O(rxclkdiv0)
  );
end
endgenerate

///////////////////////////////////////////////////////////////////////////////////////
wire        manual_ice = manual_dec | manual_inc;
wire  [3:0] chan_sel_to_machine;
reg   [7:0] data_to_machine;
wire        ice_from_machine, inc_from_machine, bitslip_from_machine;
reg   [15:0] ice_to_iserdes,   inc_to_iserdes,   bitslip_to_iserdes;
// channel select logic to share alignment machine resources in round robin fashion
always @(posedge rxclkdiv) begin
  if(manual_enable) begin
    case (manual_chan_sel)
      4'b0000: begin
        data_to_machine     <= data_from_iserdes[7:0];
        inc_to_iserdes      <= {15'b0, manual_inc};
        ice_to_iserdes      <= {15'b0, manual_ice};
        bitslip_to_iserdes  <= {15'b0, manual_bitslip};
      end
      4'b0001: begin
        data_to_machine     <= data_from_iserdes[15:8];
        inc_to_iserdes      <= {14'b0, manual_inc,     1'b0};
        ice_to_iserdes      <= {14'b0, manual_ice,     1'b0};
        bitslip_to_iserdes  <= {14'b0, manual_bitslip, 1'b0};
      end
      4'b0010: begin
        data_to_machine     <= data_from_iserdes[23:16];
        inc_to_iserdes      <= {13'b0, manual_inc,     2'b0};
        ice_to_iserdes      <= {13'b0, manual_ice,     2'b0};
        bitslip_to_iserdes  <= {13'b0, manual_bitslip, 2'b0};
      end
      4'b0011: begin
        data_to_machine     <= data_from_iserdes[31:24];
        inc_to_iserdes      <= {12'b0, manual_inc,     3'b0};
        ice_to_iserdes      <= {12'b0, manual_ice,     3'b0};
        bitslip_to_iserdes  <= {12'b0, manual_bitslip, 3'b0};
      end
      4'b0100: begin
        data_to_machine     <= data_from_iserdes[39:32];
        inc_to_iserdes      <= {11'b0, manual_inc,     4'b0};
        ice_to_iserdes      <= {11'b0, manual_ice,     4'b0};
        bitslip_to_iserdes  <= {11'b0, manual_bitslip, 4'b0};
      end
      4'b0101: begin
        data_to_machine     <= data_from_iserdes[47:40];
        inc_to_iserdes      <= {10'b0, manual_inc,     5'b0};
        ice_to_iserdes      <= {10'b0, manual_ice,     5'b0};
        bitslip_to_iserdes  <= {10'b0, manual_bitslip, 5'b0};
      end
      4'b0110: begin
        data_to_machine     <= data_from_iserdes[55:48];
        inc_to_iserdes      <= {9'b0, manual_inc,     6'b0};
        ice_to_iserdes      <= {9'b0, manual_ice,     6'b0};
        bitslip_to_iserdes  <= {9'b0, manual_bitslip, 6'b0};
      end
      4'b0111: begin
        data_to_machine     <= data_from_iserdes[63:56];
        inc_to_iserdes      <= {8'b0, manual_inc,     7'b0};
        ice_to_iserdes      <= {8'b0, manual_ice,     7'b0};
        bitslip_to_iserdes  <= {8'b0, manual_bitslip, 7'b0};
      end
      4'b1000: begin
        data_to_machine     <= data_from_iserdes[71:64];
        inc_to_iserdes      <= {7'b0, manual_inc,     8'b0};
        ice_to_iserdes      <= {7'b0, manual_ice,     8'b0};
        bitslip_to_iserdes  <= {7'b0, manual_bitslip, 8'b0};
      end
      4'b1001: begin
        data_to_machine     <= data_from_iserdes[79:72];
        inc_to_iserdes      <= {6'b0, manual_inc,     9'b0};
        ice_to_iserdes      <= {6'b0, manual_ice,     9'b0};
        bitslip_to_iserdes  <= {6'b0, manual_bitslip, 9'b0};
      end
		4'b1010: begin
        data_to_machine     <= data_from_iserdes[87:80];
        inc_to_iserdes      <= {5'b0, manual_inc,     10'b0};
        ice_to_iserdes      <= {5'b0, manual_ice,     10'b0};
        bitslip_to_iserdes  <= {5'b0, manual_bitslip, 10'b0};
      end
      4'b1011: begin
        data_to_machine     <= data_from_iserdes[95:88];
        inc_to_iserdes      <= {4'b0, manual_inc,     11'b0};
        ice_to_iserdes      <= {4'b0, manual_ice,     11'b0};
        bitslip_to_iserdes  <= {4'b0, manual_bitslip, 11'b0};
      end
      4'b1100: begin
        data_to_machine     <= data_from_iserdes[103:96];
        inc_to_iserdes      <= {3'b0, manual_inc,     12'b0};
        ice_to_iserdes      <= {3'b0, manual_ice,     12'b0};
        bitslip_to_iserdes  <= {3'b0, manual_bitslip, 12'b0};
      end
		4'b1101: begin
        data_to_machine     <= data_from_iserdes[111:104];
        inc_to_iserdes      <= {2'b0, manual_inc,     13'b0};
        ice_to_iserdes      <= {2'b0, manual_ice,     13'b0};
        bitslip_to_iserdes  <= {2'b0, manual_bitslip, 13'b0};
      end
      4'b1110: begin
        data_to_machine     <= data_from_iserdes[119:112];
        inc_to_iserdes      <= {1'b0, manual_inc,     14'b0};
        ice_to_iserdes      <= {1'b0, manual_ice,     14'b0};
        bitslip_to_iserdes  <= {1'b0, manual_bitslip, 14'b0};
      end
      4'b1111: begin
        data_to_machine     <= data_from_iserdes[127:120];
        inc_to_iserdes      <= {manual_inc,     15'b0};
        ice_to_iserdes      <= {manual_ice,     15'b0};
        bitslip_to_iserdes  <= {manual_bitslip, 15'b0};
      end
      default: begin
        data_to_machine     <= 8'b0;
        inc_to_iserdes      <= 16'b0;
        ice_to_iserdes      <= 16'b0;
        bitslip_to_iserdes  <= 16'b0;
      end
    endcase
  end
  else begin
    case (chan_sel_to_machine)
      4'b0000: begin
        data_to_machine     <= data_from_iserdes[7:0];
        inc_to_iserdes      <= {15'b0, inc_from_machine};
        ice_to_iserdes      <= {15'b0, ice_from_machine};
        bitslip_to_iserdes  <= {15'b0, bitslip_from_machine};
      end
      4'b0001: begin
        data_to_machine     <= data_from_iserdes[15:8];
        inc_to_iserdes      <= {14'b0, inc_from_machine,     1'b0};
        ice_to_iserdes      <= {14'b0, ice_from_machine,     1'b0};
        bitslip_to_iserdes  <= {14'b0, bitslip_from_machine, 1'b0};
      end
      4'b0010: begin
        data_to_machine     <= data_from_iserdes[23:16];
        inc_to_iserdes      <= {13'b0, inc_from_machine,     2'b0};
        ice_to_iserdes      <= {13'b0, ice_from_machine,     2'b0};
        bitslip_to_iserdes  <= {13'b0, bitslip_from_machine, 2'b0};
      end
      4'b0011: begin
        data_to_machine     <= data_from_iserdes[31:24];
        inc_to_iserdes      <= {12'b0, inc_from_machine,     3'b0};
        ice_to_iserdes      <= {12'b0, ice_from_machine,     3'b0};
        bitslip_to_iserdes  <= {12'b0, bitslip_from_machine, 3'b0};
      end
      4'b0100: begin
        data_to_machine     <= data_from_iserdes[39:32];
        inc_to_iserdes      <= {11'b0, inc_from_machine,     4'b0};
        ice_to_iserdes      <= {11'b0, ice_from_machine,     4'b0};
        bitslip_to_iserdes  <= {11'b0, bitslip_from_machine, 4'b0};
      end
      4'b0101: begin
        data_to_machine     <= data_from_iserdes[47:40];
        inc_to_iserdes      <= {10'b0, inc_from_machine,     5'b0};
        ice_to_iserdes      <= {10'b0, ice_from_machine,     5'b0};
        bitslip_to_iserdes  <= {10'b0, bitslip_from_machine, 5'b0};
      end
      4'b0110: begin
        data_to_machine     <= data_from_iserdes[55:48];
        inc_to_iserdes      <= {9'b0, inc_from_machine,     6'b0};
        ice_to_iserdes      <= {9'b0, ice_from_machine,     6'b0};
        bitslip_to_iserdes  <= {9'b0, bitslip_from_machine, 6'b0};
      end
      4'b0111: begin
        data_to_machine     <= data_from_iserdes[63:56];
        inc_to_iserdes      <= {8'b0, inc_from_machine,     7'b0};
        ice_to_iserdes      <= {8'b0, ice_from_machine,     7'b0};
        bitslip_to_iserdes  <= {8'b0, bitslip_from_machine, 7'b0};
      end
      4'b1000: begin
        data_to_machine     <= data_from_iserdes[71:64];
        inc_to_iserdes      <= {7'b0, inc_from_machine,     8'b0};
        ice_to_iserdes      <= {7'b0, ice_from_machine,     8'b0};
        bitslip_to_iserdes  <= {7'b0, bitslip_from_machine, 8'b0};
      end
      4'b1001: begin
        data_to_machine     <= data_from_iserdes[79:72];
        inc_to_iserdes      <= {6'b0, inc_from_machine,     9'b0};
        ice_to_iserdes      <= {6'b0, ice_from_machine,     9'b0};
        bitslip_to_iserdes  <= {6'b0, bitslip_from_machine, 9'b0};
      end
		4'b1010: begin
        data_to_machine     <= data_from_iserdes[87:80];
        inc_to_iserdes      <= {5'b0, inc_from_machine,     10'b0};
        ice_to_iserdes      <= {5'b0, ice_from_machine,     10'b0};
        bitslip_to_iserdes  <= {5'b0, bitslip_from_machine, 10'b0};
      end
      4'b1011: begin
        data_to_machine     <= data_from_iserdes[95:88];
        inc_to_iserdes      <= {4'b0, inc_from_machine,     11'b0};
        ice_to_iserdes      <= {4'b0, ice_from_machine,     11'b0};
        bitslip_to_iserdes  <= {4'b0, bitslip_from_machine, 11'b0};
      end
      4'b1100: begin
        data_to_machine     <= data_from_iserdes[103:96];
        inc_to_iserdes      <= {3'b0, inc_from_machine,     12'b0};
        ice_to_iserdes      <= {3'b0, ice_from_machine,     12'b0};
        bitslip_to_iserdes  <= {3'b0, bitslip_from_machine, 12'b0};
      end
		4'b1101: begin
        data_to_machine     <= data_from_iserdes[111:104];
        inc_to_iserdes      <= {2'b0, inc_from_machine,     13'b0};
        ice_to_iserdes      <= {2'b0, ice_from_machine,     13'b0};
        bitslip_to_iserdes  <= {2'b0, bitslip_from_machine, 13'b0};
      end
      4'b1110: begin
        data_to_machine     <= data_from_iserdes[119:112];
        inc_to_iserdes      <= {1'b0, inc_from_machine,     14'b0};
        ice_to_iserdes      <= {1'b0, ice_from_machine,     14'b0};
        bitslip_to_iserdes  <= {1'b0, bitslip_from_machine, 14'b0};
      end
      4'b1111: begin
        data_to_machine     <= data_from_iserdes[127:120];
        inc_to_iserdes      <= {inc_from_machine,     15'b0};
        ice_to_iserdes      <= {ice_from_machine,     15'b0};
        bitslip_to_iserdes  <= {bitslip_from_machine, 15'b0};
      end
      default: begin
        data_to_machine     <= 8'b0;
        inc_to_iserdes      <= 16'b0;
        ice_to_iserdes      <= 16'b0;
        bitslip_to_iserdes  <= 16'b0;
      end
    endcase
  end
end

wire start_align, data_aligned;
// machine that allocates bit_align_machine to each of the 16 data channels, one at a time
resource_sharing_control resource_sharing_control_i (
  .clk(rxclkdiv),
  .rst(rxrst),
  .training_start(training_start),
  .data_aligned(data_aligned),
  .chan_sel(chan_sel_to_machine),
  .start_align(start_align),
  .all_channels_aligned(training_done)
);

// machine that adjusts delay of a single data channel to optimize sampling point
reg	[20:0]	reset_sm;
//bit_align_machine bit_align_machine_i (
//  .rxclkdiv(rxclkdiv),
//  .rst(rxrst),
//  .rxdata(data_to_machine),
//  .start_align(start_align),
//  .inc(inc_from_machine),
//  .ice(ice_from_machine),
//  .bitslip(bitslip_from_machine),
//  .rxdataisgood(rxdataisgood),
//  .data_aligned(data_aligned)
//);
assign data_aligned = 1'b1;
assign rxdataisgood = 1'b1;


wire idly_rst = manual_idly_rst | training_start;

wire  [15:0]  data_rx_buf, data_rx_idly, shift1, shift2;
(*KEEP = "TRUE"*)wire  [CHAN*8-1:0] tapout;

genvar i;
generate
for(i=0;i<CHAN;i=i+1) begin : data_proc
	
	  // data input buffers
  IBUFDS #(
    .DIFF_TERM("TRUE"),
    .IOSTANDARD("LVDS_25")
  ) rx_data_in (
    .O(data_rx_buf[i]),
    .I(data_rx_p[i]),
    .IB(data_rx_n[i])
  );
  
  
  
	case(N)
		0: case(i) 
				0,1,4,6,7,8,9,12,13:begin
IDELAYE2 #(
      .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
      .DELAY_SRC("IDATAIN"),           // Delay input (IDATAIN, DATAIN)
      .HIGH_PERFORMANCE_MODE("TRUE"), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
      .IDELAY_TYPE("VARIABLE"),           // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
      .IDELAY_VALUE(IDELAY_INITIAL_VALUE),                // Input delay tap setting (0-31)
      .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
      .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0).
      .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
   )
   IDELAYE2_inst (
      .CNTVALUEOUT(tapout[8*i+7:8*i]), // 5-bit output: Counter value output
      .DATAOUT(data_rx_idly[i]),         // 1-bit output: Delayed data output
      .C(rxclkdiv0),                     // 1-bit input: Clock input
      .CE(ice_to_iserdes[i]),                   // 1-bit input: Active high enable increment/decrement input
      .CINVCTRL(1'b0),       // 1-bit input: Dynamic clock inversion input
      .CNTVALUEIN(5'b0),   // 5-bit input: Counter value input
      .DATAIN(1'b0),           // 1-bit input: Internal delay data input
      .IDATAIN(data_rx_buf[i]),         // 1-bit input: Data input from the I/O
      .INC(inc_to_iserdes[i]),                 // 1-bit input: Increment / Decrement tap delay input
      .LD(rxrst),  //idly_rst                 // 1-bit input: Load IDELAY_VALUE input
      .LDPIPEEN(1'b0),       // 1-bit input: Enable PIPELINE register to load data input
      .REGRST(rxrst)   //idly_rst         // 1-bit input: Active-high reset tap-delay input
   );

ISERDESE2 #(
      .DATA_RATE("DDR"),           // DDR, SDR
      .DATA_WIDTH(8),              // Parallel data width (2-8,10,14)
      .DYN_CLKDIV_INV_EN("FALSE"), // Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
      .DYN_CLK_INV_EN("FALSE"),    // Enable DYNCLKINVSEL inversion (FALSE, TRUE)
      // INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
      .INIT_Q1(1'b0),
      .INIT_Q2(1'b0),
      .INIT_Q3(1'b0),
      .INIT_Q4(1'b0),
      .INTERFACE_TYPE("NETWORKING"),   // MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
      .IOBDELAY("BOTH"),           // NONE, BOTH, IBUF, IFD
      .NUM_CE(1),                  // Number of clock enables (1,2)
      .OFB_USED("FALSE"),          // Select OFB path (FALSE, TRUE)
      .SERDES_MODE("MASTER"),      // MASTER, SLAVE
      // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
      .SRVAL_Q1(1'b0),
      .SRVAL_Q2(1'b0),
      .SRVAL_Q3(1'b0),
      .SRVAL_Q4(1'b0) 
   )
   ISERDESE2_inst (
      .O( ),                       // 1-bit output: Combinatorial output
      // Q1 - Q8: 1-bit (each) output: Registered data outputs
      .Q1(data_from_iserdes[8*i+7]),
      .Q2(data_from_iserdes[8*i+6]),
      .Q3(data_from_iserdes[8*i+5]),
      .Q4(data_from_iserdes[8*i+4]),
      .Q5(data_from_iserdes[8*i+3]),
      .Q6(data_from_iserdes[8*i+2]),
      .Q7(data_from_iserdes[8*i+1]),
      .Q8(data_from_iserdes[8*i]),
      // SHIFTOUT1, SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
      .SHIFTOUT1(),//shift1[i]
      .SHIFTOUT2(),//shift2[i]
      .BITSLIP(bitslip_to_iserdes[i]),       // 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
                                   // CLKDIV when asserted (active High). Subsequently, the data seen on the Q1
                                   // to Q8 output ports will shift, as in a barrel-shifter operation, one
                                   // position every time Bitslip is invoked (DDR operation is different from
                                   // SDR).

      // CE1, CE2: 1-bit (each) input: Data register clock enable inputs
      .CE1(1'b1),
      .CE2(1'b0),
      .CLKDIVP(1'b0),           // 1-bit input: TBD
      .CLK(rxclk0),                   // 1-bit input: High-speed clock
      .CLKB(~rxclk0),                 // 1-bit input: High-speed secondary clock
      .CLKDIV(rxclkdiv0),             // 1-bit input: Divided clock
      .OCLK(1'b0),                 // 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
      // Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
      .DYNCLKDIVSEL(1'b0), // 1-bit input: Dynamic CLKDIV inversion
      .DYNCLKSEL(1'b0),       // 1-bit input: Dynamic CLK/CLKB inversion
      // Input Data: 1-bit (each) input: ISERDESE2 data input ports
      .D(data_rx_buf[i]),                       // 1-bit input: Data input
      .DDLY(data_rx_idly[i]),                 // 1-bit input: Serial data from IDELAYE2
      .OFB(1'b0),                   // 1-bit input: Data feedback from OSERDESE2
      .OCLKB(1'b0),               // 1-bit input: High speed negative edge output clock
      .RST(rxrst),  // | ~locked                 // 1-bit input: Active high asynchronous reset
      // SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
      .SHIFTIN1(1'b0),
      .SHIFTIN2(1'b0) 
   );
   always @ (posedge rxclkdiv0)   data_from_iserdes_temp[8*i+7:8*i] <= data_from_iserdes[8*i+7:8*i];
   always @ (posedge rxclkdiv0)  begin
   		 data_from_iserdes_temp[8*i+135:8*i+128] <= data_from_iserdes_temp[8*i+7:8*i];
   		 data_from_iserdes_r[8*i+7:8*i] <= data_from_iserdes_temp[8*i+135:8*i+128];  
   end 
  
				end
				
				2,3,10,11:begin
IDELAYE2 #(
      .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
      .DELAY_SRC("IDATAIN"),           // Delay input (IDATAIN, DATAIN)
      .HIGH_PERFORMANCE_MODE("TRUE"), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
      .IDELAY_TYPE("VARIABLE"),           // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
      .IDELAY_VALUE(IDELAY_INITIAL_VALUE),                // Input delay tap setting (0-31)
      .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
      .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0).
      .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
   )
   IDELAYE2_inst (
      .CNTVALUEOUT(tapout[8*i+7:8*i]), // 5-bit output: Counter value output
      .DATAOUT(data_rx_idly[i]),         // 1-bit output: Delayed data output
      .C(rxclkdiv1),                     // 1-bit input: Clock input
      .CE(ice_to_iserdes[i]),                   // 1-bit input: Active high enable increment/decrement input
      .CINVCTRL(1'b0),       // 1-bit input: Dynamic clock inversion input
      .CNTVALUEIN(5'b0),   // 5-bit input: Counter value input
      .DATAIN(1'b0),           // 1-bit input: Internal delay data input
      .IDATAIN(data_rx_buf[i]),         // 1-bit input: Data input from the I/O
      .INC(inc_to_iserdes[i]),                 // 1-bit input: Increment / Decrement tap delay input
      .LD(rxrst),  //idly_rst                 // 1-bit input: Load IDELAY_VALUE input
      .LDPIPEEN(1'b0),       // 1-bit input: Enable PIPELINE register to load data input
      .REGRST(rxrst)   //idly_rst         // 1-bit input: Active-high reset tap-delay input
   );

ISERDESE2 #(
      .DATA_RATE("DDR"),           // DDR, SDR
      .DATA_WIDTH(8),              // Parallel data width (2-8,10,14)
      .DYN_CLKDIV_INV_EN("FALSE"), // Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
      .DYN_CLK_INV_EN("FALSE"),    // Enable DYNCLKINVSEL inversion (FALSE, TRUE)
      // INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
      .INIT_Q1(1'b0),
      .INIT_Q2(1'b0),
      .INIT_Q3(1'b0),
      .INIT_Q4(1'b0),
      .INTERFACE_TYPE("NETWORKING"),   // MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
      .IOBDELAY("BOTH"),           // NONE, BOTH, IBUF, IFD
      .NUM_CE(1),                  // Number of clock enables (1,2)
      .OFB_USED("FALSE"),          // Select OFB path (FALSE, TRUE)
      .SERDES_MODE("MASTER"),      // MASTER, SLAVE
      // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
      .SRVAL_Q1(1'b0),
      .SRVAL_Q2(1'b0),
      .SRVAL_Q3(1'b0),
      .SRVAL_Q4(1'b0) 
   )
   ISERDESE2_inst (
      .O( ),                       // 1-bit output: Combinatorial output
      // Q1 - Q8: 1-bit (each) output: Registered data outputs
      .Q1(data_from_iserdes[8*i+7]),
      .Q2(data_from_iserdes[8*i+6]),
      .Q3(data_from_iserdes[8*i+5]),
      .Q4(data_from_iserdes[8*i+4]),
      .Q5(data_from_iserdes[8*i+3]),
      .Q6(data_from_iserdes[8*i+2]),
      .Q7(data_from_iserdes[8*i+1]),
      .Q8(data_from_iserdes[8*i]),
      // SHIFTOUT1, SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
      .SHIFTOUT1(),//shift1[i]
      .SHIFTOUT2(),//shift2[i]
      .BITSLIP(bitslip_to_iserdes[i]),       // 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
                                   // CLKDIV when asserted (active High). Subsequently, the data seen on the Q1
                                   // to Q8 output ports will shift, as in a barrel-shifter operation, one
                                   // position every time Bitslip is invoked (DDR operation is different from
                                   // SDR).

      // CE1, CE2: 1-bit (each) input: Data register clock enable inputs
      .CE1(1'b1),
      .CE2(1'b0),
      .CLKDIVP(1'b0),           // 1-bit input: TBD
      .CLK(rxclk1),                   // 1-bit input: High-speed clock
      .CLKB(~rxclk1),                 // 1-bit input: High-speed secondary clock
      .CLKDIV(rxclkdiv1),             // 1-bit input: Divided clock
      .OCLK(1'b0),                 // 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
      // Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
      .DYNCLKDIVSEL(1'b0), // 1-bit input: Dynamic CLKDIV inversion
      .DYNCLKSEL(1'b0),       // 1-bit input: Dynamic CLK/CLKB inversion
      // Input Data: 1-bit (each) input: ISERDESE2 data input ports
      .D(data_rx_buf[i]),                       // 1-bit input: Data input
      .DDLY(data_rx_idly[i]),                 // 1-bit input: Serial data from IDELAYE2
      .OFB(1'b0),                   // 1-bit input: Data feedback from OSERDESE2
      .OCLKB(1'b0),               // 1-bit input: High speed negative edge output clock
      .RST(rxrst),  // | ~locked                 // 1-bit input: Active high asynchronous reset
      // SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
      .SHIFTIN1(1'b0),
      .SHIFTIN2(1'b0) 
   );
   
   always @ (posedge rxclkdiv1)   data_from_iserdes_temp[8*i+7:8*i] <= data_from_iserdes[8*i+7:8*i];
   always @ (posedge rxclkdiv0)  begin
   		 data_from_iserdes_temp[8*i+135:8*i+128] <= data_from_iserdes_temp[8*i+7:8*i];
   		 data_from_iserdes_r[8*i+7:8*i] <= data_from_iserdes_temp[8*i+135:8*i+128];  
   end 		 
   		 
				end
				5:begin
IDELAYE2 #(
      .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
      .DELAY_SRC("IDATAIN"),           // Delay input (IDATAIN, DATAIN)
      .HIGH_PERFORMANCE_MODE("TRUE"), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
      .IDELAY_TYPE("VARIABLE"),           // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
      .IDELAY_VALUE(IDELAY_INITIAL_VALUE),                // Input delay tap setting (0-31)
      .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
      .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0).
      .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
   )
   IDELAYE2_inst (
      .CNTVALUEOUT(tapout[8*i+7:8*i]), // 5-bit output: Counter value output
      .DATAOUT(data_rx_idly[i]),         // 1-bit output: Delayed data output
      .C(rxclkdiv2),                     // 1-bit input: Clock input
      .CE(ice_to_iserdes[i]),                   // 1-bit input: Active high enable increment/decrement input
      .CINVCTRL(1'b0),       // 1-bit input: Dynamic clock inversion input
      .CNTVALUEIN(5'b0),   // 5-bit input: Counter value input
      .DATAIN(1'b0),           // 1-bit input: Internal delay data input
      .IDATAIN(data_rx_buf[i]),         // 1-bit input: Data input from the I/O
      .INC(inc_to_iserdes[i]),                 // 1-bit input: Increment / Decrement tap delay input
      .LD(rxrst),  //idly_rst                 // 1-bit input: Load IDELAY_VALUE input
      .LDPIPEEN(1'b0),       // 1-bit input: Enable PIPELINE register to load data input
      .REGRST(rxrst)   //idly_rst         // 1-bit input: Active-high reset tap-delay input
   );

ISERDESE2 #(
      .DATA_RATE("DDR"),           // DDR, SDR
      .DATA_WIDTH(8),              // Parallel data width (2-8,10,14)
      .DYN_CLKDIV_INV_EN("FALSE"), // Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
      .DYN_CLK_INV_EN("FALSE"),    // Enable DYNCLKINVSEL inversion (FALSE, TRUE)
      // INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
      .INIT_Q1(1'b0),
      .INIT_Q2(1'b0),
      .INIT_Q3(1'b0),
      .INIT_Q4(1'b0),
      .INTERFACE_TYPE("NETWORKING"),   // MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
      .IOBDELAY("BOTH"),           // NONE, BOTH, IBUF, IFD
      .NUM_CE(1),                  // Number of clock enables (1,2)
      .OFB_USED("FALSE"),          // Select OFB path (FALSE, TRUE)
      .SERDES_MODE("MASTER"),      // MASTER, SLAVE
      // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
      .SRVAL_Q1(1'b0),
      .SRVAL_Q2(1'b0),
      .SRVAL_Q3(1'b0),
      .SRVAL_Q4(1'b0) 
   )
   ISERDESE2_inst (
      .O( ),                       // 1-bit output: Combinatorial output
      // Q1 - Q8: 1-bit (each) output: Registered data outputs
      .Q1(data_from_iserdes[8*i+7]),
      .Q2(data_from_iserdes[8*i+6]),
      .Q3(data_from_iserdes[8*i+5]),
      .Q4(data_from_iserdes[8*i+4]),
      .Q5(data_from_iserdes[8*i+3]),
      .Q6(data_from_iserdes[8*i+2]),
      .Q7(data_from_iserdes[8*i+1]),
      .Q8(data_from_iserdes[8*i]),
      // SHIFTOUT1, SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
      .SHIFTOUT1(),//shift1[i]
      .SHIFTOUT2(),//shift2[i]
      .BITSLIP(bitslip_to_iserdes[i]),       // 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
                                   // CLKDIV when asserted (active High). Subsequently, the data seen on the Q1
                                   // to Q8 output ports will shift, as in a barrel-shifter operation, one
                                   // position every time Bitslip is invoked (DDR operation is different from
                                   // SDR).

      // CE1, CE2: 1-bit (each) input: Data register clock enable inputs
      .CE1(1'b1),
      .CE2(1'b0),
      .CLKDIVP(1'b0),           // 1-bit input: TBD
      .CLK(rxclk2),                   // 1-bit input: High-speed clock
      .CLKB(~rxclk2),                 // 1-bit input: High-speed secondary clock
      .CLKDIV(rxclkdiv2),             // 1-bit input: Divided clock
      .OCLK(1'b0),                 // 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
      // Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
      .DYNCLKDIVSEL(1'b0), // 1-bit input: Dynamic CLKDIV inversion
      .DYNCLKSEL(1'b0),       // 1-bit input: Dynamic CLK/CLKB inversion
      // Input Data: 1-bit (each) input: ISERDESE2 data input ports
      .D(data_rx_buf[i]),                       // 1-bit input: Data input
      .DDLY(data_rx_idly[i]),                 // 1-bit input: Serial data from IDELAYE2
      .OFB(1'b0),                   // 1-bit input: Data feedback from OSERDESE2
      .OCLKB(1'b0),               // 1-bit input: High speed negative edge output clock
      .RST(rxrst),  // | ~locked                 // 1-bit input: Active high asynchronous reset
      // SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
      .SHIFTIN1(1'b0),
      .SHIFTIN2(1'b0) 
   );
   
   always @ (posedge rxclkdiv2)   data_from_iserdes_temp[8*i+7:8*i] <= data_from_iserdes[8*i+7:8*i];
   always @ (posedge rxclkdiv0)  begin
   		 data_from_iserdes_temp[8*i+135:8*i+128] <= data_from_iserdes_temp[8*i+7:8*i];
   		 data_from_iserdes_r[8*i+7:8*i] <= data_from_iserdes_temp[8*i+135:8*i+128];  
   end 
				end
			 endcase
		1: case(i) 
				0,1,2,3,4,5,10,11,12,13:begin
IDELAYE2 #(
      .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
      .DELAY_SRC("IDATAIN"),           // Delay input (IDATAIN, DATAIN)
      .HIGH_PERFORMANCE_MODE("TRUE"), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
      .IDELAY_TYPE("VARIABLE"),           // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
      .IDELAY_VALUE(IDELAY_INITIAL_VALUE),                // Input delay tap setting (0-31)
      .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
      .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0).
      .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
   )
   IDELAYE2_inst (
      .CNTVALUEOUT(tapout[8*i+7:8*i]), // 5-bit output: Counter value output
      .DATAOUT(data_rx_idly[i]),         // 1-bit output: Delayed data output
      .C(rxclkdiv0),                     // 1-bit input: Clock input
      .CE(ice_to_iserdes[i]),                   // 1-bit input: Active high enable increment/decrement input
      .CINVCTRL(1'b0),       // 1-bit input: Dynamic clock inversion input
      .CNTVALUEIN(5'b0),   // 5-bit input: Counter value input
      .DATAIN(1'b0),           // 1-bit input: Internal delay data input
      .IDATAIN(data_rx_buf[i]),         // 1-bit input: Data input from the I/O
      .INC(inc_to_iserdes[i]),                 // 1-bit input: Increment / Decrement tap delay input
      .LD(rxrst),  //idly_rst                 // 1-bit input: Load IDELAY_VALUE input
      .LDPIPEEN(1'b0),       // 1-bit input: Enable PIPELINE register to load data input
      .REGRST(rxrst)   //idly_rst         // 1-bit input: Active-high reset tap-delay input
   );

ISERDESE2 #(
      .DATA_RATE("DDR"),           // DDR, SDR
      .DATA_WIDTH(8),              // Parallel data width (2-8,10,14)
      .DYN_CLKDIV_INV_EN("FALSE"), // Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
      .DYN_CLK_INV_EN("FALSE"),    // Enable DYNCLKINVSEL inversion (FALSE, TRUE)
      // INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
      .INIT_Q1(1'b0),
      .INIT_Q2(1'b0),
      .INIT_Q3(1'b0),
      .INIT_Q4(1'b0),
      .INTERFACE_TYPE("NETWORKING"),   // MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
      .IOBDELAY("BOTH"),           // NONE, BOTH, IBUF, IFD
      .NUM_CE(1),                  // Number of clock enables (1,2)
      .OFB_USED("FALSE"),          // Select OFB path (FALSE, TRUE)
      .SERDES_MODE("MASTER"),      // MASTER, SLAVE
      // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
      .SRVAL_Q1(1'b0),
      .SRVAL_Q2(1'b0),
      .SRVAL_Q3(1'b0),
      .SRVAL_Q4(1'b0) 
   )
   ISERDESE2_inst (
      .O( ),                       // 1-bit output: Combinatorial output
      // Q1 - Q8: 1-bit (each) output: Registered data outputs
      .Q1(data_from_iserdes[8*i+7]),
      .Q2(data_from_iserdes[8*i+6]),
      .Q3(data_from_iserdes[8*i+5]),
      .Q4(data_from_iserdes[8*i+4]),
      .Q5(data_from_iserdes[8*i+3]),
      .Q6(data_from_iserdes[8*i+2]),
      .Q7(data_from_iserdes[8*i+1]),
      .Q8(data_from_iserdes[8*i]),
      // SHIFTOUT1, SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
      .SHIFTOUT1(),//shift1[i]
      .SHIFTOUT2(),//shift2[i]
      .BITSLIP(bitslip_to_iserdes[i]),       // 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
                                   // CLKDIV when asserted (active High). Subsequently, the data seen on the Q1
                                   // to Q8 output ports will shift, as in a barrel-shifter operation, one
                                   // position every time Bitslip is invoked (DDR operation is different from
                                   // SDR).

      // CE1, CE2: 1-bit (each) input: Data register clock enable inputs
      .CE1(1'b1),
      .CE2(1'b0),
      .CLKDIVP(1'b0),           // 1-bit input: TBD
      .CLK(rxclk0),                   // 1-bit input: High-speed clock
      .CLKB(~rxclk0),                 // 1-bit input: High-speed secondary clock
      .CLKDIV(rxclkdiv0),             // 1-bit input: Divided clock
      .OCLK(1'b0),                 // 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
      // Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
      .DYNCLKDIVSEL(1'b0), // 1-bit input: Dynamic CLKDIV inversion
      .DYNCLKSEL(1'b0),       // 1-bit input: Dynamic CLK/CLKB inversion
      // Input Data: 1-bit (each) input: ISERDESE2 data input ports
      .D(data_rx_buf[i]),                       // 1-bit input: Data input
      .DDLY(data_rx_idly[i]),                 // 1-bit input: Serial data from IDELAYE2
      .OFB(1'b0),                   // 1-bit input: Data feedback from OSERDESE2
      .OCLKB(1'b0),               // 1-bit input: High speed negative edge output clock
      .RST(rxrst),  // | ~locked                 // 1-bit input: Active high asynchronous reset
      // SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
      .SHIFTIN1(1'b0),
      .SHIFTIN2(1'b0) 
   );
   
   always @ (posedge rxclkdiv0)   data_from_iserdes_temp[8*i+7:8*i] <= data_from_iserdes[8*i+7:8*i];
   always @ (posedge rxclkdiv0)  begin
   		 data_from_iserdes_temp[8*i+135:8*i+128] <= data_from_iserdes_temp[8*i+7:8*i];
   		 data_from_iserdes_r[8*i+7:8*i] <= data_from_iserdes_temp[8*i+135:8*i+128];  
   end 
   
				end
				6,7,8,9:begin
IDELAYE2 #(
      .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
      .DELAY_SRC("IDATAIN"),           // Delay input (IDATAIN, DATAIN)
      .HIGH_PERFORMANCE_MODE("TRUE"), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
      .IDELAY_TYPE("VARIABLE"),           // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
      .IDELAY_VALUE(IDELAY_INITIAL_VALUE),                // Input delay tap setting (0-31)
      .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
      .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0).
      .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
   )
   IDELAYE2_inst (
      .CNTVALUEOUT(tapout[8*i+7:8*i]), // 5-bit output: Counter value output
      .DATAOUT(data_rx_idly[i]),         // 1-bit output: Delayed data output
      .C(rxclkdiv1),                     // 1-bit input: Clock input
      .CE(ice_to_iserdes[i]),                   // 1-bit input: Active high enable increment/decrement input
      .CINVCTRL(1'b0),       // 1-bit input: Dynamic clock inversion input
      .CNTVALUEIN(5'b0),   // 5-bit input: Counter value input
      .DATAIN(1'b0),           // 1-bit input: Internal delay data input
      .IDATAIN(data_rx_buf[i]),         // 1-bit input: Data input from the I/O
      .INC(inc_to_iserdes[i]),                 // 1-bit input: Increment / Decrement tap delay input
      .LD(rxrst),  //idly_rst                 // 1-bit input: Load IDELAY_VALUE input
      .LDPIPEEN(1'b0),       // 1-bit input: Enable PIPELINE register to load data input
      .REGRST(rxrst)   //idly_rst         // 1-bit input: Active-high reset tap-delay input
   );

ISERDESE2 #(
      .DATA_RATE("DDR"),           // DDR, SDR
      .DATA_WIDTH(8),              // Parallel data width (2-8,10,14)
      .DYN_CLKDIV_INV_EN("FALSE"), // Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
      .DYN_CLK_INV_EN("FALSE"),    // Enable DYNCLKINVSEL inversion (FALSE, TRUE)
      // INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
      .INIT_Q1(1'b0),
      .INIT_Q2(1'b0),
      .INIT_Q3(1'b0),
      .INIT_Q4(1'b0),
      .INTERFACE_TYPE("NETWORKING"),   // MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
      .IOBDELAY("BOTH"),           // NONE, BOTH, IBUF, IFD
      .NUM_CE(1),                  // Number of clock enables (1,2)
      .OFB_USED("FALSE"),          // Select OFB path (FALSE, TRUE)
      .SERDES_MODE("MASTER"),      // MASTER, SLAVE
      // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
      .SRVAL_Q1(1'b0),
      .SRVAL_Q2(1'b0),
      .SRVAL_Q3(1'b0),
      .SRVAL_Q4(1'b0) 
   )
   ISERDESE2_inst (
      .O( ),                       // 1-bit output: Combinatorial output
      // Q1 - Q8: 1-bit (each) output: Registered data outputs
      .Q1(data_from_iserdes[8*i+7]),
      .Q2(data_from_iserdes[8*i+6]),
      .Q3(data_from_iserdes[8*i+5]),
      .Q4(data_from_iserdes[8*i+4]),
      .Q5(data_from_iserdes[8*i+3]),
      .Q6(data_from_iserdes[8*i+2]),
      .Q7(data_from_iserdes[8*i+1]),
      .Q8(data_from_iserdes[8*i]),
      // SHIFTOUT1, SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
      .SHIFTOUT1(),//shift1[i]
      .SHIFTOUT2(),//shift2[i]
      .BITSLIP(bitslip_to_iserdes[i]),       // 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
                                   // CLKDIV when asserted (active High). Subsequently, the data seen on the Q1
                                   // to Q8 output ports will shift, as in a barrel-shifter operation, one
                                   // position every time Bitslip is invoked (DDR operation is different from
                                   // SDR).

      // CE1, CE2: 1-bit (each) input: Data register clock enable inputs
      .CE1(1'b1),
      .CE2(1'b0),
      .CLKDIVP(1'b0),           // 1-bit input: TBD
      .CLK(rxclk1),                   // 1-bit input: High-speed clock
      .CLKB(~rxclk1),                 // 1-bit input: High-speed secondary clock
      .CLKDIV(rxclkdiv1),             // 1-bit input: Divided clock
      .OCLK(1'b0),                 // 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
      // Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
      .DYNCLKDIVSEL(1'b0), // 1-bit input: Dynamic CLKDIV inversion
      .DYNCLKSEL(1'b0),       // 1-bit input: Dynamic CLK/CLKB inversion
      // Input Data: 1-bit (each) input: ISERDESE2 data input ports
      .D(data_rx_buf[i]),                       // 1-bit input: Data input
      .DDLY(data_rx_idly[i]),                 // 1-bit input: Serial data from IDELAYE2
      .OFB(1'b0),                   // 1-bit input: Data feedback from OSERDESE2
      .OCLKB(1'b0),               // 1-bit input: High speed negative edge output clock
      .RST(rxrst),  // | ~locked                 // 1-bit input: Active high asynchronous reset
      // SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
      .SHIFTIN1(1'b0),
      .SHIFTIN2(1'b0) 
   );
   
   always @ (posedge rxclkdiv1)   data_from_iserdes_temp[8*i+7:8*i] <= data_from_iserdes[8*i+7:8*i];
   always @ (posedge rxclkdiv0)  begin
   		 data_from_iserdes_temp[8*i+135:8*i+128] <= data_from_iserdes_temp[8*i+7:8*i];
   		 data_from_iserdes_r[8*i+7:8*i] <= data_from_iserdes_temp[8*i+135:8*i+128];  
   end 
   
				end
			 endcase
			 
		2,3,4,5: begin
IDELAYE2 #(
      .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
      .DELAY_SRC("IDATAIN"),           // Delay input (IDATAIN, DATAIN)
      .HIGH_PERFORMANCE_MODE("TRUE"), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
      .IDELAY_TYPE("VARIABLE"),           // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
      .IDELAY_VALUE(IDELAY_INITIAL_VALUE),                // Input delay tap setting (0-31)
      .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
      .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0).
      .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
   )
   IDELAYE2_inst (
      .CNTVALUEOUT(tapout[8*i+7:8*i]), // 5-bit output: Counter value output
      .DATAOUT(data_rx_idly[i]),         // 1-bit output: Delayed data output
      .C(rxclkdiv0),                     // 1-bit input: Clock input
      .CE(ice_to_iserdes[i]),                   // 1-bit input: Active high enable increment/decrement input
      .CINVCTRL(1'b0),       // 1-bit input: Dynamic clock inversion input
      .CNTVALUEIN(5'b0),   // 5-bit input: Counter value input
      .DATAIN(1'b0),           // 1-bit input: Internal delay data input
      .IDATAIN(data_rx_buf[i]),         // 1-bit input: Data input from the I/O
      .INC(inc_to_iserdes[i]),                 // 1-bit input: Increment / Decrement tap delay input
      .LD(rxrst),  //idly_rst                 // 1-bit input: Load IDELAY_VALUE input
      .LDPIPEEN(1'b0),       // 1-bit input: Enable PIPELINE register to load data input
      .REGRST(rxrst)   //idly_rst         // 1-bit input: Active-high reset tap-delay input
   );

ISERDESE2 #(
      .DATA_RATE("DDR"),           // DDR, SDR
      .DATA_WIDTH(8),              // Parallel data width (2-8,10,14)
      .DYN_CLKDIV_INV_EN("FALSE"), // Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
      .DYN_CLK_INV_EN("FALSE"),    // Enable DYNCLKINVSEL inversion (FALSE, TRUE)
      // INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
      .INIT_Q1(1'b0),
      .INIT_Q2(1'b0),
      .INIT_Q3(1'b0),
      .INIT_Q4(1'b0),
      .INTERFACE_TYPE("NETWORKING"),   // MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
      .IOBDELAY("BOTH"),           // NONE, BOTH, IBUF, IFD
      .NUM_CE(1),                  // Number of clock enables (1,2)
      .OFB_USED("FALSE"),          // Select OFB path (FALSE, TRUE)
      .SERDES_MODE("MASTER"),      // MASTER, SLAVE
      // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
      .SRVAL_Q1(1'b0),
      .SRVAL_Q2(1'b0),
      .SRVAL_Q3(1'b0),
      .SRVAL_Q4(1'b0) 
   )
   ISERDESE2_inst (
      .O( ),                       // 1-bit output: Combinatorial output
      // Q1 - Q8: 1-bit (each) output: Registered data outputs
      .Q1(data_from_iserdes[8*i+7]),
      .Q2(data_from_iserdes[8*i+6]),
      .Q3(data_from_iserdes[8*i+5]),
      .Q4(data_from_iserdes[8*i+4]),
      .Q5(data_from_iserdes[8*i+3]),
      .Q6(data_from_iserdes[8*i+2]),
      .Q7(data_from_iserdes[8*i+1]),
      .Q8(data_from_iserdes[8*i]),
      // SHIFTOUT1, SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
      .SHIFTOUT1(),//shift1[i]
      .SHIFTOUT2(),//shift2[i]
      .BITSLIP(bitslip_to_iserdes[i]),       // 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
                                   // CLKDIV when asserted (active High). Subsequently, the data seen on the Q1
                                   // to Q8 output ports will shift, as in a barrel-shifter operation, one
                                   // position every time Bitslip is invoked (DDR operation is different from
                                   // SDR).

      // CE1, CE2: 1-bit (each) input: Data register clock enable inputs
      .CE1(1'b1),
      .CE2(1'b0),
      .CLKDIVP(1'b0),           // 1-bit input: TBD
      .CLK(rxclk0),                   // 1-bit input: High-speed clock
      .CLKB(~rxclk0),                 // 1-bit input: High-speed secondary clock
      .CLKDIV(rxclkdiv0),             // 1-bit input: Divided clock
      .OCLK(1'b0),                 // 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
      // Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
      .DYNCLKDIVSEL(1'b0), // 1-bit input: Dynamic CLKDIV inversion
      .DYNCLKSEL(1'b0),       // 1-bit input: Dynamic CLK/CLKB inversion
      // Input Data: 1-bit (each) input: ISERDESE2 data input ports
      .D(data_rx_buf[i]),                       // 1-bit input: Data input
      .DDLY(data_rx_idly[i]),                 // 1-bit input: Serial data from IDELAYE2
      .OFB(1'b0),                   // 1-bit input: Data feedback from OSERDESE2
      .OCLKB(1'b0),               // 1-bit input: High speed negative edge output clock
      .RST(rxrst),  // | ~locked                 // 1-bit input: Active high asynchronous reset
      // SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
      .SHIFTIN1(1'b0),
      .SHIFTIN2(1'b0) 
   );
   
   always @ (posedge rxclkdiv0)   data_from_iserdes_temp[8*i+7:8*i] <= data_from_iserdes[8*i+7:8*i];
   always @ (posedge rxclkdiv0)  begin
   		 data_from_iserdes_temp[8*i+135:8*i+128] <= data_from_iserdes_temp[8*i+7:8*i];
   		 data_from_iserdes_r[8*i+7:8*i] <= data_from_iserdes_temp[8*i+135:8*i+128];  
   end  
   
				end

//		3: 		begin
//IDELAYE2 #(
//      .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
//      .DELAY_SRC("IDATAIN"),           // Delay input (IDATAIN, DATAIN)
//      .HIGH_PERFORMANCE_MODE("TRUE"), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
//      .IDELAY_TYPE("VARIABLE"),           // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
//      .IDELAY_VALUE(IDELAY_INITIAL_VALUE),                // Input delay tap setting (0-31)
//      .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
//      .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0).
//      .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
//   )
//   IDELAYE2_inst (
//      .CNTVALUEOUT(tapout[8*i+7:8*i]), // 5-bit output: Counter value output
//      .DATAOUT(data_rx_idly[i]),         // 1-bit output: Delayed data output
//      .C(rxclkdiv0),                     // 1-bit input: Clock input
//      .CE(ice_to_iserdes[i]),                   // 1-bit input: Active high enable increment/decrement input
//      .CINVCTRL(1'b0),       // 1-bit input: Dynamic clock inversion input
//      .CNTVALUEIN(5'b0),   // 5-bit input: Counter value input
//      .DATAIN(1'b0),           // 1-bit input: Internal delay data input
//      .IDATAIN(data_rx_buf[i]),         // 1-bit input: Data input from the I/O
//      .INC(inc_to_iserdes[i]),                 // 1-bit input: Increment / Decrement tap delay input
//      .LD(rxrst),  //idly_rst                 // 1-bit input: Load IDELAY_VALUE input
//      .LDPIPEEN(1'b0),       // 1-bit input: Enable PIPELINE register to load data input
//      .REGRST(rxrst)   //idly_rst         // 1-bit input: Active-high reset tap-delay input
//   );
//
//ISERDESE2 #(
//      .DATA_RATE("DDR"),           // DDR, SDR
//      .DATA_WIDTH(8),              // Parallel data width (2-8,10,14)
//      .DYN_CLKDIV_INV_EN("FALSE"), // Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
//      .DYN_CLK_INV_EN("FALSE"),    // Enable DYNCLKINVSEL inversion (FALSE, TRUE)
//      // INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
//      .INIT_Q1(1'b0),
//      .INIT_Q2(1'b0),
//      .INIT_Q3(1'b0),
//      .INIT_Q4(1'b0),
//      .INTERFACE_TYPE("NETWORKING"),   // MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
//      .IOBDELAY("BOTH"),           // NONE, BOTH, IBUF, IFD
//      .NUM_CE(1),                  // Number of clock enables (1,2)
//      .OFB_USED("FALSE"),          // Select OFB path (FALSE, TRUE)
//      .SERDES_MODE("MASTER"),      // MASTER, SLAVE
//      // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
//      .SRVAL_Q1(1'b0),
//      .SRVAL_Q2(1'b0),
//      .SRVAL_Q3(1'b0),
//      .SRVAL_Q4(1'b0) 
//   )
//   ISERDESE2_inst (
//      .O( ),                       // 1-bit output: Combinatorial output
//      // Q1 - Q8: 1-bit (each) output: Registered data outputs
//      .Q1(data_from_iserdes[8*i+7]),
//      .Q2(data_from_iserdes[8*i+6]),
//      .Q3(data_from_iserdes[8*i+5]),
//      .Q4(data_from_iserdes[8*i+4]),
//      .Q5(data_from_iserdes[8*i+3]),
//      .Q6(data_from_iserdes[8*i+2]),
//      .Q7(data_from_iserdes[8*i+1]),
//      .Q8(data_from_iserdes[8*i]),
//      // SHIFTOUT1, SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
//      .SHIFTOUT1(),//shift1[i]
//      .SHIFTOUT2(),//shift2[i]
//      .BITSLIP(bitslip_to_iserdes[i]),       // 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
//                                   // CLKDIV when asserted (active High). Subsequently, the data seen on the Q1
//                                   // to Q8 output ports will shift, as in a barrel-shifter operation, one
//                                   // position every time Bitslip is invoked (DDR operation is different from
//                                   // SDR).
//
//      // CE1, CE2: 1-bit (each) input: Data register clock enable inputs
//      .CE1(1'b1),
//      .CE2(1'b0),
//      .CLKDIVP(1'b0),           // 1-bit input: TBD
//      .CLK(rxclk0),                   // 1-bit input: High-speed clock
//      .CLKB(~rxclk0),                 // 1-bit input: High-speed secondary clock
//      .CLKDIV(rxclkdiv0),             // 1-bit input: Divided clock
//      .OCLK(1'b0),                 // 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
//      // Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
//      .DYNCLKDIVSEL(1'b0), // 1-bit input: Dynamic CLKDIV inversion
//      .DYNCLKSEL(1'b0),       // 1-bit input: Dynamic CLK/CLKB inversion
//      // Input Data: 1-bit (each) input: ISERDESE2 data input ports
//      .D(data_rx_buf[i]),                       // 1-bit input: Data input
//      .DDLY(data_rx_idly[i]),                 // 1-bit input: Serial data from IDELAYE2
//      .OFB(1'b0),                   // 1-bit input: Data feedback from OSERDESE2
//      .OCLKB(1'b0),               // 1-bit input: High speed negative edge output clock
//      .RST(rxrst),  // | ~locked                 // 1-bit input: Active high asynchronous reset
//      // SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
//      .SHIFTIN1(1'b0),
//      .SHIFTIN2(1'b0) 
//   );
//			 	end
//		4: case(i) 
//				0,1,2,3,11,12,13:begin
//IDELAYE2 #(
//      .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
//      .DELAY_SRC("IDATAIN"),           // Delay input (IDATAIN, DATAIN)
//      .HIGH_PERFORMANCE_MODE("TRUE"), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
//      .IDELAY_TYPE("VARIABLE"),           // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
//      .IDELAY_VALUE(IDELAY_INITIAL_VALUE),                // Input delay tap setting (0-31)
//      .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
//      .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0).
//      .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
//   )
//   IDELAYE2_inst (
//      .CNTVALUEOUT(tapout[8*i+7:8*i]), // 5-bit output: Counter value output
//      .DATAOUT(data_rx_idly[i]),         // 1-bit output: Delayed data output
//      .C(rxclkdiv0),                     // 1-bit input: Clock input
//      .CE(ice_to_iserdes[i]),                   // 1-bit input: Active high enable increment/decrement input
//      .CINVCTRL(1'b0),       // 1-bit input: Dynamic clock inversion input
//      .CNTVALUEIN(5'b0),   // 5-bit input: Counter value input
//      .DATAIN(1'b0),           // 1-bit input: Internal delay data input
//      .IDATAIN(data_rx_buf[i]),         // 1-bit input: Data input from the I/O
//      .INC(inc_to_iserdes[i]),                 // 1-bit input: Increment / Decrement tap delay input
//      .LD(rxrst),  //idly_rst                 // 1-bit input: Load IDELAY_VALUE input
//      .LDPIPEEN(1'b0),       // 1-bit input: Enable PIPELINE register to load data input
//      .REGRST(rxrst)   //idly_rst         // 1-bit input: Active-high reset tap-delay input
//   );
//
//ISERDESE2 #(
//      .DATA_RATE("DDR"),           // DDR, SDR
//      .DATA_WIDTH(8),              // Parallel data width (2-8,10,14)
//      .DYN_CLKDIV_INV_EN("FALSE"), // Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
//      .DYN_CLK_INV_EN("FALSE"),    // Enable DYNCLKINVSEL inversion (FALSE, TRUE)
//      // INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
//      .INIT_Q1(1'b0),
//      .INIT_Q2(1'b0),
//      .INIT_Q3(1'b0),
//      .INIT_Q4(1'b0),
//      .INTERFACE_TYPE("NETWORKING"),   // MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
//      .IOBDELAY("BOTH"),           // NONE, BOTH, IBUF, IFD
//      .NUM_CE(1),                  // Number of clock enables (1,2)
//      .OFB_USED("FALSE"),          // Select OFB path (FALSE, TRUE)
//      .SERDES_MODE("MASTER"),      // MASTER, SLAVE
//      // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
//      .SRVAL_Q1(1'b0),
//      .SRVAL_Q2(1'b0),
//      .SRVAL_Q3(1'b0),
//      .SRVAL_Q4(1'b0) 
//   )
//   ISERDESE2_inst (
//      .O( ),                       // 1-bit output: Combinatorial output
//      // Q1 - Q8: 1-bit (each) output: Registered data outputs
//      .Q1(data_from_iserdes[8*i+7]),
//      .Q2(data_from_iserdes[8*i+6]),
//      .Q3(data_from_iserdes[8*i+5]),
//      .Q4(data_from_iserdes[8*i+4]),
//      .Q5(data_from_iserdes[8*i+3]),
//      .Q6(data_from_iserdes[8*i+2]),
//      .Q7(data_from_iserdes[8*i+1]),
//      .Q8(data_from_iserdes[8*i]),
//      // SHIFTOUT1, SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
//      .SHIFTOUT1(),//shift1[i]
//      .SHIFTOUT2(),//shift2[i]
//      .BITSLIP(bitslip_to_iserdes[i]),       // 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
//                                   // CLKDIV when asserted (active High). Subsequently, the data seen on the Q1
//                                   // to Q8 output ports will shift, as in a barrel-shifter operation, one
//                                   // position every time Bitslip is invoked (DDR operation is different from
//                                   // SDR).
//
//      // CE1, CE2: 1-bit (each) input: Data register clock enable inputs
//      .CE1(1'b1),
//      .CE2(1'b0),
//      .CLKDIVP(1'b0),           // 1-bit input: TBD
//      .CLK(rxclk0),                   // 1-bit input: High-speed clock
//      .CLKB(~rxclk0),                 // 1-bit input: High-speed secondary clock
//      .CLKDIV(rxclkdiv0),             // 1-bit input: Divided clock
//      .OCLK(1'b0),                 // 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
//      // Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
//      .DYNCLKDIVSEL(1'b0), // 1-bit input: Dynamic CLKDIV inversion
//      .DYNCLKSEL(1'b0),       // 1-bit input: Dynamic CLK/CLKB inversion
//      // Input Data: 1-bit (each) input: ISERDESE2 data input ports
//      .D(data_rx_buf[i]),                       // 1-bit input: Data input
//      .DDLY(data_rx_idly[i]),                 // 1-bit input: Serial data from IDELAYE2
//      .OFB(1'b0),                   // 1-bit input: Data feedback from OSERDESE2
//      .OCLKB(1'b0),               // 1-bit input: High speed negative edge output clock
//      .RST(rxrst),  // | ~locked                 // 1-bit input: Active high asynchronous reset
//      // SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
//      .SHIFTIN1(1'b0),
//      .SHIFTIN2(1'b0) 
//   );
//				end
//				4,5,6,7,10:begin
//IDELAYE2 #(
//      .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
//      .DELAY_SRC("IDATAIN"),           // Delay input (IDATAIN, DATAIN)
//      .HIGH_PERFORMANCE_MODE("TRUE"), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
//      .IDELAY_TYPE("VARIABLE"),           // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
//      .IDELAY_VALUE(IDELAY_INITIAL_VALUE),                // Input delay tap setting (0-31)
//      .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
//      .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0).
//      .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
//   )
//   IDELAYE2_inst (
//      .CNTVALUEOUT(tapout[8*i+7:8*i]), // 5-bit output: Counter value output
//      .DATAOUT(data_rx_idly[i]),         // 1-bit output: Delayed data output
//      .C(rxclkdiv1),                     // 1-bit input: Clock input
//      .CE(ice_to_iserdes[i]),                   // 1-bit input: Active high enable increment/decrement input
//      .CINVCTRL(1'b0),       // 1-bit input: Dynamic clock inversion input
//      .CNTVALUEIN(5'b0),   // 5-bit input: Counter value input
//      .DATAIN(1'b0),           // 1-bit input: Internal delay data input
//      .IDATAIN(data_rx_buf[i]),         // 1-bit input: Data input from the I/O
//      .INC(inc_to_iserdes[i]),                 // 1-bit input: Increment / Decrement tap delay input
//      .LD(rxrst),  //idly_rst                 // 1-bit input: Load IDELAY_VALUE input
//      .LDPIPEEN(1'b0),       // 1-bit input: Enable PIPELINE register to load data input
//      .REGRST(rxrst)   //idly_rst         // 1-bit input: Active-high reset tap-delay input
//   );
//
//ISERDESE2 #(
//      .DATA_RATE("DDR"),           // DDR, SDR
//      .DATA_WIDTH(8),              // Parallel data width (2-8,10,14)
//      .DYN_CLKDIV_INV_EN("FALSE"), // Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
//      .DYN_CLK_INV_EN("FALSE"),    // Enable DYNCLKINVSEL inversion (FALSE, TRUE)
//      // INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
//      .INIT_Q1(1'b0),
//      .INIT_Q2(1'b0),
//      .INIT_Q3(1'b0),
//      .INIT_Q4(1'b0),
//      .INTERFACE_TYPE("NETWORKING"),   // MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
//      .IOBDELAY("BOTH"),           // NONE, BOTH, IBUF, IFD
//      .NUM_CE(1),                  // Number of clock enables (1,2)
//      .OFB_USED("FALSE"),          // Select OFB path (FALSE, TRUE)
//      .SERDES_MODE("MASTER"),      // MASTER, SLAVE
//      // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
//      .SRVAL_Q1(1'b0),
//      .SRVAL_Q2(1'b0),
//      .SRVAL_Q3(1'b0),
//      .SRVAL_Q4(1'b0) 
//   )
//   ISERDESE2_inst (
//      .O( ),                       // 1-bit output: Combinatorial output
//      // Q1 - Q8: 1-bit (each) output: Registered data outputs
//      .Q1(data_from_iserdes[8*i+7]),
//      .Q2(data_from_iserdes[8*i+6]),
//      .Q3(data_from_iserdes[8*i+5]),
//      .Q4(data_from_iserdes[8*i+4]),
//      .Q5(data_from_iserdes[8*i+3]),
//      .Q6(data_from_iserdes[8*i+2]),
//      .Q7(data_from_iserdes[8*i+1]),
//      .Q8(data_from_iserdes[8*i]),
//      // SHIFTOUT1, SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
//      .SHIFTOUT1(),//shift1[i]
//      .SHIFTOUT2(),//shift2[i]
//      .BITSLIP(bitslip_to_iserdes[i]),       // 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
//                                   // CLKDIV when asserted (active High). Subsequently, the data seen on the Q1
//                                   // to Q8 output ports will shift, as in a barrel-shifter operation, one
//                                   // position every time Bitslip is invoked (DDR operation is different from
//                                   // SDR).
//
//      // CE1, CE2: 1-bit (each) input: Data register clock enable inputs
//      .CE1(1'b1),
//      .CE2(1'b0),
//      .CLKDIVP(1'b0),           // 1-bit input: TBD
//      .CLK(rxclk1),                   // 1-bit input: High-speed clock
//      .CLKB(~rxclk1),                 // 1-bit input: High-speed secondary clock
//      .CLKDIV(rxclkdiv1),             // 1-bit input: Divided clock
//      .OCLK(1'b0),                 // 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
//      // Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
//      .DYNCLKDIVSEL(1'b0), // 1-bit input: Dynamic CLKDIV inversion
//      .DYNCLKSEL(1'b0),       // 1-bit input: Dynamic CLK/CLKB inversion
//      // Input Data: 1-bit (each) input: ISERDESE2 data input ports
//      .D(data_rx_buf[i]),                       // 1-bit input: Data input
//      .DDLY(data_rx_idly[i]),                 // 1-bit input: Serial data from IDELAYE2
//      .OFB(1'b0),                   // 1-bit input: Data feedback from OSERDESE2
//      .OCLKB(1'b0),               // 1-bit input: High speed negative edge output clock
//      .RST(rxrst),  // | ~locked                 // 1-bit input: Active high asynchronous reset
//      // SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
//      .SHIFTIN1(1'b0),
//      .SHIFTIN2(1'b0) 
//   );
//				end
//				8,9:begin
//IDELAYE2 #(
//      .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
//      .DELAY_SRC("IDATAIN"),           // Delay input (IDATAIN, DATAIN)
//      .HIGH_PERFORMANCE_MODE("TRUE"), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
//      .IDELAY_TYPE("VARIABLE"),           // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
//      .IDELAY_VALUE(IDELAY_INITIAL_VALUE),                // Input delay tap setting (0-31)
//      .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
//      .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0).
//      .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
//   )
//   IDELAYE2_inst (
//      .CNTVALUEOUT(tapout[8*i+7:8*i]), // 5-bit output: Counter value output
//      .DATAOUT(data_rx_idly[i]),         // 1-bit output: Delayed data output
//      .C(rxclkdiv2),                     // 1-bit input: Clock input
//      .CE(ice_to_iserdes[i]),                   // 1-bit input: Active high enable increment/decrement input
//      .CINVCTRL(1'b0),       // 1-bit input: Dynamic clock inversion input
//      .CNTVALUEIN(5'b0),   // 5-bit input: Counter value input
//      .DATAIN(1'b0),           // 1-bit input: Internal delay data input
//      .IDATAIN(data_rx_buf[i]),         // 1-bit input: Data input from the I/O
//      .INC(inc_to_iserdes[i]),                 // 1-bit input: Increment / Decrement tap delay input
//      .LD(rxrst),  //idly_rst                 // 1-bit input: Load IDELAY_VALUE input
//      .LDPIPEEN(1'b0),       // 1-bit input: Enable PIPELINE register to load data input
//      .REGRST(rxrst)   //idly_rst         // 1-bit input: Active-high reset tap-delay input
//   );
//
//ISERDESE2 #(
//      .DATA_RATE("DDR"),           // DDR, SDR
//      .DATA_WIDTH(8),              // Parallel data width (2-8,10,14)
//      .DYN_CLKDIV_INV_EN("FALSE"), // Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
//      .DYN_CLK_INV_EN("FALSE"),    // Enable DYNCLKINVSEL inversion (FALSE, TRUE)
//      // INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
//      .INIT_Q1(1'b0),
//      .INIT_Q2(1'b0),
//      .INIT_Q3(1'b0),
//      .INIT_Q4(1'b0),
//      .INTERFACE_TYPE("NETWORKING"),   // MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
//      .IOBDELAY("BOTH"),           // NONE, BOTH, IBUF, IFD
//      .NUM_CE(1),                  // Number of clock enables (1,2)
//      .OFB_USED("FALSE"),          // Select OFB path (FALSE, TRUE)
//      .SERDES_MODE("MASTER"),      // MASTER, SLAVE
//      // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
//      .SRVAL_Q1(1'b0),
//      .SRVAL_Q2(1'b0),
//      .SRVAL_Q3(1'b0),
//      .SRVAL_Q4(1'b0) 
//   )
//   ISERDESE2_inst (
//      .O( ),                       // 1-bit output: Combinatorial output
//      // Q1 - Q8: 1-bit (each) output: Registered data outputs
//      .Q1(data_from_iserdes[8*i+7]),
//      .Q2(data_from_iserdes[8*i+6]),
//      .Q3(data_from_iserdes[8*i+5]),
//      .Q4(data_from_iserdes[8*i+4]),
//      .Q5(data_from_iserdes[8*i+3]),
//      .Q6(data_from_iserdes[8*i+2]),
//      .Q7(data_from_iserdes[8*i+1]),
//      .Q8(data_from_iserdes[8*i]),
//      // SHIFTOUT1, SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
//      .SHIFTOUT1(),//shift1[i]
//      .SHIFTOUT2(),//shift2[i]
//      .BITSLIP(bitslip_to_iserdes[i]),       // 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
//                                   // CLKDIV when asserted (active High). Subsequently, the data seen on the Q1
//                                   // to Q8 output ports will shift, as in a barrel-shifter operation, one
//                                   // position every time Bitslip is invoked (DDR operation is different from
//                                   // SDR).
//
//      // CE1, CE2: 1-bit (each) input: Data register clock enable inputs
//      .CE1(1'b1),
//      .CE2(1'b0),
//      .CLKDIVP(1'b0),           // 1-bit input: TBD
//      .CLK(rxclk2),                   // 1-bit input: High-speed clock
//      .CLKB(~rxclk2),                 // 1-bit input: High-speed secondary clock
//      .CLKDIV(rxclkdiv2),             // 1-bit input: Divided clock
//      .OCLK(1'b0),                 // 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
//      // Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
//      .DYNCLKDIVSEL(1'b0), // 1-bit input: Dynamic CLKDIV inversion
//      .DYNCLKSEL(1'b0),       // 1-bit input: Dynamic CLK/CLKB inversion
//      // Input Data: 1-bit (each) input: ISERDESE2 data input ports
//      .D(data_rx_buf[i]),                       // 1-bit input: Data input
//      .DDLY(data_rx_idly[i]),                 // 1-bit input: Serial data from IDELAYE2
//      .OFB(1'b0),                   // 1-bit input: Data feedback from OSERDESE2
//      .OCLKB(1'b0),               // 1-bit input: High speed negative edge output clock
//      .RST(rxrst),  // | ~locked                 // 1-bit input: Active high asynchronous reset
//      // SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
//      .SHIFTIN1(1'b0),
//      .SHIFTIN2(1'b0) 
//   );
//				end
//			 endcase
//		5: 		begin
//IDELAYE2 #(
//      .CINVCTRL_SEL("FALSE"),          // Enable dynamic clock inversion (FALSE, TRUE)
//      .DELAY_SRC("IDATAIN"),           // Delay input (IDATAIN, DATAIN)
//      .HIGH_PERFORMANCE_MODE("TRUE"), // Reduced jitter ("TRUE"), Reduced power ("FALSE")
//      .IDELAY_TYPE("VARIABLE"),           // FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
//      .IDELAY_VALUE(IDELAY_INITIAL_VALUE),                // Input delay tap setting (0-31)
//      .PIPE_SEL("FALSE"),              // Select pipelined mode, FALSE, TRUE
//      .REFCLK_FREQUENCY(200.0),        // IDELAYCTRL clock input frequency in MHz (190.0-210.0).
//      .SIGNAL_PATTERN("DATA")          // DATA, CLOCK input signal
//   )
//   IDELAYE2_inst (
//      .CNTVALUEOUT(tapout[8*i+7:8*i]), // 5-bit output: Counter value output
//      .DATAOUT(data_rx_idly[i]),         // 1-bit output: Delayed data output
//      .C(rxclkdiv0),                     // 1-bit input: Clock input
//      .CE(ice_to_iserdes[i]),                   // 1-bit input: Active high enable increment/decrement input
//      .CINVCTRL(1'b0),       // 1-bit input: Dynamic clock inversion input
//      .CNTVALUEIN(5'b0),   // 5-bit input: Counter value input
//      .DATAIN(1'b0),           // 1-bit input: Internal delay data input
//      .IDATAIN(data_rx_buf[i]),         // 1-bit input: Data input from the I/O
//      .INC(inc_to_iserdes[i]),                 // 1-bit input: Increment / Decrement tap delay input
//      .LD(rxrst),  //idly_rst                 // 1-bit input: Load IDELAY_VALUE input
//      .LDPIPEEN(1'b0),       // 1-bit input: Enable PIPELINE register to load data input
//      .REGRST(rxrst)   //idly_rst         // 1-bit input: Active-high reset tap-delay input
//   );
//
//ISERDESE2 #(
//      .DATA_RATE("DDR"),           // DDR, SDR
//      .DATA_WIDTH(8),              // Parallel data width (2-8,10,14)
//      .DYN_CLKDIV_INV_EN("FALSE"), // Enable DYNCLKDIVINVSEL inversion (FALSE, TRUE)
//      .DYN_CLK_INV_EN("FALSE"),    // Enable DYNCLKINVSEL inversion (FALSE, TRUE)
//      // INIT_Q1 - INIT_Q4: Initial value on the Q outputs (0/1)
//      .INIT_Q1(1'b0),
//      .INIT_Q2(1'b0),
//      .INIT_Q3(1'b0),
//      .INIT_Q4(1'b0),
//      .INTERFACE_TYPE("NETWORKING"),   // MEMORY, MEMORY_DDR3, MEMORY_QDR, NETWORKING, OVERSAMPLE
//      .IOBDELAY("BOTH"),           // NONE, BOTH, IBUF, IFD
//      .NUM_CE(1),                  // Number of clock enables (1,2)
//      .OFB_USED("FALSE"),          // Select OFB path (FALSE, TRUE)
//      .SERDES_MODE("MASTER"),      // MASTER, SLAVE
//      // SRVAL_Q1 - SRVAL_Q4: Q output values when SR is used (0/1)
//      .SRVAL_Q1(1'b0),
//      .SRVAL_Q2(1'b0),
//      .SRVAL_Q3(1'b0),
//      .SRVAL_Q4(1'b0) 
//   )
//   ISERDESE2_inst (
//      .O( ),                       // 1-bit output: Combinatorial output
//      // Q1 - Q8: 1-bit (each) output: Registered data outputs
//      .Q1(data_from_iserdes[8*i+7]),
//      .Q2(data_from_iserdes[8*i+6]),
//      .Q3(data_from_iserdes[8*i+5]),
//      .Q4(data_from_iserdes[8*i+4]),
//      .Q5(data_from_iserdes[8*i+3]),
//      .Q6(data_from_iserdes[8*i+2]),
//      .Q7(data_from_iserdes[8*i+1]),
//      .Q8(data_from_iserdes[8*i]),
//      // SHIFTOUT1, SHIFTOUT2: 1-bit (each) output: Data width expansion output ports
//      .SHIFTOUT1(),//shift1[i]
//      .SHIFTOUT2(),//shift2[i]
//      .BITSLIP(bitslip_to_iserdes[i]),       // 1-bit input: The BITSLIP pin performs a Bitslip operation synchronous to
//                                   // CLKDIV when asserted (active High). Subsequently, the data seen on the Q1
//                                   // to Q8 output ports will shift, as in a barrel-shifter operation, one
//                                   // position every time Bitslip is invoked (DDR operation is different from
//                                   // SDR).
//
//      // CE1, CE2: 1-bit (each) input: Data register clock enable inputs
//      .CE1(1'b1),
//      .CE2(1'b0),
//      .CLKDIVP(1'b0),           // 1-bit input: TBD
//      .CLK(rxclk0),                   // 1-bit input: High-speed clock
//      .CLKB(~rxclk0),                 // 1-bit input: High-speed secondary clock
//      .CLKDIV(rxclkdiv0),             // 1-bit input: Divided clock
//      .OCLK(1'b0),                 // 1-bit input: High speed output clock used when INTERFACE_TYPE="MEMORY" 
//      // Dynamic Clock Inversions: 1-bit (each) input: Dynamic clock inversion pins to switch clock polarity
//      .DYNCLKDIVSEL(1'b0), // 1-bit input: Dynamic CLKDIV inversion
//      .DYNCLKSEL(1'b0),       // 1-bit input: Dynamic CLK/CLKB inversion
//      // Input Data: 1-bit (each) input: ISERDESE2 data input ports
//      .D(data_rx_buf[i]),                       // 1-bit input: Data input
//      .DDLY(data_rx_idly[i]),                 // 1-bit input: Serial data from IDELAYE2
//      .OFB(1'b0),                   // 1-bit input: Data feedback from OSERDESE2
//      .OCLKB(1'b0),               // 1-bit input: High speed negative edge output clock
//      .RST(rxrst),  // | ~locked                 // 1-bit input: Active high asynchronous reset
//      // SHIFTIN1, SHIFTIN2: 1-bit (each) input: Data width expansion input ports
//      .SHIFTIN1(1'b0),
//      .SHIFTIN2(1'b0) 
//   );
//				end		 
	endcase

//  For Vertex 5
//	IODELAY #(
//    .DELAY_SRC("I"),
//    .HIGH_PERFORMANCE_MODE("TRUE"),
//    .IDELAY_TYPE("VARIABLE"),
//    .IDELAY_VALUE(IDELAY_INITIAL_VALUE),
//    .ODELAY_VALUE(0),
//    .REFCLK_FREQUENCY(200.00),
//    .SIGNAL_PATTERN("DATA")
//  ) iodelay_rx_data (
//    .DATAOUT(data_rx_idly[i]),
//    .IDATAIN(data_rx_buf[i]),
//    .ODATAIN(1'b0),
//    .DATAIN(1'b0),
//    .T(1'b0),
//    .CE(ice_to_iserdes[i]),
//    .INC(inc_to_iserdes[i]),
//    .C(rxclkdiv),
//    .RST(idly_rst)      //  synchronous to the input clock signal (C)
//  );
//  // master iserdes in data path
//  ISERDES_NODELAY #(
//    .BITSLIP_ENABLE("TRUE"),
//    .DATA_RATE("DDR"),
//    .DATA_WIDTH(8),
//    .INTERFACE_TYPE("NETWORKING"),
//    .NUM_CE(1),
//    .SERDES_MODE("MASTER")
//  ) iserdes_rx_data_m (
//    .Q1(data_from_iserdes[8*i+7]),
//    .Q2(data_from_iserdes[8*i+6]),
//    .Q3(data_from_iserdes[8*i+5]),
//    .Q4(data_from_iserdes[8*i+4]),
//    .Q5(data_from_iserdes[8*i+3]),
//    .Q6(data_from_iserdes[8*i+2]),
//    .SHIFTOUT1(shift1[i]),
//    .SHIFTOUT2(shift2[i]),
//    .BITSLIP(bitslip_to_iserdes[i]),
//    .CE1(1'b1),
//    .CE2(1'b0),
//    .CLK(rxclk),
//    .CLKB(~rxclk),
//    .CLKDIV(rxclkdiv),
//    .D(data_rx_idly[i]),
//    .OCLK(1'b0),
//    .SHIFTIN1(1'b0),
//    .SHIFTIN2(1'b0),
//    .RST(rxrst)         // CLKDIV domains
//  );
//  // slave iserdes in data path
//  ISERDES_NODELAY #(
//    .BITSLIP_ENABLE("TRUE"),
//    .DATA_RATE("DDR"),
//    .DATA_WIDTH(8),
//    .INTERFACE_TYPE("NETWORKING"),
//    .NUM_CE(1),
//    .SERDES_MODE("SLAVE")
//  ) iserdes_rx_data_s (
//    .Q1(),
//    .Q2(),
//    .Q3(data_from_iserdes[8*i+1]),
//    .Q4(data_from_iserdes[8*i]),
//    .Q5(),
//    .Q6(),
//    .SHIFTOUT1(),
//    .SHIFTOUT2(),
//    .BITSLIP(bitslip_to_iserdes[i]),
//    .CE1(1'b1),
//    .CE2(1'b0),
//    .CLK(rxclk),
//    .CLKB(~rxclk),
//    .CLKDIV(rxclkdiv),
//    .D(1'b0),
//    .OCLK(1'b0),
//    .SHIFTIN1(shift1[i]),
//    .SHIFTIN2(shift2[i]),
//    .RST(rxrst)         // CLKDIV domains
//  );

// keep track of current tap setting of idelay in data path of channels 0-16

  count_to_32 #(
    .IDELAY_INITIAL_VALUE(IDELAY_INITIAL_VALUE)
  ) tap_counter (
    .clk(rxclkdiv),
    .rst(idly_rst),
    .count(ice_to_iserdes[i]),
    .ud(inc_to_iserdes[i]),
    .counter_value(tap[5*i+4: 5*i])
  );

end
endgenerate

endmodule

///////////////////////////////////////////////////////////////////////////////
// This module counts up/down between 0 to 31
module count_to_32 #(
  parameter IDELAY_INITIAL_VALUE = 0
)(
  input clk,
  input rst,
  input count,
  input ud,
  output reg [4:0] counter_value
);
always@(posedge clk) begin
  if(rst) counter_value <= IDELAY_INITIAL_VALUE;
  else begin
    case({count,ud})
      2'b10: counter_value <= counter_value - 1'b1;
      2'b11: counter_value <= counter_value + 1'b1;
      default: counter_value <= counter_value;
    endcase
  end
end

endmodule
