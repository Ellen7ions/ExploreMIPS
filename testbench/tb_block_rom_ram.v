`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/26 16:50:10
// Design Name: 
// Module Name: tb_block_rom_ram
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

// `include "defines.v"

module tb_block_rom_ram();

    reg [31:0] addr;
    reg clk;
    reg [3:0] w_ena;
    reg  [31:0] dina;
    wire [31:0] r_data;

    initial begin
        clk = 1'b0;
        repeat (300) begin
            #50 clk = ~clk;
        end
    end

        RAM your_instance_name (
            .clka(clk),    // input wire clka
            .ena(1'b1),      // input wire ena
            .wea(w_ena),      // input wire [3 : 0] wea
            .addra(addr),  // input wire [31 : 0] addra
            .dina(dina),    // input wire [31 : 0] dina
            .douta(r_data)  // output wire [31 : 0] douta
        );


    initial begin
        #10 begin
            w_ena = 4'b0001;
            addr = 32'h0000_0000;
            dina = 32'h1122_3344;
        end

        #100 begin
            w_ena = 4'b0010;
            addr = 32'h0000_0001;
            dina = 32'h1122_3344;
        end

        #100 begin
            w_ena = 4'b0100;
            addr = 32'h0000_0002;
            dina = 32'h1122_3344;
        end

        #170 begin
            addr = 32'h0000_0000;
        end

        #170 begin
            addr = 32'h0000_0001;
        end

        #170 begin
            addr = 32'h0000_0002;
        end
    end

endmodule
