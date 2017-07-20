@echo off
set xv_path=F:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xsim adc_trig_testbench_time_impl -key {Post-Implementation:sim_1:Timing:adc_trig_testbench} -tclbatch adc_trig_testbench.tcl -view E:/vivado_hardware_design/xadc_triger/adc_trig_testbench_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
