// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
// Date        : Thu Dec  5 02:38:46 2024
// Host        : LAPTOP-4G708Q4E running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/boram/Desktop/kernel_filtering/kernel_filtering.gen/sources_1/ip/buffer_ram_1/buffer_ram_1_stub.v
// Design      : buffer_ram_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100ticsg324-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *)
module buffer_ram_1(clka, ena, wea, addra, dina, douta, clkb, enb, web, addrb, 
  dinb, doutb)
/* synthesis syn_black_box black_box_pad_pin="ena,wea[0:0],addra[15:0],dina[3:0],douta[3:0],enb,web[0:0],addrb[15:0],dinb[3:0],doutb[3:0]" */
/* synthesis syn_force_seq_prim="clka" */
/* synthesis syn_force_seq_prim="clkb" */;
  input clka /* synthesis syn_isclock = 1 */;
  input ena;
  input [0:0]wea;
  input [15:0]addra;
  input [3:0]dina;
  output [3:0]douta;
  input clkb /* synthesis syn_isclock = 1 */;
  input enb;
  input [0:0]web;
  input [15:0]addrb;
  input [3:0]dinb;
  output [3:0]doutb;
endmodule
