`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/18 11:11:07
// Design Name: 
// Module Name: ID
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

module ID(
    input   wire                        clk,
    input   wire                        rst,
    input   wire [`INSTR_WIDTH-1:0]     W_IF_instr,

    // 将信号传递到WB后，再写RegFile
    input   wire                        W_WB_w_reg_ena,
    input   wire [4:0]                  W_WB_w_addr,
    input   wire [`INSTR_WIDTH-1:0]     W_WB_w_data,

    // controller
    output  wire [5:0]                  W_op,
    output  wire [5:0]                  W_func,
    // W_w_dst_sel is used in ID stage, 
    // pass the left signals down.
    input   wire                        W_w_dst_sel,    // *
    input   wire                        W_w_reg_ena,
    input   wire                        W_rt_sel,
    input   wire [3:0]                  W_alu_sel,
    input   wire                        W_w_mem_ena,
    input   wire                        W_wb_sel,
    //---
    
    output  wire [15:0]                 W_ID_imme,
    output  wire [25:0]                 W_j_imme,
    output  wire [4:0]                  W_ID_rs,
    output  wire [4:0]                  W_ID_rt,
    output  wire [4:0]                  W_ID_rd,
    output  wire [`INSTR_WIDTH-1:0]     W_ID_rs_data,
    output  wire [`INSTR_WIDTH-1:0]     W_ID_rt_data,
    output  wire                        W_ID_mem_r,
    output  wire                        W_ID_branch_op,
    output  wire                        W_ID_j_op,

    // control
    // ex
    output  wire                        W_ID_rt_sel,
    output  wire [3:0]                  W_ID_alu_sel,
    // mem
    output  wire [3:0]                  W_ID_w_mem_ena,
    // wb
    output  wire                        W_ID_w_reg_ena,
    output  wire                        W_ID_wb_sel
    );

    wire [4:0] W_rs, W_rt, W_rd, W_shamt;
    wire [15:0] W_imme;
    // wire [25:0] W_j_imme;

    assign W_op     =   W_IF_instr[31:26];
    assign W_rs     =   W_IF_instr[25:21];
    assign W_rt     =   W_IF_instr[20:16];
    assign W_rd     =   W_IF_instr[15:11];
    assign W_shamt  =   W_IF_instr[10:6];         // not used now
    assign W_func   =   W_IF_instr[5:0];
    assign W_imme   =   W_IF_instr[15:0];
    assign W_j_imme =   W_IF_instr[25:0];         

    assign W_ID_mem_r       = (W_op == `LW_OP_CODE);
    assign W_ID_branch_op   = (W_op == `BEQ_OP_CODE);
    assign W_ID_j_op        = (W_op == `J_OP_CODE);

    wire [4:0] W_w_addr;
    wire [`INSTR_WIDTH-1:0] W_rs_data, W_rt_data;

    // Controller controller(
    //     .W_op(W_op),
    //     .W_func(W_func),
    //     .W_w_dst_sel(W_w_dst_sel),
    //     .W_w_reg_ena(W_w_reg_ena),
    //     .W_rt_sel(W_rt_sel),
    //     .W_alu_sel(W_alu_sel),
    //     .W_w_mem_ena(W_w_mem_ena),
    //     .W_wb_sel(W_wb_sel)
    // );

    assign W_w_addr = (W_w_dst_sel == 1'b0) ? W_rd : W_rt;

    RegFile regfile(
        .clk(clk),
        .rst(rst),
        .W_r_rs_addr(W_rs),
        .W_r_rt_addr(W_rt),
        .W_w_ena(W_WB_w_reg_ena),
        .W_w_addr(W_WB_w_addr),
        .W_w_data(W_WB_w_data),
        .R_r_rs_data(W_rs_data),
        .R_r_rt_data(W_rt_data)
    );

    assign W_ID_imme        = W_imme;
    assign W_ID_rs          = W_rs;
    assign W_ID_rt          = W_rt;
    assign W_ID_rd          = W_w_addr;
    assign W_ID_rs_data     = W_rs_data;
    assign W_ID_rt_data     = W_rt_data;

    // assign W_ID_w_dst_sel   = W_w_dst_sel;
    assign W_ID_w_reg_ena   = W_w_reg_ena;
    assign W_ID_rt_sel      = W_rt_sel;
    assign W_ID_alu_sel     = W_alu_sel;
    assign W_ID_w_mem_ena   = W_w_mem_ena;
    assign W_ID_wb_sel      = W_wb_sel;

endmodule
