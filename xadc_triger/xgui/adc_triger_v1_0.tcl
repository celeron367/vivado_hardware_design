# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "CLK_HI" -parent ${Page_0}
  ipgui::add_param $IPINST -name "CLK_LO" -parent ${Page_0}
  ipgui::add_param $IPINST -name "HI" -parent ${Page_0}
  ipgui::add_param $IPINST -name "LO" -parent ${Page_0}
  ipgui::add_param $IPINST -name "OUT_OFF" -parent ${Page_0}
  ipgui::add_param $IPINST -name "OUT_ON" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PULSE_NUM" -parent ${Page_0}
  ipgui::add_param $IPINST -name "RUN" -parent ${Page_0}
  ipgui::add_param $IPINST -name "WAIT" -parent ${Page_0}


}

proc update_PARAM_VALUE.CLK_HI { PARAM_VALUE.CLK_HI } {
	# Procedure called to update CLK_HI when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLK_HI { PARAM_VALUE.CLK_HI } {
	# Procedure called to validate CLK_HI
	return true
}

proc update_PARAM_VALUE.CLK_LO { PARAM_VALUE.CLK_LO } {
	# Procedure called to update CLK_LO when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLK_LO { PARAM_VALUE.CLK_LO } {
	# Procedure called to validate CLK_LO
	return true
}

proc update_PARAM_VALUE.HI { PARAM_VALUE.HI } {
	# Procedure called to update HI when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.HI { PARAM_VALUE.HI } {
	# Procedure called to validate HI
	return true
}

proc update_PARAM_VALUE.LO { PARAM_VALUE.LO } {
	# Procedure called to update LO when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.LO { PARAM_VALUE.LO } {
	# Procedure called to validate LO
	return true
}

proc update_PARAM_VALUE.OUT_OFF { PARAM_VALUE.OUT_OFF } {
	# Procedure called to update OUT_OFF when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OUT_OFF { PARAM_VALUE.OUT_OFF } {
	# Procedure called to validate OUT_OFF
	return true
}

proc update_PARAM_VALUE.OUT_ON { PARAM_VALUE.OUT_ON } {
	# Procedure called to update OUT_ON when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OUT_ON { PARAM_VALUE.OUT_ON } {
	# Procedure called to validate OUT_ON
	return true
}

proc update_PARAM_VALUE.PULSE_NUM { PARAM_VALUE.PULSE_NUM } {
	# Procedure called to update PULSE_NUM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PULSE_NUM { PARAM_VALUE.PULSE_NUM } {
	# Procedure called to validate PULSE_NUM
	return true
}

proc update_PARAM_VALUE.RUN { PARAM_VALUE.RUN } {
	# Procedure called to update RUN when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RUN { PARAM_VALUE.RUN } {
	# Procedure called to validate RUN
	return true
}

proc update_PARAM_VALUE.WAIT { PARAM_VALUE.WAIT } {
	# Procedure called to update WAIT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.WAIT { PARAM_VALUE.WAIT } {
	# Procedure called to validate WAIT
	return true
}


proc update_MODELPARAM_VALUE.WAIT { MODELPARAM_VALUE.WAIT PARAM_VALUE.WAIT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.WAIT}] ${MODELPARAM_VALUE.WAIT}
}

proc update_MODELPARAM_VALUE.RUN { MODELPARAM_VALUE.RUN PARAM_VALUE.RUN } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RUN}] ${MODELPARAM_VALUE.RUN}
}

proc update_MODELPARAM_VALUE.HI { MODELPARAM_VALUE.HI PARAM_VALUE.HI } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.HI}] ${MODELPARAM_VALUE.HI}
}

proc update_MODELPARAM_VALUE.LO { MODELPARAM_VALUE.LO PARAM_VALUE.LO } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.LO}] ${MODELPARAM_VALUE.LO}
}

proc update_MODELPARAM_VALUE.CLK_HI { MODELPARAM_VALUE.CLK_HI PARAM_VALUE.CLK_HI } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CLK_HI}] ${MODELPARAM_VALUE.CLK_HI}
}

proc update_MODELPARAM_VALUE.CLK_LO { MODELPARAM_VALUE.CLK_LO PARAM_VALUE.CLK_LO } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CLK_LO}] ${MODELPARAM_VALUE.CLK_LO}
}

proc update_MODELPARAM_VALUE.PULSE_NUM { MODELPARAM_VALUE.PULSE_NUM PARAM_VALUE.PULSE_NUM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PULSE_NUM}] ${MODELPARAM_VALUE.PULSE_NUM}
}

proc update_MODELPARAM_VALUE.OUT_ON { MODELPARAM_VALUE.OUT_ON PARAM_VALUE.OUT_ON } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OUT_ON}] ${MODELPARAM_VALUE.OUT_ON}
}

proc update_MODELPARAM_VALUE.OUT_OFF { MODELPARAM_VALUE.OUT_OFF PARAM_VALUE.OUT_OFF } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OUT_OFF}] ${MODELPARAM_VALUE.OUT_OFF}
}

