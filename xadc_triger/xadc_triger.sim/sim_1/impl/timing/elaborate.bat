@echo off
set xv_path=F:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto d202c5d17ea84aeaa49eed174a7c1f12 -m64 --debug typical --relax --mt 2 --maxdelay -L xil_defaultlib -L simprims_ver -L secureip --snapshot adc_trig_testbench_time_impl -transport_int_delays -pulse_r 0 -pulse_int_r 0 -pulse_e 0 -pulse_int_e 0 xil_defaultlib.adc_trig_testbench xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
