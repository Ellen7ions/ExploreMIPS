`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 18:53:07
// Design Name: 
// Module Name: NextPC
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

module NextPC(
    input   wire [`INSTR_WIDTH-1:0] W_pc,
    input   wire [1:0]              W_pc_sel,
    input   wire [15:0]             W_branch_imme,
    input   wire [25:0]             W_j_imme,
    input   wire [`INSTR_WIDTH-1:0] W_ID_rs_data,
    input   wire [`INSTR_WIDTH-1:0] W_ID_PC,
    output  reg  [`INSTR_WIDTH-1:0] W_next_pc
    );

    wire [`INSTR_WIDTH-1:0] W_pc_add4;

    assign W_pc_add4 = W_pc + 32'h4;

    always @(*) begin
        case (W_pc_sel)
            `PC_SEL_ADD4: begin
                W_next_pc   = W_pc_add4;
            end

            `PC_SEL_BRANCH: begin
                W_next_pc   = W_ID_PC + {{14{W_branch_imme[15]}}, {W_branch_imme[15:0]}, 2'b00};
            end

            `PC_SEL_J_IMME: begin
                W_next_pc   = {4'b0000, W_j_imme, 2'b00};
            end

            `PC_SEL_J_R: begin
                W_next_pc   = W_ID_rs_data;
            end

            default: begin
                W_next_pc   = 32'h0000_0000;
            end
        endcase
    end
endmodule
