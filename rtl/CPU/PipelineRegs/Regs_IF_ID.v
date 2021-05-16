`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 18:57:51
// Design Name: 
// Module Name: Regs_IF_ID
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

`include "../defines.v"    

module Regs_IF_ID(
    input wire clk,
    input wire en,
    input wire rst,
    input wire clear,
    input wire [`INSTR_WIDTH-1:0] W_IF_instr_i,
    input wire [`INSTR_WIDTH-1:0] W_IF_PC_i,

    output wire [`INSTR_WIDTH-1:0] W_IF_instr_o,
    output wire [`INSTR_WIDTH-1:0] W_IF_PC_o
    );

    FlopEnRC #(`INSTR_WIDTH) flop_instr(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_IF_instr_i),
        .out(W_IF_instr_o)
    );
    
    FlopEnRC #(`INSTR_WIDTH) flop_pc(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_IF_PC_i),
        .out(W_IF_PC_o)
    );

endmodule
