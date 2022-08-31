`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/26 14:25:51
// Design Name: 
// Module Name: register_file 寄存器堆
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//   一个含有32个32位寄存器的寄存器堆,支持双口读取,单口写入,在时钟周期的上升沿
// 写入并需要提供写使能信号和要写入的数据.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register_file (
    input wire i_clk,
    input wire i_write_enable,
    input wire [4:0] i_read_addr1,
    input wire [4:0] i_read_addr2,
    input wire [4:0] i_write_addr,
    input wire [31:0] i_write_data,
    output wire [31:0] o_read_data1,
    output wire [31:0] o_read_data2
);
  reg [31:0] register_file[31:0];

  assign o_read_data1 = (i_read_addr1 == 0) ? 32'b0 : register_file[i_read_addr1];
  assign o_read_data2 = (i_read_addr2 == 0) ? 32'b0 : register_file[i_read_addr2];

  always @(posedge i_clk) begin
    if (i_write_enable) begin
      register_file[i_write_addr] <= i_write_data;
    end
  end
endmodule
