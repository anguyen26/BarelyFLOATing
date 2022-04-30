# Begin_DVE_Session_Save_Info
# DVE full session
# Saved on Sat Apr 30 00:33:00 2022
# Designs open: 1
#   V1: /home/nguyea9/ee478/Core/vcdplus.vpd
# Toplevel windows open: 1
# 	TopLevel.2
#   Wave.1: 42 signals
#   Group count = 5
#   Group cpuControl_testbench signal count = 20
#   Group cpuStim_1 signal count = 6
#   Group registers signal count = 10
#   Group controlUnit signal count = 21
# End_DVE_Session_Save_Info

# DVE version: S-2021.09-SP1_Full64
# DVE build date: Nov 30 2021 00:09:19


#<Session mode="Full" path="/home/nguyea9/ee478/Core/DVEfiles/session.tcl" type="Debug">

gui_set_loading_session_type Post
gui_continuetime_set

# Close design
if { [gui_sim_state -check active] } {
    gui_sim_terminate
}
gui_close_db -all
gui_expr_clear_all

# Close all windows
gui_close_window -type Console
gui_close_window -type Wave
gui_close_window -type Source
gui_close_window -type Schematic
gui_close_window -type Data
gui_close_window -type DriverLoad
gui_close_window -type List
gui_close_window -type Memory
gui_close_window -type HSPane
gui_close_window -type DLPane
gui_close_window -type Assertion
gui_close_window -type CovHier
gui_close_window -type CoverageTable
gui_close_window -type CoverageMap
gui_close_window -type CovDetail
gui_close_window -type Local
gui_close_window -type Stack
gui_close_window -type Watch
gui_close_window -type Group
gui_close_window -type Transaction



# Application preferences
gui_set_pref_value -key app_default_font -value {Helvetica,10,-1,5,50,0,0,0,0,0}
gui_src_preferences -tabstop 8 -maxbits 24 -windownumber 1
#<WindowLayout>

# DVE top-level session


# Create and position top-level window: TopLevel.2

if {![gui_exist_window -window TopLevel.2]} {
    set TopLevel.2 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.2 TopLevel.2
}
gui_show_window -window ${TopLevel.2} -show_state normal -rect {{763 68} {1519 861}}

# ToolBar settings
gui_set_toolbar_attributes -toolbar {TimeOperations} -dock_state top
gui_set_toolbar_attributes -toolbar {TimeOperations} -offset 0
gui_show_toolbar -toolbar {TimeOperations}
gui_hide_toolbar -toolbar {&File}
gui_set_toolbar_attributes -toolbar {&Edit} -dock_state top
gui_set_toolbar_attributes -toolbar {&Edit} -offset 0
gui_show_toolbar -toolbar {&Edit}
gui_hide_toolbar -toolbar {CopyPaste}
gui_set_toolbar_attributes -toolbar {&Trace} -dock_state top
gui_set_toolbar_attributes -toolbar {&Trace} -offset 0
gui_show_toolbar -toolbar {&Trace}
gui_hide_toolbar -toolbar {TraceInstance}
gui_hide_toolbar -toolbar {BackTrace}
gui_set_toolbar_attributes -toolbar {&Scope} -dock_state top
gui_set_toolbar_attributes -toolbar {&Scope} -offset 0
gui_show_toolbar -toolbar {&Scope}
gui_set_toolbar_attributes -toolbar {&Window} -dock_state top
gui_set_toolbar_attributes -toolbar {&Window} -offset 0
gui_show_toolbar -toolbar {&Window}
gui_set_toolbar_attributes -toolbar {Signal} -dock_state top
gui_set_toolbar_attributes -toolbar {Signal} -offset 0
gui_show_toolbar -toolbar {Signal}
gui_set_toolbar_attributes -toolbar {Zoom} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom} -offset 0
gui_show_toolbar -toolbar {Zoom}
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -dock_state top
gui_set_toolbar_attributes -toolbar {Zoom And Pan History} -offset 0
gui_show_toolbar -toolbar {Zoom And Pan History}
gui_set_toolbar_attributes -toolbar {Grid} -dock_state top
gui_set_toolbar_attributes -toolbar {Grid} -offset 0
gui_show_toolbar -toolbar {Grid}
gui_hide_toolbar -toolbar {Simulator}
gui_hide_toolbar -toolbar {Interactive Rewind}
gui_set_toolbar_attributes -toolbar {Testbench} -dock_state top
gui_set_toolbar_attributes -toolbar {Testbench} -offset 0
gui_show_toolbar -toolbar {Testbench}

# End ToolBar settings

# Docked window settings
gui_sync_global -id ${TopLevel.2} -option true

# MDI window settings
set Wave.1 [gui_create_window -type {Wave}  -parent ${TopLevel.2}]
gui_show_window -window ${Wave.1} -show_state maximized
gui_update_layout -id ${Wave.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 370} {child_wave_right 381} {child_wave_colname 209} {child_wave_colvalue 154} {child_wave_col1 0} {child_wave_col2 1}}

# End MDI window settings

gui_set_env TOPLEVELS::TARGET_FRAME(Source) none
gui_set_env TOPLEVELS::TARGET_FRAME(Schematic) none
gui_set_env TOPLEVELS::TARGET_FRAME(PathSchematic) none
gui_set_env TOPLEVELS::TARGET_FRAME(Wave) none
gui_set_env TOPLEVELS::TARGET_FRAME(List) none
gui_set_env TOPLEVELS::TARGET_FRAME(Memory) none
gui_set_env TOPLEVELS::TARGET_FRAME(DriverLoad) none
gui_update_statusbar_target_frame ${TopLevel.2}

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
gui_load_child_values {cpuStim}
gui_load_child_values {cpuStim.testCpu.regWrMux}
gui_load_child_values {cpuStim.testCpu.controlUnit}
gui_load_child_values {cpuControl_testbench}
gui_load_child_values {cpuStim.testCpu.registers}


set _session_group_6 cpuControl_testbench
gui_sg_create "$_session_group_6"
set cpuControl_testbench "$_session_group_6"

gui_sg_addsignal -group "$_session_group_6" { cpuControl_testbench.instr cpuControl_testbench.negative cpuControl_testbench.zero cpuControl_testbench.overflow cpuControl_testbench.alu_zero cpuControl_testbench.clk cpuControl_testbench.reset cpuControl_testbench.Reg2Loc cpuControl_testbench.RegWrite cpuControl_testbench.MemWrite cpuControl_testbench.MemRead cpuControl_testbench.MemToReg cpuControl_testbench.BrTaken cpuControl_testbench.UncondBr cpuControl_testbench.ALUSrc cpuControl_testbench.ShiftDir cpuControl_testbench.nineOrTwelve cpuControl_testbench.keepFlags cpuControl_testbench.ALUOp cpuControl_testbench.calcSrc }

set _session_group_7 cpuStim_1
gui_sg_create "$_session_group_7"
set cpuStim_1 "$_session_group_7"

gui_sg_addsignal -group "$_session_group_7" { cpuStim.ClockDelay cpuStim.clk cpuStim.reset cpuStim.testCpu.PC cpuStim.testCpu.PCNext cpuStim.testCpu.instr }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.ClockDelay}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.ClockDelay}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.PC}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.PC}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.PCNext}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.PCNext}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.instr}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.instr}

set _session_group_8 registers
gui_sg_create "$_session_group_8"
set registers "$_session_group_8"

gui_sg_addsignal -group "$_session_group_8" { cpuStim.testCpu.registers.wr_data cpuStim.testCpu.registers.rd_addr_0 cpuStim.testCpu.registers.rd_addr_1 cpuStim.testCpu.registers.wr_addr cpuStim.testCpu.registers.wr_en cpuStim.testCpu.registers.rd_data_0 cpuStim.testCpu.registers.rd_data_1 cpuStim.testCpu.registers.MEM cpuStim.testCpu.registers.clk }
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.registers.wr_data}
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
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.registers.MEM}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.MEM}

set _session_group_9 $_session_group_8|
append _session_group_9 regWrMux
gui_sg_create "$_session_group_9"
set registers|regWrMux "$_session_group_9"

gui_sg_addsignal -group "$_session_group_9" { cpuStim.testCpu.regWrMux.i0 cpuStim.testCpu.regWrMux.i1 cpuStim.testCpu.regWrMux.i2 cpuStim.testCpu.regWrMux.i3 cpuStim.testCpu.regWrMux.sel cpuStim.testCpu.regWrMux.out }

set _session_group_10 controlUnit
gui_sg_create "$_session_group_10"
set controlUnit "$_session_group_10"

gui_sg_addsignal -group "$_session_group_10" { cpuStim.testCpu.controlUnit.PC cpuStim.testCpu.controlUnit.instr cpuStim.testCpu.controlUnit.FlagsReg cpuStim.testCpu.controlUnit.clk cpuStim.testCpu.controlUnit.reset cpuStim.testCpu.controlUnit.RegWrite cpuStim.testCpu.controlUnit.MemWrite cpuStim.testCpu.controlUnit.MemRead cpuStim.testCpu.controlUnit.ShiftDir cpuStim.testCpu.controlUnit.noop cpuStim.testCpu.controlUnit.keepFlags cpuStim.testCpu.controlUnit.Reg1Loc cpuStim.testCpu.controlUnit.Reg2Loc cpuStim.testCpu.controlUnit.Reg3Loc cpuStim.testCpu.controlUnit.selOpB cpuStim.testCpu.controlUnit.selOpA cpuStim.testCpu.controlUnit.ALUOp cpuStim.testCpu.controlUnit.brSel cpuStim.testCpu.controlUnit.brEx cpuStim.testCpu.controlUnit.selWrData cpuStim.testCpu.controlUnit.opcode }

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 9165



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


# View 'Wave.1'
gui_wv_sync -id ${Wave.1} -switch false
set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_marker_set_ref -id ${Wave.1}  C1
gui_wv_zoom_timerange -id ${Wave.1} 0 42533
gui_list_add_group -id ${Wave.1} -after {New Group} {cpuStim_1}
gui_list_add_group -id ${Wave.1} -after {New Group} {registers}
gui_list_add_group -id ${Wave.1}  -after registers {registers|regWrMux}
gui_list_add_group -id ${Wave.1} -after {New Group} {controlUnit}
gui_list_select -id ${Wave.1} {cpuStim.testCpu.registers.clk }
gui_seek_criteria -id ${Wave.1} {Any Edge}



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
gui_list_set_insertion_bar  -id ${Wave.1} -group registers  -position below

gui_marker_move -id ${Wave.1} {C1} 9165
gui_view_scroll -id ${Wave.1} -vertical -set 150
gui_show_grid -id ${Wave.1} -enable false
# Restore toplevel window zorder
# The toplevel window could be closed if it has no view/pane
if {[gui_exist_window -window ${TopLevel.2}]} {
	gui_set_active_window -window ${TopLevel.2}
	gui_set_active_window -window ${Wave.1}
}
#</Session>

