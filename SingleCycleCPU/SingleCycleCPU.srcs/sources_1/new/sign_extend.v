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
    input wire [15:0] i_imm,
    input wire i_ctrl,
    output wire [31:0] o_imm
);
  // 正常情况下在立即数进行符号拓展,但当为LUI指令时在立即数的后面加16个0
  assign o_imm = (i_ctrl == 0) ? {{16{i_imm[15]}}, i_imm} : {i_imm, 16'b0};
endmodule
