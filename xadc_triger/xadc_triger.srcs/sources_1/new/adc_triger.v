`timescale 1ns / 1ps


module adc_triger(clk,rst,trig_in,trig_out,num_hi,num_lo,num_pulse);
input clk;
input trig_in;
input rst;
input [7:0] num_hi;
input [7:0] num_lo;
input [15:0] num_pulse;
output trig_out;
//------------------------reg defination-----------------
reg current_state;    
reg next_state;
reg pulse_state;
reg pulse_state_next;
reg t0=0;
reg t1=0;
reg[7:0] clk_num=0;
reg[15:0] pulse_num=0;
reg output_state;
reg trig_out;
reg tlast;

parameter WAIT=1'b0;
parameter RUN=1'b1;
parameter HI=1'b0;
parameter LO=1'b1;
parameter CLK_HI=5;
parameter CLK_LO=5;
parameter PULSE_NUM=15;
parameter OUT_ON=1'b1;
parameter OUT_OFF=1'b0;

always@(posedge clk or negedge rst)    
 begin         
   if(!rst)    
   begin          
   current_state <= WAIT;      
   end    
   else
    current_state <= next_state;     
    pulse_state<=pulse_state_next;
 end
 
always@(*)
begin
   next_state=WAIT;
   case(current_state)
   WAIT:
      begin
      if (output_state==1'b1) next_state<=RUN;
      else next_state<=WAIT; 
      end
   RUN:
      begin
      if (output_state==1'b0) next_state<=WAIT;
      else next_state<=RUN;  
      end         
   endcase
end


always@(posedge clk or negedge rst)
 begin
   if(!rst)
   begin  
      pulse_num<=0;
      clk_num<=0;
      t0<=0;
      t1<=0;
   end
   else
   begin
      t1<=trig_in;
      t0<=t1;
      if(t1==1 && t0==0)  
      begin 
      output_state<=OUT_ON;
      pulse_state_next<=HI;
      end   
      //---------------------------
      case(current_state)
          WAIT:trig_out<=0;
          RUN:
             case(pulse_state)
             LO:
               begin
               trig_out<=0;
               clk_num<=clk_num+1;
               //----------------------
               if(clk_num==num_lo)
               begin
                  pulse_state_next<=HI;
                  clk_num<=0;
                  if(pulse_num<num_pulse) 
                   pulse_num<=pulse_num+1;
                   else
                   begin
                   pulse_num<=0;
                   output_state<=OUT_OFF;
                   end
               end
               
               //----------------------
               end
             HI:
               begin        
               //-----------------
               if(clk_num==num_hi) 
               begin 
               pulse_state_next<=LO;
               clk_num<=0;
               end   
               else
               begin
               trig_out<=1;
               clk_num<=clk_num+1;
               end
               //-----------------
               end
             endcase
          endcase
   end
 end
 endmodule

