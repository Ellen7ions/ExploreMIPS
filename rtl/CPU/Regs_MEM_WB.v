`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 18:58:41
// Design Name: 
// Module Name: Regs_MEM_WB
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

module Regs_MEM_WB(
    input   wire clk, en, rst, clear,

    input  wire [`INSTR_WIDTH-1:0]  W_MEM_mem_data_i,
    input  wire [`INSTR_WIDTH-1:0]  W_MEM_alu_res_i,
    input  wire [4:0]               W_MEM_rd_i,
    input  wire                     W_MEM_w_reg_ena_i,
    input  wire                     W_MEM_wb_sel_i,

    // debug
    input  wire [31:0]              W_MEM_PC_i,

    output  wire [`INSTR_WIDTH-1:0] W_MEM_mem_data_o,
    output  wire [`INSTR_WIDTH-1:0] W_MEM_alu_res_o,
    output  wire [4:0]              W_MEM_rd_o,
    output  wire                    W_MEM_w_reg_ena_o,
    output  wire                    W_MEM_wb_sel_o,

    // debug
    input  wire [31:0]              W_MEM_PC_o
    );

    FlopEnRC #(`INSTR_WIDTH) flop_pc(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_MEM_PC_i),
        .out(W_MEM_PC_o)
    );

    FlopEnRC #(`INSTR_WIDTH) flop_mem_data(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_MEM_mem_data_i),
        .out(W_MEM_mem_data_o)
    );

    FlopEnRC #(`INSTR_WIDTH) flop_alu_res(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_MEM_alu_res_i),
        .out(W_MEM_alu_res_o)
    );

    FlopEnRC #(1) flop_w_reg_ena(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_MEM_w_reg_ena_i),
        .out(W_MEM_w_reg_ena_o)
    );

    FlopEnRC #(5) flop_rd(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_MEM_rd_i),
        .out(W_MEM_rd_o)
    );

    FlopEnRC #(1) flop_wb_sel(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_MEM_wb_sel_i),
        .out(W_MEM_wb_sel_o)
    );

endmodule
