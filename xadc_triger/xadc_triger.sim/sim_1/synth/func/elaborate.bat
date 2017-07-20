@echo off
set xv_path=F:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto d202c5d17ea84aeaa49eed174a7c1f12 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L secureip --snapshot adc_trig_testbench_func_synth xil_defaultlib.adc_trig_testbench xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
