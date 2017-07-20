// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
// Date        : Thu Jul 20 16:35:17 2017
// Host        : win-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               E:/vivado_hardware_design/xadc_triger/xadc_triger.sim/sim_1/synth/timing/adc_trig_testbench_time_synth.v
// Design      : adc_triger
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* CLK_HI = "5" *) (* CLK_LO = "5" *) (* HI = "1'b0" *) 
(* LO = "1'b1" *) (* OUT_OFF = "1'b0" *) (* OUT_ON = "1'b1" *) 
(* PULSE_NUM = "15" *) (* RUN = "1'b1" *) (* WAIT = "1'b0" *) 
(* NotValidForBitStream *)
module adc_triger
   (clk,
    rst,
    trig_in,
    trig_out,
    num_hi,
    num_lo,
    num_pulse);
  input clk;
  input rst;
  input trig_in;
  output trig_out;
  input [7:0]num_hi;
  input [7:0]num_lo;
  input [15:0]num_pulse;

  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire [7:0]clk_num;
  wire [5:3]clk_num0;
  wire clk_num1;
  wire \clk_num[0]_i_1_n_0 ;
  wire \clk_num[1]_i_1_n_0 ;
  wire \clk_num[2]_i_1_n_0 ;
  wire \clk_num[3]_i_1_n_0 ;
  wire \clk_num[4]_i_1_n_0 ;
  wire \clk_num[5]_i_1_n_0 ;
  wire \clk_num[6]_i_1_n_0 ;
  wire \clk_num[7]_i_1_n_0 ;
  wire \clk_num[7]_i_3_n_0 ;
  wire \clk_num[7]_i_5_n_0 ;
  wire \clk_num[7]_i_6_n_0 ;
  wire \clk_num[7]_i_7_n_0 ;
  wire \clk_num[7]_i_8_n_0 ;
  wire current_state;
  wire current_state_i_1_n_0;
  wire [7:0]num_hi;
  wire [7:0]num_hi_IBUF;
  wire [7:0]num_lo;
  wire [7:0]num_lo_IBUF;
  wire [15:0]num_pulse;
  wire [15:0]num_pulse_IBUF;
  wire output_state;
  wire output_state2_in;
  wire output_state_i_1_n_0;
  wire output_state_i_2_n_0;
  wire pulse_num0;
  wire pulse_num1;
  wire \pulse_num[0]_i_10_n_0 ;
  wire \pulse_num[0]_i_11_n_0 ;
  wire \pulse_num[0]_i_12_n_0 ;
  wire \pulse_num[0]_i_13_n_0 ;
  wire \pulse_num[0]_i_14_n_0 ;
  wire \pulse_num[0]_i_15_n_0 ;
  wire \pulse_num[0]_i_16_n_0 ;
  wire \pulse_num[0]_i_17_n_0 ;
  wire \pulse_num[0]_i_18_n_0 ;
  wire \pulse_num[0]_i_19_n_0 ;
  wire \pulse_num[0]_i_1_n_0 ;
  wire \pulse_num[0]_i_20_n_0 ;
  wire \pulse_num[0]_i_21_n_0 ;
  wire \pulse_num[0]_i_22_n_0 ;
  wire \pulse_num[0]_i_23_n_0 ;
  wire \pulse_num[0]_i_24_n_0 ;
  wire \pulse_num[0]_i_4_n_0 ;
  wire \pulse_num[0]_i_5_n_0 ;
  wire \pulse_num[0]_i_6_n_0 ;
  wire \pulse_num[0]_i_7_n_0 ;
  wire \pulse_num[0]_i_9_n_0 ;
  wire \pulse_num[12]_i_2_n_0 ;
  wire \pulse_num[12]_i_3_n_0 ;
  wire \pulse_num[12]_i_4_n_0 ;
  wire \pulse_num[12]_i_5_n_0 ;
  wire \pulse_num[4]_i_2_n_0 ;
  wire \pulse_num[4]_i_3_n_0 ;
  wire \pulse_num[4]_i_4_n_0 ;
  wire \pulse_num[4]_i_5_n_0 ;
  wire \pulse_num[8]_i_2_n_0 ;
  wire \pulse_num[8]_i_3_n_0 ;
  wire \pulse_num[8]_i_4_n_0 ;
  wire \pulse_num[8]_i_5_n_0 ;
  wire [15:0]pulse_num_reg;
  wire \pulse_num_reg[0]_i_2_n_0 ;
  wire \pulse_num_reg[0]_i_2_n_1 ;
  wire \pulse_num_reg[0]_i_2_n_2 ;
  wire \pulse_num_reg[0]_i_2_n_3 ;
  wire \pulse_num_reg[0]_i_2_n_4 ;
  wire \pulse_num_reg[0]_i_2_n_5 ;
  wire \pulse_num_reg[0]_i_2_n_6 ;
  wire \pulse_num_reg[0]_i_2_n_7 ;
  wire \pulse_num_reg[0]_i_3_n_1 ;
  wire \pulse_num_reg[0]_i_3_n_2 ;
  wire \pulse_num_reg[0]_i_3_n_3 ;
  wire \pulse_num_reg[0]_i_8_n_0 ;
  wire \pulse_num_reg[0]_i_8_n_1 ;
  wire \pulse_num_reg[0]_i_8_n_2 ;
  wire \pulse_num_reg[0]_i_8_n_3 ;
  wire \pulse_num_reg[12]_i_1_n_1 ;
  wire \pulse_num_reg[12]_i_1_n_2 ;
  wire \pulse_num_reg[12]_i_1_n_3 ;
  wire \pulse_num_reg[12]_i_1_n_4 ;
  wire \pulse_num_reg[12]_i_1_n_5 ;
  wire \pulse_num_reg[12]_i_1_n_6 ;
  wire \pulse_num_reg[12]_i_1_n_7 ;
  wire \pulse_num_reg[4]_i_1_n_0 ;
  wire \pulse_num_reg[4]_i_1_n_1 ;
  wire \pulse_num_reg[4]_i_1_n_2 ;
  wire \pulse_num_reg[4]_i_1_n_3 ;
  wire \pulse_num_reg[4]_i_1_n_4 ;
  wire \pulse_num_reg[4]_i_1_n_5 ;
  wire \pulse_num_reg[4]_i_1_n_6 ;
  wire \pulse_num_reg[4]_i_1_n_7 ;
  wire \pulse_num_reg[8]_i_1_n_0 ;
  wire \pulse_num_reg[8]_i_1_n_1 ;
  wire \pulse_num_reg[8]_i_1_n_2 ;
  wire \pulse_num_reg[8]_i_1_n_3 ;
  wire \pulse_num_reg[8]_i_1_n_4 ;
  wire \pulse_num_reg[8]_i_1_n_5 ;
  wire \pulse_num_reg[8]_i_1_n_6 ;
  wire \pulse_num_reg[8]_i_1_n_7 ;
  wire pulse_state;
  wire pulse_state_next;
  wire pulse_state_next__0;
  wire pulse_state_next_i_1_n_0;
  wire rst;
  wire rst_IBUF;
  wire t0;
  wire t1;
  wire trig_in;
  wire trig_in_IBUF;
  wire trig_out;
  wire trig_out0_out;
  wire trig_out_OBUF;
  wire trig_out_i_2_n_0;
  wire [3:0]\NLW_pulse_num_reg[0]_i_3_O_UNCONNECTED ;
  wire [3:0]\NLW_pulse_num_reg[0]_i_8_O_UNCONNECTED ;
  wire [3:3]\NLW_pulse_num_reg[12]_i_1_CO_UNCONNECTED ;

initial begin
 $sdf_annotate("adc_trig_testbench_time_synth.sdf",,,,"tool_control");
end
  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h0407)) 
    \clk_num[0]_i_1 
       (.I0(pulse_num0),
        .I1(pulse_state),
        .I2(clk_num[0]),
        .I3(clk_num1),
        .O(\clk_num[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h04400770)) 
    \clk_num[1]_i_1 
       (.I0(pulse_num0),
        .I1(pulse_state),
        .I2(clk_num[1]),
        .I3(clk_num[0]),
        .I4(clk_num1),
        .O(\clk_num[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0440404007707070)) 
    \clk_num[2]_i_1 
       (.I0(pulse_num0),
        .I1(pulse_state),
        .I2(clk_num[2]),
        .I3(clk_num[1]),
        .I4(clk_num[0]),
        .I5(clk_num1),
        .O(\clk_num[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h4070)) 
    \clk_num[3]_i_1 
       (.I0(pulse_num0),
        .I1(pulse_state),
        .I2(clk_num0[3]),
        .I3(clk_num1),
        .O(\clk_num[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \clk_num[3]_i_2 
       (.I0(clk_num[1]),
        .I1(clk_num[0]),
        .I2(clk_num[2]),
        .I3(clk_num[3]),
        .O(clk_num0[3]));
  LUT4 #(
    .INIT(16'h4070)) 
    \clk_num[4]_i_1 
       (.I0(pulse_num0),
        .I1(pulse_state),
        .I2(clk_num0[4]),
        .I3(clk_num1),
        .O(\clk_num[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \clk_num[4]_i_2 
       (.I0(clk_num[2]),
        .I1(clk_num[0]),
        .I2(clk_num[1]),
        .I3(clk_num[3]),
        .I4(clk_num[4]),
        .O(clk_num0[4]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h4070)) 
    \clk_num[5]_i_1 
       (.I0(pulse_num0),
        .I1(pulse_state),
        .I2(clk_num0[5]),
        .I3(clk_num1),
        .O(\clk_num[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \clk_num[5]_i_2 
       (.I0(clk_num[3]),
        .I1(clk_num[1]),
        .I2(clk_num[0]),
        .I3(clk_num[2]),
        .I4(clk_num[4]),
        .I5(clk_num[5]),
        .O(clk_num0[5]));
  LUT5 #(
    .INIT(32'h04400770)) 
    \clk_num[6]_i_1 
       (.I0(pulse_num0),
        .I1(pulse_state),
        .I2(clk_num[6]),
        .I3(\clk_num[7]_i_3_n_0 ),
        .I4(clk_num1),
        .O(\clk_num[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0440404007707070)) 
    \clk_num[7]_i_1 
       (.I0(pulse_num0),
        .I1(pulse_state),
        .I2(clk_num[7]),
        .I3(clk_num[6]),
        .I4(\clk_num[7]_i_3_n_0 ),
        .I5(clk_num1),
        .O(\clk_num[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000000000)) 
    \clk_num[7]_i_2 
       (.I0(num_lo_IBUF[7]),
        .I1(clk_num[7]),
        .I2(num_lo_IBUF[6]),
        .I3(clk_num[6]),
        .I4(\clk_num[7]_i_5_n_0 ),
        .I5(\clk_num[7]_i_6_n_0 ),
        .O(pulse_num0));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \clk_num[7]_i_3 
       (.I0(clk_num[5]),
        .I1(clk_num[3]),
        .I2(clk_num[1]),
        .I3(clk_num[0]),
        .I4(clk_num[2]),
        .I5(clk_num[4]),
        .O(\clk_num[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000000000)) 
    \clk_num[7]_i_4 
       (.I0(num_hi_IBUF[7]),
        .I1(clk_num[7]),
        .I2(num_hi_IBUF[6]),
        .I3(clk_num[6]),
        .I4(\clk_num[7]_i_7_n_0 ),
        .I5(\clk_num[7]_i_8_n_0 ),
        .O(clk_num1));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \clk_num[7]_i_5 
       (.I0(clk_num[3]),
        .I1(num_lo_IBUF[3]),
        .I2(num_lo_IBUF[5]),
        .I3(clk_num[5]),
        .I4(num_lo_IBUF[4]),
        .I5(clk_num[4]),
        .O(\clk_num[7]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \clk_num[7]_i_6 
       (.I0(clk_num[0]),
        .I1(num_lo_IBUF[0]),
        .I2(num_lo_IBUF[2]),
        .I3(clk_num[2]),
        .I4(num_lo_IBUF[1]),
        .I5(clk_num[1]),
        .O(\clk_num[7]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \clk_num[7]_i_7 
       (.I0(clk_num[3]),
        .I1(num_hi_IBUF[3]),
        .I2(num_hi_IBUF[5]),
        .I3(clk_num[5]),
        .I4(num_hi_IBUF[4]),
        .I5(clk_num[4]),
        .O(\clk_num[7]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'h9009000000009009)) 
    \clk_num[7]_i_8 
       (.I0(clk_num[0]),
        .I1(num_hi_IBUF[0]),
        .I2(num_hi_IBUF[2]),
        .I3(clk_num[2]),
        .I4(num_hi_IBUF[1]),
        .I5(clk_num[1]),
        .O(\clk_num[7]_i_8_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \clk_num_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(current_state),
        .CLR(current_state_i_1_n_0),
        .D(\clk_num[0]_i_1_n_0 ),
        .Q(clk_num[0]));
  FDCE #(
    .INIT(1'b0)) 
    \clk_num_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(current_state),
        .CLR(current_state_i_1_n_0),
        .D(\clk_num[1]_i_1_n_0 ),
        .Q(clk_num[1]));
  FDCE #(
    .INIT(1'b0)) 
    \clk_num_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(current_state),
        .CLR(current_state_i_1_n_0),
        .D(\clk_num[2]_i_1_n_0 ),
        .Q(clk_num[2]));
  FDCE #(
    .INIT(1'b0)) 
    \clk_num_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(current_state),
        .CLR(current_state_i_1_n_0),
        .D(\clk_num[3]_i_1_n_0 ),
        .Q(clk_num[3]));
  FDCE #(
    .INIT(1'b0)) 
    \clk_num_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(current_state),
        .CLR(current_state_i_1_n_0),
        .D(\clk_num[4]_i_1_n_0 ),
        .Q(clk_num[4]));
  FDCE #(
    .INIT(1'b0)) 
    \clk_num_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(current_state),
        .CLR(current_state_i_1_n_0),
        .D(\clk_num[5]_i_1_n_0 ),
        .Q(clk_num[5]));
  FDCE #(
    .INIT(1'b0)) 
    \clk_num_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(current_state),
        .CLR(current_state_i_1_n_0),
        .D(\clk_num[6]_i_1_n_0 ),
        .Q(clk_num[6]));
  FDCE #(
    .INIT(1'b0)) 
    \clk_num_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(current_state),
        .CLR(current_state_i_1_n_0),
        .D(\clk_num[7]_i_1_n_0 ),
        .Q(clk_num[7]));
  LUT1 #(
    .INIT(2'h1)) 
    current_state_i_1
       (.I0(rst_IBUF),
        .O(current_state_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    current_state_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(current_state_i_1_n_0),
        .D(output_state),
        .Q(current_state));
  IBUF \num_hi_IBUF[0]_inst 
       (.I(num_hi[0]),
        .O(num_hi_IBUF[0]));
  IBUF \num_hi_IBUF[1]_inst 
       (.I(num_hi[1]),
        .O(num_hi_IBUF[1]));
  IBUF \num_hi_IBUF[2]_inst 
       (.I(num_hi[2]),
        .O(num_hi_IBUF[2]));
  IBUF \num_hi_IBUF[3]_inst 
       (.I(num_hi[3]),
        .O(num_hi_IBUF[3]));
  IBUF \num_hi_IBUF[4]_inst 
       (.I(num_hi[4]),
        .O(num_hi_IBUF[4]));
  IBUF \num_hi_IBUF[5]_inst 
       (.I(num_hi[5]),
        .O(num_hi_IBUF[5]));
  IBUF \num_hi_IBUF[6]_inst 
       (.I(num_hi[6]),
        .O(num_hi_IBUF[6]));
  IBUF \num_hi_IBUF[7]_inst 
       (.I(num_hi[7]),
        .O(num_hi_IBUF[7]));
  IBUF \num_lo_IBUF[0]_inst 
       (.I(num_lo[0]),
        .O(num_lo_IBUF[0]));
  IBUF \num_lo_IBUF[1]_inst 
       (.I(num_lo[1]),
        .O(num_lo_IBUF[1]));
  IBUF \num_lo_IBUF[2]_inst 
       (.I(num_lo[2]),
        .O(num_lo_IBUF[2]));
  IBUF \num_lo_IBUF[3]_inst 
       (.I(num_lo[3]),
        .O(num_lo_IBUF[3]));
  IBUF \num_lo_IBUF[4]_inst 
       (.I(num_lo[4]),
        .O(num_lo_IBUF[4]));
  IBUF \num_lo_IBUF[5]_inst 
       (.I(num_lo[5]),
        .O(num_lo_IBUF[5]));
  IBUF \num_lo_IBUF[6]_inst 
       (.I(num_lo[6]),
        .O(num_lo_IBUF[6]));
  IBUF \num_lo_IBUF[7]_inst 
       (.I(num_lo[7]),
        .O(num_lo_IBUF[7]));
  IBUF \num_pulse_IBUF[0]_inst 
       (.I(num_pulse[0]),
        .O(num_pulse_IBUF[0]));
  IBUF \num_pulse_IBUF[10]_inst 
       (.I(num_pulse[10]),
        .O(num_pulse_IBUF[10]));
  IBUF \num_pulse_IBUF[11]_inst 
       (.I(num_pulse[11]),
        .O(num_pulse_IBUF[11]));
  IBUF \num_pulse_IBUF[12]_inst 
       (.I(num_pulse[12]),
        .O(num_pulse_IBUF[12]));
  IBUF \num_pulse_IBUF[13]_inst 
       (.I(num_pulse[13]),
        .O(num_pulse_IBUF[13]));
  IBUF \num_pulse_IBUF[14]_inst 
       (.I(num_pulse[14]),
        .O(num_pulse_IBUF[14]));
  IBUF \num_pulse_IBUF[15]_inst 
       (.I(num_pulse[15]),
        .O(num_pulse_IBUF[15]));
  IBUF \num_pulse_IBUF[1]_inst 
       (.I(num_pulse[1]),
        .O(num_pulse_IBUF[1]));
  IBUF \num_pulse_IBUF[2]_inst 
       (.I(num_pulse[2]),
        .O(num_pulse_IBUF[2]));
  IBUF \num_pulse_IBUF[3]_inst 
       (.I(num_pulse[3]),
        .O(num_pulse_IBUF[3]));
  IBUF \num_pulse_IBUF[4]_inst 
       (.I(num_pulse[4]),
        .O(num_pulse_IBUF[4]));
  IBUF \num_pulse_IBUF[5]_inst 
       (.I(num_pulse[5]),
        .O(num_pulse_IBUF[5]));
  IBUF \num_pulse_IBUF[6]_inst 
       (.I(num_pulse[6]),
        .O(num_pulse_IBUF[6]));
  IBUF \num_pulse_IBUF[7]_inst 
       (.I(num_pulse[7]),
        .O(num_pulse_IBUF[7]));
  IBUF \num_pulse_IBUF[8]_inst 
       (.I(num_pulse[8]),
        .O(num_pulse_IBUF[8]));
  IBUF \num_pulse_IBUF[9]_inst 
       (.I(num_pulse[9]),
        .O(num_pulse_IBUF[9]));
  LUT4 #(
    .INIT(16'hBF80)) 
    output_state_i_1
       (.I0(output_state_i_2_n_0),
        .I1(output_state2_in),
        .I2(rst_IBUF),
        .I3(output_state),
        .O(output_state_i_1_n_0));
  LUT6 #(
    .INIT(64'h00000000BFFF0000)) 
    output_state_i_2
       (.I0(pulse_num1),
        .I1(pulse_num0),
        .I2(pulse_state),
        .I3(current_state),
        .I4(t1),
        .I5(t0),
        .O(output_state_i_2_n_0));
  LUT6 #(
    .INIT(64'h40004000FFFF4000)) 
    output_state_i_3
       (.I0(pulse_num1),
        .I1(pulse_num0),
        .I2(pulse_state),
        .I3(current_state),
        .I4(t1),
        .I5(t0),
        .O(output_state2_in));
  FDRE #(
    .INIT(1'b0)) 
    output_state_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(output_state_i_1_n_0),
        .Q(output_state),
        .R(1'b0));
  LUT3 #(
    .INIT(8'h80)) 
    \pulse_num[0]_i_1 
       (.I0(current_state),
        .I1(pulse_num0),
        .I2(pulse_state),
        .O(\pulse_num[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F02)) 
    \pulse_num[0]_i_10 
       (.I0(num_pulse_IBUF[12]),
        .I1(pulse_num_reg[12]),
        .I2(pulse_num_reg[13]),
        .I3(num_pulse_IBUF[13]),
        .O(\pulse_num[0]_i_10_n_0 ));
  LUT4 #(
    .INIT(16'h2F02)) 
    \pulse_num[0]_i_11 
       (.I0(num_pulse_IBUF[10]),
        .I1(pulse_num_reg[10]),
        .I2(pulse_num_reg[11]),
        .I3(num_pulse_IBUF[11]),
        .O(\pulse_num[0]_i_11_n_0 ));
  LUT4 #(
    .INIT(16'h2F02)) 
    \pulse_num[0]_i_12 
       (.I0(num_pulse_IBUF[8]),
        .I1(pulse_num_reg[8]),
        .I2(pulse_num_reg[9]),
        .I3(num_pulse_IBUF[9]),
        .O(\pulse_num[0]_i_12_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \pulse_num[0]_i_13 
       (.I0(num_pulse_IBUF[14]),
        .I1(pulse_num_reg[14]),
        .I2(num_pulse_IBUF[15]),
        .I3(pulse_num_reg[15]),
        .O(\pulse_num[0]_i_13_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \pulse_num[0]_i_14 
       (.I0(num_pulse_IBUF[12]),
        .I1(pulse_num_reg[12]),
        .I2(num_pulse_IBUF[13]),
        .I3(pulse_num_reg[13]),
        .O(\pulse_num[0]_i_14_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \pulse_num[0]_i_15 
       (.I0(num_pulse_IBUF[10]),
        .I1(pulse_num_reg[10]),
        .I2(num_pulse_IBUF[11]),
        .I3(pulse_num_reg[11]),
        .O(\pulse_num[0]_i_15_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \pulse_num[0]_i_16 
       (.I0(num_pulse_IBUF[8]),
        .I1(pulse_num_reg[8]),
        .I2(num_pulse_IBUF[9]),
        .I3(pulse_num_reg[9]),
        .O(\pulse_num[0]_i_16_n_0 ));
  LUT4 #(
    .INIT(16'h2F02)) 
    \pulse_num[0]_i_17 
       (.I0(num_pulse_IBUF[6]),
        .I1(pulse_num_reg[6]),
        .I2(pulse_num_reg[7]),
        .I3(num_pulse_IBUF[7]),
        .O(\pulse_num[0]_i_17_n_0 ));
  LUT4 #(
    .INIT(16'h2F02)) 
    \pulse_num[0]_i_18 
       (.I0(num_pulse_IBUF[4]),
        .I1(pulse_num_reg[4]),
        .I2(pulse_num_reg[5]),
        .I3(num_pulse_IBUF[5]),
        .O(\pulse_num[0]_i_18_n_0 ));
  LUT4 #(
    .INIT(16'h2F02)) 
    \pulse_num[0]_i_19 
       (.I0(num_pulse_IBUF[2]),
        .I1(pulse_num_reg[2]),
        .I2(pulse_num_reg[3]),
        .I3(num_pulse_IBUF[3]),
        .O(\pulse_num[0]_i_19_n_0 ));
  LUT4 #(
    .INIT(16'h2F02)) 
    \pulse_num[0]_i_20 
       (.I0(num_pulse_IBUF[0]),
        .I1(pulse_num_reg[0]),
        .I2(pulse_num_reg[1]),
        .I3(num_pulse_IBUF[1]),
        .O(\pulse_num[0]_i_20_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \pulse_num[0]_i_21 
       (.I0(num_pulse_IBUF[6]),
        .I1(pulse_num_reg[6]),
        .I2(num_pulse_IBUF[7]),
        .I3(pulse_num_reg[7]),
        .O(\pulse_num[0]_i_21_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \pulse_num[0]_i_22 
       (.I0(num_pulse_IBUF[4]),
        .I1(pulse_num_reg[4]),
        .I2(num_pulse_IBUF[5]),
        .I3(pulse_num_reg[5]),
        .O(\pulse_num[0]_i_22_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \pulse_num[0]_i_23 
       (.I0(num_pulse_IBUF[2]),
        .I1(pulse_num_reg[2]),
        .I2(num_pulse_IBUF[3]),
        .I3(pulse_num_reg[3]),
        .O(\pulse_num[0]_i_23_n_0 ));
  LUT4 #(
    .INIT(16'h9009)) 
    \pulse_num[0]_i_24 
       (.I0(num_pulse_IBUF[0]),
        .I1(pulse_num_reg[0]),
        .I2(num_pulse_IBUF[1]),
        .I3(pulse_num_reg[1]),
        .O(\pulse_num[0]_i_24_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pulse_num[0]_i_4 
       (.I0(pulse_num1),
        .I1(pulse_num_reg[3]),
        .O(\pulse_num[0]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pulse_num[0]_i_5 
       (.I0(pulse_num1),
        .I1(pulse_num_reg[2]),
        .O(\pulse_num[0]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pulse_num[0]_i_6 
       (.I0(pulse_num1),
        .I1(pulse_num_reg[1]),
        .O(\pulse_num[0]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h4)) 
    \pulse_num[0]_i_7 
       (.I0(pulse_num_reg[0]),
        .I1(pulse_num1),
        .O(\pulse_num[0]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'h2F02)) 
    \pulse_num[0]_i_9 
       (.I0(num_pulse_IBUF[14]),
        .I1(pulse_num_reg[14]),
        .I2(pulse_num_reg[15]),
        .I3(num_pulse_IBUF[15]),
        .O(\pulse_num[0]_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pulse_num[12]_i_2 
       (.I0(pulse_num1),
        .I1(pulse_num_reg[15]),
        .O(\pulse_num[12]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pulse_num[12]_i_3 
       (.I0(pulse_num1),
        .I1(pulse_num_reg[14]),
        .O(\pulse_num[12]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pulse_num[12]_i_4 
       (.I0(pulse_num1),
        .I1(pulse_num_reg[13]),
        .O(\pulse_num[12]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pulse_num[12]_i_5 
       (.I0(pulse_num1),
        .I1(pulse_num_reg[12]),
        .O(\pulse_num[12]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pulse_num[4]_i_2 
       (.I0(pulse_num1),
        .I1(pulse_num_reg[7]),
        .O(\pulse_num[4]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pulse_num[4]_i_3 
       (.I0(pulse_num1),
        .I1(pulse_num_reg[6]),
        .O(\pulse_num[4]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pulse_num[4]_i_4 
       (.I0(pulse_num1),
        .I1(pulse_num_reg[5]),
        .O(\pulse_num[4]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pulse_num[4]_i_5 
       (.I0(pulse_num1),
        .I1(pulse_num_reg[4]),
        .O(\pulse_num[4]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pulse_num[8]_i_2 
       (.I0(pulse_num1),
        .I1(pulse_num_reg[11]),
        .O(\pulse_num[8]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pulse_num[8]_i_3 
       (.I0(pulse_num1),
        .I1(pulse_num_reg[10]),
        .O(\pulse_num[8]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pulse_num[8]_i_4 
       (.I0(pulse_num1),
        .I1(pulse_num_reg[9]),
        .O(\pulse_num[8]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \pulse_num[8]_i_5 
       (.I0(pulse_num1),
        .I1(pulse_num_reg[8]),
        .O(\pulse_num[8]_i_5_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[0]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num_reg[0]_i_2_n_7 ),
        .Q(pulse_num_reg[0]));
  CARRY4 \pulse_num_reg[0]_i_2 
       (.CI(1'b0),
        .CO({\pulse_num_reg[0]_i_2_n_0 ,\pulse_num_reg[0]_i_2_n_1 ,\pulse_num_reg[0]_i_2_n_2 ,\pulse_num_reg[0]_i_2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,pulse_num1}),
        .O({\pulse_num_reg[0]_i_2_n_4 ,\pulse_num_reg[0]_i_2_n_5 ,\pulse_num_reg[0]_i_2_n_6 ,\pulse_num_reg[0]_i_2_n_7 }),
        .S({\pulse_num[0]_i_4_n_0 ,\pulse_num[0]_i_5_n_0 ,\pulse_num[0]_i_6_n_0 ,\pulse_num[0]_i_7_n_0 }));
  CARRY4 \pulse_num_reg[0]_i_3 
       (.CI(\pulse_num_reg[0]_i_8_n_0 ),
        .CO({pulse_num1,\pulse_num_reg[0]_i_3_n_1 ,\pulse_num_reg[0]_i_3_n_2 ,\pulse_num_reg[0]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({\pulse_num[0]_i_9_n_0 ,\pulse_num[0]_i_10_n_0 ,\pulse_num[0]_i_11_n_0 ,\pulse_num[0]_i_12_n_0 }),
        .O(\NLW_pulse_num_reg[0]_i_3_O_UNCONNECTED [3:0]),
        .S({\pulse_num[0]_i_13_n_0 ,\pulse_num[0]_i_14_n_0 ,\pulse_num[0]_i_15_n_0 ,\pulse_num[0]_i_16_n_0 }));
  CARRY4 \pulse_num_reg[0]_i_8 
       (.CI(1'b0),
        .CO({\pulse_num_reg[0]_i_8_n_0 ,\pulse_num_reg[0]_i_8_n_1 ,\pulse_num_reg[0]_i_8_n_2 ,\pulse_num_reg[0]_i_8_n_3 }),
        .CYINIT(1'b0),
        .DI({\pulse_num[0]_i_17_n_0 ,\pulse_num[0]_i_18_n_0 ,\pulse_num[0]_i_19_n_0 ,\pulse_num[0]_i_20_n_0 }),
        .O(\NLW_pulse_num_reg[0]_i_8_O_UNCONNECTED [3:0]),
        .S({\pulse_num[0]_i_21_n_0 ,\pulse_num[0]_i_22_n_0 ,\pulse_num[0]_i_23_n_0 ,\pulse_num[0]_i_24_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[10] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[0]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num_reg[8]_i_1_n_5 ),
        .Q(pulse_num_reg[10]));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[11] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[0]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num_reg[8]_i_1_n_4 ),
        .Q(pulse_num_reg[11]));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[12] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[0]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num_reg[12]_i_1_n_7 ),
        .Q(pulse_num_reg[12]));
  CARRY4 \pulse_num_reg[12]_i_1 
       (.CI(\pulse_num_reg[8]_i_1_n_0 ),
        .CO({\NLW_pulse_num_reg[12]_i_1_CO_UNCONNECTED [3],\pulse_num_reg[12]_i_1_n_1 ,\pulse_num_reg[12]_i_1_n_2 ,\pulse_num_reg[12]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\pulse_num_reg[12]_i_1_n_4 ,\pulse_num_reg[12]_i_1_n_5 ,\pulse_num_reg[12]_i_1_n_6 ,\pulse_num_reg[12]_i_1_n_7 }),
        .S({\pulse_num[12]_i_2_n_0 ,\pulse_num[12]_i_3_n_0 ,\pulse_num[12]_i_4_n_0 ,\pulse_num[12]_i_5_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[13] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[0]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num_reg[12]_i_1_n_6 ),
        .Q(pulse_num_reg[13]));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[14] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[0]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num_reg[12]_i_1_n_5 ),
        .Q(pulse_num_reg[14]));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[15] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[0]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num_reg[12]_i_1_n_4 ),
        .Q(pulse_num_reg[15]));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[0]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num_reg[0]_i_2_n_6 ),
        .Q(pulse_num_reg[1]));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[0]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num_reg[0]_i_2_n_5 ),
        .Q(pulse_num_reg[2]));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[0]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num_reg[0]_i_2_n_4 ),
        .Q(pulse_num_reg[3]));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[0]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num_reg[4]_i_1_n_7 ),
        .Q(pulse_num_reg[4]));
  CARRY4 \pulse_num_reg[4]_i_1 
       (.CI(\pulse_num_reg[0]_i_2_n_0 ),
        .CO({\pulse_num_reg[4]_i_1_n_0 ,\pulse_num_reg[4]_i_1_n_1 ,\pulse_num_reg[4]_i_1_n_2 ,\pulse_num_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\pulse_num_reg[4]_i_1_n_4 ,\pulse_num_reg[4]_i_1_n_5 ,\pulse_num_reg[4]_i_1_n_6 ,\pulse_num_reg[4]_i_1_n_7 }),
        .S({\pulse_num[4]_i_2_n_0 ,\pulse_num[4]_i_3_n_0 ,\pulse_num[4]_i_4_n_0 ,\pulse_num[4]_i_5_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[0]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num_reg[4]_i_1_n_6 ),
        .Q(pulse_num_reg[5]));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[0]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num_reg[4]_i_1_n_5 ),
        .Q(pulse_num_reg[6]));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[0]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num_reg[4]_i_1_n_4 ),
        .Q(pulse_num_reg[7]));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[8] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[0]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num_reg[8]_i_1_n_7 ),
        .Q(pulse_num_reg[8]));
  CARRY4 \pulse_num_reg[8]_i_1 
       (.CI(\pulse_num_reg[4]_i_1_n_0 ),
        .CO({\pulse_num_reg[8]_i_1_n_0 ,\pulse_num_reg[8]_i_1_n_1 ,\pulse_num_reg[8]_i_1_n_2 ,\pulse_num_reg[8]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\pulse_num_reg[8]_i_1_n_4 ,\pulse_num_reg[8]_i_1_n_5 ,\pulse_num_reg[8]_i_1_n_6 ,\pulse_num_reg[8]_i_1_n_7 }),
        .S({\pulse_num[8]_i_2_n_0 ,\pulse_num[8]_i_3_n_0 ,\pulse_num[8]_i_4_n_0 ,\pulse_num[8]_i_5_n_0 }));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[9] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[0]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num_reg[8]_i_1_n_6 ),
        .Q(pulse_num_reg[9]));
  LUT6 #(
    .INIT(64'h20FFFFFF20000000)) 
    pulse_state_next_i_1
       (.I0(current_state),
        .I1(pulse_state),
        .I2(clk_num1),
        .I3(pulse_state_next__0),
        .I4(rst_IBUF),
        .I5(pulse_state_next),
        .O(pulse_state_next_i_1_n_0));
  LUT6 #(
    .INIT(64'hB800B800FFFFB800)) 
    pulse_state_next_i_2
       (.I0(pulse_num0),
        .I1(pulse_state),
        .I2(clk_num1),
        .I3(current_state),
        .I4(t1),
        .I5(t0),
        .O(pulse_state_next__0));
  FDRE #(
    .INIT(1'b0)) 
    pulse_state_next_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(pulse_state_next_i_1_n_0),
        .Q(pulse_state_next),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    pulse_state_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(pulse_state_next),
        .Q(pulse_state),
        .R(1'b0));
  IBUF rst_IBUF_inst
       (.I(rst),
        .O(rst_IBUF));
  FDCE #(
    .INIT(1'b0)) 
    t0_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(current_state_i_1_n_0),
        .D(t1),
        .Q(t0));
  FDCE #(
    .INIT(1'b0)) 
    t1_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(current_state_i_1_n_0),
        .D(trig_in_IBUF),
        .Q(t1));
  IBUF trig_in_IBUF_inst
       (.I(trig_in),
        .O(trig_in_IBUF));
  OBUF trig_out_OBUF_inst
       (.I(trig_out_OBUF),
        .O(trig_out));
  LUT4 #(
    .INIT(16'hDF00)) 
    trig_out_i_1
       (.I0(current_state),
        .I1(pulse_state),
        .I2(clk_num1),
        .I3(rst_IBUF),
        .O(trig_out0_out));
  LUT2 #(
    .INIT(4'h2)) 
    trig_out_i_2
       (.I0(current_state),
        .I1(pulse_state),
        .O(trig_out_i_2_n_0));
  FDRE #(
    .INIT(1'b0)) 
    trig_out_reg
       (.C(clk_IBUF_BUFG),
        .CE(trig_out0_out),
        .D(trig_out_i_2_n_0),
        .Q(trig_out_OBUF),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
