`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 18:04:00
// Design Name: 
// Module Name: Controller
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

module Controller(
    input   wire [5:0]  W_op,
    input   wire [5:0]  W_func,
    
    // id
    output  reg         R_w_dst_sel,
    output  reg         R_w_reg_ena,
    output  reg  [1:0]  R_branch_sel,
    output  reg  [1:0]  R_j_sel,
    
    // ex
    output  reg         R_rt_sel,
    output  reg  [3:0]  R_alu_sel,

    // mem
    output  reg         R_w_mem_ena,
    
    // wb
    output  reg         R_wb_sel
    );

    always @(*) begin
        case(W_op)
            `ARITH_OP_CODE: begin
                case (W_func)
                    `ADD_FUNCT: begin
                        R_w_dst_sel =   `W_DST_SEL_RD;
                        R_w_reg_ena =   `W_REG_ENABLE;
                        R_branch_sel=   `BRANCH_SEL_NOP;
                        R_j_sel     =   `J_SEL_NOP;
                        R_rt_sel    =   `RT_SEL_RT;
                        R_alu_sel   =   `ALU_SEL_ADD;
                        R_w_mem_ena =   `W_MEM_DISABLE;
                        R_wb_sel    =   `WB_SEL_ALU;
                    end

                    `SUB_FUNCT: begin
                        R_w_dst_sel =   `W_DST_SEL_RD;
                        R_w_reg_ena =   `W_REG_ENABLE;
                        R_branch_sel=   `BRANCH_SEL_NOP;
                        R_j_sel     =   `J_SEL_NOP;
                        R_rt_sel    =   `RT_SEL_RT;
                        R_alu_sel   =   `ALU_SEL_SUB;
                        R_w_mem_ena =   `W_MEM_DISABLE;
                        R_wb_sel    =   `WB_SEL_ALU;
                    end

                    `AND_FUNCT: begin
                        R_w_dst_sel =   `W_DST_SEL_RD;
                        R_w_reg_ena =   `W_REG_ENABLE;
                        R_branch_sel=   `BRANCH_SEL_NOP;
                        R_j_sel     =   `J_SEL_NOP;
                        R_rt_sel    =   `RT_SEL_RT;
                        R_alu_sel   =   `ALU_SEL_AND;
                        R_w_mem_ena =   `W_MEM_DISABLE;
                        R_wb_sel    =   `WB_SEL_ALU;
                    end 

                    `OR_FUNCT: begin
                        R_w_dst_sel =   `W_DST_SEL_RD;
                        R_w_reg_ena =   `W_REG_ENABLE;
                        R_branch_sel=   `BRANCH_SEL_NOP;
                        R_j_sel     =   `J_SEL_NOP;
                        R_rt_sel    =   `RT_SEL_RT;
                        R_alu_sel   =   `ALU_SEL_OR;
                        R_w_mem_ena =   `W_MEM_DISABLE;
                        R_wb_sel    =   `WB_SEL_ALU;
                    end

                    `SLT_FUNCT: begin
                        R_w_dst_sel =   `W_DST_SEL_RD;
                        R_w_reg_ena =   `W_REG_ENABLE;
                        R_branch_sel=   `BRANCH_SEL_NOP;
                        R_j_sel     =   `J_SEL_NOP;
                        R_rt_sel    =   `RT_SEL_RT;
                        R_alu_sel   =   `ALU_SEL_SLT;
                        R_w_mem_ena =   `W_MEM_DISABLE;
                        R_wb_sel    =   `WB_SEL_ALU;
                    end
                    default: begin
                        R_w_dst_sel =   `W_DST_SEL_NOP;
                        R_w_reg_ena =   `W_REG_NOP;
                        R_branch_sel=   `BRANCH_SEL_NOP;
                        R_j_sel     =   `J_SEL_NOP;
                        R_rt_sel    =   `RT_SEL_NOP;
                        R_alu_sel   =   `ALU_SEL_NOP;
                        R_w_mem_ena =   `W_MEM_NOP;
                        R_wb_sel    =   `WB_SEL_NOP;
                    end 
                endcase
            end

            `ADDI_OP_CODE: begin
                R_w_dst_sel =   `W_DST_SEL_RT;
                R_w_reg_ena =   `W_REG_ENABLE;
                R_branch_sel=   `BRANCH_SEL_NOP;
                R_j_sel     =   `J_SEL_NOP;
                R_rt_sel    =   `RT_SEL_IMME;
                R_alu_sel   =   `ALU_SEL_ADD;
                R_w_mem_ena =   `W_MEM_DISABLE;
                R_wb_sel    =   `WB_SEL_ALU;
            end

            `LW_OP_CODE: begin
                R_w_dst_sel =   `W_DST_SEL_RT;
                R_w_reg_ena =   `W_REG_ENABLE;
                R_branch_sel=   `BRANCH_SEL_NOP;
                R_j_sel     =   `J_SEL_NOP;
                R_rt_sel    =   `RT_SEL_IMME;
                R_alu_sel   =   `ALU_SEL_ADD;
                R_w_mem_ena =   `W_MEM_DISABLE;
                R_wb_sel    =   `WB_SEL_MEM;
            end

            `SW_OP_CODE: begin
                R_w_dst_sel =   `W_DST_SEL_NOP;
                R_w_reg_ena =   `W_REG_DISABLE;
                R_branch_sel=   `BRANCH_SEL_NOP;
                R_j_sel     =   `J_SEL_NOP;
                R_rt_sel    =   `RT_SEL_IMME;
                R_alu_sel   =   `ALU_SEL_ADD;
                R_w_mem_ena =   `W_MEM_ENABLE;
                R_wb_sel    =   `WB_SEL_NOP;
            end

            `BEQ_OP_CODE: begin
                R_w_dst_sel =   `W_DST_SEL_NOP;
                R_w_reg_ena =   `W_REG_NOP;
                R_branch_sel=   `BRANCH_SEL_BEQ;
                R_j_sel     =   `J_SEL_NOP;
                R_rt_sel    =   `RT_SEL_NOP;
                R_alu_sel   =   `ALU_SEL_NOP;
                R_w_mem_ena =   `W_MEM_NOP;
                R_wb_sel    =   `WB_SEL_NOP;
            end

            `J_OP_CODE: begin
                // haven't implemented
                R_w_dst_sel =   `W_DST_SEL_NOP;
                R_w_reg_ena =   `W_REG_NOP;
                R_branch_sel=   `BRANCH_SEL_NOP;
                R_j_sel     =   `J_SEL_J;
                R_rt_sel    =   `RT_SEL_NOP;
                R_alu_sel   =   `ALU_SEL_NOP;
                R_w_mem_ena =   `W_MEM_NOP;
                R_wb_sel    =   `WB_SEL_NOP;
            end

            default: begin
                R_w_dst_sel =   `W_DST_SEL_NOP;
                R_w_reg_ena =   `W_REG_NOP;
                R_branch_sel=   `BRANCH_SEL_NOP;
                R_rt_sel    =   `RT_SEL_NOP;
                R_alu_sel   =   `ALU_SEL_NOP;
                R_w_mem_ena =   `W_MEM_NOP;
                R_wb_sel    =   `WB_SEL_NOP;
            end
        endcase
    end

endmodule
