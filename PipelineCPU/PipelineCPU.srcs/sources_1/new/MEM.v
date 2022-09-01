`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/30 17:02:41
// Design Name: 
// Module Name: MEM
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


module MEM (
    input wire i_clk,
    input wire i_rst,
    input wire [31:0] i_alu_result,
    input wire [31:0] i_reg_data2,
    input wire i_data_memory_write_enable,
    input wire i_mux32_2_ctrl,

    output wire [31:0] o_reg_write_data
);
  wire [31:0] data_memory_read_data;
  data_memory u_data_memory (
    .i_clk(i_clk),
    .i_write_enable(i_data_memory_write_enable),
    .i_addr(i_alu_result[9:2]),
    .i_write_data(i_reg_data2),
    .o_read_data(data_memory_read_data)
  );

  mux32 u_mux32_2 (
    .i_input1(i_alu_result),
    .i_input2(data_memory_read_data),
    .i_ctrl(i_mux32_2_ctrl),
    .o_output(o_reg_write_data)
  );
endmodule
