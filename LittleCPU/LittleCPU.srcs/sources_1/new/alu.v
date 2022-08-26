`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/26 14:46:49
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//   拥有两路32位输入和一路32位输出,支持加/减/按位与/按位或/按位异或/左移
// /右移/取第二路输入运算.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu (
    input  wire [ 3:0] i_ctrl,
    input  wire [31:0] i_input1,
    input  wire [31:0] i_input2,
    output wire [31:0] o_output
);

  assign o_output = 
        (i_ctrl == 4'b0001) ? (i_input1 + i_input2) :
        (i_ctrl == 4'b0010) ? (i_input1 - i_input2) :
        (i_ctrl == 4'b0011) ? (i_input1 & i_input2) :
        (i_ctrl == 4'b0100) ? (i_input1 | i_input2) :
        (i_ctrl == 4'b0101) ? (i_input1 ^ i_input2) :
        (i_ctrl == 4'b0110) ? (i_input1 << i_input2) :
        (i_ctrl == 4'b0111) ? (i_input1 >> i_input2) :
        (i_ctrl == 4'b1000) ? ((i_input1 < i_input2) ? 32'b1 : 32'b0) :
        i_input2;
endmodule
