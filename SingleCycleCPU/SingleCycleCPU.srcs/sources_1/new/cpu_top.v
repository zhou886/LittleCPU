`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 15:18:45
// Design Name: 
// Module Name: cpu_top
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


module cpu_top (
    input wire i_clk,
    input wire i_rst,
    output wire[31:0] debug
);
  // PC模块
  wire [31:0] pc;
  wire [31:0] npc;

  pc u_pc (
      .i_clk(i_clk),
      .i_rst(i_rst),
      .i_npc(npc),
      .o_pc (pc)
  );

  // 指令寄存器模块及取指操作
  wire [31:0] inst;
  wire [ 5:0] opcode;
  wire [ 4:0] rs;
  wire [ 4:0] rt;
  wire [ 4:0] rd;
  wire [15:0] imm;
  wire [25:0] addr;
  wire [ 5:0] func;

  assign opcode = inst[31:26];
  assign rs = inst[25:21];
  assign rt = inst[20:16];
  assign rd = inst[15:11];
  assign imm = inst[15:0];
  assign func = inst[5:0];
  assign addr = inst[25:0];

  instruction_memory u_im (
      .i_inst_addr(pc[9:2]),
      .o_inst(inst)
  );

  // 控制模块及指令译码操作
  wire [2:0] alu_ctrl;
  wire [1:0] br_ctrl;
  wire reg_write;
  wire mem_write;
  wire mux1_ctrl;
  wire mux2_ctrl;
  wire mux3_ctrl;
  wire mux4_ctrl;

  control_unit u_cn (
      .i_opcode(opcode),
      .i_func(func),
      .o_alu_ctrl(alu_ctrl),
      .o_br_ctrl(br_ctrl),
      .o_reg_write(reg_write),
      .o_mem_write(mem_write),
      .o_c1(mux1_ctrl),
      .o_c2(mux2_ctrl),
      .o_c3(mux3_ctrl),
      .o_c4(mux4_ctrl)
  );

  // 立即数拓展
  wire [31:0] ext_imm;

  sign_extend u_se (
    .i_imm(imm),
    .o_imm(ext_imm)
  );

  // 寄存器堆及其读写操作
  wire [31:0] reg_data1;
  wire [31:0] reg_data2;
  
  wire [4:0] mem_write_addr;
  wire [31:0] mem_write_data;

  register_file u_rf (
    .i_clk(i_clk),
    .i_reg_write(reg_write),
    .i_read_addr1(rs),
    .i_read_addr2(rt),
    .i_write_addr(mem_write_addr),
    .i_write_data(mem_write_data),
    .o_read_data1(reg_data1),
    .o_read_data2(reg_data2)
  );

  // ALU第一个操作数选择器
  wire [31:0] alu_data1;
  mux32 u_mux32_1 (
    .i_input1(reg_data1),
    .i_input2(ext_imm),
    .i_ctrl(mux1_ctrl),
    .o_output(alu_data1)
  );

  // ALU第二个操作数选择器
  wire [31:0] alu_data2;
  mux32 u_mux32_2 (
    .i_input1(reg_data2),
    .i_input2(ext_imm),
    .i_ctrl(mux2_ctrl),
    .o_output(alu_data2)
  );

  // ALU
  wire [31:0] alu_result;
  alu u_alu (
    .i_alu_ctrl(alu_ctrl),
    .i_input1(alu_data1),
    .i_input2(alu_data2),
    .o_result(alu_result)
  );

  // 内存及其读写操作
  wire [31:0] mem_data;
  data_memory u_dm(
    .i_clk(i_clk),
    .i_mem_write(mem_write),
    .i_addr(alu_result[9:2]),
    .i_write_data(reg_data2),
    .o_read_data(mem_data)
  );

  // 寄存器堆写地址选择器
  mux5 u_mux5_3 (
    .i_input1(rt),
    .i_input2(rd),
    .i_ctrl(mux3_ctrl),
    .o_output(mem_write_addr)
  );

  // 寄存器堆写数据选择器
  mux32 u_mux32_4 (
    .i_input1(alu_result),
    .i_input2(mem_data),
    .i_ctrl(mux4_ctrl),
    .o_output(mem_write_data)
  );

  // 跳转模块
  branch_unit u_br (
    .i_pc(pc),
    .i_addr(addr),
    .i_offset(imm),
    .i_ctrl(br_ctrl),
    .i_input1(reg_data1),
    .i_input2(reg_data2),
    .o_npc(npc)
  );
  
  assign debug = alu_result;
endmodule
