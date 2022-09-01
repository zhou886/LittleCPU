`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/31 12:09:00
// Design Name: 
// Module Name: testbench
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


module testbench();
    reg clk;
    reg rst;
    wire [31:0] debug;

    initial begin
        $readmemh("D:/CODE/Verilog/LittleCPU/PipelineCPU/TestResources/InstMemory.txt", u_cpu_top.u_IF.u_inst_memory.inst_memory, 0, 255);
        $readmemh("D:/CODE/Verilog/LittleCPU/PipelineCPU/TestResources/DataMemory.txt", u_cpu_top.u_MEM.u_data_memory.data_memory, 0, 255);
        $readmemh("D:/CODE/Verilog/LittleCPU/PipelineCPU/TestResources/RegisterFile.txt", u_cpu_top.u_ID.u_register_file.register_file, 0, 31);
        rst <= 1;
        clk <= 0;
        #12 rst <= 0;
        #42 rst <= 1;
    end

    always #20 clk <= ~clk;

    cpu_top u_cpu_top (
        .i_clk(clk),
        .i_rst(rst),
        .o_debug(debug)
    );
endmodule
