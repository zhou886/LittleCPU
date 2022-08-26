`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 18:45:06
// Design Name: 
// Module Name: register_file
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


module register_file (
    input wire i_clk,
    input wire i_reg_write,
    input wire [4:0] i_read_addr1,
    input wire [4:0] i_read_addr2,
    input wire [4:0] i_write_addr,
    input wire [31:0] i_write_data,
    output wire [31:0] o_read_data1,
    output wire [31:0] o_read_data2
);
  reg [31:0] register_file[31:0];

  initial begin
    $readmemb("D:/CODE/Verilog/LittleCPU/SingleCycleCPU/SingleCycleCPU.srcs/sources_1/new/RegData.txt", register_file, 0, 31);
  end

  assign o_read_data1 = (i_read_addr1 == 0) ? 32'b0 : register_file[i_read_addr1];
  assign o_read_data2 = (i_read_addr2 == 0) ? 32'b0 : register_file[i_read_addr2];

  always @(posedge i_clk) begin
    if (i_reg_write) begin
      register_file[i_write_addr] <= i_write_data;
    end
  end
endmodule
