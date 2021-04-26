`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 19:08:11
// Design Name: 
// Module Name: Mux2
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


module Mux2 #(parameter WIDTH = 32)(
    input   wire [WIDTH-1:0]    W_a,
    input   wire [WIDTH-1:0]    W_b,
    input   wire                W_sel,
    output  wire [WIDTH-1:0]    W_out
    );
    assign W_out = ({WIDTH{~W_sel}} & W_a) | ({WIDTH{W_sel}} & W_b);
endmodule
