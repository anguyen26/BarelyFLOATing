# Begin_DVE_Session_Save_Info
# DVE full session
# Saved on Wed May 18 21:27:51 2022
# Designs open: 1
#   V1: /home/nguyea9/ee478/fpu/vcdplus.vpd
# Toplevel windows open: 1
# 	TopLevel.2
#   Wave.1: 76 signals
#   Group count = 3
#   Group fpuStim signal count = 16
#   Group dut signal count = 26
#   Group add_sub signal count = 34
# End_DVE_Session_Save_Info

# DVE version: S-2021.09-SP1_Full64
# DVE build date: Nov 30 2021 00:09:19


#<Session mode="Full" path="/home/nguyea9/ee478/fpu/DVEfiles/session.tcl" type="Debug">

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
gui_show_window -window ${TopLevel.2} -show_state maximized -rect {{728 71} {2247 867}}

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
gui_update_layout -id ${Wave.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 496} {child_wave_right 1018} {child_wave_colname 292} {child_wave_colvalue 200} {child_wave_col1 0} {child_wave_col2 1}}

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

if { ![gui_is_db_opened -db {/home/nguyea9/ee478/fpu/vcdplus.vpd}] } {
	gui_open_db -design V1 -file /home/nguyea9/ee478/fpu/vcdplus.vpd -nosource
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
gui_load_child_values {fpuStim.dut}
gui_load_child_values {fpuStim.dut.add_sub}
gui_load_child_values {fpuStim}


set _session_group_16 fpuStim
gui_sg_create "$_session_group_16"
set fpuStim "$_session_group_16"

gui_sg_addsignal -group "$_session_group_16" { fpuStim.clk fpuStim.reset fpuStim.opA fpuStim.opB fpuStim.op fpuStim.start fpuStim.result fpuStim.overflow fpuStim.underflow fpuStim.inexact fpuStim.valid fpuStim.busy fpuStim.address fpuStim.count fpuStim.f fpuStim.ClockDelay }

set _session_group_17 dut
gui_sg_create "$_session_group_17"
set dut "$_session_group_17"

gui_sg_addsignal -group "$_session_group_17" { fpuStim.dut.result fpuStim.dut.overflow fpuStim.dut.underflow fpuStim.dut.inexact fpuStim.dut.hold_op fpuStim.dut.clk fpuStim.dut.reset fpuStim.dut.opA fpuStim.dut.opB fpuStim.dut.op fpuStim.dut.start fpuStim.dut.valid fpuStim.dut.busy fpuStim.dut.newOpB fpuStim.dut.sum fpuStim.dut.product fpuStim.dut.quotient fpuStim.dut.aUnderflow fpuStim.dut.aOverflow fpuStim.dut.aInexact fpuStim.dut.pUnderflow fpuStim.dut.pOverflow fpuStim.dut.pInexact fpuStim.dut.qUnderflow fpuStim.dut.qOverflow fpuStim.dut.qInexact }

set _session_group_18 add_sub
gui_sg_create "$_session_group_18"
set add_sub "$_session_group_18"

gui_sg_addsignal -group "$_session_group_18" { fpuStim.dut.add_sub.clk fpuStim.dut.add_sub.reset fpuStim.dut.add_sub.opA fpuStim.dut.add_sub.opB fpuStim.dut.add_sub.sum fpuStim.dut.add_sub.underflow fpuStim.dut.add_sub.overflow fpuStim.dut.add_sub.inexact fpuStim.dut.add_sub.sA fpuStim.dut.add_sub.sB fpuStim.dut.add_sub.eA fpuStim.dut.add_sub.eB fpuStim.dut.add_sub.mA fpuStim.dut.add_sub.mB fpuStim.dut.add_sub.diffE fpuStim.dut.add_sub.absDiffE fpuStim.dut.add_sub.shiftInput fpuStim.dut.add_sub.shiftOutput fpuStim.dut.add_sub.op2 fpuStim.dut.add_sub.sticky fpuStim.dut.add_sub.subtract fpuStim.dut.add_sub.diffM fpuStim.dut.add_sub.absDiffM fpuStim.dut.add_sub.mSum fpuStim.dut.add_sub.cout fpuStim.dut.add_sub.selBigE fpuStim.dut.add_sub.finalS fpuStim.dut.add_sub.bigE fpuStim.dut.add_sub.sumM fpuStim.dut.add_sub.sumE fpuStim.dut.add_sub.finalM fpuStim.dut.add_sub.finalE fpuStim.dut.add_sub.addShiftAmount fpuStim.dut.add_sub.subShiftAmount }
gui_set_radix -radix {binary} -signals {V1:fpuStim.dut.add_sub.opA}
gui_set_radix -radix {unsigned} -signals {V1:fpuStim.dut.add_sub.opA}
gui_set_radix -radix {binary} -signals {V1:fpuStim.dut.add_sub.opB}
gui_set_radix -radix {unsigned} -signals {V1:fpuStim.dut.add_sub.opB}
gui_set_radix -radix {decimal} -signals {V1:fpuStim.dut.add_sub.eA}
gui_set_radix -radix {unsigned} -signals {V1:fpuStim.dut.add_sub.eA}
gui_set_radix -radix {decimal} -signals {V1:fpuStim.dut.add_sub.eB}
gui_set_radix -radix {unsigned} -signals {V1:fpuStim.dut.add_sub.eB}
gui_set_radix -radix {binary} -signals {V1:fpuStim.dut.add_sub.mA}
gui_set_radix -radix {unsigned} -signals {V1:fpuStim.dut.add_sub.mA}
gui_set_radix -radix {binary} -signals {V1:fpuStim.dut.add_sub.mB}
gui_set_radix -radix {unsigned} -signals {V1:fpuStim.dut.add_sub.mB}
gui_set_radix -radix {decimal} -signals {V1:fpuStim.dut.add_sub.diffE}
gui_set_radix -radix {unsigned} -signals {V1:fpuStim.dut.add_sub.diffE}
gui_set_radix -radix {decimal} -signals {V1:fpuStim.dut.add_sub.absDiffE}
gui_set_radix -radix {unsigned} -signals {V1:fpuStim.dut.add_sub.absDiffE}
gui_set_radix -radix {binary} -signals {V1:fpuStim.dut.add_sub.shiftInput}
gui_set_radix -radix {unsigned} -signals {V1:fpuStim.dut.add_sub.shiftInput}
gui_set_radix -radix {decimal} -signals {V1:fpuStim.dut.add_sub.shiftOutput}
gui_set_radix -radix {unsigned} -signals {V1:fpuStim.dut.add_sub.shiftOutput}
gui_set_radix -radix {decimal} -signals {V1:fpuStim.dut.add_sub.op2}
gui_set_radix -radix {unsigned} -signals {V1:fpuStim.dut.add_sub.op2}
gui_set_radix -radix {binary} -signals {V1:fpuStim.dut.add_sub.diffM}
gui_set_radix -radix {unsigned} -signals {V1:fpuStim.dut.add_sub.diffM}
gui_set_radix -radix {binary} -signals {V1:fpuStim.dut.add_sub.absDiffM}
gui_set_radix -radix {unsigned} -signals {V1:fpuStim.dut.add_sub.absDiffM}
gui_set_radix -radix {decimal} -signals {V1:fpuStim.dut.add_sub.mSum}
gui_set_radix -radix {unsigned} -signals {V1:fpuStim.dut.add_sub.mSum}
gui_set_radix -radix {binary} -signals {V1:fpuStim.dut.add_sub.sumM}
gui_set_radix -radix {unsigned} -signals {V1:fpuStim.dut.add_sub.sumM}
gui_set_radix -radix {decimal} -signals {V1:fpuStim.dut.add_sub.subShiftAmount}
gui_set_radix -radix {unsigned} -signals {V1:fpuStim.dut.add_sub.subShiftAmount}

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 1119239416339



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
gui_wv_zoom_timerange -id ${Wave.1} 1048795090186 1240357590187
gui_list_add_group -id ${Wave.1} -after {New Group} {fpuStim}
gui_list_add_group -id ${Wave.1} -after {New Group} {dut}
gui_list_add_group -id ${Wave.1} -after {New Group} {add_sub}
gui_list_collapse -id ${Wave.1} dut
gui_list_select -id ${Wave.1} {fpuStim.dut.add_sub.sumM }
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
gui_list_set_insertion_bar  -id ${Wave.1} -group add_sub  -item {fpuStim.dut.add_sub.absDiffM[7:0]} -position below

gui_marker_move -id ${Wave.1} {C1} 1119239416339
gui_view_scroll -id ${Wave.1} -vertical -set 776
gui_show_grid -id ${Wave.1} -enable false
# Restore toplevel window zorder
# The toplevel window could be closed if it has no view/pane
if {[gui_exist_window -window ${TopLevel.2}]} {
	gui_set_active_window -window ${TopLevel.2}
	gui_set_active_window -window ${Wave.1}
}
#</Session>

