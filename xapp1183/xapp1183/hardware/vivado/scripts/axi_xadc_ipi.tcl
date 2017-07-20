# This is a generated script based on design: axi_xadc_dma_zynq
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
#
# To test this script, run the following commands from Vivado Tcl console:
# source axi_xadc_dma_zynq_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7vx485tffg1157-1 -force

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design axi_xadc_dma_zynq

# Creating design if needed
if { [get_files *.bd] eq "" } {
   puts "INFO: Currently there are no designs in project, so creating one..."
   create_bd_design axi_xadc_dma_zynq
}



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports

  # Create instance: processing_system7_1, and set properties
  set processing_system7_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7 processing_system7_1 ]
  set_property -dict [ list CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} CONFIG.PCW_USE_S_AXI_GP0 {1} CONFIG.PCW_USE_FABRIC_INTERRUPT {1} CONFIG.PCW_IRQ_F2P_INTR {1} CONFIG.PCW_IMPORT_BOARD_PRESET {ZC702}  ] $processing_system7_1

  # Create instance: xadc_wiz_1, and set properties
  set xadc_wiz_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xadc_wiz xadc_wiz_1 ]
  set_property -dict [ list CONFIG.OT_ALARM {false} CONFIG.USER_TEMP_ALARM {false} CONFIG.VCCINT_ALARM {false} CONFIG.VCCAUX_ALARM {false} CONFIG.ENABLE_AXI4STREAM {true} CONFIG.FIFO_DEPTH {1017}  ] $xadc_wiz_1

  # Create instance: processing_system7_1_axi_periph, and set properties
  set processing_system7_1_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect processing_system7_1_axi_periph ]
  set_property -dict [ list CONFIG.NUM_MI {3}  ] $processing_system7_1_axi_periph

  # Create instance: proc_sys_reset, and set properties
  set proc_sys_reset [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset proc_sys_reset ]

  # Create instance: axi_dma_1, and set properties
  set axi_dma_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma axi_dma_1 ]
  set_property -dict [ list CONFIG.c_include_sg {0} CONFIG.c_sg_include_stscntrl_strm {0} CONFIG.c_include_mm2s {0} CONFIG.c_s_axis_s2mm_tdata_width {16} CONFIG.c_include_s2mm_dre {1}  ] $axi_dma_1

  # Create instance: axi_interconnect_1, and set properties
  set axi_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect axi_interconnect_1 ]
  set_property -dict [ list CONFIG.NUM_MI {1} CONFIG.ENABLE_ADVANCED_OPTIONS {1}  ] $axi_interconnect_1

  # Create instance: xadc_axis_fifo_adapter_1, and set properties
  set xadc_axis_fifo_adapter_1 [ create_bd_cell -type ip -vlnv xilinx.com:user:xadc_axis_fifo_adapter xadc_axis_fifo_adapter_1 ]
  set_property -dict [ list CONFIG.C_HIGHADDR {0x43C1FFFF} CONFIG.C_BASEADDR {0x43C10000}  ] $xadc_axis_fifo_adapter_1

  # Create instance: xlconcat_1, and set properties
  set xlconcat_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat_1 ]

  # Create interface connections
  connect_bd_intf_net -intf_net processing_system7_1_m_axi_gp0 [get_bd_intf_pins processing_system7_1/M_AXI_GP0] [get_bd_intf_pins processing_system7_1_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_1_axi_periph_m00_axi [get_bd_intf_pins processing_system7_1_axi_periph/M00_AXI] [get_bd_intf_pins xadc_wiz_1/s_axi_lite]
  connect_bd_intf_net -intf_net xadc_wiz_1_m_axis [get_bd_intf_pins xadc_axis_fifo_adapter_1/S_AXIS] [get_bd_intf_pins xadc_wiz_1/M_AXIS]
  connect_bd_intf_net -intf_net processing_system7_1_axi_periph_m02_axi [get_bd_intf_pins processing_system7_1_axi_periph/M02_AXI] [get_bd_intf_pins axi_dma_1/S_AXI_LITE]
  connect_bd_intf_net -intf_net xadc_axis_fifo_adapter_1_m_axis [get_bd_intf_pins xadc_axis_fifo_adapter_1/M_AXIS] [get_bd_intf_pins axi_dma_1/S_AXIS_S2MM]
  connect_bd_intf_net -intf_net axi_dma_1_m_axi_s2mm [get_bd_intf_pins axi_dma_1/M_AXI_S2MM] [get_bd_intf_pins axi_interconnect_1/S00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_m00_axi [get_bd_intf_pins axi_interconnect_1/M00_AXI] [get_bd_intf_pins processing_system7_1/S_AXI_GP0]
  connect_bd_intf_net -intf_net processing_system7_1_axi_periph_m01_axi [get_bd_intf_pins processing_system7_1_axi_periph/M01_AXI] [get_bd_intf_pins xadc_axis_fifo_adapter_1/S_AXI]

  # Create port connections
  connect_bd_net -net processing_system7_1_fclk_clk0 [get_bd_pins processing_system7_1/FCLK_CLK0] [get_bd_pins processing_system7_1/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_1_axi_periph/S00_ACLK] [get_bd_pins proc_sys_reset/slowest_sync_clk] [get_bd_pins processing_system7_1_axi_periph/ACLK] [get_bd_pins xadc_wiz_1/s_axi_aclk] [get_bd_pins processing_system7_1_axi_periph/M00_ACLK] [get_bd_pins processing_system7_1_axi_periph/M01_ACLK] [get_bd_pins axi_dma_1/s_axi_lite_aclk] [get_bd_pins processing_system7_1_axi_periph/M02_ACLK] [get_bd_pins axi_dma_1/m_axi_s2mm_aclk] [get_bd_pins processing_system7_1/S_AXI_GP0_ACLK] [get_bd_pins xadc_wiz_1/s_axis_aclk] [get_bd_pins axi_interconnect_1/M00_ACLK] [get_bd_pins axi_interconnect_1/S00_ACLK] [get_bd_pins axi_interconnect_1/ACLK] [get_bd_pins xadc_axis_fifo_adapter_1/S_AXIS_ACLK] [get_bd_pins xadc_axis_fifo_adapter_1/M_AXIS_ACLK] [get_bd_pins xadc_axis_fifo_adapter_1/S_AXI_ACLK]
  connect_bd_net -net processing_system7_1_fclk_reset0_n [get_bd_pins processing_system7_1/FCLK_RESET0_N] [get_bd_pins proc_sys_reset/ext_reset_in]
  connect_bd_net -net proc_sys_reset_peripheral_aresetn [get_bd_pins proc_sys_reset/peripheral_aresetn] [get_bd_pins processing_system7_1_axi_periph/S00_ARESETN] [get_bd_pins processing_system7_1_axi_periph/M00_ARESETN] [get_bd_pins xadc_wiz_1/s_axi_aresetn] [get_bd_pins processing_system7_1_axi_periph/M01_ARESETN] [get_bd_pins axi_dma_1/axi_resetn] [get_bd_pins processing_system7_1_axi_periph/M02_ARESETN] [get_bd_pins axi_interconnect_1/ARESETN] [get_bd_pins axi_interconnect_1/M00_ARESETN] [get_bd_pins xadc_axis_fifo_adapter_1/AXIS_RESET_N] [get_bd_pins xadc_axis_fifo_adapter_1/S_AXI_ARESETN]
  connect_bd_net -net proc_sys_reset_interconnect_aresetn [get_bd_pins proc_sys_reset/interconnect_aresetn] [get_bd_pins processing_system7_1_axi_periph/ARESETN]
  connect_bd_net -net s00_aresetn_1 [get_bd_pins axi_dma_1/s2mm_prmry_reset_out_n] [get_bd_pins axi_interconnect_1/S00_ARESETN]
  connect_bd_net -net xadc_wiz_1_ip2intc_irpt [get_bd_pins xadc_wiz_1/ip2intc_irpt] [get_bd_pins xlconcat_1/In1]
  connect_bd_net -net axi_dma_1_s2mm_introut [get_bd_pins axi_dma_1/s2mm_introut] [get_bd_pins xlconcat_1/In0]
  connect_bd_net -net xlconcat_1_dout [get_bd_pins xlconcat_1/dout] [get_bd_pins processing_system7_1/IRQ_F2P]

  # Create address segments
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs xadc_wiz_1/s_axi_lite/Reg] SEG1
  create_bd_addr_seg -range 0x10000 -offset 0x40400000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs axi_dma_1/S_AXI_LITE/Reg] SEG2
  create_bd_addr_seg -range 0x10000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_1/Data] [get_bd_addr_segs xadc_axis_fifo_adapter_1/S_AXI/reg0] SEG3
  create_bd_addr_seg -range 0x20000 -offset 0x0 [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs processing_system7_1/S_AXI_GP0/GP0_DDR_LOWOCM] SEG1
  create_bd_addr_seg -range 0x20000 -offset 0xFC000000 [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs processing_system7_1/S_AXI_GP0/GP0_QSPI_LINEAR] SEG2
  create_bd_addr_seg -range 0x20000 -offset 0xE0000000 [get_bd_addr_spaces axi_dma_1/Data_S2MM] [get_bd_addr_segs processing_system7_1/S_AXI_GP0/GP0_IOP] SEG3
  

  # Restore current instance
  current_bd_instance $oldCurInst
}


#####################################################
# Main Flow
#####################################################

create_root_design ""
