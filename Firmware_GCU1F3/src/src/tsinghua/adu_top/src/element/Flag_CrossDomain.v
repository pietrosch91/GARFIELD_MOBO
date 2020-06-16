`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         www.fpga4fun.com
// Engineer:
//
// Create Date:    20:43:19 11/13/2013
// Design Name:
// Module Name:    Flag_CrossDomain
// Project Name:
// Target Devices:
// Tool versions:
// Description: If the signal that needs to cross the clock domains is just a
// pulse (i.e. it lasts just one clock cycle), we call it a "flag".
// The previous design usually doesn't work (the flag might be missed, or be
// seen for too long, depending on the ratio of the clocks used).
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module Flag_CrossDomain(
  input clkA,
  input FlagIn_clkA,
  input clkB,
  output FlagOut_clkB
);

// this changes level when the FlagIn_clkA is seen in clkA
reg FlagToggle_clkA;
always @(posedge clkA) FlagToggle_clkA <= FlagToggle_clkA ^ FlagIn_clkA;

// which can then be sync-ed to clkB
reg [2:0] SyncA_clkB;
always @(posedge clkB) SyncA_clkB <= {SyncA_clkB[1:0], FlagToggle_clkA};

// and recreate the flag in clkB
assign FlagOut_clkB = (SyncA_clkB[2] ^ SyncA_clkB[1]);

endmodule

