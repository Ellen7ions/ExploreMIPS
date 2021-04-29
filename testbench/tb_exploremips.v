`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/22 18:15:18
// Design Name: 
// Module Name: tb_exploremips
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


module tb_exploremips();
    reg clk;
    reg rst;

    wire [31:0]     W_debug_wb_pc;
    wire [ 3:0]     W_debug_wb_rf_wen;
    wire [ 4:0]     W_debug_wb_rf_wnum;
    wire [31:0]     W_debug_wb_rf_wdata;

    Top mips(
        clk,
        rst,

        // debug
        W_debug_wb_pc,
        W_debug_wb_rf_wen,
        W_debug_wb_rf_wnum,
        W_debug_wb_rf_wdata
    );

    initial begin
        clk = 1'b0;
        forever begin
            #50 clk = ~clk;
        end
    end

    initial begin
        #10 rst = 1'b0;
        #100 rst = 1'b1;
        #100 rst = 1'b0;
    end
endmodule
