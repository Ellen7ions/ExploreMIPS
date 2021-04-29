`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/17 18:59:02
// Design Name: 
// Module Name: RegFile
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

module RegFile(
    input   wire        clk,
    input   wire        rst,
    input   wire [4:0]  W_r_rs_addr,
    input   wire [4:0]  W_r_rt_addr,
    input   wire        W_w_ena,
    input   wire [4:0]  W_w_addr,
    input   wire [31:0] W_w_data,
    output  reg  [31:0] R_r_rs_data,
    output  reg  [31:0] R_r_rt_data
    );
    reg [31:0] regfile[31:0];

    initial begin
        $readmemh("C:/Users/Ellen7ions/Desktop/ExploreMIPS/rtl/CPU/regfile_ram.dat", regfile);
    end

    // read rs
    always @(*) begin
        if (rst) begin
            R_r_rs_data = {32{1'b0}};
        end else if (W_w_ena && W_w_addr == W_r_rs_addr) begin
            R_r_rs_data = W_w_data;
        end else begin
            R_r_rs_data = regfile[W_r_rs_addr];
        end
    end

    // read rt
        always @(*) begin
        if (rst) begin
            R_r_rt_data = {32{1'b0}};
        end else if (W_w_ena && W_w_addr == W_r_rt_addr) begin
            R_r_rt_data = W_w_data;
        end else begin
            R_r_rt_data = regfile[W_r_rt_addr];
        end
    end

    // write rd
    always @(posedge clk) begin
        if (W_w_ena) begin
            regfile[W_w_addr] = W_w_data;
        end
    end

endmodule
