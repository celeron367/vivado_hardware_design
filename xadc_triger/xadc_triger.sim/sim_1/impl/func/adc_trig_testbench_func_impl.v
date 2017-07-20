// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
// Date        : Wed Jul 19 21:09:13 2017
// Host        : win-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               E:/vivado_hardware_design/xadc_triger/xadc_triger.sim/sim_1/impl/func/adc_trig_testbench_func_impl.v
// Design      : adc_triger
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CLK_HI = "5" *) (* CLK_LO = "5" *) (* ECO_CHECKSUM = "b31b8eaf" *) 
(* HI = "1'b0" *) (* LO = "1'b1" *) (* OUT_OFF = "1'b0" *) 
(* OUT_ON = "1'b1" *) (* PULSE_NUM = "15" *) (* RUN = "1'b1" *) 
(* WAIT = "1'b0" *) 
(* NotValidForBitStream *)
module adc_triger
   (clk,
    rst,
    trig_in,
    trig_out);
  input clk;
  input rst;
  input trig_in;
  output trig_out;

  wire clk;
  wire clk_IBUF;
  wire clk_IBUF_BUFG;
  wire [7:0]clk_num;
  wire \clk_num[1]_i_2_n_0 ;
  wire \clk_num[2]_i_2_n_0 ;
  wire \clk_num[7]_i_2_n_0 ;
  wire \clk_num_reg_n_0_[0] ;
  wire \clk_num_reg_n_0_[1] ;
  wire \clk_num_reg_n_0_[2] ;
  wire \clk_num_reg_n_0_[3] ;
  wire \clk_num_reg_n_0_[4] ;
  wire \clk_num_reg_n_0_[5] ;
  wire \clk_num_reg_n_0_[6] ;
  wire \clk_num_reg_n_0_[7] ;
  wire current_state;
  wire current_state_i_1_n_0;
  wire output_state_i_1_n_0;
  wire output_state_i_2_n_0;
  wire output_state_i_3_n_0;
  wire output_state_reg_n_0;
  wire [3:0]pulse_num;
  wire \pulse_num[0]_i_1_n_0 ;
  wire \pulse_num[1]_i_1_n_0 ;
  wire \pulse_num[2]_i_1_n_0 ;
  wire \pulse_num[3]_i_1_n_0 ;
  wire \pulse_num[3]_i_2_n_0 ;
  wire pulse_state;
  wire pulse_state_next_i_1_n_0;
  wire pulse_state_next_reg_n_0;
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

  BUFG clk_IBUF_BUFG_inst
       (.I(clk_IBUF),
        .O(clk_IBUF_BUFG));
  IBUF clk_IBUF_inst
       (.I(clk),
        .O(clk_IBUF));
  LUT1 #(
    .INIT(2'h1)) 
    \clk_num[0]_i_1 
       (.I0(\clk_num_reg_n_0_[0] ),
        .O(clk_num[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h38)) 
    \clk_num[1]_i_1 
       (.I0(\clk_num[1]_i_2_n_0 ),
        .I1(\clk_num_reg_n_0_[0] ),
        .I2(\clk_num_reg_n_0_[1] ),
        .O(clk_num[1]));
  LUT6 #(
    .INIT(64'hFFFFFFFEFFFFFFFF)) 
    \clk_num[1]_i_2 
       (.I0(\clk_num_reg_n_0_[5] ),
        .I1(\clk_num_reg_n_0_[3] ),
        .I2(\clk_num_reg_n_0_[7] ),
        .I3(\clk_num_reg_n_0_[6] ),
        .I4(\clk_num_reg_n_0_[4] ),
        .I5(\clk_num_reg_n_0_[2] ),
        .O(\clk_num[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h5AD0)) 
    \clk_num[2]_i_1 
       (.I0(\clk_num_reg_n_0_[0] ),
        .I1(\clk_num[2]_i_2_n_0 ),
        .I2(\clk_num_reg_n_0_[2] ),
        .I3(\clk_num_reg_n_0_[1] ),
        .O(clk_num[2]));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \clk_num[2]_i_2 
       (.I0(\clk_num_reg_n_0_[4] ),
        .I1(\clk_num_reg_n_0_[6] ),
        .I2(\clk_num_reg_n_0_[7] ),
        .I3(\clk_num_reg_n_0_[3] ),
        .I4(\clk_num_reg_n_0_[5] ),
        .O(\clk_num[2]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \clk_num[3]_i_1 
       (.I0(\clk_num_reg_n_0_[1] ),
        .I1(\clk_num_reg_n_0_[0] ),
        .I2(\clk_num_reg_n_0_[2] ),
        .I3(\clk_num_reg_n_0_[3] ),
        .O(clk_num[3]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \clk_num[4]_i_1 
       (.I0(\clk_num_reg_n_0_[3] ),
        .I1(\clk_num_reg_n_0_[2] ),
        .I2(\clk_num_reg_n_0_[0] ),
        .I3(\clk_num_reg_n_0_[1] ),
        .I4(\clk_num_reg_n_0_[4] ),
        .O(clk_num[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \clk_num[5]_i_1 
       (.I0(\clk_num_reg_n_0_[4] ),
        .I1(\clk_num_reg_n_0_[1] ),
        .I2(\clk_num_reg_n_0_[0] ),
        .I3(\clk_num_reg_n_0_[2] ),
        .I4(\clk_num_reg_n_0_[3] ),
        .I5(\clk_num_reg_n_0_[5] ),
        .O(clk_num[5]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h9)) 
    \clk_num[6]_i_1 
       (.I0(\clk_num[7]_i_2_n_0 ),
        .I1(\clk_num_reg_n_0_[6] ),
        .O(clk_num[6]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hD2)) 
    \clk_num[7]_i_1 
       (.I0(\clk_num_reg_n_0_[6] ),
        .I1(\clk_num[7]_i_2_n_0 ),
        .I2(\clk_num_reg_n_0_[7] ),
        .O(clk_num[7]));
  LUT6 #(
    .INIT(64'h7FFFFFFFFFFFFFFF)) 
    \clk_num[7]_i_2 
       (.I0(\clk_num_reg_n_0_[4] ),
        .I1(\clk_num_reg_n_0_[1] ),
        .I2(\clk_num_reg_n_0_[0] ),
        .I3(\clk_num_reg_n_0_[2] ),
        .I4(\clk_num_reg_n_0_[3] ),
        .I5(\clk_num_reg_n_0_[5] ),
        .O(\clk_num[7]_i_2_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \clk_num_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(current_state),
        .CLR(current_state_i_1_n_0),
        .D(clk_num[0]),
        .Q(\clk_num_reg_n_0_[0] ));
  FDCE #(
    .INIT(1'b0)) 
    \clk_num_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(current_state),
        .CLR(current_state_i_1_n_0),
        .D(clk_num[1]),
        .Q(\clk_num_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \clk_num_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(current_state),
        .CLR(current_state_i_1_n_0),
        .D(clk_num[2]),
        .Q(\clk_num_reg_n_0_[2] ));
  FDCE #(
    .INIT(1'b0)) 
    \clk_num_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(current_state),
        .CLR(current_state_i_1_n_0),
        .D(clk_num[3]),
        .Q(\clk_num_reg_n_0_[3] ));
  FDCE #(
    .INIT(1'b0)) 
    \clk_num_reg[4] 
       (.C(clk_IBUF_BUFG),
        .CE(current_state),
        .CLR(current_state_i_1_n_0),
        .D(clk_num[4]),
        .Q(\clk_num_reg_n_0_[4] ));
  FDCE #(
    .INIT(1'b0)) 
    \clk_num_reg[5] 
       (.C(clk_IBUF_BUFG),
        .CE(current_state),
        .CLR(current_state_i_1_n_0),
        .D(clk_num[5]),
        .Q(\clk_num_reg_n_0_[5] ));
  FDCE #(
    .INIT(1'b0)) 
    \clk_num_reg[6] 
       (.C(clk_IBUF_BUFG),
        .CE(current_state),
        .CLR(current_state_i_1_n_0),
        .D(clk_num[6]),
        .Q(\clk_num_reg_n_0_[6] ));
  FDCE #(
    .INIT(1'b0)) 
    \clk_num_reg[7] 
       (.C(clk_IBUF_BUFG),
        .CE(current_state),
        .CLR(current_state_i_1_n_0),
        .D(clk_num[7]),
        .Q(\clk_num_reg_n_0_[7] ));
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
        .D(output_state_reg_n_0),
        .Q(current_state));
  LUT5 #(
    .INIT(32'hF0FF2000)) 
    output_state_i_1
       (.I0(t1),
        .I1(t0),
        .I2(output_state_i_2_n_0),
        .I3(rst_IBUF),
        .I4(output_state_reg_n_0),
        .O(output_state_i_1_n_0));
  LUT6 #(
    .INIT(64'hFFFFFDFFFFFFFFFF)) 
    output_state_i_2
       (.I0(pulse_state),
        .I1(output_state_i_3_n_0),
        .I2(\clk_num_reg_n_0_[1] ),
        .I3(current_state),
        .I4(\clk_num[1]_i_2_n_0 ),
        .I5(\clk_num_reg_n_0_[0] ),
        .O(output_state_i_2_n_0));
  LUT4 #(
    .INIT(16'h7FFF)) 
    output_state_i_3
       (.I0(pulse_num[2]),
        .I1(pulse_num[0]),
        .I2(pulse_num[1]),
        .I3(pulse_num[3]),
        .O(output_state_i_3_n_0));
  FDRE #(
    .INIT(1'b0)) 
    output_state_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(output_state_i_1_n_0),
        .Q(output_state_reg_n_0),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \pulse_num[0]_i_1 
       (.I0(pulse_num[0]),
        .O(\pulse_num[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \pulse_num[1]_i_1 
       (.I0(pulse_num[0]),
        .I1(pulse_num[1]),
        .O(\pulse_num[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \pulse_num[2]_i_1 
       (.I0(pulse_num[1]),
        .I1(pulse_num[0]),
        .I2(pulse_num[2]),
        .O(\pulse_num[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00200000)) 
    \pulse_num[3]_i_1 
       (.I0(\clk_num_reg_n_0_[0] ),
        .I1(\clk_num[1]_i_2_n_0 ),
        .I2(current_state),
        .I3(\clk_num_reg_n_0_[1] ),
        .I4(pulse_state),
        .O(\pulse_num[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h7F80)) 
    \pulse_num[3]_i_2 
       (.I0(pulse_num[2]),
        .I1(pulse_num[0]),
        .I2(pulse_num[1]),
        .I3(pulse_num[3]),
        .O(\pulse_num[3]_i_2_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[0] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[3]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num[0]_i_1_n_0 ),
        .Q(pulse_num[0]));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[1] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[3]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num[1]_i_1_n_0 ),
        .Q(pulse_num[1]));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[2] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[3]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num[2]_i_1_n_0 ),
        .Q(pulse_num[2]));
  FDCE #(
    .INIT(1'b0)) 
    \pulse_num_reg[3] 
       (.C(clk_IBUF_BUFG),
        .CE(\pulse_num[3]_i_1_n_0 ),
        .CLR(current_state_i_1_n_0),
        .D(\pulse_num[3]_i_2_n_0 ),
        .Q(pulse_num[3]));
  LUT6 #(
    .INIT(64'hFFDF0000FFFF0020)) 
    pulse_state_next_i_1
       (.I0(\clk_num_reg_n_0_[0] ),
        .I1(\clk_num[1]_i_2_n_0 ),
        .I2(current_state),
        .I3(\clk_num_reg_n_0_[1] ),
        .I4(pulse_state_next_reg_n_0),
        .I5(pulse_state),
        .O(pulse_state_next_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    pulse_state_next_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .CLR(current_state_i_1_n_0),
        .D(pulse_state_next_i_1_n_0),
        .Q(pulse_state_next_reg_n_0));
  FDRE #(
    .INIT(1'b0)) 
    pulse_state_reg
       (.C(clk_IBUF_BUFG),
        .CE(1'b1),
        .D(pulse_state_next_reg_n_0),
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
  LUT6 #(
    .INIT(64'hFFFFFFDF00000000)) 
    trig_out_i_1
       (.I0(\clk_num_reg_n_0_[0] ),
        .I1(\clk_num[1]_i_2_n_0 ),
        .I2(current_state),
        .I3(\clk_num_reg_n_0_[1] ),
        .I4(pulse_state),
        .I5(rst_IBUF),
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
