`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/30 17:02:17
// Design Name: 
// Module Name: ID
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


module ID (
    input wire i_clk,
    input wire i_rst,
    input wire [31:0] i_inst,
    input wire [31:0] i_reg_write_data,
    input wire [4:0] i_reg_write_addr,
    input wire i_register_file_write_enable,

    output wire [3:0] o_alu_ctrl,
    output wire [2:0] o_npc_ctrl,
    output wire [1:0] o_imm_extend_ctrl,
    output wire [1:0] o_interrupt_ctrl,
    output wire [4:0] o_reg_write_addr,
    output wire o_register_file_write_enable,
    output wire o_data_memory_write_enable,
    output wire o_mux32_1_ctrl,
    output wire o_mux32_2_ctrl,
    output wire [31:0] o_reg_data1,
    output wire [31:0] o_reg_data2
);
  wire [ 5:0] opcode;
  wire [ 5:0] func;
  wire [ 5:0] rs;
  wire [ 5:0] rt;
  wire [ 5:0] rd;
  wire [15:0] imm;
  wire [25:0] addr;

  assign opcode = i_inst[31:26];
  assign rs = i_inst[25:21];
  assign rt = i_inst[20:16];
  assign rd = i_inst[15:11];
  assign func = i_inst[5:0];
  assign imm = i_inst[15:0];
  assign addr = i_inst[25:0];

  wire mux5_1_ctrl;
  control_unit u_control_unit (
      .i_opcode(opcode),
      .i_func(func),
      .o_alu_ctrl(o_alu_ctrl),
      .o_npc_ctrl(o_npc_ctrl),
      .o_imm_extend_ctrl(o_imm_extend_ctrl),
      .o_interrupt_ctrl(o_interrupt_ctrl),
      .o_register_file_write_enable(o_register_file_write_enable),
      .o_data_memory_write_enable(o_data_memory_write_enable),
      .o_mux32_1_ctrl(o_mux32_1_ctrl),
      .o_mux32_2_ctrl(o_mux32_2_ctrl),
      .o_mux5_1_ctrl(mux5_1_ctrl)
  );
  
  mux5 u_mux5_1 (
    .i_input1(rt),
    .i_input2(rd),
    .i_ctrl(mux5_1_ctrl),
    .o_output(o_reg_write_addr)
  );

  register_file u_register_file (
    .i_clk(i_clk),
    .i_write_enable(i_register_file_write_enable),
    .i_read_addr1(rs),
    .i_read_addr2(rt),
    .i_write_addr(i_reg_write_addr),
    .i_write_data(i_reg_write_data),
    .o_read_data1(o_reg_data1),
    .o_read_data2(o_reg_data2)
  );
endmodule
