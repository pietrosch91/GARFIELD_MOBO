`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////
//
//    File Name:  RESOURCE_SHARING_CONTROL.v
//      Version:  1.0
//         Date:  05/19/06
//        Model:  Round Robin Channel Alignment
//
//      Company:  Xilinx, Inc.
//  Contributor:  APD Applications Group
//
//  Modified by:  Zhang Jie @ IHEP
//         Date:  11/11/13
//  Modified by:  Hu Jun @ IHEP
//         Date:  1/20/16
///////////////////////////////////////////////////////////////////////////////
//
// Summary:
//
// The resource_sharing_control module allocates the bit_align_machine
// module to each of the 10 data channels of the interface.  Each channel
// must be aligned one at a time, such that the resource_sharing_control module
// must determine when training on a given channel is complete, and then
// switch the context to the next channel.
//
//----------------------------------------------------------------

module resource_sharing_control#(
  parameter CHAN = 12
)(
  input             clk,
  input             rst,
  input             training_start,       // flag: start to make data alignment
  input             data_aligned,         // flag: alignment done on current channel, go to next
  output reg [3:0]  chan_sel,             // vector indicating current channel being aligned
  output reg        start_align,          // signal that alignment process may begin on next channel
  output reg        all_channels_aligned  // signal that all channels are aligned
);

reg count_chan;
always@(posedge clk) begin
  if(rst|training_start|all_channels_aligned) chan_sel <= 0;
  else if(count_chan) chan_sel <= chan_sel + 1'b1;
end

reg  [2:0]  count_value;
reg         count_delay;
always@(posedge clk) begin
  if(rst) count_value <= 0;
  else begin
    if(count_delay) count_value <= count_value + 1'b1;
    else count_value <= 0;
  end
end

localparam  IDLE = 0,
            INIT = 1,
           START = 2,
            WAIT = 3,
    INC_CHAN_SEL = 4,
      TRAIN_DONE = 5;
reg [2:0] current_state;  // current state
reg [2:0] next_state;     // next state

always @(posedge clk) // current state logic
  if (rst) current_state <= IDLE;
  else current_state <= next_state;

always @(*) begin     // next state logic
  next_state = IDLE;
  count_chan  = 1'b0;
  count_delay = 1'b0;
  start_align = 1'b0;
  all_channels_aligned = 1'b0;
  case (current_state)
    IDLE: begin // 0
      if(training_start) next_state = INIT;
      else next_state = IDLE;
    end
    INIT: begin // 1
      count_delay = 1'b1;
      if (count_value == 3'h7) next_state = START;
      else next_state = INIT;
    end
    START: begin // 2
      start_align = 1'b1;
      next_state = WAIT;
    end
    WAIT: begin // 3
      if(data_aligned) next_state = INC_CHAN_SEL;
      else next_state = WAIT;
    end
    INC_CHAN_SEL: begin // 4
      count_chan = 1'b1;
      if(chan_sel == (CHAN - 1)) next_state = TRAIN_DONE;
      else next_state = INIT;
    end
    TRAIN_DONE: begin // 5
      all_channels_aligned = 1'b1;
      if(training_start) next_state = INIT;
      else next_state = TRAIN_DONE;
    end
    default: next_state = IDLE;
  endcase
end

endmodule
