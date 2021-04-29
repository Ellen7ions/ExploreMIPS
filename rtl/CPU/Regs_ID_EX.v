`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 18:58:03
// Design Name: 
// Module Name: Regs_ID_EX
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

module Regs_ID_EX(
    input wire clk, en, rst, clear,
    
    input wire [15:0]               W_ID_imme_i,
    input wire [4:0]                W_ID_rs_i,
    input wire [4:0]                W_ID_rt_i,
    input wire [4:0]                W_ID_rd_i,
    input wire [`INSTR_WIDTH-1:0]   W_ID_rs_data_i,
    input wire [`INSTR_WIDTH-1:0]   W_ID_rt_data_i,

    input wire                      W_ID_rt_sel_i,
    input wire [3:0]                W_ID_alu_sel_i,
    input wire                      W_ID_w_mem_ena_i,
    input wire                      W_ID_w_reg_ena_i,
    input wire                      W_ID_wb_sel_i,
    input wire                      W_ID_mem_r_i,

    // debug
    input wire [31:0]               W_ID_PC_i,

    output wire [15:0]              W_ID_imme_o,
    output wire [4:0]               W_ID_rs_o,
    output wire [4:0]               W_ID_rt_o,
    output wire [4:0]               W_ID_rd_o,
    output wire [`INSTR_WIDTH-1:0]  W_ID_rs_data_o,
    output wire [`INSTR_WIDTH-1:0]  W_ID_rt_data_o,

    output wire                     W_ID_rt_sel_o,
    output wire [3:0]               W_ID_alu_sel_o,
    output wire                     W_ID_w_mem_ena_o,
    output wire                     W_ID_w_reg_ena_o,
    output wire                     W_ID_wb_sel_o,
    output wire                     W_ID_mem_r_o,

    // debug
    output wire [31:0]              W_ID_PC_o
    );

    FlopEnRC #(32) flop_pc(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_ID_PC_i),
        .out(W_ID_PC_o)
    );

    FlopEnRC #(16) flop_imme(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_ID_imme_i),
        .out(W_ID_imme_o)
    );

    FlopEnRC #(5) flop_rs(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_ID_rs_i),
        .out(W_ID_rs_o)
    );

    FlopEnRC #(5) flop_rt(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_ID_rt_i),
        .out(W_ID_rt_o)
    );

    FlopEnRC #(5) flop_rd(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_ID_rd_i),
        .out(W_ID_rd_o)
    );

    FlopEnRC #(`INSTR_WIDTH) flop_rs_data(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_ID_rs_data_i),
        .out(W_ID_rs_data_o)
    );

    FlopEnRC #(`INSTR_WIDTH) flop_rt_data(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_ID_rt_data_i),
        .out(W_ID_rt_data_o)
    );

    FlopEnRC #(1) flop_rt_sel(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_ID_rt_sel_i),
        .out(W_ID_rt_sel_o)
    );

    FlopEnRC #(4) flop_alu_sel(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_ID_alu_sel_i),
        .out(W_ID_alu_sel_o)
    );

    FlopEnRC #(1) flop_w_mem_ena_sel(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_ID_w_mem_ena_i),
        .out(W_ID_w_mem_ena_o)
    );

    FlopEnRC #(1) flop_w_reg_ena(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_ID_w_reg_ena_i),
        .out(W_ID_w_reg_ena_o)
    );

    FlopEnRC #(1) flop_wb_sel(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_ID_wb_sel_i),
        .out(W_ID_wb_sel_o)
    );

    FlopEnRC #(1) flop_id_mem_r(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .clear(clear),
        .in(W_ID_mem_r_i),
        .out(W_ID_mem_r_o)
    );

endmodule
