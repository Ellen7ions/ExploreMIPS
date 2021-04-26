`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/21 13:00:04
// Design Name: 
// Module Name: tb_id
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


module tb_id();
    reg clk, rst;

    wire [31:0] IF_ID_instr;

    // wire [31:0] W_instr;
    IF iff(
        clk, 1'b0, rst,
        IF_ID_instr
    );

    reg W_WB_w_reg_ena;
    reg [4:0] W_WB_w_addr;
    reg [31:0] W_WB_w_data;

    wire [5:0] W_op, W_func;
    wire W_w_dst_sel, W_w_reg_ena, W_rt_sel, W_w_mem_ena, W_wb_sel;
    wire [3:0] W_alu_sel;

    wire [15:0] W_ID_imme;
    wire [4:0] W_ID_rs, W_ID_rt, W_ID_rd;
    wire [31:0] W_ID_rs_data, W_ID_rt_data;
    wire W_ID_mem_r;

    wire W_ID_rt_sel, W_ID_alu_sel, W_ID_w_mem_ena, W_ID_w_reg_ena, W_ID_wb_sel;

    Controller controller(
        W_op, W_func,
        W_w_dst_sel, W_w_reg_ena, W_rt_sel, W_alu_sel, W_w_mem_ena, W_wb_sel
    );

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
        W_ID_rs, W_ID_rt, W_ID_rd,
        W_ID_rs_data, W_ID_rt_data,
        W_ID_mem_r,
        // pass control
        W_ID_rt_sel,
        W_ID_alu_sel,
        W_ID_w_mem_ena,
        W_ID_w_reg_ena,
        W_ID_wb_sel
    );

    initial begin
        clk = 1'b0;
        repeat (300) begin
            #50 clk = ~clk;
        end
    end

    initial begin
        rst = 1'b0;
        #10 rst = 1'b1;
        #100 rst = 1'b0;
        #100 begin
            W_WB_w_reg_ena = 1'b0;
            W_WB_w_addr = {32{1'b0}};
            W_WB_w_data = {32{1'b0}};

            // W_w_dst_sel = 1'b0;
            // W_w_reg_ena = 1'b0;
            // W_rt_sel    = 1'b0;
            // W_alu_sel   = 1'b0;
            // W_w_mem_ena = 1'b0;
            // W_wb_sel    = 1'b0;
        end
    end

endmodule
