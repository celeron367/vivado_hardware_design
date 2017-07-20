//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
//Date        : Thu Jul 20 10:48:22 2017
//Host        : win-PC running 64-bit Service Pack 1  (build 7601)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (sys_clock,
    trig_in);
  input sys_clock;
  input trig_in;

  wire sys_clock;
  wire trig_in;

  design_1 design_1_i
       (.sys_clock(sys_clock),
        .trig_in(trig_in));
endmodule
