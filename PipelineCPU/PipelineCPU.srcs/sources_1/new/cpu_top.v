`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/30 22:42:06
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
    output wire [31:0] o_debug
);
  wire ex_is_lw;
  wire [4:0] ex_reg_write_addr;
  wire [4:0] id_rs;
  wire [4:0] id_rt;
  wire [3:0] pipeline_ctrl;
  pipeline_control_unit u_pipeline_control_unit (
    .i_rst(i_rst),
    .i_clk(i_clk),
    .i_ex_is_lw(ex_is_lw),
    .i_ex_reg_write_addr(ex_reg_write_addr),
    .i_rs(id_rs),
    .i_rt(id_rt),
    .o_pipeline_ctrl(pipeline_ctrl)
  );

  wire [31:0] npc;
  wire [31:0] if_inst;
  wire [31:0] pc;
  IF u_IF (
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_ctrl(pipeline_ctrl[0]),
    .i_npc(npc),
    .o_inst(if_inst),
    .o_pc(pc)
  );

  wire [31:0] id_inst;
  IF_ID_reg u_IF_ID_reg (
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_ctrl(pipeline_ctrl[1]),
    .i_inst(if_inst),
    .o_inst(id_inst)
  );

  wire [3:0] id_alu_ctrl;
  wire [1:0] id_imm_extend_ctrl;
  wire [1:0] id_interrupt_ctrl;
  wire [4:0] id_reg_write_addr;
  wire [31:0] wb_reg_write_data;
  wire [4:0] wb_reg_write_addr;
  wire wb_reg_write_enable;
  wire id_register_file_write_enable;
  wire id_data_memory_write_enable;
  wire id_mux32_1_ctrl;
  wire id_mux32_2_ctrl;
  wire [31:0] id_reg_data1;
  wire [31:0] id_reg_data2;
  ID u_ID (
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_inst(id_inst),
    .i_pc(pc),
    .i_reg_write_data(wb_reg_write_data),
    .i_reg_write_addr(wb_reg_write_addr),
    .i_register_file_write_enable(wb_reg_write_enable),
    .o_alu_ctrl(id_alu_ctrl),
    .o_imm_extend_ctrl(id_imm_extend_ctrl),
    .o_interrupt_ctrl(id_interrupt_ctrl),
    .o_reg_write_addr(id_reg_write_addr),
    .o_register_file_write_enable(id_register_file_write_enable),
    .o_data_memory_write_enable(id_data_memory_write_enable),
    .o_mux32_1_ctrl(id_mux32_1_ctrl),
    .o_mux32_2_ctrl(id_mux32_1_ctrl),
    .o_reg_data1(id_reg_data1),
    .o_reg_data2(id_reg_data2),
    .o_npc(npc)
  );

  wire [31:0] ex_reg_data1;
  wire [31:0] ex_reg_data2;
  wire [4:0] ex_rs;
  wire [4:0] ex_rt;
  wire [15:0] ex_imm;
  wire [3:0] ex_alu_ctrl;
  wire [1:0] ex_imm_extend_ctrl;
  wire ex_register_file_write_enable;
  wire ex_data_memory_write_enable;
  wire ex_mux32_1_ctrl;
  wire ex_mux32_2_ctrl;
  ID_EX_reg u_ID_EX_reg (
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_ctrl(pipeline_ctrl[2]),
    .i_reg_data1(id_reg_data1),
    .i_reg_data2(id_reg_data2),
    .i_inst(id_inst),
    .i_reg_write_addr(id_reg_write_addr),
    .i_alu_ctrl(id_alu_ctrl),
    .i_imm_extend_ctrl(id_imm_extend_ctrl),
    .i_register_file_write_enable(id_register_file_write_enable),
    .i_data_memory_write_enable(id_data_memory_write_enable),
    .i_mux32_1_ctrl(id_mux32_1_ctrl),
    .i_mux32_2_ctrl(id_mux32_2_ctrl),
    .o_reg_data1(ex_reg_data1),
    .o_reg_data2(ex_reg_data2),
    .o_reg_write_addr(ex_reg_write_addr),
    .o_rs(ex_rs),
    .o_rt(ex_rt),
    .o_imm(ex_imm),
    .o_alu_ctrl(ex_alu_ctrl),
    .o_imm_extend_ctrl(ex_imm_extend_ctrl),
    .o_register_file_write_enable(ex_register_file_write_enable),
    .o_data_memory_write_enable(ex_data_memory_write_enable),
    .o_mux32_1_ctrl(ex_mux32_1_ctrl),
    .o_mux32_2_ctrl(ex_mux32_2_ctrl)
  );

  wire mem_reg_write_enable;
  wire [4:0] mem_reg_write_addr;
  wire [31:0] ex_alu_result;
  EX u_EX (
    .i_reg_data1(ex_reg_data1),
    .i_reg_data2(ex_reg_data2),
    .i_imm(ex_imm),
    .i_alu_ctrl(ex_alu_ctrl),
    .i_imm_extend_ctrl(ex_imm_extend_ctrl),
    .i_mux32_1_ctrl(ex_mux32_1_ctrl),
    .i_mem_reg_write_enable(mem_reg_write_enable),
    .i_mem_reg_write_addr(mem_reg_write_addr),
    .i_wb_reg_write_enable(wb_reg_write_enable),
    .i_wb_reg_write_addr(wb_reg_write_addr),
    .i_rs(ex_rs),
    .i_rt(ex_rt),
    .o_alu_result(ex_alu_result)
  );

  wire [31:0] mem_alu_result;
  wire [31:0] mem_reg_data2;
  wire mem_data_memory_write_enable;
  wire mem_register_file_write_enable;
  wire mem_mux32_2_ctrl;
  EX_MEM_reg u_EX_MEM_reg (
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_ctrl(pipeline_ctrl[3]),
    .i_alu_result(ex_alu_result),
    .i_reg_data2(ex_reg_data2),
    .i_reg_write_addr(ex_reg_write_addr),
    .i_data_memory_write_enable(ex_data_memory_write_enable),
    .i_register_file_write_enable(ex_register_file_write_enable),
    .i_mux32_2_ctrl(ex_mux32_2_ctrl),
    .o_alu_result(o_alu_result),
    .o_reg_data2(mem_reg_data2),
    .o_reg_write_addr(mem_reg_write_addr),
    .o_data_memory_write_enable(mem_data_memory_write_enable),
    .o_register_file_write_enable(mem_register_file_write_enable),
    .o_mux32_2_ctrl(mem_mux32_2_ctrl)
  );
  assign mem_reg_write_enable = mem_register_file_write_enable;

  wire [31:0] mem_reg_write_data;
  MEM u_MEM (
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_alu_result(mem_alu_result),
    .i_reg_data2(mem_reg_data2),
    .i_data_memory_write_enable(mem_data_memory_write_enable),
    .i_mux32_2_ctrl(mem_mux32_2_ctrl),
    .o_reg_write_data(mem_reg_write_data)
  );

  wire wb_register_file_write_enable;
  MEM_WB_reg u_MEM_WB_reg (
    .i_clk(i_clk),
    .i_rst(i_rst),
    .i_reg_write_addr(mem_reg_write_addr),
    .i_reg_write_data(mem_reg_write_data),
    .i_register_file_write_enable(mem_register_file_write_enable),
    .o_reg_write_data(wb_reg_write_data),
    .o_reg_write_addr(wb_reg_write_addr),
    .o_register_file_write_enable(wb_register_file_write_enable)
  );
  assign wb_reg_write_enable = wb_register_file_write_enable;

endmodule
