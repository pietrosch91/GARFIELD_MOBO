`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         www.fpga4fun.com
// Engineer:
//
// Create Date:    20:43:19 11/14/2013
// Design Name:
// Module Name:    Signal_CrossDomain
// Project Name:
// Target Devices:
// Tool versions:
// Description: Let's say a signal from clkA domain is needed in clkB domain.
// It needs to be "synchronized" to clkB domain, so we want to build a
// "synchronizer" design, which takes a signal from clkA domain, and creates a
// new signal into clkB domain.
//
// We assume that the "Signal-in" changes slowly compared to both clkA and clkB
// clock speeds.
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module Signal_CrossDomain(
  input SignalIn_clkA,
  input clkB,
  output SignalOut_clkB
);

// We use a two-stages shift-register to synchronize SignalIn_clkA to the clkB clock domain
reg [1:0] SyncA_clkB;
always @(posedge clkB) SyncA_clkB[0] <= SignalIn_clkA;   // notice that we use clkB
always @(posedge clkB) SyncA_clkB[1] <= SyncA_clkB[0];   // notice that we use clkB

assign SignalOut_clkB = SyncA_clkB[1];  // new signal synchronized to (=ready to be used in) clkB domain

endmodule
