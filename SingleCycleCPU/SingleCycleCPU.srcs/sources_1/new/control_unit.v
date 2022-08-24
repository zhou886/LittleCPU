`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 16:07:46
// Design Name: 
// Module Name: control_unit
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


module control_unit (
    input wire [5:0] i_opcode,
    input wire [5:0] i_func,
    output wire [2:0] o_alu_ctrl,  // ALU操作控制信号
    output wire [1:0] o_br_ctrl,  // branch_unit操作控制信号
    output wire o_ext_ctrl,  // 立即数拓展控制信号
    output wire o_reg_write,  // 寄存器堆写使能信号
    output wire o_mem_write,  // 内存写使能信号
    output wire o_c1,  // ALU第一个输入的MUX控制信号
    output wire o_c2,  // ALU第二个输入的MUX控制信号
    output wire o_c3,  // 选择目的寄存器的MUX控制信号
    output wire o_c4  // 选择写入寄存器堆数据的控制信号
);
  wire [3:0] inst_type;
  assign inst_type = (i_opcode == 6'b001111) ? 1 :  // LUI
      (i_opcode == 6'b001100) ? 2 :  // ADDIU
      (i_opcode == 6'b100011) ? 3 :  // LW
      (i_opcode == 6'b101011) ? 4 :  // SW
      (i_opcode == 6'b000100) ? 5 :  // BEQ
      (i_opcode == 6'b000010) ? 6 :  // J
      (i_opcode == 6'b001011) ? 7 :  // SLTIU
      (i_opcode == 6'b0) ? ((i_func == 6'b100000) ? 8 : 0) :  // ADD
      0;

  assign o_alu_ctrl = (inst_type == 2 || inst_type == 8) ? 3'b010 :  // ADDIU || ADD
      (inst_type == 1) ? 3'b001 :  // LUI
      3'b0;

  assign o_br_ctrl = (inst_type == 6) ? 2'b01 :  // J
      (inst_type == 5) ? 2'b10 :  // BEQ
      2'b0;

  assign o_ext_ctrl = (inst_type == 1) ? 1 : 0; // LUI指令要求在立即数的后面加16个0,其他情况下在立即数的前面加16个0

  assign o_mem_write = (inst_type == 4) ? 1 : 0;  // 只有SW指令会写内存
  assign o_reg_write = (inst_type == 4 || inst_type == 5 || inst_type == 6 || inst_type == 0) ? 0 : 1; // 除SW/J/BEQ指令不会写寄存器,其他指令都会写寄存器

  // 多路复用器中0表示选择第一个操作数,1表示选择第二个操作数
  // 第一第二个多路复用器第一个操作数为来自寄存器堆的值,第二个操作数为来自立即数的值

  // LUI/J指令第一个操作数无意义,ADDIU/SLTIU/ADD/LW/SW指令的第一个操作数来自寄存器堆
  assign o_c1 = (inst_type == 0 || inst_type == 1 || inst_type == 6) ? 0 : 1;
  // LUI/ADDIU/SLTIU/LW/SW指令的第二个操作数来自立即数,ADD指令的第二个操作数来自寄存器堆
  assign o_c2 = (inst_type == 8) ? 1 : 0;
  // ADD指令的目的寄存器是第三个字段rd,其他指令的目的寄存器是第二个字段rt
  assign o_c3 = (inst_type == 8) ? 1 : 0;
  // SW指令要写入寄存器堆的数据来自内存,其他指令写入寄存器堆的数据来自ALU运算结果
  assign o_c4 = (inst_type == 4) ? 1 : 0;
endmodule
