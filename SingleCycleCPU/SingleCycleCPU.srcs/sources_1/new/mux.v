`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 18:52:01
// Design Name: 
// Module Name: mux
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
