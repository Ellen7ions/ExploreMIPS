`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/21 16:48:01
// Design Name: 
// Module Name: tb_mem
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


module tb_mem();
    reg clk;

    // reg [3:0]   W_EX_MEM_w_mem_ena;
    // reg [31:0]  W_EX_MEM_alu_res;    
    // reg [31:0]  W_EX_MEM_rt_data;
    // reg [4:0]   W_EX_MEM_rd;
    // reg         W_EX_MEM_w_reg_ena;
    // reg         W_EX_MEM_wb_sel;
    
    // wire [31:0] W_MEM_mem_data;
    // wire [31:0] W_MEM_alu_res;
    // wire [4:0]  W_MEM_rd;
    // wire        W_MEM_w_reg_ena;
    // wire        W_MEM_wb_sel;

    initial begin
        clk = 1'b0;
        repeat (300) begin
            #50 clk = ~clk;
        end
    end

    // MEM mem(
    //     clk,
    //     W_EX_MEM_w_mem_ena,
    //     W_EX_MEM_alu_res,
    //     W_EX_MEM_rt_data,
    //     // control
    //     // in
    //     W_EX_MEM_rd,
    //     W_EX_MEM_w_reg_ena,
    //     W_EX_MEM_wb_sel,
    //     // out
    //     W_MEM_mem_data,
    //     W_MEM_alu_res,
    //     W_MEM_rd,
    //     W_MEM_w_reg_ena,
    //     W_MEM_wb_sel
    // );

    reg en;

    reg         W_EX_w_mem_ena;
    reg  [31:0] W_EX_alu_res;
    reg  [31:0] W_EX_rt_data;
    wire [31:0] W_mem_data;

    Memory mem (
        .clka(clk),                 // input wire clka
        .ena(en),                   // input wire ena
        .wea(W_EX_w_mem_ena),       // input wire [3 : 0] wea
        .addra(W_EX_alu_res),       // input wire [31 : 0] addra
        .dina(W_EX_rt_data),        // input wire [31 : 0] dina
        .douta(W_mem_data)          // output wire [31 : 0] douta
    );
 
    initial begin
        // write to

        en = 1'b1;
        #10 begin
            W_EX_w_mem_ena = 1;
            W_EX_alu_res = 32'h1;
            W_EX_rt_data = 32'h0000_1234;
        end

        // #100 begin
        //     W_EX_w_mem_ena = 4'b1111;
        //     W_EX_alu_res = 32'h2;
        //     W_EX_rt_data = 32'h0001_2340;
        // end

        // #100 begin
        //     W_EX_w_mem_ena = 4'b1111;
        //     W_EX_alu_res = 32'h3;
        //     W_EX_rt_data = 32'h0012_3400;
        // end

        // #100 begin
        //     W_EX_w_mem_ena = 4'b1111;
        //     W_EX_alu_res = 32'h4;
        //     W_EX_rt_data = 32'h0123_4000;
        // end
    
        #100 begin
            W_EX_rt_data = 32'h0000_0000;
            en = 1'b1;
            W_EX_w_mem_ena = 4'b0000;
            W_EX_alu_res = 32'h2;
        end

        #100 begin
            W_EX_w_mem_ena = 4'b0000;
            W_EX_alu_res = 32'h1;
        end

        #100 begin
            W_EX_w_mem_ena = 4'b0000;
            W_EX_alu_res = 32'h3;
        end

        // #10 begin
        //     W_EX_MEM_rd         = 4'h0;
        //     W_EX_MEM_w_reg_ena  = 1'b0;
        //     W_EX_MEM_wb_sel     = 1'b0;
        // end

        // #10 begin
        //     W_EX_MEM_w_mem_ena  = 4'b1111;
        //     W_EX_MEM_alu_res    = 32'h0000_0001;
        //     W_EX_MEM_rt_data    = 32'h0000_1234;
        // end

        // #100 begin
        //     W_EX_MEM_w_mem_ena  = 4'b1111;
        //     W_EX_MEM_alu_res    = 32'h0000_0002;
        //     W_EX_MEM_rt_data    = 32'h0001_2340;
        // end

        // #100 begin
        //     W_EX_MEM_w_mem_ena  = 4'b1111;
        //     W_EX_MEM_alu_res    = 32'h0000_0003;
        //     W_EX_MEM_rt_data    = 32'h0012_3400;
        // end

        // #100 begin
        //     W_EX_MEM_w_mem_ena = 4'b0000;
        //     W_EX_MEM_alu_res    = 32'h0000_0001;
        // end

        // #100 begin
        //     W_EX_MEM_w_mem_ena = 4'b0000;
        //     W_EX_MEM_alu_res    = 32'h0000_0002;
        // end

        // #100 begin
        //     W_EX_MEM_w_mem_ena = 4'b0000;
        //     W_EX_MEM_alu_res    = 32'h0000_0003;
        // end

    end
endmodule
