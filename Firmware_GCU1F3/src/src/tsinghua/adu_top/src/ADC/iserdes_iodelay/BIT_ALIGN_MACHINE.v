`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////
//
//    File Name:  BIT_ALIGN_MACHINE.v
//      Version:  1.0
//         Date:  05/19/06
//        Model:  Channel Alignment Module
//
//      Company:  Xilinx, Inc.
//  Contributor:  APD Applications Group
//
//  Modified by:  Zhang Jie @ IHEP
//         Date:  11/12/13
//  Modified by:  Hu Jun @ IHEP
//         Date:  1/20/16
///////////////////////////////////////////////////////////////////////////////
//
// Summary:
//
// The bit_align_machine module analyzes the data input of a single channel
// to determine the optimal clock/data relationship for that channel.  By
// dynamically changing the delay of the data channel (with respect to the
// sampling clock), the machine places the sampling point at the center of
// the data eye.
//
//----------------------------------------------------------------

module bit_align_machine #(
  parameter CHECK_PATTERN = 8'h01
)(
  input           rxclkdiv,     // rx parallel side clock
  input           rst,          // reset all circuitry in machine
  input   [7:0]   rxdata,       // data from one channel only
  input           start_align,  // start to make data alignment
  output  reg     inc,          // machine issues delay increment to appropriate data channel
  output  reg     ice,          // machine issues delay decrement to appropriate data channel
  output  reg     bitslip,      // machine issues bitslip command to appropriate data channel
  output          rxdataisgood, // indicate rxdata is good, output for chipscope
  output  reg     data_aligned  // flag indicating alignment complete on this channel
);

wire rxdataiszero = (rxdata == 0)? 1'b1: 1'b0;
reg [7:0] rxdata_prev;
assign rxdataisgood = ((rxdata == rxdata_prev)&(^rxdata))? 1'b1: 1'b0;
//  // an odd number of 1

//assign rxdataisgood = rxdata == CHECK_PATTERN;


reg   count_sample;
reg  [9:0] count_value_sample;
always@(posedge rxclkdiv) begin
  if(rst) count_value_sample <= 0;
  else
    if(count_sample) count_value_sample <= count_value_sample + 1'b1;
    else count_value_sample <= 0;
end

reg count_delay_inc_en;
reg count_delay_inc_up;
reg  [4:0] count_value_delay_inc;
always@(posedge rxclkdiv) begin
  if(rst|~count_delay_inc_en) count_value_delay_inc <= 0;
  else if(count_delay_inc_up) count_value_delay_inc <= count_value_delay_inc + 1'b1;
end

// cvs is a snapshot of the tap counter. its value is the size of the data
// valid window. our intention is to decrement the delay to 1/2 this value to be
// at the center of the eye.
reg store;
reg [4:0] cvs;
always @(posedge rxclkdiv) if(store) cvs <= count_value_delay_inc;
wire  [3:0] half_data_eye = cvs[4:1] + cvs[0]; // the cvs[0] factor causes a round-up

reg [4:0] current_state;
reg [4:0] next_state;
localparam
  IDLE                          = 0,
  FIRST_TRANSITION_SEARCH       = 1,
  FIRST_TRANSITION_SEARCH_WAIT  = 2,
  STABILITY_SEARCH_WAIT         = 3,
  STABILITY_SEARCH              = 4,
  RECHECK                       = 5,
  SECOND_TRANSITION_SEARCH      = 6,
  SECOND_TRANSITION_SEARCH_WAIT = 7,
  DEC_TO_HALF                   = 8,
  DEC_TO_HALF_WAIT              = 9,
  BYTE_ALIGN                    = 10,
  BYTE_ALIGN_WAIT               = 11;
always@(posedge rxclkdiv)  // current state logic
  if(rst) current_state = IDLE;
  else current_state = next_state;

//next state logic
always @(*) begin
  next_state          = IDLE;
  inc                 = 1'b0;
  ice                 = 1'b0;
  bitslip             = 1'b0;
  data_aligned        = 1'b0;
  count_sample        = 1'b0;
  count_delay_inc_en  = 1'b0;
  count_delay_inc_up  = 1'b0;
  store               = 1'b0;
  case(current_state)
    IDLE: begin  // 0
      if (start_align) next_state = FIRST_TRANSITION_SEARCH;
      else next_state = IDLE;
    end
    FIRST_TRANSITION_SEARCH: begin // 1, check sample to see if it is on a transition
      if (rxdataisgood) next_state = FIRST_TRANSITION_SEARCH_WAIT;
      else next_state = STABILITY_SEARCH_WAIT; // if sampled point is transition, edge is found, so inc delay to exit transition
      ice = 1'b1;
      inc = 1'b1;
    end
    FIRST_TRANSITION_SEARCH_WAIT: begin // 2, wait 17 cycles for stabilization
      count_sample = 1'b1;
      if (count_value_sample[4]) next_state = FIRST_TRANSITION_SEARCH;
      else next_state = FIRST_TRANSITION_SEARCH_WAIT;
    end
    STABILITY_SEARCH_WAIT: begin // 3, wait 17 cycles for stabilization
      count_sample = 1'b1;
      if (count_value_sample[4]) next_state = STABILITY_SEARCH;
      else next_state = STABILITY_SEARCH_WAIT;
    end
    STABILITY_SEARCH: begin // 4
      if(rxdataisgood) next_state = RECHECK;
      else begin
        next_state = STABILITY_SEARCH_WAIT;
        inc = 1'b1;
        ice = 1'b1;
      end
    end
    RECHECK: begin // 5, check sample again to see if we have exited transition
      count_sample = 1'b1;
      if (rxdataisgood) begin
        if(count_value_sample == 10'h3FF) next_state = SECOND_TRANSITION_SEARCH;
        else next_state = RECHECK;
      end
      else begin
        next_state = STABILITY_SEARCH_WAIT;
        count_sample = 1'b0;
        inc = 1'b1;
        ice = 1'b1;
      end
    end
    SECOND_TRANSITION_SEARCH: begin // 6, check sample to see if it is on a transition
      count_delay_inc_en = 1'b1;
      if (rxdataisgood) begin
        next_state = SECOND_TRANSITION_SEARCH_WAIT;
        count_delay_inc_up = 1'b1;
        inc = 1'b1;
        ice = 1'b1;
      end
      else begin
        next_state = DEC_TO_HALF; // if sampled point is transition, 2nd edge is found
        store = 1'b1;
      end
    end
    SECOND_TRANSITION_SEARCH_WAIT: begin // 7, wait 17 cycles for stabilization
      count_sample = 1'b1;
      count_delay_inc_en = 1'b1;
      if (count_value_sample[4]) next_state = SECOND_TRANSITION_SEARCH;
      else next_state = SECOND_TRANSITION_SEARCH_WAIT;
    end
    DEC_TO_HALF: begin // 8, decrement to middle of data eye
      count_sample = 1'b1;
      if(count_value_sample[4:0] == half_data_eye) next_state = DEC_TO_HALF_WAIT;
      else begin
        next_state = DEC_TO_HALF;
        count_sample = 1'b1;
        inc = 1'b0;
        ice = 1'b1;
      end
    end
    DEC_TO_HALF_WAIT: begin // 9, wait 17 cycles for stabilization
      count_sample = 1'b1;
      if(count_value_sample[4]) next_state = BYTE_ALIGN;
      else next_state = DEC_TO_HALF_WAIT;
    end
    BYTE_ALIGN: begin // 10, sample pattern to see if word alignment needed
      if (rxdata != CHECK_PATTERN) begin
        next_state = BYTE_ALIGN_WAIT;
        bitslip = 1'b1;
      end
      else begin
        next_state = IDLE;
        data_aligned = 1'b1;
       end
    end
    BYTE_ALIGN_WAIT: begin // 11, wait 5 cycles
      count_sample = 1'b1;
      if (count_value_sample[3]) next_state = BYTE_ALIGN;
      else next_state = BYTE_ALIGN_WAIT;
    end
    default: next_state = IDLE;
  endcase
end

always @(posedge rxclkdiv)
  if(~rxdataiszero && ((current_state == IDLE)||ice)) rxdata_prev <= rxdata;

endmodule
