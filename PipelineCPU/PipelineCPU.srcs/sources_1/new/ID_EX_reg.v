`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/29 15:36:32
// Design Name: 
// Module Name: ID_EX_reg
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


module ID_EX_reg (
    input wire i_clk,
    input wire i_rst,
    input wire i_ctrl,
    input wire [31:0] i_reg_data1,
    input wire [31:0] i_reg_data2,
    input wire [31:0] i_inst,
    input wire [4:0] i_reg_write_addr,
    input wire [3:0] i_alu_ctrl,
    input wire [2:0] i_npc_ctrl,
    input wire [1:0] i_imm_extend_ctrl,
    input wire i_register_file_write_enable,
    input wire i_data_memory_write_enable,
    input wire i_mux32_1_ctrl,
    input wire i_mux32_2_ctrl,

    output wire [31:0] o_reg_data1,
    output wire [31:0] o_reg_data2,
    output wire [4:0] o_reg_write_addr,
    output wire [4:0] o_rs,
    output wire [4:0] o_rt,
    output wire [15:0] o_imm,
    output wire [25:0] o_addr,
    output wire [3:0] o_alu_ctrl,
    output wire [2:0] o_npc_ctrl,
    output wire [1:0] o_imm_extend_ctrl,
    output wire o_register_file_write_enable,
    output wire o_data_memory_write_enable,
    output wire o_mux32_1_ctrl,
    output wire o_mux32_2_ctrl
);

  reg [31:0] inst;
  reg [31:0] reg_data1;
  reg [31:0] reg_data2;
  reg [4:0] reg_write_addr;
  reg [3:0] alu_ctrl;
  reg [2:0] npc_ctrl;
  reg [1:0] imm_extend_ctrl;
  reg register_file_write_enable;
  reg data_memory_write_enable;
  reg mux32_1_ctrl;
  reg mux32_2_ctrl;

  always @(posedge i_clk) begin
    if (!i_rst) begin
      // 复位
      inst <= 32'b0;
      reg_data1 <= 32'b0;
      reg_data2 <= 32'b0;
      alu_ctrl <= 4'b0;
      npc_ctrl <= 3'b0;
      imm_extend_ctrl <= 2'b0;
      register_file_write_enable <= 1'b0;
      data_memory_write_enable <= 1'b0;
      mux32_1_ctrl <= 1'b0;
      mux32_2_ctrl <= 1'b0;
      reg_write_addr <= 5'b0;
    end else if (i_ctrl) begin
      // 正常运行
      inst <= i_inst;
      reg_data1 <= i_reg_data1;
      reg_data2 <= i_reg_data2;
      alu_ctrl <= i_alu_ctrl;
      npc_ctrl <= i_npc_ctrl;
      imm_extend_ctrl <= i_imm_extend_ctrl;
      register_file_write_enable <= i_register_file_write_enable;
      data_memory_write_enable <= i_data_memory_write_enable;
      mux32_1_ctrl <= i_mux32_1_ctrl;
      mux32_2_ctrl <= i_mux32_2_ctrl;
      reg_write_addr <= i_reg_write_addr;
    end else begin
      // 插入空周期
      inst <= 32'b0;
      reg_data1 <= 32'b0;
      reg_data2 <= 32'b0;
      alu_ctrl <= 4'b0;
      npc_ctrl <= 3'b0;
      imm_extend_ctrl <= 2'b0;
      register_file_write_enable <= 1'b0;
      data_memory_write_enable <= 1'b0;
      mux32_1_ctrl <= 1'b0;
      mux32_2_ctrl <= 1'b0;
      reg_write_addr <= 5'b0;
    end
  end

  assign o_imm = inst[15:0];
  assign o_addr = inst[25:0];
  assign o_rs = inst[25:21];
  assign o_rt = inst[20:16];
  assign o_reg_data1 = reg_data1;
  assign o_reg_data2 = reg_data2;
  assign o_alu_ctrl = alu_ctrl;
  assign o_npc_ctrl = npc_ctrl;
  assign o_imm_extend_ctrl = imm_extend_ctrl;
  assign o_register_file_write_enable = register_file_write_enable;
  assign o_data_memory_write_enable = data_memory_write_enable;
  assign o_mux32_1_ctrl = mux32_1_ctrl;
  assign o_mux32_2_ctrl = mux32_2_ctrl;
endmodule
