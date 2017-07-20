//Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
//Date        : Thu Jul 20 10:48:22 2017
//Host        : win-PC running 64-bit Service Pack 1  (build 7601)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=5,numReposBlks=5,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_board_cnt=2,da_clkrst_cnt=2,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (sys_clock,
    trig_in);
  input sys_clock;
  input trig_in;

  wire adc_triger_0_trig_out;
  wire clk_wiz_clk_out1;
  wire sys_clock_1;
  wire trig_in_1;
  wire [7:0]vio_0_probe_out0;
  wire [7:0]vio_0_probe_out1;
  wire [15:0]vio_0_probe_out2;
  wire [15:0]xadc_wiz_0_M_AXIS_TDATA;
  wire [4:0]xadc_wiz_0_M_AXIS_TID;
  wire xadc_wiz_0_M_AXIS_TREADY;
  wire xadc_wiz_0_M_AXIS_TVALID;
  wire xadc_wiz_0_busy_out;
  wire [4:0]xadc_wiz_0_channel_out;
  wire xadc_wiz_0_eos_out;

  assign sys_clock_1 = sys_clock;
  assign trig_in_1 = trig_in;
  design_1_adc_triger_0_0 adc_triger_0
       (.clk(clk_wiz_clk_out1),
        .num_hi(vio_0_probe_out0),
        .num_lo(vio_0_probe_out1),
        .num_pulse(vio_0_probe_out2),
        .rst(1'b0),
        .trig_in(trig_in_1),
        .trig_out(adc_triger_0_trig_out));
  design_1_axis_data_fifo_0_0 axis_data_fifo_0
       (.m_axis_tready(1'b1),
        .s_axis_aclk(clk_wiz_clk_out1),
        .s_axis_aresetn(1'b0),
        .s_axis_tdata(xadc_wiz_0_M_AXIS_TDATA),
        .s_axis_tid(xadc_wiz_0_M_AXIS_TID),
        .s_axis_tready(xadc_wiz_0_M_AXIS_TREADY),
        .s_axis_tvalid(xadc_wiz_0_M_AXIS_TVALID));
  design_1_clk_wiz_0 clk_wiz
       (.clk_in1(sys_clock_1),
        .clk_out1(clk_wiz_clk_out1),
        .reset(1'b0));
  design_1_vio_0_0 vio_0
       (.clk(sys_clock_1),
        .probe_in0(xadc_wiz_0_channel_out),
        .probe_in1(xadc_wiz_0_eos_out),
        .probe_in2(xadc_wiz_0_busy_out),
        .probe_out0(vio_0_probe_out0),
        .probe_out1(vio_0_probe_out1),
        .probe_out2(vio_0_probe_out2));
  design_1_xadc_wiz_0_0 xadc_wiz_0
       (.busy_out(xadc_wiz_0_busy_out),
        .channel_out(xadc_wiz_0_channel_out),
        .convst_in(adc_triger_0_trig_out),
        .daddr_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .den_in(1'b0),
        .di_in({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dwe_in(1'b0),
        .eos_out(xadc_wiz_0_eos_out),
        .m_axis_aclk(clk_wiz_clk_out1),
        .m_axis_resetn(1'b0),
        .m_axis_tdata(xadc_wiz_0_M_AXIS_TDATA),
        .m_axis_tid(xadc_wiz_0_M_AXIS_TID),
        .m_axis_tready(xadc_wiz_0_M_AXIS_TREADY),
        .m_axis_tvalid(xadc_wiz_0_M_AXIS_TVALID),
        .s_axis_aclk(clk_wiz_clk_out1),
        .vauxn0(1'b0),
        .vauxn1(1'b0),
        .vauxn14(1'b0),
        .vauxn15(1'b0),
        .vauxp0(1'b0),
        .vauxp1(1'b0),
        .vauxp14(1'b0),
        .vauxp15(1'b0),
        .vn_in(1'b0),
        .vp_in(1'b0));
endmodule
