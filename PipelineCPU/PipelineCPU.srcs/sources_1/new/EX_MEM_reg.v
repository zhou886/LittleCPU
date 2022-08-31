`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/29 15:36:43
// Design Name: 
// Module Name: EX_MEM_reg
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


module EX_MEM_reg (
    input wire i_clk,
    input wire i_rst,
    input wire i_ctrl,
    input wire [31:0] i_alu_result,
    input wire [31:0] i_reg_data2,
    input wire [4:0] i_reg_write_addr,
    input wire i_data_memory_write_enable,
    input wire i_register_file_write_enable,
    input wire i_mux32_2_ctrl,

    output wire [31:0] o_alu_result,
    output wire [31:0] o_reg_data2,
    output wire [4:0] o_reg_write_addr,
    output wire o_data_memory_write_enable,
    output wire o_register_file_write_enable,
    output wire o_mux32_2_ctrl
);
  reg [31:0] alu_result;
  reg [31:0] reg_data2;
  reg [4:0] reg_write_addr;
  reg data_memory_write_enable;
  reg register_file_write_enable;
  reg mux32_2_ctrl;

  always @(posedge i_clk) begin
    if (!i_rst) begin
      // 复位
      alu_result <= 32'b0;
      reg_data2 <= 32'b0;
      reg_write_addr <= 5'b0;
      data_memory_write_enable <= 1'b0;
      register_file_write_enable <= 1'b0;
      mux32_2_ctrl <= 1'b0;
    end else if (i_ctrl) begin
      alu_result <= i_alu_result;
      reg_data2 <= i_reg_data2;
      reg_write_addr <= i_reg_write_addr;
      data_memory_write_enable <= i_data_memory_write_enable;
      register_file_write_enable <= i_register_file_write_enable;
      mux32_2_ctrl <= i_mux32_2_ctrl;
    end else begin
      // 置空周期
      alu_result <= 32'b0;
      reg_data2 <= 32'b0;
      reg_write_addr <= 5'b0;
      data_memory_write_enable <= 1'b0;
      register_file_write_enable <= 1'b0;
      mux32_2_ctrl <= 1'b0;
    end
  end

  assign o_alu_result = alu_result;
  assign o_reg_data2 = reg_data2;
  assign o_reg_write_addr = reg_write_addr;
  assign o_data_memory_write_enable = data_memory_write_enable;
  assign o_register_file_write_enable = register_file_write_enable;
  assign o_mux32_2_ctrl = mux32_2_ctrl;
endmodule
