`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 18:03:35
// Design Name: 
// Module Name: DataPath
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

module DataPath(
    input   wire clk,
    input   wire rst,

    // controller
    input   wire            W_w_dst_sel,
    input   wire            W_w_reg_ena,
    input   wire [1:0]      W_branch_sel,
    input   wire [1:0]      W_j_sel,
    input   wire            W_rt_sel,
    input   wire [3:0]      W_alu_sel,
    input   wire            W_w_mem_ena,
    input   wire            W_wb_sel,

    // hazard unit
    input   wire            PC_stall,
    input   wire            IF_ID_stall,
    input   wire            IF_ID_flush,
    // input wire ID_EX_stall,
    input   wire            ID_EX_flush,
    // input wire EX_MEM_stall,
    // input wire EX_MEM_flush,
    // input wire MEM_WB_stall,
    // input wire MEM_WB_flush,
    input   wire [1:0]      W_EX_forwardA,
    input   wire [1:0]      W_EX_forwardB,
    input   wire [1:0]      W_ID_forwardA,
    input   wire [1:0]      W_ID_forwardB,

    // to controller
    output  wire [5:0]      W_op,
    output  wire [5:0]      W_func,
    // to hazard unit
    output  wire [4:0]      W_ID_rs,
    output  wire [4:0]      W_ID_rt,
    output  wire            W_ID_branch_op,
    output  wire            W_ID_j_op,
    output  wire            W_ID_EX_mem_r,
    output  wire            W_EX_MEM_mem_r,

    output  wire [4:0]      W_ID_EX_rt,
    output  wire [4:0]      W_ID_EX_rs,
    output  wire [4:0]      W_ID_EX_rd,
    output  wire [4:0]      W_EX_MEM_rt,
    output  wire [4:0]      W_EX_MEM_rs,
    
    output  wire            W_ID_EX_w_reg_ena,
    output  wire            W_EX_MEM_w_reg_ena,
    output  wire [4:0]      W_EX_MEM_rd,

    output  wire            W_MEM_WB_w_reg_ena,
    output  wire [4:0]      W_MEM_WB_rd,

    // instr_ram
    output  wire [31:0]     W_instr_ram_addr,
    input   wire [31:0]     W_instr_ram_r_data,

    // data_ram
    output  wire [3:0]      W_data_ram_wea,
    output  wire [31:0]     W_data_ram_w_data,
    output  wire [31:0]     W_data_ram_addr,
    input   wire [31:0]     W_data_ram_r_data,

    // debug
    output  wire [31:0]     W_debug_wb_pc,
    output  wire [ 3:0]     W_debug_wb_rf_wen,
    output  wire [ 4:0]     W_debug_wb_rf_wnum,
    output  wire [31:0]     W_debug_wb_rf_wdata
    );

    // wire    IF_ID_flush;
    wire    ID_EX_stall;
    wire    EX_MEM_stall;
    wire    EX_MEM_flush;
    wire    MEM_WB_stall;
    wire    MEM_WB_flush;

    // assign  IF_ID_flush = 1'b0;
    assign  ID_EX_stall = 1'b0;
    assign  EX_MEM_stall = 1'b0;
    assign  EX_MEM_flush = 1'b0;
    assign  MEM_WB_stall = 1'b0;
    assign  MEM_WB_flush = 1'b0;

    wire [`INSTR_WIDTH-1:0] IF_instr, IF_ID_instr;

    wire [15:0]             W_branch_imme;
    wire [25:0]             W_j_imme;
    wire [`INSTR_WIDTH-1:0] W_b_rs_data;
    wire [`INSTR_WIDTH-1:0] W_b_rt_data;
    wire [`INSTR_WIDTH-1:0] W_ID_rs_data, W_ID_rt_data;

    wire [`INSTR_WIDTH-1:0] W_IF_ID_PC, W_IF_PC;

    IF iff(
        clk,
        PC_stall,
        rst,
        W_branch_sel,
        W_j_sel,
        W_branch_imme,
        W_b_rs_data,
        W_b_rt_data,
        W_j_imme,
        W_ID_rs_data,
        W_IF_ID_PC,
        // IF_instr,
        W_IF_PC,
        W_instr_ram_addr
    );

    assign IF_instr = W_instr_ram_r_data;

    Regs_IF_ID if_id(
        clk,
        IF_ID_stall,
        rst,
        IF_ID_flush,
        // in
        IF_instr,
        W_IF_PC,
        // out
        IF_ID_instr,
        W_IF_ID_PC
    );

    // ================================================= //

    wire W_WB_w_reg_ena;
    wire [4:0] W_WB_w_addr;
    wire [`INSTR_WIDTH-1:0] W_WB_w_data;

    wire [15:0] W_ID_imme;
    wire [4:0] W_ID_rd;     // not used ?, pass down

    wire W_ID_rt_sel;
    wire [3:0] W_ID_alu_sel;
    wire W_ID_w_mem_ena;
    wire W_ID_w_reg_ena;
    wire W_ID_wb_sel;

    wire W_ID_mem_r;

    ID id(
        clk,
        rst,
        IF_ID_instr,
        // WB
        W_WB_w_reg_ena, W_WB_w_addr, W_WB_w_data,
        // from controller
        W_op, W_func,
        W_w_dst_sel, 
        W_w_reg_ena, 
        W_rt_sel, 
        W_alu_sel, 
        W_w_mem_ena, 
        W_wb_sel,
        // get from instr
        W_ID_imme,
        W_j_imme,
        W_ID_rs, W_ID_rt, W_ID_rd,
        W_ID_rs_data, W_ID_rt_data,
        W_ID_mem_r,
        W_ID_branch_op,
        W_ID_j_op,
        // pass control
        W_ID_rt_sel,
        W_ID_alu_sel,
        W_ID_w_mem_ena,
        W_ID_w_reg_ena,
        W_ID_wb_sel
    );
    wire [`INSTR_WIDTH-1:0]  W_EX_MEM_alu_res;

    assign W_branch_imme = W_ID_imme;
    assign W_b_rs_data = 
        (W_ID_forwardA == 2'b00) ? 
        W_ID_rs_data : (W_ID_forwardA == 2'b01) ? 
        W_EX_MEM_alu_res : W_WB_w_data;
    assign W_b_rt_data = 
        (W_ID_forwardB == 2'b00) ?
        W_ID_rt_data : (W_ID_forwardB == 2'b01) ?
        W_EX_MEM_alu_res : W_WB_w_data;

    wire [15:0] W_ID_EX_imme;
    // wire [4:0]  W_ID_EX_rd;
    wire [`INSTR_WIDTH-1:0] W_ID_EX_rs_data, W_ID_EX_rt_data;

    wire W_ID_EX_rt_sel;
    wire [3:0]  W_ID_EX_alu_sel;
    wire        W_ID_EX_w_mem_ena;
    // wire W_ID_EX_w_reg_ena;
    wire W_ID_EX_wb_sel;

    wire [31:0] W_ID_EX_PC;

    Regs_ID_EX id_ex(
        clk,
        ID_EX_stall,
        rst,
        ID_EX_flush,
        // in
        W_ID_imme,
        W_ID_rs, W_ID_rt, W_ID_rd,
        W_ID_rs_data, W_ID_rt_data,
        // control
        W_ID_rt_sel,
        W_ID_alu_sel,
        W_ID_w_mem_ena,
        W_ID_w_reg_ena,
        W_ID_wb_sel,
        W_ID_mem_r,
        // debug
        W_IF_ID_PC,

        // out
        W_ID_EX_imme,
        W_ID_EX_rs, W_ID_EX_rt, W_ID_EX_rd,
        W_ID_EX_rs_data, W_ID_EX_rt_data,
        // control
        W_ID_EX_rt_sel,
        W_ID_EX_alu_sel,
        W_ID_EX_w_mem_ena,
        W_ID_EX_w_reg_ena,
        W_ID_EX_wb_sel,
        W_ID_EX_mem_r,

        // debug
        W_ID_EX_PC
    );

    // ================================================= //

    wire [`INSTR_WIDTH-1:0] W_EX_alu_res;
    wire [`INSTR_WIDTH-1:0] W_EX_rt_data;
    wire [4:0]              W_EX_rd;
    wire                    W_EX_w_mem_ena;
    wire                    W_EX_w_reg_ena;
    wire                    W_EX_wb_sel;

    EX ex(
        W_ID_EX_rs_data,
        W_ID_EX_rt_data,
        W_ID_EX_rt_sel,
        W_ID_EX_alu_sel,
        W_ID_EX_imme,
        W_EX_forwardA,
        W_EX_forwardB,
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

    wire [`INSTR_WIDTH-1:0] W_EX_MEM_rt_data;
    // wire [4:0]               W_EX_MEM_rd;
    wire                    W_EX_MEM_w_mem_ena;
    // wire                     W_EX_MEM_w_reg_ena;
    wire                    W_EX_MEM_wb_sel;

    wire [31:0] W_EX_MEM_PC;

    Regs_EX_MEM ex_mem(
        clk,
        EX_MEM_stall,
        rst,
        EX_MEM_flush,
        // in
        W_EX_alu_res,
        W_EX_rt_data,
        W_EX_rd,
        W_EX_w_mem_ena,
        W_EX_w_reg_ena,
        W_EX_wb_sel,

        W_ID_EX_mem_r,
        W_ID_EX_rs,
        W_ID_EX_rt,
        
        // debug
        W_ID_EX_PC,

        // out
        W_EX_MEM_alu_res,
        W_EX_MEM_rt_data,
        W_EX_MEM_rd,
        W_EX_MEM_w_mem_ena,
        W_EX_MEM_w_reg_ena,
        W_EX_MEM_wb_sel,

        W_EX_MEM_mem_r,
        W_EX_MEM_rs,
        W_EX_MEM_rt,

        // debug
        W_EX_MEM_PC
    );

    wire [`INSTR_WIDTH-1:0] W_MEM_mem_data;
    wire [`INSTR_WIDTH-1:0] W_MEM_alu_res;
    wire [4:0]              W_MEM_rd;
    wire                    W_MEM_w_reg_ena;
    wire                    W_MEM_wb_sel;

    MEM mem(
        clk,
        // W_EX_MEM_w_mem_ena,
        W_EX_MEM_alu_res,
        // W_EX_MEM_rt_data,
        // control
        // in
        W_EX_MEM_rd,
        W_EX_MEM_w_reg_ena,
        W_EX_MEM_wb_sel,
        // out
        W_MEM_mem_data,
        W_MEM_alu_res,
        W_MEM_rd,
        W_MEM_w_reg_ena,
        W_MEM_wb_sel,

        W_data_ram_r_data
    );

    assign W_data_ram_wea       = {4{W_EX_MEM_w_mem_ena}};
    assign W_data_ram_addr      = W_EX_MEM_alu_res;
    assign W_data_ram_w_data    = W_EX_MEM_rt_data;

    wire [`INSTR_WIDTH-1:0] W_MEM_WB_mem_data;
    wire [`INSTR_WIDTH-1:0] W_MEM_WB_alu_res;
    // wire [4:0]              W_MEM_WB_rd;
    // wire                    W_MEM_WB_w_reg_ena;
    wire                    W_MEM_WB_wb_sel;

    wire [31:0] W_WB_PC;

    Regs_MEM_WB mem_wb(
        clk,
        MEM_WB_stall,
        rst,
        MEM_WB_flush,
        // in
        W_MEM_mem_data,
        W_MEM_alu_res,
        W_MEM_rd,
        W_MEM_w_reg_ena,
        W_MEM_wb_sel,

        W_EX_MEM_PC,
        // out
        W_MEM_WB_mem_data,
        W_MEM_WB_alu_res,
        W_MEM_WB_rd,
        W_MEM_WB_w_reg_ena,
        W_MEM_WB_wb_sel,

        W_WB_PC
    );

    // wire [4:0] W_WB_addr;
    // wire W_WB_w_reg_ena;
    // wire [`INSTR_WIDTH-1:0] W_WB_wb_data;

    WB wb(
        W_MEM_WB_alu_res,
        W_MEM_WB_mem_data,
        W_MEM_WB_wb_sel,
        // control
        W_MEM_WB_rd,
        W_MEM_WB_w_reg_ena,
        W_WB_w_addr,
        W_WB_w_reg_ena,
        W_WB_w_data
    );

    assign W_debug_wb_pc        = W_WB_PC;
    assign W_debug_wb_rf_wen    = {4{W_WB_w_reg_ena}};
    assign W_debug_wb_rf_wnum   = W_WB_w_addr;
    assign W_debug_wb_rf_wdata  = W_WB_w_data;

endmodule
