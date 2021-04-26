`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 19:18:29
// Design Name: 
// Module Name: ALU
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

module ALU(
    input   wire [`INSTR_WIDTH-1:0] W_a,
    input   wire [`INSTR_WIDTH-1:0] W_b,
    input   wire [3:0]              W_op_sel,
    output  reg  [`INSTR_WIDTH-1:0] R_alu_res
    );
    always @(*) begin
       case(W_op_sel)
       `ALU_ADD: R_alu_res = W_a + W_b;
       `ALU_SUB: R_alu_res = W_a - W_b;
       `ALU_AND: R_alu_res = W_a & W_b;
       `ALU_OR : R_alu_res = W_a | W_b;
       `ALU_SLT : R_alu_res = (W_a < W_b) ? {{31{1'b0}}, 1'b1} : {{31{1'b0}}, 1'b0};
       default: R_alu_res = {(`INSTR_WIDTH-1){1'b0}};
       endcase 
    end
endmodule
