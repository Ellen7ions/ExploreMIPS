`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 18:43:42
// Design Name: 
// Module Name: PC
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

`include "defines.v"

module PC(
    input   wire        clk,
    input   wire        en,
    input   wire        rst,
    input   wire [31:0] W_next_pc,
    output  reg  [31:0] W_pc
    );
    
    // FlopEnR dff(clk, en, rst, W_next_pc, W_pc);
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            W_pc <= 32'hffff_fffc;
        end else if (en) begin
            W_pc <= W_next_pc;
        end
    end
endmodule
