`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/18 11:11:28
// Design Name: 
// Module Name: MEM
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

module MEM(
    input   wire                    clk,
    
    // input   wire                    W_EX_w_mem_ena,
    input   wire [`INSTR_WIDTH-1:0] W_EX_alu_res,
    // input   wire [`INSTR_WIDTH-1:0] W_EX_rt_data,
    
    // control
    input   wire [4:0]              W_EX_rd,
    input   wire                    W_EX_w_reg_ena,
    input   wire                    W_EX_wb_sel,

    output  wire [`INSTR_WIDTH-1:0] W_MEM_mem_data,
    output  wire [`INSTR_WIDTH-1:0] W_MEM_alu_res,

    output  wire [4:0]              W_MEM_rd,
    output  wire                    W_MEM_w_reg_ena,
    output  wire                    W_MEM_wb_sel,

    // data ram
    input   wire [`INSTR_WIDTH-1:0] W_data_ram_r_data
    );

    // wire [`INSTR_WIDTH-1:0] W_mem_data;

    // Memory mem (
    //     .clka(~clk),                 // input wire clka
    //     .ena(1'b1),                 // input wire ena
    //     .wea(W_EX_w_mem_ena),       // input wire [3 : 0] wea
    //     .addra({2'b00, W_EX_alu_res[31:2]}),       // input wire [31 : 0] addra
    //     .dina(W_EX_rt_data),        // input wire [31 : 0] dina
    //     .douta(W_mem_data)          // output wire [31 : 0] douta
    // );

    assign W_MEM_alu_res    = W_EX_alu_res;
    assign W_MEM_mem_data   = W_data_ram_r_data;
    assign W_MEM_rd         = W_EX_rd;
    assign W_MEM_w_reg_ena  = W_EX_w_reg_ena;
    assign W_MEM_wb_sel     = W_EX_wb_sel;

endmodule
