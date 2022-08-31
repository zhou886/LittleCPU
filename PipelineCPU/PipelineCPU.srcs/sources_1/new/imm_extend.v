`timescale 1ns / 1ps
`include "definition.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/26 15:00:26
// Design Name: 
// Module Name: imm_extend
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//   立即数拓展模块,支持三种拓展方式:零拓展至32位,符号拓展至32位,在立即数后面加16个0.
// 分别对应i_ctrl为2'b01,2'b10,2'b11.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module imm_extend (
    input  wire [ 1:0] i_ctrl,
    input  wire [15:0] i_imm,
    output wire [31:0] o_imm
);
  assign o_imm =
      // 符号拓展至32位
      (i_ctrl == `IMM_SIGN_EXT) ? {{16{i_imm[15]}}, i_imm} :
      // 在立即数后面加16个0
      (i_ctrl == `IMM_LUI_EXT) ? {i_imm, 16'b0} :
      // 零拓展至32位
      {16'b0, i_imm};
endmodule
