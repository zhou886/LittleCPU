`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/24 08:11:57
// Design Name: 
// Module Name: branch_unit
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


module branch_unit (
    input  wire [31:0] i_pc,
    input  wire [25:0] i_addr,
    input  wire [15:0] i_offset,
    input  wire [ 1:0] i_ctrl,
    input  wire [31:0] i_input1,
    input  wire [31:0] i_input2,
    output wire [31:0] o_npc
);
  wire [31:0] npc = i_pc + 32'h4;

  assign o_npc =
      // 没有J指令和BEQ指令
      (i_ctrl == 2'b0) ? npc :
      // J指令, o_npc = npc的高4位 + i_addr + 00
      (i_ctrl == 2'b01) ? {npc[31:28], i_addr, 2'b0} :
      // BEQ指令, o_npc = i_pc + 4 + i_offset<<2并符号拓展到32位
      (i_ctrl == 2'b10) ? ((i_input1 == i_input2) ? npc + {{14{i_offset[15]}}, {i_offset, 2'b0}} : npc) 
      : npc;
endmodule
