`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/26 14:34:40
// Design Name: 
// Module Name: data_memory 数据存储器
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//   一个含有256个32位存储单元的数据存储器,只提供一个用于输入地址的接口,其同时
// 兼顾读取地址和写入地址的功能,故读取和写入不能同时进行. 数据写入在时钟信号上
// 升沿进行,同时需要提供写使能信号和要写入的数据.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module data_memory(
    input wire i_clk,
    input wire i_write_enable,
    input wire [9:2] i_addr,
    input wire [31:0] i_write_data,
    output wire [31:0] o_read_data
    );
  reg [31:0] data_memory[255:0];

  assign o_read_data = data_memory[i_addr];

  always @(posedge i_clk) begin
    if (i_write_enable) begin
      data_memory[i_addr] <= i_write_data;
    end
  end
endmodule
