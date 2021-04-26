`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 18:28:05
// Design Name: 
// Module Name: FlopR
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


module FlopR #(parameter WIDTH = 32)(
    input wire clk,
    input wire rst,
    input wire [WIDTH-1:0] in,
    output reg [WIDTH-1:0] out
    );

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            out <= {WIDTH{1'b0}};
        end else begin
            out <= in;
        end
    end

endmodule
