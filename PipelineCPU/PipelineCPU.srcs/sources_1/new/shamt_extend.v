`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/26 17:28:11
// Design Name: 
// Module Name: shamt_extend
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


module shamt_extend (
    input  wire [ 4:0] i_input,
    output wire [31:0] o_output
);
  assign o_output = {27'b0, i_input};
endmodule
