`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 19:26:09
// Design Name: 
// Module Name: SIM_ALU
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


module SIM_ALU();
    reg [31:0] a, b;
    wire [31:0] c;
    reg [3:0] sel;
    
    ALU alu(a, b, sel, c);

    integer i;

    initial begin
        #10 begin
            a = 32'h0010_c1a1;
            b = 32'h0000_2333;
        end

        for (i = 4'h0; i <= 4'hf; i = i + 1) begin
            #10 sel = i;
        end
    end
endmodule
