`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/30 21:10:49
// Design Name: 
// Module Name: forward_unit
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


module forward_unit (
    input wire i_mem_reg_write_enable,
    input wire i_wb_reg_write_enable,
    input wire [4:0] i_mem_reg_write_addr,
    input wire [4:0] i_wb_reg_write_addr,
    input wire [4:0] i_rs,
    input wire [4:0] i_rt,

    output wire [1:0] o_alu_input1_mux_ctrl,
    output wire [1:0] o_alu_input2_mux_ctrl
);
  assign o_alu_input1_mux_ctrl =
    (i_mem_reg_write_enable && i_mem_reg_write_addr == i_rs) ? 2'b01 :
    (i_wb_reg_write_enable && i_wb_reg_write_addr == i_rs) ? 2'b10 :
    2'b00;

  assign o_alu_input2_mux_ctrl =
    (i_mem_reg_write_enable && i_mem_reg_write_addr == i_rt) ? 2'b01 :
    (i_wb_reg_write_enable && i_wb_reg_write_addr == i_rt) ? 2'b10 :
    2'b00;
endmodule
