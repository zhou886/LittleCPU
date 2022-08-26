`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/24 17:07:39
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


module testbench ();
  reg clk;
  reg rst;
  wire [31:0] res;

  initial begin
    
    clk = 0;
    rst = 0;
    #30 rst = 1;
    #53 rst = 0;
    #500 $stop;
  end

  always #10 clk = ~clk;

  cpu_top u_cpu_top (
      .i_clk(clk),
      .i_rst(rst),
      .debug(res)
  );
endmodule
