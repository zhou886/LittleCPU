`timescale 1ns / 1ps
`include "definition.vh"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/26 15:16:21
// Design Name: 
// Module Name: control_unit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//   ControlUnit用于指令译码并发出各个模块的控制信号.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control_unit (
    input wire [5:0] i_opcode,
    input wire [5:0] i_func,
    output wire [3:0] o_alu_ctrl,
    output wire [2:0] o_npc_ctrl,
    output wire [1:0] o_imm_extend_ctrl,
    output wire [1:0] o_interrupt_ctrl,
    output wire o_register_file_write_enable,
    output wire o_data_memory_write_enable,
    output wire o_mux32_1_ctrl,
    output wire o_mux32_2_ctrl,
    output wire o_mux5_1_ctrl
);
  wire [4:0] inst_type;
  assign inst_type = 
    (i_opcode == 6'b001000) ? `INST_ADDI  : 
    (i_opcode == 6'b001001) ? `INST_ADDIU :
    (i_opcode == 6'b001010) ? `INST_SLTI  : 
    (i_opcode == 6'b001011) ? `INST_SLTIU :
    (i_opcode == 6'b001100) ? `INST_ANDI  : 
    (i_opcode == 6'b001101) ? `INST_ORI   : 
    (i_opcode == 6'b001110) ? `INST_XORI  : 
    (i_opcode == 6'b001111) ? `INST_LUI   : 
    (i_opcode == 6'b100011) ? `INST_LW    : 
    (i_opcode == 6'b101011) ? `INST_SW    :
    (i_opcode == 6'b000100) ? `INST_BEQ   :
    (i_opcode == 6'b000101) ? `INST_BNE   :
    (i_opcode == 6'b000010) ? `INST_J     :
    (i_opcode == 6'b0) ? (
        (i_func == 6'b100000) ? `INST_ADD  : 
        (i_func == 6'b100001) ? `INST_ADDU : 
        (i_func == 6'b100010) ? `INST_SUB  : 
        (i_func == 6'b100011) ? `INST_SUBU : 
        (i_func == 6'b100100) ? `INST_AND  : 
        (i_func == 6'b100101) ? `INST_OR   : 
        (i_func == 6'b100110) ? `INST_XOR  : 
        (i_func == 6'b000100) ? `INST_SLLV : 
        (i_func == 6'b000110) ? `INST_VSRL : 
        (i_func == 6'b001000) ? `INST_JR   : 
        0
    ) :
    0;


  assign o_alu_ctrl = 
      (inst_type == `INST_ADDI
      || inst_type == `INST_ADDIU
      || inst_type == `INST_LW
      || inst_type == `INST_SW
      || inst_type == `INST_ADD
      || inst_type == `INST_ADDU) ? `ALU_ADD :

      (inst_type == `INST_SUB
      || inst_type == `INST_SUBU) ? `ALU_SUB :

      (inst_type == `INST_AND 
      || inst_type == `INST_ANDI) ? `ALU_AND :

      (inst_type == `INST_OR
      || inst_type == `INST_ORI)  ? `ALU_OR :

      (inst_type == `INST_XOR 
      || inst_type == `INST_XORI) ? `ALU_XOR :

      (inst_type == `INST_SLLV)   ? `ALU_ML :

      (inst_type == `INST_VSRL)   ? `ALU_MR :

      `ALU_DEF;


  assign o_npc_ctrl = 
      (inst_type == `INST_J)   ? `NPC_J :
      (inst_type == `INST_BEQ) ? `NPC_BEQ :
      (inst_type == `INST_BNE) ? `NPC_BNE :
      (inst_type == `INST_JR)  ? `NPC_JR :
      `NPC_DEF;


  assign o_imm_extend_ctrl =
    (inst_type == `INST_LUI) ? `IMM_LUI_EXT : 

    (inst_type == `INST_ADDI 
    || inst_type == `INST_ADDIU
    || inst_type == `INST_SLTI
    || inst_type == `INST_SLTIU
    || inst_type == `INST_LW
    || inst_type == `INST_SW) ? `IMM_SIGN_EXT :

    `IMM_ZERO_EXT;


  assign o_interrupt_ctrl = 2'b0;

  assign o_mux32_1_ctrl = 
  (inst_type == `INST_ADDI
  || inst_type == `INST_ADDIU
  || inst_type == `INST_SLTI
  || inst_type == `INST_SLTIU
  || inst_type == `INST_ANDI
  || inst_type == `INST_ORI
  || inst_type == `INST_XORI
  || inst_type == `INST_LUI
  || inst_type == `INST_LW
  || inst_type == `INST_SW) ? 1'b1 : 1'b0;

  assign o_mux32_2_ctrl = (inst_type == `INST_LW) ? 1'b1 : 1'b0;

  assign o_data_memory_write_enable = (inst_type == `INST_SW) ? 1'b1 : 1'b0;
  assign o_register_file_write_enable = 
  (inst_type == `INST_SW
  || inst_type == `INST_BEQ
  || inst_type == `INST_BNE
  || inst_type == `INST_J
  || inst_type == `INST_JR
  || inst_type == `INST_DEF) ? 1'b0 : 1'b1;


  assign o_mux5_1_ctrl = 
  (inst_type == `INST_ADD
  || inst_type == `INST_ADDU
  || inst_type == `INST_SUB
  || inst_type == `INST_SUBU
  || inst_type == `INST_AND
  || inst_type == `INST_OR
  || inst_type == `INST_XOR
  || inst_type == `INST_SLLV
  || inst_type == `INST_VSRL) ? 1'b1 : 1'b0;
endmodule
