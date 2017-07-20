# PlanAhead Launch Script
set design_top axi_xadc_top 
set device xc7z020clg484-1 
set proj_dir runs 

create_project -name ${design_top} -force -dir "../${proj_dir}" -part ${device}

# Project Settings

#set_property top ${design_top} [current_fileset]

set_property ip_repo_paths ./../../sources/ip_package [current_fileset]
update_ip_catalog

source axi_xadc_ipi.tcl
make_wrapper -files [get_files ../${proj_dir}/axi_xadc_top.srcs/sources_1/bd/axi_xadc_dma_zynq/axi_xadc_dma_zynq.bd] -top -fileset [get_filesets sources_1] -import

update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

