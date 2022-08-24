`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 17:09:42
// Design Name: 
// Module Name: alu
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

module alu (
    input  wire [ 2:0] i_alu_ctrl,
    input  wire [31:0] i_input1,
    input  wire [31:0] i_input2,
    output wire [31:0] o_result
);

  reg [31:0] temp_result;

  assign o_result = temp_result;

  always @(*) begin
    case (i_alu_ctrl)
      3'b001:  // LUI
      temp_result <= i_input2;
      3'b010:  // ADD/ADDIU/LW/SW
      temp_result <= i_input1 + i_input2;
      3'b100:  // SUB
      temp_result <= i_input1 - i_input2;
      default: temp_result <= i_input2;
    endcase
  end
endmodule
