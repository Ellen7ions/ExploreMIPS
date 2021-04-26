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
    wire [31:0] data;

    initial begin
        clk = 1'b0;
        repeat (300) begin
            #50 clk = ~clk;
        end
    end

    RAM ram (
        .clka(~clk),                 // input wire clka
        .ena(1'b1),                 // input wire ena
        .wea(1'b0),       // input wire [3 : 0] wea
        .addra(addr),       // input wire [31 : 0] addra
        .dina(32'h0000_0000),        // input wire [31 : 0] dina
        .douta(data)          // output wire [31 : 0] douta
    );


    initial begin
        #70 begin
            addr = 32'h0000_0001;
        end

        #20 begin
            addr = 32'h0000_0002;
        end

        #130 begin
            addr = 32'h0000_0003;
        end

        
        #130 begin
            addr = 32'h0000_0004;
        end

        
        #130 begin
            addr = 32'h0000_0005;
        end
    end

endmodule
