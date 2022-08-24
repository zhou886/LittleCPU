`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 18:55:07
// Design Name: 
// Module Name: sign_extend
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


module sign_extend (
    input wire i_ctrl,
    input wire [15:0] i_imm,
    output wire [31:0] o_imm
);
  // 正常情况下,在立即数的前面扩展加0,但当出现LUI指令时需要在立即数的后面加0
  assign o_imm = (i_ctrl == 0) ? {16'b0, i_imm} : {i_imm, 16'b0};
endmodule
