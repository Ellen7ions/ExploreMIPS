`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/18 16:38:11
// Design Name: 
// Module Name: Hazard
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


module Hazard(
    input   wire [4:0]  W_ID_rs,
    input   wire [4:0]  W_ID_rt,
    input   wire        W_ID_branch_op,
    input   wire        W_ID_j_op,
    input   wire        W_ID_EX_mem_r,
    input   wire        W_EX_MEM_mem_r,
    input   wire [4:0]  W_ID_EX_rt,
    input   wire [4:0]  W_ID_EX_rs,
    input   wire [4:0]  W_ID_EX_rd,
    input   wire [4:0]  W_EX_MEM_rt,
    input   wire [4:0]  W_EX_MEM_rs,
    input   wire        W_ID_EX_w_reg_ena,
    input   wire        W_EX_MEM_w_reg_ena,
    input   wire [4:0]  W_EX_MEM_rd,
    input   wire        W_MEM_WB_w_reg_ena,
    input   wire [4:0]  W_MEM_WB_rd,

    output  reg         PC_stall,
    output  reg         IF_ID_stall,
    output  reg         IF_ID_flush,
    // output wire ID_EX_stall,
    output  reg         ID_EX_flush,
    // output wire EX_MEM_stall,
    // output wire EX_MEM_flush,
    // output wire MEM_WB_stall,
    // output wire MEM_WB_flush,
    output  reg [1:0]   W_EX_forwardA,
    output  reg [1:0]   W_EX_forwardB,
    output  reg [1:0]   W_ID_forwardA,
    output  reg [1:0]   W_ID_forwardB
    );

    always @(*) begin
        W_EX_forwardA = 2'b00;
        if (W_EX_MEM_w_reg_ena && (W_EX_MEM_rd != 5'h00) && (W_EX_MEM_rd == W_ID_EX_rs)) begin
            W_EX_forwardA = 2'b01;
        end else if (W_MEM_WB_w_reg_ena && (W_MEM_WB_rd != 5'h00) && (W_MEM_WB_rd == W_ID_EX_rs)) begin
            W_EX_forwardA = 2'b10;
        end
    end

    always @(*) begin
        W_EX_forwardB = 2'b00;
        if (W_EX_MEM_w_reg_ena && (W_EX_MEM_rd != 5'h00) && (W_EX_MEM_rd == W_ID_EX_rt)) begin
            W_EX_forwardB =  2'b01;
        end else if (W_MEM_WB_w_reg_ena && (W_MEM_WB_rd != 5'h00) && (W_MEM_WB_rd == W_ID_EX_rt)) begin
            W_EX_forwardB = 2'b10;
        end
    end

    always @(*) begin
        W_ID_forwardA = 2'b00;
        if (W_EX_MEM_w_reg_ena && (W_EX_MEM_rd != 5'h00) && (W_EX_MEM_rd == W_ID_rs)) begin
            W_ID_forwardA = 2'b01;
        end else if (W_MEM_WB_w_reg_ena && (W_MEM_WB_rd != 5'h00) && (W_MEM_WB_rd == W_ID_rs)) begin
            W_ID_forwardA = 2'b10;
        end
    end

    always @(*) begin
        W_ID_forwardB = 2'b00;
        if (W_EX_MEM_w_reg_ena && (W_EX_MEM_rd != 5'h00) && (W_EX_MEM_rd == W_ID_rt)) begin
            W_ID_forwardB = 2'b01;
        end else if (W_MEM_WB_w_reg_ena && (W_MEM_WB_rd != 5'h00) && (W_MEM_WB_rd == W_ID_rt)) begin
            W_ID_forwardB = 2'b10;
        end
    end

    always @(*) begin
        if (W_ID_j_op) begin
            PC_stall    = 1'b0;
            IF_ID_stall = 1'b0;
            IF_ID_flush = 1'b1;
            ID_EX_flush = 1'b0;
        end else if (W_ID_branch_op) begin
            if (W_ID_EX_mem_r && ((W_ID_EX_rt == W_ID_rs) || (W_ID_EX_rt == W_ID_rt))) begin
                PC_stall    = 1'b1;
                IF_ID_stall = 1'b1;
                IF_ID_flush = 1'b0;
                ID_EX_flush = 1'b1;
            end else if (W_EX_MEM_mem_r && ((W_EX_MEM_rt == W_ID_rs) || (W_EX_MEM_rt == W_ID_rt))) begin
                PC_stall    = 1'b1;
                IF_ID_stall = 1'b1;
                IF_ID_flush = 1'b0;
                ID_EX_flush = 1'b1;
            end else if (W_ID_EX_w_reg_ena && ((W_ID_EX_rd != 5'h00) && ((W_ID_EX_rd == W_ID_rs) || (W_ID_EX_rd == W_ID_rt)))) begin
                PC_stall    = 1'b1;
                IF_ID_stall = 1'b1;
                IF_ID_flush = 1'b0;
                ID_EX_flush = 1'b1;
            end else begin
                PC_stall    = 1'b0;
                IF_ID_stall = 1'b0;
                IF_ID_flush = 1'b1;
                ID_EX_flush = 1'b0;
            end
        end else begin
            if (W_ID_EX_mem_r && ((W_ID_EX_rt == W_ID_rs) || (W_ID_EX_rt == W_ID_rt))) begin
                PC_stall    = 1'b1;
                IF_ID_stall = 1'b1;
                IF_ID_flush = 1'b0;
                ID_EX_flush = 1'b1;
            end else begin
                PC_stall    = 1'b0;
                IF_ID_stall = 1'b0;
                IF_ID_flush = 1'b0;
                ID_EX_flush = 1'b0;
            end
        end
    end

endmodule
