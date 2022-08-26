`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/26 14:43:24
// Design Name: 
// Module Name: inst_memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//   一个提供256个32位存储单元的只读指令存储器,需要一个8位地址来读取32位指令.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module inst_memory (
    input  wire [ 9:2] i_addr,
    output wire [31:0] o_inst
);
  reg [31:0] inst_memory[255:0];
  assign o_inst = inst_memory[i_addr];
endmodule
