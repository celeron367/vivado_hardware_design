vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../xadc_base_design.srcs/sources_1/ip/ila_0/hdl/verilog" "+incdir+../../../../xadc_base_design.srcs/sources_1/ip/ila_0/hdl/verilog" \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"C:/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../xadc_base_design.srcs/sources_1/ip/ila_0/sim/ila_0.vhd" \


vlog -work xil_defaultlib \
"glbl.v"

