`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 18:58:15
// Design Name: 
// Module Name: Regs_EX_MEM
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

module Regs_EX_MEM(
    input wire clk, en, rst, clear,

    input wire [`INSTR_WIDTH-1:0]   W_EX_alu_res_i,
    input wire [`INSTR_WIDTH-1:0]   W_EX_rt_data_i,
    input wire [4:0]                W_EX_rd_i,
    input wire                      W_EX_w_mem_ena_i,
    input wire                      W_EX_w_reg_ena_i,
    input wire                      W_EX_wb_sel_i,

    input wire                      W_EX_mem_r_i,
    input wire [4:0]                W_EX_rs_i,
    input wire [4:0]                W_EX_rt_i,

    output wire [`INSTR_WIDTH-1:0]  W_EX_alu_res_o,
    output wire [`INSTR_WIDTH-1:0]  W_EX_rt_data_o,
    output wire [4:0]               W_EX_rd_o,
    output wire                     W_EX_w_mem_ena_o,
    output wire                     W_EX_w_reg_ena_o,
    output wire                     W_EX_wb_sel_o,
    
    output wire                     W_EX_mem_r_o,
    output wire [4:0]               W_EX_rs_o,
    output wire [4:0]               W_EX_rt_o
    );

    FlopEnRC #(1) flop_mem_r(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_EX_mem_r_i),
        .out(W_EX_mem_r_o)
    );

    FlopEnRC #(5) flop_rs(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_EX_rs_i),
        .out(W_EX_rs_o)
    );

    FlopEnRC #(5) flop_rt(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_EX_rt_i),
        .out(W_EX_rt_o)
    );

    FlopEnRC #(`INSTR_WIDTH) flop_alu_res(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_EX_alu_res_i),
        .out(W_EX_alu_res_o)
    );

    FlopEnRC #(`INSTR_WIDTH) flop_rt_data(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_EX_rt_data_i),
        .out(W_EX_rt_data_o)
    );

    FlopEnRC #(5) flop_rd(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_EX_rd_i),
        .out(W_EX_rd_o)
    );

    FlopEnRC #(1) flop_w_mem_ena(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_EX_w_mem_ena_i),
        .out(W_EX_w_mem_ena_o)
    );

    FlopEnRC #(1) flop_w_reg_ena(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_EX_w_reg_ena_i),
        .out(W_EX_w_reg_ena_o)
    );

    FlopEnRC #(1) flop_wb_sel(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_EX_wb_sel_i),
        .out(W_EX_wb_sel_o)
    );

endmodule
