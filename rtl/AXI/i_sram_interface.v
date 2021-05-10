`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/10 17:09:43
// Design Name: 
// Module Name: i_sram_interface
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

`define SRAM_IDLE       2'B00
`define SRAM_ADDR_OK    2'B01
`define SRAM_DATA_OK    2'B10

module i_sram_interface(
    input   wire            clk,
    input   wire            rst,
    input   wire            W_ena,
    input   wire [ 3:0]     W_wea,
    input   wire [31:0]     W_w_data,
    input   wire [31:0]     W_addr,
    output  reg  [31:0]     W_r_data,
    output  reg             W_stall,

    output  reg             W_req_o,
    output  reg             W_wr_o,
    output  reg  [ 1:0]     W_size_o,
    output  reg  [31:0]     W_addr_o,
    output  reg  [ 3:0]     W_wstrb_o,
    output  reg  [31:0]     W_wdata_o,
    input   wire            W_addr_ok_o,
    input   wire            W_data_ok_o,
    input   wire [31:0]     W_rdata_o
    );

    reg [1:0] W_cur_state, W_next_state;

    // update state
    always @(posedge clk) begin
        if (rst) begin
            W_cur_state <= `SRAM_IDLE;
        end else begin
            W_cur_state <= W_next_state;
        end
    end

    // next state
    always @(*) begin
        case(W_cur_state)
        `SRAM_IDLE: begin
            if ((W_ena == 1'b1) && (W_wea == 1'b0)) begin
                W_next_state = `SRAM_ADDR_OK;
            end else begin
                W_next_state = `SRAM_IDLE;
            end
        end

        `SRAM_ADDR_OK: begin
            if (W_addr_ok_o == 1'b1) begin
                W_next_state = `SRAM_DATA_OK;
            end else begin
                W_next_state = `SRAM_ADDR_OK;
            end
        end

        `SRAM_DATA_OK: begin
            if (W_data_ok_o == 1'b1) begin
                W_next_state = `SRAM_IDLE; 
            end else begin
                W_next_state = `SRAM_DATA_OK; 
            end
        end

        default: begin
            W_next_state = `SRAM_IDLE;
        end
        endcase
    end

    always @(*) begin
        if (rst) begin
            W_next_state = `SRAM_IDLE;
        end else begin
            case(W_cur_state)
            `SRAM_IDLE: begin
                W_stall = 1'b0;
                if ((W_ena == 1'b1) && (W_wea == 4'b0000)) begin
                    W_req_o     = 1'b1;
                    W_wr_o      = 1'b0;
                    W_size_o    = 2'b00;
                    W_addr_o    = W_addr;
                    W_wstrb_o   = 4'b000;
                    W_wdata_o   = 31'h0000_0000;
                end
            end
            
            `SRAM_ADDR_OK: begin
                W_stall = 1'b1;
            end

            `SRAM_DATA_OK: begin
                W_stall = 1'b1;
                if (W_data_ok_o == 1'b1) begin
                    W_r_data = W_rdata_o;
                end
            end

            default: begin
                W_stall = 1'b0;
            end
            endcase 
        end
    end

endmodule
