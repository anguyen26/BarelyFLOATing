# Begin_DVE_Session_Save_Info
# DVE reload session
# Saved on Sat Apr 30 03:18:29 2022
# Designs open: 1
#   V1: /home/nguyea9/ee478/Core/vcdplus.vpd
# Toplevel windows open: 2
# 	TopLevel.1
# 	TopLevel.2
#   Source.1: cpuControl_testbench
#   Wave.1: 52 signals
#   Group count = 6
#   Group cpuControl_testbench signal count = 20
#   Group cpuStim_1 signal count = 6
#   Group registers signal count = 11
#   Group controlUnit signal count = 21
#   Group aluBlock signal count = 9
# End_DVE_Session_Save_Info

# DVE version: S-2021.09-SP1_Full64
# DVE build date: Nov 30 2021 00:09:19


#<Session mode="Reload" path="/home/nguyea9/ee478/Core/DVEfiles/session.tcl" type="Debug">

gui_set_loading_session_type Reload
gui_continuetime_set

# Close design
if { [gui_sim_state -check active] } {
    gui_sim_terminate
}
gui_close_db -all
gui_expr_clear_all
gui_clear_window -type Wave
gui_clear_window -type List

# Application preferences
gui_set_pref_value -key app_default_font -value {Helvetica,10,-1,5,50,0,0,0,0,0}
gui_src_preferences -tabstop 8 -maxbits 24 -windownumber 1
#<WindowLayout>

# DVE top-level session


# Create and position top-level window: TopLevel.1

set TopLevel.1 TopLevel.1

# Docked window settings
set HSPane.1 HSPane.1
set Hier.1 Hier.1
set DLPane.1 DLPane.1
set Data.1 Data.1
set Console.1 Console.1
gui_sync_global -id ${TopLevel.1} -option true

# MDI window settings
set Source.1 Source.1
gui_update_layout -id ${Source.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false}}

# End MDI window settings


# Create and position top-level window: TopLevel.2

set TopLevel.2 TopLevel.2

# Docked window settings
gui_sync_global -id ${TopLevel.2} -option true

# MDI window settings
set Wave.1 Wave.1
gui_update_layout -id ${Wave.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 370} {child_wave_right 379} {child_wave_colname 210} {child_wave_colvalue 156} {child_wave_col1 0} {child_wave_col2 1}}

# End MDI window settings


#</WindowLayout>

#<Database>

# DVE Open design session: 

if { ![gui_is_db_opened -db {/home/nguyea9/ee478/Core/vcdplus.vpd}] } {
	gui_open_db -design V1 -file /home/nguyea9/ee478/Core/vcdplus.vpd -nosource
}
gui_set_precision 1ps
gui_set_time_units 1ps
#</Database>

# DVE Global setting session: 


# Global: Bus

# Global: Expressions

# Global: Signal Time Shift

# Global: Signal Compare

# Global: Signal Groups
gui_load_child_values {cpuStim.testCpu}
gui_load_child_values {cpuStim}
gui_load_child_values {cpuStim.testCpu.regWrMux}
gui_load_child_values {cpuStim.testCpu.controlUnit}
gui_load_child_values {cpuControl_testbench}
gui_load_child_values {cpuStim.testCpu.aluBlock}
gui_load_child_values {cpuStim.testCpu.registers}


set _session_group_90 cpuControl_testbench
gui_sg_create "$_session_group_90"
set cpuControl_testbench "$_session_group_90"

gui_sg_addsignal -group "$_session_group_90" { cpuControl_testbench.instr cpuControl_testbench.negative cpuControl_testbench.zero cpuControl_testbench.overflow cpuControl_testbench.alu_zero cpuControl_testbench.clk cpuControl_testbench.reset cpuControl_testbench.Reg2Loc cpuControl_testbench.RegWrite cpuControl_testbench.MemWrite cpuControl_testbench.MemRead cpuControl_testbench.MemToReg cpuControl_testbench.BrTaken cpuControl_testbench.UncondBr cpuControl_testbench.ALUSrc cpuControl_testbench.ShiftDir cpuControl_testbench.nineOrTwelve cpuControl_testbench.keepFlags cpuControl_testbench.ALUOp cpuControl_testbench.calcSrc }

set _session_group_91 cpuStim_1
gui_sg_create "$_session_group_91"
set cpuStim_1 "$_session_group_91"

gui_sg_addsignal -group "$_session_group_91" { cpuStim.ClockDelay cpuStim.clk cpuStim.reset cpuStim.testCpu.PC cpuStim.testCpu.PCNext cpuStim.testCpu.instr }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.ClockDelay}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.ClockDelay}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.PC}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.PC}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.PCNext}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.PCNext}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.instr}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.instr}

set _session_group_92 registers
gui_sg_create "$_session_group_92"
set registers "$_session_group_92"

gui_sg_addsignal -group "$_session_group_92" { cpuStim.testCpu.whichMOV cpuStim.testCpu.registers.wr_data cpuStim.testCpu.registers.rd_addr_0 cpuStim.testCpu.registers.rd_addr_1 cpuStim.testCpu.registers.wr_addr cpuStim.testCpu.registers.wr_en cpuStim.testCpu.registers.rd_data_0 cpuStim.testCpu.registers.rd_data_1 cpuStim.testCpu.registers.MEM cpuStim.testCpu.registers.clk }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.whichMOV}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.whichMOV}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.registers.wr_data}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.wr_data}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.registers.rd_addr_0}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.rd_addr_0}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.registers.rd_addr_1}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.rd_addr_1}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.registers.wr_addr}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.wr_addr}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.registers.rd_data_0}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.rd_data_0}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.registers.rd_data_1}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.rd_data_1}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.registers.MEM}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.MEM}

set _session_group_93 $_session_group_92|
append _session_group_93 regWrMux
gui_sg_create "$_session_group_93"
set registers|regWrMux "$_session_group_93"

gui_sg_addsignal -group "$_session_group_93" { cpuStim.testCpu.regWrMux.i0 cpuStim.testCpu.regWrMux.i1 cpuStim.testCpu.regWrMux.i2 cpuStim.testCpu.regWrMux.i3 cpuStim.testCpu.regWrMux.sel cpuStim.testCpu.regWrMux.out }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.regWrMux.i0}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.regWrMux.i0}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.regWrMux.i1}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.regWrMux.i1}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.regWrMux.i2}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.regWrMux.i2}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.regWrMux.i3}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.regWrMux.i3}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.regWrMux.sel}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.regWrMux.sel}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.regWrMux.out}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.regWrMux.out}

gui_sg_move "$_session_group_93" -after "$_session_group_92" -pos 1 

set _session_group_94 controlUnit
gui_sg_create "$_session_group_94"
set controlUnit "$_session_group_94"

gui_sg_addsignal -group "$_session_group_94" { cpuStim.testCpu.controlUnit.PC cpuStim.testCpu.controlUnit.instr cpuStim.testCpu.controlUnit.FlagsReg cpuStim.testCpu.controlUnit.clk cpuStim.testCpu.controlUnit.reset cpuStim.testCpu.controlUnit.RegWrite cpuStim.testCpu.controlUnit.MemWrite cpuStim.testCpu.controlUnit.MemRead cpuStim.testCpu.controlUnit.ShiftDir cpuStim.testCpu.controlUnit.noop cpuStim.testCpu.controlUnit.keepFlags cpuStim.testCpu.controlUnit.Reg1Loc cpuStim.testCpu.controlUnit.Reg2Loc cpuStim.testCpu.controlUnit.Reg3Loc cpuStim.testCpu.controlUnit.selOpB cpuStim.testCpu.controlUnit.selOpA cpuStim.testCpu.controlUnit.ALUOp cpuStim.testCpu.controlUnit.brSel cpuStim.testCpu.controlUnit.brEx cpuStim.testCpu.controlUnit.selWrData cpuStim.testCpu.controlUnit.opcode }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.controlUnit.keepFlags}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.controlUnit.keepFlags}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.controlUnit.Reg1Loc}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.controlUnit.Reg1Loc}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.controlUnit.Reg2Loc}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.controlUnit.Reg2Loc}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.controlUnit.Reg3Loc}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.controlUnit.Reg3Loc}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.controlUnit.selOpB}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.controlUnit.selOpB}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.controlUnit.ALUOp}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.controlUnit.ALUOp}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.controlUnit.brSel}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.controlUnit.brSel}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.controlUnit.selWrData}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.controlUnit.selWrData}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.controlUnit.opcode}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.controlUnit.opcode}

set _session_group_95 aluBlock
gui_sg_create "$_session_group_95"
set aluBlock "$_session_group_95"

gui_sg_addsignal -group "$_session_group_95" { cpuStim.testCpu.aluBlock.a cpuStim.testCpu.aluBlock.b cpuStim.testCpu.aluBlock.ALUControl cpuStim.testCpu.aluBlock.Result cpuStim.testCpu.aluBlock.ALUFlags cpuStim.testCpu.aluBlock.temp_op cpuStim.testCpu.aluBlock.carry cpuStim.testCpu.aluBlock.adder_out cpuStim.testCpu.aluBlock.SIZE }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.aluBlock.SIZE}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.aluBlock.SIZE}

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 10529



# Save global setting...

# Wave/List view global setting
gui_cov_show_value -switch false

# Close all empty TopLevel windows
foreach __top [gui_ekki_get_window_ids -type TopLevel] {
    if { [llength [gui_ekki_get_window_ids -parent $__top]] == 0} {
        gui_close_window -window $__top
    }
}
gui_set_loading_session_type noSession
# DVE View/pane content session: 


# Hier 'Hier.1'
gui_show_window -window ${Hier.1}
gui_list_set_filter -id ${Hier.1} -list { {Package 1} {All 0} {Process 1} {VirtPowSwitch 0} {UnnamedProcess 1} {UDP 0} {Function 1} {Block 1} {SrsnAndSpaCell 0} {OVA Unit 1} {LeafScCell 1} {LeafVlgCell 1} {Interface 1} {LeafVhdCell 1} {$unit 1} {NamedBlock 1} {Task 1} {VlgPackage 1} {ClassDef 1} {VirtIsoCell 0} }
gui_list_set_filter -id ${Hier.1} -text {*} -force
gui_change_design -id ${Hier.1} -design V1
catch {gui_list_expand -id ${Hier.1} cpuStim}
catch {gui_list_expand -id ${Hier.1} cpuStim.testCpu}
catch {gui_list_select -id ${Hier.1} {cpuStim.testCpu.instructionMemory}}
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Data 'Data.1'
gui_list_set_filter -id ${Data.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {LowPower 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Data.1} -text {*}
gui_list_show_data -id ${Data.1} {cpuStim.testCpu.instructionMemory}
gui_show_window -window ${Data.1}
catch { gui_list_select -id ${Data.1} {cpuStim.testCpu.instructionMemory.mem }}
gui_view_scroll -id ${Data.1} -vertical -set 0
gui_view_scroll -id ${Data.1} -horizontal -set 0
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Source 'Source.1'
gui_src_value_annotate -id ${Source.1} -switch false
gui_set_env TOGGLE::VALUEANNOTATE 0
gui_open_source -id ${Source.1}  -replace -active cpuControl_testbench /home/nguyea9/ee478/Core/cpuControl.sv
gui_view_scroll -id ${Source.1} -vertical -set 108
gui_src_set_reusable -id ${Source.1}

# View 'Wave.1'
gui_wv_sync -id ${Wave.1} -switch false
set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_wv_zoom_timerange -id ${Wave.1} 0 105000
gui_list_add_group -id ${Wave.1} -after {New Group} {cpuStim_1}
gui_list_add_group -id ${Wave.1} -after {New Group} {registers}
gui_list_add_group -id ${Wave.1} -after {{cpuStim.testCpu.whichMOV[15:0]}} {registers|regWrMux}
gui_list_add_group -id ${Wave.1} -after {New Group} {controlUnit}
gui_list_add_group -id ${Wave.1} -after {New Group} {aluBlock}
gui_list_select -id ${Wave.1} {cpuStim.testCpu.instr }
gui_seek_criteria -id ${Wave.1} {Rising}



gui_set_env TOGGLE::DEFAULT_WAVE_WINDOW ${Wave.1}
gui_set_pref_value -category Wave -key exclusiveSG -value $groupExD
gui_list_set_height -id Wave -height $origWaveHeight
if {$origGroupCreationState} {
	gui_list_create_group_when_add -wave -enable
}
if { $groupExD } {
 gui_msg_report -code DVWW028
}
gui_list_set_filter -id ${Wave.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Wave.1} -text {*}
gui_list_set_insertion_bar  -id ${Wave.1} -group cpuStim_1  -item {cpuStim.testCpu.instr[15:0]} -position below

gui_marker_move -id ${Wave.1} {C1} 10529
gui_view_scroll -id ${Wave.1} -vertical -set 7
gui_show_grid -id ${Wave.1} -enable false
# Restore toplevel window zorder
# The toplevel window could be closed if it has no view/pane
if {[gui_exist_window -window ${TopLevel.1}]} {
	gui_set_active_window -window ${TopLevel.1}
	gui_set_active_window -window ${Source.1}
	gui_set_active_window -window ${DLPane.1}
}
if {[gui_exist_window -window ${TopLevel.2}]} {
	gui_set_active_window -window ${TopLevel.2}
	gui_set_active_window -window ${Wave.1}
}
#</Session>

