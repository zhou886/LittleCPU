`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/29 15:36:14
// Design Name: 
// Module Name: IF_ID_reg
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


module IF_ID_reg (
    input wire i_clk,
    input wire i_rst,
    input wire i_ctrl,
    input wire [31:0] i_inst,

    output wire [31:0] o_inst
);
  reg [31:0] inst;
  always @(posedge i_clk) begin
    if (!i_rst) begin
      inst <= 32'b0;
    end 
    else if (i_ctrl) begin
      inst <= i_inst;
    end 
    else begin
      // nothing
    end
  end
  
  assign o_inst = inst;
endmodule
