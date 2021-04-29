`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/29 18:02:56
// Design Name: 
// Module Name: Top
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


module Top(
    input wire clk,
    input wire rst
    );
    
    wire        W_instr_ram_ena;
    wire [3:0]  W_instr_ram_wea;
    wire [31:0] W_instr_ram_w_data;
    wire [31:0] W_instr_ram_addr;
    wire [31:0] W_instr_ram_r_data;

    wire        W_data_ram_ena;
    wire [3:0]  W_data_ram_wea;
    wire [31:0] W_data_ram_w_data;
    wire [31:0] W_data_ram_addr;
    wire [31:0] W_data_ram_r_data;


    ExploreMIPS cpu_core(
        clk, rst,

        // instr_ram
        W_instr_ram_ena,
        W_instr_ram_wea,
        W_instr_ram_w_data,
        W_instr_ram_addr,
        W_instr_ram_r_data,

        // data_ram
        W_data_ram_ena,
        W_data_ram_wea,
        W_data_ram_w_data,
        W_data_ram_addr,
        W_data_ram_r_data
    );

    Data_RAM data_ram(
        .clka(~clk),                    // input wire clka
        .ena(W_data_ram_ena),           // input wire ena
        .wea(W_data_ram_wea),           // input wire [3 : 0] wea
        .addra(W_data_ram_addr[19:2]),  // input wire [17 : 0] addra
        .dina(W_data_ram_w_data),       // input wire [31 : 0] dina
        .douta(W_data_ram_r_data)       // output wire [31 : 0] douta
    );

    Instr_RAM instr_ram(
        .clka(clk),                     // input wire clka
        .ena(W_instr_ram_ena),          // input wire ena
        .wea(W_instr_ram_wea),          // input wire [3 : 0] wea
        .addra(W_instr_ram_addr[19:2]), // input wire [17 : 0] addra
        .dina(W_instr_ram_w_data),      // input wire [31 : 0] dina
        .douta(W_instr_ram_r_data)      // output wire [31 : 0] douta
    );

endmodule
