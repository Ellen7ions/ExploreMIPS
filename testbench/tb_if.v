`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/21 12:25:46
// Design Name: 
// Module Name: tb_if
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


module tb_if();
    reg clk, rst;
    wire [31:0] W_instr;
    IF iff(
        clk, 1'b0, rst,
        W_instr
    );

    initial begin
        clk = 1'b0;
        repeat (200) begin
            #50 clk = ~clk;
        end        
    end

    initial begin
        #10 rst = 1'b0;
        #100 rst = 1'b1;
        #100 rst = 1'b0;
    end
endmodule
