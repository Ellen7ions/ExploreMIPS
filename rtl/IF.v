`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/18 11:10:58
// Design Name: 
// Module Name: IF
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

module IF(
    input   wire                    clk,
    input   wire                    en,
    input   wire                    rst,
    input   wire [1:0]              W_branch_sel,
    input   wire [1:0]              W_j_sel,
    input   wire [15:0]             W_branch_imme,
    input   wire [`INSTR_WIDTH-1:0] W_b_rs_data,
    input   wire [`INSTR_WIDTH-1:0] W_b_rt_data,
    input   wire [25:0]             W_j_imme,
    
    input   wire [`INSTR_WIDTH-1:0] W_ID_rs_data,
    input   wire [`INSTR_WIDTH-1:0] W_ID_PC,
    output  wire [`INSTR_WIDTH-1:0] W_instr,
    output  wire [`INSTR_WIDTH-1:0] W_IF_PC
    // output wire [`INSTR_WIDTH-1:0] W_pc
    );

    wire [`INSTR_WIDTH-1:0] W_next_pc, W_pc;
    reg  [1:0] W_pc_sel;

    always @(*) begin
        if (W_j_sel == `J_SEL_NOP) begin
            case (W_branch_sel)
                `BRANCH_SEL_NOP: begin
                    W_pc_sel = `PC_SEL_ADD4;
                end 

                `BRANCH_SEL_BEQ: begin
                    if (W_b_rs_data == W_b_rt_data)
                        W_pc_sel = `PC_SEL_BRANCH;
                    else
                        W_pc_sel = `PC_SEL_ADD4;
                end

                `BRANCH_SEL_BNE: begin
                    if (W_b_rs_data != W_b_rt_data)
                        W_pc_sel = `PC_SEL_BRANCH;
                    else
                        W_pc_sel = `PC_SEL_ADD4;
                end

                default: begin
                    W_pc_sel = `PC_SEL_ADD4;
                end
            endcase
        end else begin
            case (W_j_sel)
                `J_SEL_NOP: begin
                    W_pc_sel = `PC_SEL_ADD4;
                end 

                `J_SEL_J: begin
                    W_pc_sel = `PC_SEL_J_IMME;
                end

                `J_SEL_JR: begin
                    // haven't implemented
                    W_pc_sel = `PC_SEL_J_R;
                end

                `J_SEL_JAL: begin
                    // haven't implemented
                    W_pc_sel = `PC_SEL_J_IMME;
                end

                default: begin
                    W_pc_sel = `PC_SEL_ADD4;
                end
            endcase
        end

        // jmp case
    end

    PC pc(
        .clk(clk),
        .en(~en),
        .rst(rst),
        .W_next_pc(W_next_pc),
        .W_pc(W_pc)
    );

    NextPC next_pc(
        .W_pc(W_pc),
        .W_pc_sel(W_pc_sel),
        .W_branch_imme(W_branch_imme),
        .W_j_imme(W_j_imme),
        .W_ID_rs_data(W_ID_rs_data),
        .W_ID_PC(W_ID_PC),
        .W_next_pc(W_next_pc)
    );

    // Instr_ROM instr_rom(
    //     .clka(clk),     // input wire clka
    //     .ena(1'b1),      // input wire ena
    //     .addra(W_next_pc),  // input wire [31 : 0] addra
    //     .douta(W_instr)   // output wire [31 : 0] douta
    // );

    Instr_RAM instr_ram (
        .clka(clk),    // input wire clka
        .ena(1'b1),      // input wire ena
        .wea(1'b0),      // input wire [0 : 0] wea
        .addra(W_next_pc[11:2]),  // input wire [9 : 0] addra
        .dina(32'h0000_0000),    // input wire [31 : 0] dina
        .douta(W_instr)  // output wire [31 : 0] douta
    );

    assign W_IF_PC = W_next_pc;

endmodule
