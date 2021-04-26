`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 18:15:37
// Design Name: 
// Module Name: SIM_DFFS
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


module SIM_DFFS();
    reg clk, rst, clear, en;
    reg [31:0] in;
    wire [31:0] out;
    FlopEnRC #(32) dff(clk, en, rst, clear, in, out);

    initial begin
        clk = 1'b0;
        forever #50 begin
            clk = ~clk;
        end
    end

    initial begin
        en = 1'b1;
        in = 32'h1234_1234;
        clear = 1'b0;

        #10 rst = 1'b0;
        #30 rst = 1'b1;
        #50 rst = 1'b0;
        // #100 clear = 1'b1;

        #200 begin
            en = 1'b0;
            in = 32'h4321_4321;
        end
    end

endmodule
