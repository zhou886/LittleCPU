`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 16:05:17
// Design Name: 
// Module Name: instruction_memory 指令存储器
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
//  输入指令地址，输出指令的机器码
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module instruction_memory (
    input  wire [ 9:2] i_inst_addr,
    output wire [31:0] o_inst
);
  reg [31:0] inst_memory[255:0];
  initial begin
    $readmemh("D:/CODE/Verilog/LittleCPU/SingleCycleCPU/SingleCycleCPU.srcs/sources_1/new/InstFlow.txt", inst_memory, 0, 255);
  end
  // 因为只设置了256个指令存储字，所以只用指令地址的8位
  assign o_inst = inst_memory[i_inst_addr];
endmodule
