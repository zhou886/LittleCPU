`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/26 22:52:23
// Design Name: 
// Module Name: pc
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


module pc (
    input wire i_clk,
    input wire i_rst,
    input wire [31:0] i_npc,
    output reg [31:0] o_pc
);
  always @(posedge i_clk) begin
    if (!i_rst) o_pc <= 32'b0;
    else o_pc <= i_npc;
  end
endmodule
