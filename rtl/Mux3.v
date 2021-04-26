`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 19:13:10
// Design Name: 
// Module Name: Mux3
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


module Mux3 #(parameter WIDTH = 32)(
    input   wire [WIDTH-1:0]    W_a,     // 00
    input   wire [WIDTH-1:0]    W_b,     // 01
    input   wire [WIDTH-1:0]    W_c,     // 10
    input   wire [1:0]          sel,
    output  wire [WIDTH-1:0]    W_out
    );

    assign W_out = 
        ({WIDTH{ (~sel[1]) & (~sel[0]) }} & W_a) |
        ({WIDTH{ (~sel[1]) & ( sel[0]) }} & W_b) |
        ({WIDTH{ ( sel[1]) & (~sel[0]) }} & W_c);

endmodule
