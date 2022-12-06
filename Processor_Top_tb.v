`timescale 1ns / 1ns
`include "Processor_Top.v"

module Processor_Top_tb;

reg clk;
reg rst_n;

Processor_Top uut 
(
	.clk(clk), 
	.rst_n(rst_n)
);

always begin 
    #5
    clk = ~clk;
end

initial begin
	$dumpfile("Processor_Top_tb.vcd");
    $dumpvars(0, Processor_Top_tb);

	clk = 1'b1;
	rst_n = 1'b0;
	#30
	rst_n = 1'b1;
	#70	
	$finish;
end   
endmodule