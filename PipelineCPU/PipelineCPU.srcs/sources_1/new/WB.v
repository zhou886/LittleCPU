`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/30 17:02:49
// Design Name: 
// Module Name: WB
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


module WB (
    input wire [31:0] i_reg_write_data,
    input wire [4:0] i_reg_write_addr,
    input wire i_register_file_write_enable,

    output wire [31:0] o_reg_write_data,
    output wire [4:0] o_reg_write_addr,
    output wire o_register_file_write_enable
);
  assign o_reg_write_addr = i_reg_write_addr;
  assign o_reg_write_data = i_reg_write_data;
  assign o_register_file_write_enable = i_register_file_write_enable;
endmodule
