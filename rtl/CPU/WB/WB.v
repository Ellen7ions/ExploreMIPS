`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/18 11:12:36
// Design Name: 
// Module Name: WB
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

module WB(
    input   wire [`INSTR_WIDTH-1:0] W_MEM_alu_res,
    input   wire [`INSTR_WIDTH-1:0] W_MEM_mem_data,
    input   wire                    W_MEM_wb_sel,

    // control
    input   wire [4:0]              W_MEM_rd,
    input   wire                    W_MEM_w_reg_ena,

    output  wire [4:0]              W_WB_addr,
    output  wire                    W_WB_w_reg_ena,
    output  wire [`INSTR_WIDTH-1:0] W_WB_wb_data
    );

    assign W_WB_addr = W_MEM_rd;
    assign W_WB_w_reg_ena = W_MEM_w_reg_ena;

    assign W_WB_wb_data = 
            {32{~W_MEM_wb_sel}} & W_MEM_alu_res | 
            {32{W_MEM_wb_sel}} & W_MEM_mem_data;

endmodule
