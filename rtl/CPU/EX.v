`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/18 11:11:14
// Design Name: 
// Module Name: EX
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

module EX(
    input wire  [`INSTR_WIDTH-1:0]  W_ID_rs_data,
    input wire  [`INSTR_WIDTH-1:0]  W_ID_rt_data,
    input wire                      W_ID_rt_sel,
    input wire  [3:0]               W_ID_alu_sel,
    input wire  [15:0]              W_ID_imme,

    // harzard
    input wire  [1:0]               W_forwardA,
    input wire  [1:0]               W_forwardB,
    input wire  [`INSTR_WIDTH-1:0]  W_EX_MEM_alu_res,
    input wire  [`INSTR_WIDTH-1:0]  W_WB_wb_data,

    // control
    input wire  [4:0]               W_ID_rd,
    // mem
    input wire                      W_ID_w_mem_ena,
    // wb
    input wire                      W_ID_w_reg_ena,
    input wire                      W_ID_wb_sel,


    output wire [`INSTR_WIDTH-1:0]  W_EX_alu_res,
    output wire [`INSTR_WIDTH-1:0]  W_EX_rt_data,
    output wire [4:0]               W_EX_rd,
    output wire                     W_EX_w_mem_ena,
    output wire                     W_EX_w_reg_ena,
    output wire                     W_EX_wb_sel
    );

    reg [`INSTR_WIDTH-1:0] W_a, W_b;
    wire [`INSTR_WIDTH-1:0] W_alu_res, W_a_src, W_b_src;

    always @(*) begin
        case (W_forwardA)
            2'b00: W_a = W_ID_rs_data;
            2'b01: W_a = W_EX_MEM_alu_res;
            2'b10: W_a = W_WB_wb_data;
            default: W_a = {`INSTR_WIDTH{1'b0}};
        endcase
    end

    always @(*) begin
        case (W_forwardB)
            2'b00: W_b = W_ID_rt_data;
            2'b01: W_b = W_EX_MEM_alu_res;
            2'b10: W_b = W_WB_wb_data;
            default: W_b = {`INSTR_WIDTH{1'b0}};
        endcase
    end

    assign W_a_src = W_a;
    assign W_b_src = (W_ID_rt_sel == 1'b0) ? W_b : {{16{W_ID_imme[15]}}, W_ID_imme};

    ALU alu(
        .W_a(W_a_src),
        .W_b(W_b_src),
        .W_op_sel(W_ID_alu_sel),
        .R_alu_res(W_alu_res)
    );

    assign W_EX_alu_res     = W_alu_res;
    assign W_EX_rt_data     = W_b;
    assign W_EX_rd          = W_ID_rd;
    assign W_EX_w_mem_ena   = W_ID_w_mem_ena;
    assign W_EX_w_reg_ena   = W_ID_w_reg_ena;
    assign W_EX_wb_sel      = W_ID_wb_sel;

endmodule
