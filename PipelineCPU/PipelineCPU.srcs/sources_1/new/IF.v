`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/30 17:02:04
// Design Name: 
// Module Name: IF
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


module IF (
    input wire i_clk,
    input wire i_rst,
    input wire i_ctrl,
    input wire [31:0] i_npc,

    output wire [31:0] o_inst,
    output wire [31:0] o_pc
);
  pc u_pc (
      .i_clk (i_clk),
      .i_ctrl(i_ctrl),
      .i_rst (i_rst),
      .i_npc (i_npc),
      .o_pc  (o_pc)
  );

  inst_memory u_inst_memory (
      .i_addr(o_pc[9:2]),
      .o_inst(o_inst)
  );
endmodule
