`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/30 20:32:07
// Design Name: 
// Module Name: pipeline_control_unit
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


module pipeline_control_unit (
    input wire i_rst,
    input wire i_clk,
    input wire i_ex_is_lw,
    input wire [4:0] i_ex_reg_write_addr,
    input wire [4:0] i_rs,
    input wire [4:0] i_rt,

    output wire [3:0] o_pipeline_ctrl
);
  reg [3:0] pipeline_ctrl;
  always @(posedge i_clk) begin
    if (!i_rst) begin
      pipeline_ctrl <= 4'b1111;
    end else if (i_ex_is_lw && (i_ex_reg_write_addr == i_rs || i_ex_reg_write_addr == i_rt)) begin
      pipeline_ctrl <= 4'b1000;
    end else begin
      pipeline_ctrl <= 4'b1111;
    end
  end
  assign o_pipeline_ctrl = pipeline_ctrl;
endmodule
