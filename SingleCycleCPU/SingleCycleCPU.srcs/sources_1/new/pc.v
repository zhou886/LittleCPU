`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 15:05:07
// Design Name: 
// Module Name: pc 程序计数器
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//  用于得到下一条指令的地址
// Dependencies: 
//  i_clk, i_rst, i_npc
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pc (
    input  wire        i_clk,  // 时钟信号
    input  wire        i_rst,  // 复位信号
    input  wire [31:0] i_npc,  // 下一条指令地址
    output reg  [31:0] o_pc    // 输出的指令地址
);

  always @(posedge i_clk) begin
    if (i_rst) begin
      o_pc <= 31'b0;
    end else begin
      o_pc <= i_npc;
    end
  end
endmodule
