`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/07/18 15:11:49
// Design Name: 
// Module Name: adc_trig_testbench
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


module adc_trig_testbench( );
reg clk;
reg rst;
reg trig_in;
wire trig_out;
wire tlast;
adc_trig testtrig(.clk(clk),
                  .rst(rst),
                  .trig_in(trig_in),
                  .trig_out(trig_out),
                  .tlast(tlast)
);

initial
bgin 
    clk=1'b0;
    rst=1'b1;
    #10
    rst=1'b0;
    #100
    trig_in=1'b1;
    #150
    trig_in=1'b0;
end
always
begin
   #10 
     clk=~clk;
end

endmodule
