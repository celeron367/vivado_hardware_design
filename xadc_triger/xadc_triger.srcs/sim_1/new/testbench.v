`timescale 1ns / 1ps

module adc_trig_testbench( );
reg clk;
reg rst;
reg trig_in;
wire trig_out;
reg [7:0] num_lo=5;
reg [7:0] num_hi=5;
reg [15:0] num_pulse=10;

adc_triger testtrig(.clk(clk),
                  .rst(rst),
                  .trig_in(trig_in),
                  .trig_out(trig_out),
                  .num_lo(num_lo),
                  .num_hi(num_hi),
                  .num_pulse(num_pulse)
);

initial
begin 
    clk=1'b0;
    rst=1'b1;
    trig_in=1'b0;
    num_lo=5;
    num_hi=5;
    num_pulse=10;
    #10
    //rst=1'b0;
    #20
    rst=1'b1;
    #98
    trig_in=1'b1;
    #150
    trig_in=1'b0;
end

always
begin
   #5 
     clk=~clk;
end

endmodule