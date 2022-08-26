`timescale 1ns / 1ps
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
    (i_opcode == 6'b001000) ? 1 : // ADDI
    (i_opcode == 6'b001001) ? 2 : // ADDIU
    (i_opcode == 6'b001010) ? 3 : // SLTI
    (i_opcode == 6'b001011) ? 4 : // SLTIU
    (i_opcode == 6'b001100) ? 5 : // ANDI
    (i_opcode == 6'b001101) ? 6 : // ORI
    (i_opcode == 6'b001110) ? 7 : // XORI
    (i_opcode == 6'b001111) ? 8 : // LUI
    (i_opcode == 6'b100011) ? 9 : // LW
    (i_opcode == 6'b101011) ? 10 : // SW
    (i_opcode == 6'b000100) ? 11 : // BEQ
    (i_opcode == 6'b000101) ? 12 : // BNE
    (i_opcode == 6'b000010) ? 13 : // J
    (i_opcode == 6'b0) ? (
        (i_func == 6'b100000) ? 14 : // ADD
        (i_func == 6'b100001) ? 15 : // ADDU
        (i_func == 6'b100010) ? 16 : // SUB
        (i_func == 6'b100011) ? 17 : // SUBU
        (i_func == 6'b100100) ? 18 : // AND
        (i_func == 6'b100101) ? 19 : // OR
        (i_func == 6'b100110) ? 20 : // XOR
        (i_func == 6'b000100) ? 21 : // SLLV
        (i_func == 6'b000110) ? 22 : // VSRL
        (i_func == 6'b001000) ? 23 : // JR
        0
    ) :
    0;

  assign o_alu_ctrl =
    (inst_type == 1 || inst_type == 2 || inst_type == 9 || inst_type == 10 || inst_type == 14 || inst_type == 15) ? 4'b0001 :
    (inst_type == 16 || inst_type == 17) ? 4'b0010 :
    (inst_type == 5 || inst_type == 18) ? 4'b0011 :
    (inst_type == 6 || inst_type == 19) ? 4'b0100 : 
    (inst_type == 7 || inst_type == 20) ? 4'b0101 : 
    (inst_type == 21) ? 4'b0110 :
    (inst_type == 22) ? 4'b0111 :
    4'b0;

  assign o_npc_ctrl =
    (inst_type == 13) ? 3'b001 : // J
    (inst_type == 11) ? 3'b010 : // BEQ
    (inst_type == 12) ? 3'b011 : // BNE
    (inst_type == 23) ? 3'b100 : // JR
    3'b0;

  assign o_imm_extend_ctrl =
    (inst_type == 8) ? 2'b11 : 
    (inst_type == 1 || inst_type == 2 || inst_type == 3 || inst_type == 4 || inst_type == 9 || inst_type == 10) ? 2'b10 :
    2'b0;

  assign o_interrupt_ctrl = 2'b0;

  assign o_data_memory_write_enable = (inst_type == 10) ? 1'b1 : 1'b0;
  assign o_register_file_write_enable = (inst_type == 10 || inst_type == 11 || inst_type == 12 || inst_type == 13 || inst_type == 23 || inst_type == 0) ? 1'b0 : 1'b1;

  assign o_mux32_1_ctrl = (inst_type >= 1 && inst_type <= 10) ? 1'b1 : 1'b0;
  assign o_mux32_2_ctrl = (inst_type >= 14 && inst_type <= 22) ? 1'b1 : 1'b0;
  assign o_mux5_1_ctrl = (inst_type == 9) ? 1'b1 : 1'b0;
endmodule
