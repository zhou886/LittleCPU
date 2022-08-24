`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 18:30:17
// Design Name: 
// Module Name: data_memory
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


module data_memory (
    input wire i_clk,
    input wire i_mem_write,
    input wire [9:2] i_addr,
    input wire [31:0] i_write_data,
    output wire [31:0] o_read_data
);
  reg [31:0] data_memory[255:0];

  assign o_read_data = data_memory[i_addr];

  always @(posedge i_clk) begin
    if (i_mem_write) begin
      data_memory[i_addr] <= i_write_data;
    end
  end
endmodule
