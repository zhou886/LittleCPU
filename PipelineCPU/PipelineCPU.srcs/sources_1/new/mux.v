`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/26 14:18:50
// Design Name: 
// Module Name: mux 多路复用器
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// mux32,32位多路复用器,i_ctrl为0时输出i_input1,i_ctrl为1时输出i_input2.
// mux5,5位多路复用器,i_ctrl为0时输出i_input1,i_ctrl为1时输出i_input2.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux32 (
    input wire [31:0] i_input1,
    input wire [31:0] i_input2,
    input wire i_ctrl,
    output wire [31:0] o_output
);
    assign o_output = (i_ctrl == 0) ? i_input1 : i_input2;
endmodule

module mux5 (
    input wire [4:0] i_input1,
    input wire [4:0] i_input2,
    input wire i_ctrl,
    output wire [4:0] o_output
);
    assign o_output = (i_ctrl == 0) ? i_input1 : i_input2;
endmodule

module mux32_3_1 (
    input wire [31:0] i_input1,
    input wire [31:0] i_input2,
    input wire [31:0] i_input3,
    input wire [1:0] i_ctrl,
    output wire [31:0] o_output
);
  assign o_output =
    (i_ctrl == 2'b00) ? i_input1 :
    (i_ctrl == 2'b01) ? i_input2 :
    (i_ctrl == 2'b10) ? i_input3 :
    i_input1;
endmodule