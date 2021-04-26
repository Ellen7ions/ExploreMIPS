// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Mon Apr 26 16:57:31 2021
// Host        : DESKTOP-27OI68B running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub f:/University/LoogSonSrc/ExploreMIPS/ip_core/ROM/ROM_stub.v
// Design      : ROM
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tfbg676-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.1" *)
module ROM(clka, ena, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,addra[9:0],douta[31:0]" */;
  input clka;
  input ena;
  input [9:0]addra;
  output [31:0]douta;
endmodule
