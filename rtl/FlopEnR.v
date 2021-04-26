`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 18:28:33
// Design Name: 
// Module Name: FlopEnR
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


module FlopEnR #(parameter WIDTH = 32)(
    input wire clk,
    input wire en,
    input wire rst,
    input wire [WIDTH-1:0] in,
    output reg [WIDTH-1:0] out
    );

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            out <= {WIDTH{1'b0}};
        end else if (en) begin
            out <= in;
        end
    end

endmodule
