`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/10 17:43:56
// Design Name: 
// Module Name: tb_i_sram
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


module tb_i_sram();
    reg clk, rst;

    initial begin
        clk = 1'b1;
        repeat (300) begin
            #200 clk = ~clk;
        end
    end

    reg         W_instr_ram_ena;
    reg  [3:0]  W_instr_ram_wea;
    reg  [31:0] W_instr_ram_addr;
    reg  [31:0] W_instr_ram_w_data;
    wire [31:0] W_instr_ram_r_data;

    wire rsta_busy;
    wire rstb_busy;

    wire [3:0]   s_axi_awid;
    wire [31:0]  s_axi_awaddr;
    wire [7:0]   s_axi_awlen;
    wire [2:0]   s_axi_awsize;
    wire [1:0]   s_axi_awburst;
    wire         s_axi_awvalid;
    wire         s_axi_awready;
    wire [31:0]  s_axi_wdata;
    wire [3:0]   s_axi_wstrb;
    wire         s_axi_wlast;
    wire         s_axi_wvalid;
    wire         s_axi_wready;
    wire [3:0]   s_axi_bid;
    wire [1:0]   s_axi_bresp;
    wire         s_axi_bvalid;
    wire         s_axi_bready;
    wire [3:0]   s_axi_arid;
    wire [31:0]  s_axi_araddr;
    wire [7:0]   s_axi_arlen;
    wire [2:0]   s_axi_arsize;
    wire [1:0]   s_axi_arburst;
    wire         s_axi_arvalid;
    wire         s_axi_arready;
    wire [3:0]   s_axi_rid;
    wire [31:0]  s_axi_rdata;
    wire [1:0]   s_axi_rresp;
    wire         s_axi_rlast;
    wire         s_axi_rvalid;
    wire         s_axi_rready;

    wire W_stall;

    wire            W_req_o;
    wire            W_wr_o;
    wire [1:0]      W_size_o;
    wire [31:0]     W_addr_o;
    wire [3:0]      W_wstrb_o;
    wire [31:0]     W_wdata_o;
    wire            W_addr_ok_o;
    wire            W_data_ok_o;
    wire [31:0]     W_rdata_o;

    // wire            W_addr_ok_o;
    // wire            W_data_ok_o;

    wire W_data_data_ok;
    wire W_data_addr_ok;

    i_sram_interface isi(
        clk, rst,
        W_instr_ram_ena,
        W_instr_ram_wea,
        W_instr_ram_w_data,
        W_instr_ram_addr,
        W_instr_ram_r_data,
        W_stall,

        W_req_o,
        W_wr_o,
        W_size_o,
        W_addr_o,
        W_wstrb_o,
        W_wdata_o,
        W_addr_ok_o,
        W_data_ok_o,
        W_rdata_o
    );

    cpu_axi_interface ls_axi(
        .clk(clk),
        .resetn(~rst),

        .inst_req(W_req_o)     ,
        .inst_wr(W_wr_o)      ,
        .inst_size(W_size_o)    ,
        .inst_addr(W_addr_o)    ,
        .inst_wdata(W_data_o)   ,
        .inst_rdata(W_rdata_o)   ,
        .inst_addr_ok(W_addr_ok_o) ,
        .inst_data_ok(W_data_ok_o) ,

        .data_req(1'b0)     ,
        .data_wr(0)      ,
        .data_size(2'h0)    ,
        .data_addr(32'h0000_0000)    ,
        .data_wdata(32'h0000_0000)   ,
        .data_rdata()   ,
        .data_addr_ok() ,
        .data_data_ok() ,

        .arid(s_axi_arid)         ,
        .araddr(s_axi_araddr)       ,
        .arlen(s_axi_arlen)        ,
        .arsize(s_axi_arsize)       ,
        .arburst(s_axi_arburst)      ,
        .arlock()       ,
        .arcache()      ,
        .arprot()       ,
        .arvalid(s_axi_arvalid)      ,
        .arready(s_axi_arready)      ,

        .rid(s_axi_rid)          ,
        .rdata(s_axi_rdata)        ,
        .rresp(s_axi_rresp)        ,
        .rlast(s_axi_rlast)        ,
        .rvalid(s_axi_rvalid)       ,
        .rready(s_axi_rready)       ,   

        .awid(s_axi_awid)         ,
        .awaddr(s_axi_awaddr)       ,
        .awlen(s_axi_awlen)        ,
        .awsize(s_axi_awsize)       ,
        .awburst(awburst)      ,
        
        .awlock()       ,
        .awcache()      ,
        .awprot()       ,
        .awvalid(awvalid)      ,
        .awready(awready)      ,

        .wid()          ,
        .wdata(s_axi_wdata)        ,
        .wstrb(s_axi_wstrb)        ,
        .wlast(s_axi_wlast)        ,
        .wvalid(s_axi_wvalid)       ,
        .wready(s_axi_wready)       ,

        .bid(s_axi_bid)          ,
        .bresp(s_axi_bresp)        ,
        .bvalid(s_axi_bvalid)       ,
        .bready(s_axi_bready)       
        
    );

    AXI_RAM your_instance_name (
        .rsta_busy          (rsta_busy),          // output wire rsta_busy
        .rstb_busy          (rstb_busy),          // output wire rstb_busy
        .s_aclk             (clk),                // input wire s_aclk
        .s_aresetn          (~rst),          // input wire s_aresetn
        .s_axi_awid         (s_axi_awid),        // input wire [3 : 0] s_axi_awid
        .s_axi_awaddr       (s_axi_awaddr),    // input wire [31 : 0] s_axi_awaddr
        .s_axi_awlen        (s_axi_awlen),      // input wire [7 : 0] s_axi_awlen
        .s_axi_awsize       (s_axi_awsize),    // input wire [2 : 0] s_axi_awsize
        .s_axi_awburst      (s_axi_awburst),  // input wire [1 : 0] s_axi_awburst
        .s_axi_awvalid      (s_axi_awvalid),  // input wire s_axi_awvalid
        .s_axi_awready      (s_axi_awready),  // output wire s_axi_awready
        .s_axi_wdata        (s_axi_wdata),      // input wire [31 : 0] s_axi_wdata
        .s_axi_wstrb        (s_axi_wstrb),      // input wire [3 : 0] s_axi_wstrb
        .s_axi_wlast        (s_axi_wlast),      // input wire s_axi_wlast
        .s_axi_wvalid       (s_axi_wvalid),    // input wire s_axi_wvalid
        .s_axi_wready       (s_axi_wready),    // output wire s_axi_wready
        .s_axi_bid          (s_axi_bid),          // output wire [3 : 0] s_axi_bid
        .s_axi_bresp        (s_axi_bresp),      // output wire [1 : 0] s_axi_bresp
        .s_axi_bvalid       (s_axi_bvalid),    // output wire s_axi_bvalid
        .s_axi_bready       (s_axi_bready),    // input wire s_axi_bready
        .s_axi_arid         (s_axi_arid),        // input wire [3 : 0] s_axi_arid
        .s_axi_araddr       (s_axi_araddr),    // input wire [31 : 0] s_axi_araddr
        .s_axi_arlen        (s_axi_arlen),      // input wire [7 : 0] s_axi_arlen
        .s_axi_arsize       (s_axi_arsize),    // input wire [2 : 0] s_axi_arsize
        .s_axi_arburst      (s_axi_arburst),  // input wire [1 : 0] s_axi_arburst
        .s_axi_arvalid      (s_axi_arvalid),  // input wire s_axi_arvalid
        .s_axi_arready      (s_axi_arready),  // output wire s_axi_arready
        .s_axi_rid          (s_axi_rid),          // output wire [3 : 0] s_axi_rid
        .s_axi_rdata        (s_axi_rdata),      // output wire [31 : 0] s_axi_rdata
        .s_axi_rresp        (s_axi_rresp),      // output wire [1 : 0] s_axi_rresp
        .s_axi_rlast        (s_axi_rlast),      // output wire s_axi_rlast
        .s_axi_rvalid       (s_axi_rvalid),    // output wire s_axi_rvalid
        .s_axi_rready       (s_axi_rready)    // input wire s_axi_rready
    );

    // always @(posedge clk) begin
    //     if (rst) begin
    //         W_instr_ram_addr = 32'h0000_0000;
    //     end else begin
    //         if (!W_stall) begin
    //             W_instr_ram_addr <= W_instr_ram_addr + 32'h0000_0001;
    //         end
    //     end
    // end

    initial begin
        W_instr_ram_ena =   1'b1;
        W_instr_ram_wea =   4'b0000;
        rst = 1'b1;
        W_instr_ram_addr = 32'h0000_0001;
        #400 rst = 1'b0;
        // #400 W_instr_ram_addr = 32'h0000_0002;
        // #400 W_instr_ram_addr = 32'h0000_0003;
        // #400 W_instr_ram_addr = 32'h0000_0004;
    end
endmodule
