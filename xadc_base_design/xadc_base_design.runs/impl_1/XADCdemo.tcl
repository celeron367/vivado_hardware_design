proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}


start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  create_project -in_memory -part xc7z010clg400-1
  set_property board_part digilentinc.com:zybo:part0:1.0 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir E:/vivado_hardware_design/xadc_base_design/xadc_base_design.cache/wt [current_project]
  set_property parent.project_path E:/vivado_hardware_design/xadc_base_design/xadc_base_design.xpr [current_project]
  set_property ip_repo_paths D:/hardware/Zybo-XADC-2016.4-1/Zybo-XADC/repo [current_project]
  set_property ip_output_repo E:/vivado_hardware_design/xadc_base_design/xadc_base_design.cache/ip [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  set_property XPM_LIBRARIES XPM_MEMORY [current_project]
  add_files -quiet E:/vivado_hardware_design/xadc_base_design/xadc_base_design.runs/synth_1/XADCdemo.dcp
  read_ip -quiet E:/vivado_hardware_design/xadc_base_design/xadc_base_design.srcs/sources_1/ip/ila_0/ila_0.xci
  set_property is_locked true [get_files E:/vivado_hardware_design/xadc_base_design/xadc_base_design.srcs/sources_1/ip/ila_0/ila_0.xci]
  read_ip -quiet E:/vivado_hardware_design/xadc_base_design/xadc_base_design.srcs/sources_1/ip/xadc_wiz_0/xadc_wiz_0.xci
  set_property is_locked true [get_files E:/vivado_hardware_design/xadc_base_design/xadc_base_design.srcs/sources_1/ip/xadc_wiz_0/xadc_wiz_0.xci]
  read_xdc E:/vivado_hardware_design/xadc_base_design/xadc_base_design.srcs/constrs_1/imports/constraints/ZYBO_Master.xdc
  link_design -top XADCdemo -part xc7z010clg400-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design -directive RuntimeOptimized
  write_checkpoint -force XADCdemo_opt.dcp
  catch { report_drc -file XADCdemo_drc_opted.rpt }
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design -directive RuntimeOptimized
  write_checkpoint -force XADCdemo_placed.dcp
  catch { report_io -file XADCdemo_io_placed.rpt }
  catch { report_utilization -file XADCdemo_utilization_placed.rpt -pb XADCdemo_utilization_placed.pb }
  catch { report_control_sets -verbose -file XADCdemo_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design -directive RuntimeOptimized
  write_checkpoint -force XADCdemo_routed.dcp
  catch { report_drc -file XADCdemo_drc_routed.rpt -pb XADCdemo_drc_routed.pb -rpx XADCdemo_drc_routed.rpx }
  catch { report_methodology -file XADCdemo_methodology_drc_routed.rpt -rpx XADCdemo_methodology_drc_routed.rpx }
  catch { report_power -file XADCdemo_power_routed.rpt -pb XADCdemo_power_summary_routed.pb -rpx XADCdemo_power_routed.rpx }
  catch { report_route_status -file XADCdemo_route_status.rpt -pb XADCdemo_route_status.pb }
  catch { report_clock_utilization -file XADCdemo_clock_utilization_routed.rpt }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file XADCdemo_timing_summary_routed.rpt -rpx XADCdemo_timing_summary_routed.rpx }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force XADCdemo_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

start_step write_bitstream
set ACTIVE_STEP write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  set_property XPM_LIBRARIES XPM_MEMORY [current_project]
  catch { write_mem_info -force XADCdemo.mmi }
  write_bitstream -force XADCdemo.bit 
  catch {write_debug_probes -no_partial_ltxfile -quiet -force debug_nets}
  catch {file copy -force debug_nets.ltx XADCdemo.ltx}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
  unset ACTIVE_STEP 
}

