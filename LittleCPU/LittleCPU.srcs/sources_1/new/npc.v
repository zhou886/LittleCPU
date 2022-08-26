`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/26 17:36:49
// Design Name: 
// Module Name: npc
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module npc (
    input  wire [ 2:0] i_ctrl,
    input  wire [25:0] i_addr,
    input  wire [15:0] i_offset,
    input  wire [31:0] i_pc,
    input  wire [31:0] i_input1,
    input  wire [31:0] i_input2,
    output wire [31:0] o_npc
);
  wire [31:0] npc = i_pc + 32'h4;

  assign o_npc = 
    (i_ctrl == 3'b001) ? {npc[31:28], i_addr, 2'b0} :
    (i_ctrl == 3'b010) ? ((i_input1 == i_input2) ? npc + {{14{i_offset[15]}}, {i_offset, 2'b0}} : npc) :
    (i_ctrl == 3'b011) ? ((i_input1 != i_input2) ? npc + {{14{i_offset[15]}}, {i_offset, 2'b0}} : npc) :
    (i_ctrl == 3'b100) ? i_input1 :
    npc;

endmodule
