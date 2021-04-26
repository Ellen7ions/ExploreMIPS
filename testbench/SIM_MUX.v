`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 19:10:41
// Design Name: 
// Module Name: SIM_MUX
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


module SIM_MUX();
    reg [31:0] a, b, c;
    reg [1:0] sel;
    wire [31:0] out;
    Mux3 mux(a, b, c, sel, out);
    initial begin
        #10 begin
            a = 32'h1234_0000;
            b = 32'h0000_1234;
            c = 32'h0012_3400;
            sel = 2'b00;
        end
        #10 begin
            sel = 2'b01;
        end
        #10 begin
            sel = 2'b10;
        end
    end
endmodule
