`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 18:46:57
// Design Name: 
// Module Name: 
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

`define INSTR_WIDTH 32

// ALU
`define ALU_ADD 4'h0
`define ALU_SUB 4'h1
`define ALU_AND 4'h2
`define ALU_OR  4'h3
`define ALU_SLT 4'h4
// `define ALU_ADD 4'h5
// `define ALU_ADD 4'h6
// `define ALU_ADD 4'h7
// `define ALU_ADD 4'h8
// `define ALU_ADD 4'h9
// `define ALU_ADD 4'ha
// `define ALU_ADD 4'hb
// `define ALU_ADD 4'hc
// `define ALU_ADD 4'hd
// `define ALU_ADD 4'he
// `define ALU_ADD 4'hf


// Controller
`define ARITH_OP_CODE   6'b000_000
`define ADDI_OP_CODE    6'b001_000
`define LW_OP_CODE      6'b100_011
`define SW_OP_CODE      6'b101_011
`define BEQ_OP_CODE     6'b000_100
`define J_OP_CODE       6'b000_010

`define ADD_FUNCT       6'b100_000
`define SUB_FUNCT       6'b100_010
`define AND_FUNCT       6'b100_100
`define OR_FUNCT        6'b100_101
`define SLT_FUNCT       6'b101_010

`define W_DST_SEL_NOP   1'b0
`define W_DST_SEL_RD    1'b0
`define W_DST_SEL_RT    1'b1

`define W_REG_NOP       1'b0
`define W_REG_ENABLE    1'b1
`define W_REG_DISABLE   1'b0

`define W_MEM_NOP       1'b0
`define W_MEM_ENABLE    1'b1
`define W_MEM_DISABLE   1'b0

`define RT_SEL_NOP      1'b0
`define RT_SEL_RT       1'b0
`define RT_SEL_IMME     1'b1

`define ALU_SEL_NOP     4'h0
`define ALU_SEL_ADD     4'h0
`define ALU_SEL_SUB     4'h1
`define ALU_SEL_AND     4'h2
`define ALU_SEL_OR      4'h3
`define ALU_SEL_SLT     4'h4

`define WB_SEL_NOP      1'b0
`define WB_SEL_ALU      1'b0
`define WB_SEL_MEM      1'b1

`define BRANCH_SEL_NOP  2'b00
`define BRANCH_SEL_BEQ  2'b01
`define BRANCH_SEL_BNE  2'b10

`define PC_SEL_ADD4     2'b00
`define PC_SEL_BRANCH   2'b01
`define PC_SEL_J_IMME   2'b10
`define PC_SEL_J_R      2'b11

`define J_SEL_NOP       2'b00
`define J_SEL_J         2'b01
`define J_SEL_JR        2'b10
`define J_SEL_JAL       2'b11