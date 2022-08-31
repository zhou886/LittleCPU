`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/29 15:36:56
// Design Name: 
// Module Name: MEM_WB_reg
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


module MEM_WB_reg (
    input wire i_clk,
    input wire i_rst,
    input wire [31:0] i_reg_write_data,
    input wire [4:0] i_reg_write_addr,
    input wire i_register_file_write_enable,

    output wire [31:0] o_reg_write_data,
    output wire [4:0] o_reg_write_addr,
    output wire o_register_file_write_enable
);
  reg [31:0] reg_write_data;
  reg [4:0] reg_write_addr;
  reg register_file_write_enable;

  always @(posedge i_clk) begin
    if (!i_rst) begin
        reg_write_data <= 32'b0;
        reg_write_addr <= 5'b0;
        register_file_write_enable = 1'b0;
    end
    else begin
        reg_write_data <= i_reg_write_data;
        reg_write_addr <= i_reg_write_addr;
        register_file_write_enable <= i_register_file_write_enable;
    end
  end

  assign o_reg_write_data = reg_write_data;
  assign o_reg_write_addr = reg_write_addr;
  assign o_register_file_write_enable = register_file_write_enable;
endmodule
