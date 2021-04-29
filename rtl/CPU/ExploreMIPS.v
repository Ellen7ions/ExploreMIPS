`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 18:03:20
// Design Name: 
// Module Name: ExploreMIPS
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

module ExploreMIPS(
    input   wire          clk,
    input   wire          rst,
    
    // instr_ram
    output  wire          W_instr_ram_ena,
    output  wire [3:0]    W_instr_ram_wea,
    output  wire [31:0]   W_instr_ram_w_data,
    output  wire [31:0]   W_instr_ram_addr,         // *
    input   wire [31:0]   W_instr_ram_r_data,       // *
    
    // data_ram
    output  wire          W_data_ram_ena,
    output  wire [3:0]    W_data_ram_wea,           // *
    output  wire [31:0]   W_data_ram_w_data,        // *
    output  wire [31:0]   W_data_ram_addr,          // *
    input   wire [31:0]   W_data_ram_r_data         // *
    );

    assign W_instr_ram_ena = 1'b1;
    assign W_instr_ram_wea = 4'h0;
    assign W_instr_ram_w_data = 32'h0000_0000;

    assign W_data_ram_ena = 1'b1;

    wire [5:0]  W_op, W_func;
    wire        W_w_dst_sel;
    wire        W_w_reg_ena;
    wire        W_rt_sel;
    wire [3:0]  W_alu_sel;
    wire        W_w_mem_ena;
    wire        W_wb_sel;
    wire        W_ID_EX_mem_r;
    wire [1:0]  W_branch_sel;
    wire [1:0]  W_j_sel;

    Controller controller(
        W_op,
        W_func,
        W_w_dst_sel,
        W_w_reg_ena,
        W_branch_sel,
        W_j_sel,
        W_rt_sel,
        W_alu_sel,
        W_w_mem_ena,
        W_wb_sel
    );

    wire        PC_stall;
    wire        IF_ID_stall;
    wire        ID_EX_flush;
    wire        IF_ID_flush;

    wire [1:0]  W_EX_forwardA;
    wire [1:0]  W_EX_forwardB;
    wire [1:0]  W_ID_forwardA;
    wire [1:0]  W_ID_forwardB;

    wire [4:0]  W_ID_rs, W_ID_rt;
    wire        W_ID_mem_r;
    wire        W_ID_branch_op;
    wire        W_ID_j_op;
    wire [4:0]  W_ID_EX_rt, W_ID_EX_rs, W_ID_EX_rd;
    wire        W_EX_MEM_w_reg_ena;
    wire        W_ID_EX_w_reg_ena;
    wire [4:0]  W_EX_MEM_rd;
    wire        W_MEM_WB_w_reg_ena;
    wire [4:0]  W_MEM_WB_rd;

    wire        W_EX_MEM_mem_r;
    wire [4:0]  W_EX_MEM_rs, W_EX_MEM_rt;

    DataPath datapath(
        clk, rst,
        // controller
        W_w_dst_sel,
        W_w_reg_ena,
        W_branch_sel,
        W_j_sel,
        W_rt_sel,
        W_alu_sel,
        W_w_mem_ena,
        W_wb_sel,
        // harzard
        PC_stall,
        IF_ID_stall,
        IF_ID_flush,
        ID_EX_flush,

        W_EX_forwardA,
        W_EX_forwardB,
        W_ID_forwardA,
        W_ID_forwardB,
        // to controller
        W_op,
        W_func,
        // to hazard unit
        W_ID_rs,
        W_ID_rt,
        W_ID_branch_op,
        W_ID_j_op,
        W_ID_EX_mem_r,
        W_EX_MEM_mem_r,

        W_ID_EX_rt,
        W_ID_EX_rs,
        W_ID_EX_rd,

        W_EX_MEM_rt,
        W_EX_MEM_rs,

        W_ID_EX_w_reg_ena,
        W_EX_MEM_w_reg_ena,
        W_EX_MEM_rd,
        W_MEM_WB_w_reg_ena,
        W_MEM_WB_rd,

        // instr_ram
        W_instr_ram_addr,
        W_instr_ram_r_data,

        // data_ram
        W_data_ram_wea,
        W_data_ram_w_data,
        W_data_ram_addr,
        W_data_ram_r_data
    );

    Hazard hazard(
        W_ID_rs,
        W_ID_rt,
        W_ID_branch_op,
        W_ID_j_op,
        W_ID_EX_mem_r,

        W_EX_MEM_mem_r,
        
        W_ID_EX_rt,
        W_ID_EX_rs,
        W_ID_EX_rd,

        W_EX_MEM_rt,
        W_EX_MEM_rs,

        W_ID_EX_w_reg_ena,
        W_EX_MEM_w_reg_ena,
        W_EX_MEM_rd,
        W_MEM_WB_w_reg_ena,
        W_MEM_WB_rd,
        
        PC_stall,
        IF_ID_stall,
        IF_ID_flush,
        ID_EX_flush,

        W_EX_forwardA,
        W_EX_forwardB,
        W_ID_forwardA,
        W_ID_forwardB
    );

endmodule
