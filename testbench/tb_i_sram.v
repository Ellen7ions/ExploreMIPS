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
            #50 clk = ~clk;
        end
    end

    reg         W_instr_ram_ena;
    reg  [3:0]  W_instr_ram_wea;
    reg  [17:0] W_instr_ram_addr;
    reg  [31:0] W_instr_ram_w_data;
    wire [31:0] W_instr_ram_r_data;

    reg rsta_busy;
    reg rstb_busy;

    reg s_axi_awid;
    reg s_axi_awaddr;
    reg s_axi_awlen;
    reg s_axi_awsize;
    reg s_axi_awburst;
    reg s_axi_awvalid;
    reg s_axi_awready;

    reg s_axi_wdata;
    reg s_axi_wstrb;
    reg s_axi_wlast;
    reg s_axi_wvalid;
    reg s_axi_wready;

    reg s_axi_bid;
    reg s_axi_bresp;
    reg s_axi_bvalid;
    reg s_axi_bready;

    reg s_axi_arid;
    reg s_axi_araddr;
    reg s_axi_arlen;
    reg s_axi_arsize;
    reg s_axi_arburst;
    reg s_axi_arvalid;
    reg s_axi_arready;

    reg s_axi_rid;
    reg s_axi_rdata;
    reg s_axi_rresp;
    reg s_axi_rlast;
    reg s_axi_rvalid;
    reg s_axi_rready;

    cpu_axi_interface ls_axi(
        .clk(clk),
        .resetn(~rst),

        .inst_req()     ,
        .inst_wr()      ,
        .inst_size()    ,
        .inst_addr()    ,
        .inst_wdata()   ,
        .inst_rdata()   ,
        .inst_addr_ok() ,
        .inst_data_ok() ,

        .data_req()     ,
        .data_wr()      ,
        .data_size()    ,
        .data_addr()    ,
        .data_wdata()   ,
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
        .awsize()       ,
        .awburst()      ,
        
        .awlock()       ,
        .awcache()      ,
        .awprot()       ,
        .awvalid()      ,
        .awready()      ,

        .wid()          ,
        .wdata()        ,
        .wstrb()        ,
        .wlast()        ,
        .wvalid()       ,
        .wready()       ,

        .bid()          ,
        .bresp()        ,
        .bvalid()       ,
        .bready()       
        
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

    always @(posedge clk) begin
        W_instr_ram_addr = W_instr_ram_addr + 32'h1;
    end

    initial begin
        W_instr_ram_ena =   1'b1;
        W_instr_ram_wea =   4'b0000;
    end
endmodule
