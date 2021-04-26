`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/21 16:24:10
// Design Name: 
// Module Name: tb_ex
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

// `include "defines.v"

module tb_ex();
    reg [31:0] W_ID_EX_rs_data, W_ID_EX_rt_data;
    reg W_ID_EX_rt_sel;
    reg [3:0] W_ID_EX_alu_sel;
    reg [15:0] W_ID_EX_imme;
    
    reg [1:0] W_forwardA;
    reg [1:0] W_forwardB;
    reg [31:0] W_EX_MEM_alu_res;
    reg [31:0] W_WB_w_data;

    reg [4:0] W_ID_EX_rd;
    reg W_ID_EX_w_mem_ena;
    reg W_ID_EX_w_reg_ena;
    reg W_ID_EX_wb_sel;

    wire [31:0] W_EX_alu_res;
    wire [31:0] W_EX_rt_data;
    wire W_EX_rd;
    wire W_EX_w_mem_ena;
    // wire W_EX_MEM_w_reg_ena;
    wire W_EX_wb_sel;

    EX ex(
        W_ID_EX_rs_data,
        W_ID_EX_rt_data,
        W_ID_EX_rt_sel,
        W_ID_EX_alu_sel,
        W_ID_EX_imme,
        W_forwardA,
        W_forwardB,
        W_EX_MEM_alu_res,
        W_WB_w_data,
        // control
        W_ID_EX_rd,
        W_ID_EX_w_mem_ena,
        W_ID_EX_w_reg_ena,
        W_ID_EX_wb_sel,

        // out
        W_EX_alu_res,
        W_EX_rt_data,
        W_EX_rd,
        W_EX_w_mem_ena,
        W_EX_w_reg_ena,
        W_EX_wb_sel
    );

    initial begin
        // init data

        W_ID_EX_rd = 4'h0;
        W_ID_EX_w_mem_ena = 0;
        W_ID_EX_w_reg_ena = 0;
        W_ID_EX_wb_sel = 0;

        // alu = 1
        #10 begin
            W_ID_EX_rs_data = 32'h0000_0001;
            W_ID_EX_rt_data = 32'h0000_0010;
            W_ID_EX_imme = 16'h1000;
            W_ID_EX_rt_sel = 1'b1;
            W_ID_EX_alu_sel = 4'h1;
            W_forwardA = 2'b00;
            W_forwardB = 2'b00;
            W_EX_MEM_alu_res = 32'h0000_0100;
            W_WB_w_data = 32'h0000_1000;
        end

        // alu = 2
        #10 begin
            W_ID_EX_alu_sel = 4'h2;
        end

        // reset
        #10 begin
            W_ID_EX_rt_sel = 1'b0;
        end

        // forward
        #10 begin
            W_ID_EX_alu_sel = 4'h3;
            W_forwardA = 2'b01;
        end
    end

endmodule
