`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/30 17:02:29
// Design Name: 
// Module Name: EX
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


module EX (
    input wire [31:0] i_pc,
    input wire [31:0] i_reg_data1,
    input wire [31:0] i_reg_data2,
    input wire [15:0] i_imm,
    input wire [25:0] i_addr,
    input wire [3:0] i_alu_ctrl,
    input wire [2:0] i_npc_ctrl,
    input wire [1:0] i_imm_extend_ctrl,
    input wire i_mux32_1_ctrl,
    input wire i_mem_reg_write_enable,
    input wire [4:0] i_mem_reg_write_addr,
    input wire i_wb_reg_write_enable,
    input wire [4:0] i_wb_reg_write_addr,
    input wire [4:0] i_rs,
    input wire [4:0] i_rt,

    output wire [31:0] o_alu_result,
    output wire [31:0] o_npc
);
  wire [1:0] alu_input1_mux_ctrl;
  wire [1:0] alu_input2_mux_ctrl;
  forward_unit u_forward_unit (
    .i_mem_reg_write_enable(i_mem_reg_write_enable),
    .i_wb_reg_write_enable(i_wb_reg_write_enable),
    .i_mem_reg_write_addr(i_mem_reg_write_addr),
    .i_wb_reg_write_addr(i_wb_reg_write_addr),
    .i_rs(i_rs),
    .i_rt(i_rt),
    .o_alu_input1_mux_ctrl(alu_input1_mux_ctrl),
    .o_alu_input2_mux_ctrl(alu_input2_mux_ctrl)
  );

  wire [31:0] imm32;
  imm_extend u_imm_extend (
    .i_ctrl(i_imm_extend_ctrl),
    .i_imm(i_imm),
    .o_imm(imm32)
  );

  wire [31:0] alu_input1;
  mux32_3_1 u_alu_input1_mux (
    .i_input1(i_reg_data1),
    .i_input2(i_mem_reg_data),
    .i_input3(i_wb_reg_data),
    .i_ctrl(alu_input1_mux_ctrl),
    .o_output(alu_input1)
  );

  wire [31:0] alu_input2_tmp;
  mux32_3_1 u_alu_input2_mux (
    .i_input1(i_reg_data2),
    .i_input2(i_mem_reg_data),
    .i_input3(i_wb_reg_data),
    .i_ctrl(alu_input2_mux_ctrl),
    .o_output(alu_input2_tmp)
  );

  wire [31:0] alu_input2;
  mux32 u_mux32_1 (
    .i_input1(alu_input2_tmp),
    .i_input2(imm32),
    .i_ctrl(i_mux32_1_ctrl),
    .o_output(alu_input2)
  );

  alu u_alu (
    .i_ctrl(i_alu_ctrl),
    .i_input1(alu_input1),
    .i_input2(alu_input2),
    .o_output(o_alu_result)
  );

  npc u_npc (
    .i_ctrl(i_npc_ctrl),
    .i_addr(i_addr),
    .i_offset(i_imm),
    .i_pc(i_pc),
    .i_input1(i_reg_data1),
    .i_input2(i_reg_data2)
  );
endmodule
