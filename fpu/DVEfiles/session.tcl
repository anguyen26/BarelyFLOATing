# Begin_DVE_Session_Save_Info
# DVE reload session
# Saved on Wed May 18 07:02:40 2022
# Designs open: 1
#   V1: /home/nguyea9/ee478/fpu/vcdplus.vpd
# Toplevel windows open: 2
# 	TopLevel.1
# 	TopLevel.2
#   Source.1: fpuStim
#   Wave.1: 76 signals
#   Group count = 3
#   Group fpuStim signal count = 16
#   Group dut signal count = 26
#   Group add_sub signal count = 34
# End_DVE_Session_Save_Info

# DVE version: S-2021.09-SP1_Full64
# DVE build date: Nov 30 2021 00:09:19


#<Session mode="Reload" path="/home/nguyea9/ee478/fpu/DVEfiles/session.tcl" type="Debug">

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
gui_update_layout -id ${Wave.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 496} {child_wave_right 1018} {child_wave_colname 292} {child_wave_colvalue 200} {child_wave_col1 0} {child_wave_col2 1}}

# End MDI window settings


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


set _session_group_13 fpuStim
gui_sg_create "$_session_group_13"
set fpuStim "$_session_group_13"

gui_sg_addsignal -group "$_session_group_13" { fpuStim.clk fpuStim.reset fpuStim.opA fpuStim.opB fpuStim.op fpuStim.start fpuStim.result fpuStim.overflow fpuStim.underflow fpuStim.inexact fpuStim.valid fpuStim.busy fpuStim.address fpuStim.count fpuStim.f fpuStim.ClockDelay }
gui_set_radix -radix {decimal} -signals {V1:fpuStim.f}
gui_set_radix -radix {twosComplement} -signals {V1:fpuStim.f}

set _session_group_14 dut
gui_sg_create "$_session_group_14"
set dut "$_session_group_14"

gui_sg_addsignal -group "$_session_group_14" { fpuStim.dut.result fpuStim.dut.overflow fpuStim.dut.underflow fpuStim.dut.inexact fpuStim.dut.hold_op fpuStim.dut.clk fpuStim.dut.reset fpuStim.dut.opA fpuStim.dut.opB fpuStim.dut.op fpuStim.dut.start fpuStim.dut.valid fpuStim.dut.busy fpuStim.dut.newOpB fpuStim.dut.sum fpuStim.dut.product fpuStim.dut.quotient fpuStim.dut.aUnderflow fpuStim.dut.aOverflow fpuStim.dut.aInexact fpuStim.dut.pUnderflow fpuStim.dut.pOverflow fpuStim.dut.pInexact fpuStim.dut.qUnderflow fpuStim.dut.qOverflow fpuStim.dut.qInexact }

set _session_group_15 add_sub
gui_sg_create "$_session_group_15"
set add_sub "$_session_group_15"

gui_sg_addsignal -group "$_session_group_15" { fpuStim.dut.add_sub.clk fpuStim.dut.add_sub.reset fpuStim.dut.add_sub.opA fpuStim.dut.add_sub.opB fpuStim.dut.add_sub.sum fpuStim.dut.add_sub.underflow fpuStim.dut.add_sub.overflow fpuStim.dut.add_sub.inexact fpuStim.dut.add_sub.sA fpuStim.dut.add_sub.sB fpuStim.dut.add_sub.eA fpuStim.dut.add_sub.eB fpuStim.dut.add_sub.mA fpuStim.dut.add_sub.mB fpuStim.dut.add_sub.diffE fpuStim.dut.add_sub.absDiffE fpuStim.dut.add_sub.shiftInput fpuStim.dut.add_sub.shiftOutput fpuStim.dut.add_sub.op2 fpuStim.dut.add_sub.sticky fpuStim.dut.add_sub.subtract fpuStim.dut.add_sub.diffM fpuStim.dut.add_sub.absDiffM fpuStim.dut.add_sub.mSum fpuStim.dut.add_sub.cout fpuStim.dut.add_sub.selBigE fpuStim.dut.add_sub.finalS fpuStim.dut.add_sub.bigE fpuStim.dut.add_sub.sumM fpuStim.dut.add_sub.sumE fpuStim.dut.add_sub.finalM fpuStim.dut.add_sub.finalE fpuStim.dut.add_sub.addShiftAmount fpuStim.dut.add_sub.subShiftAmount }
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
gui_set_radix -radix {decimal} -signals {V1:fpuStim.dut.add_sub.absDiffM}
gui_set_radix -radix {unsigned} -signals {V1:fpuStim.dut.add_sub.absDiffM}
gui_set_radix -radix {decimal} -signals {V1:fpuStim.dut.add_sub.mSum}
gui_set_radix -radix {unsigned} -signals {V1:fpuStim.dut.add_sub.mSum}
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


# Hier 'Hier.1'
gui_show_window -window ${Hier.1}
gui_list_set_filter -id ${Hier.1} -list { {Package 1} {All 0} {Process 1} {VirtPowSwitch 0} {UnnamedProcess 1} {UDP 0} {Function 1} {Block 1} {SrsnAndSpaCell 0} {OVA Unit 1} {LeafScCell 1} {LeafVlgCell 1} {Interface 1} {LeafVhdCell 1} {$unit 1} {NamedBlock 1} {Task 1} {VlgPackage 1} {ClassDef 1} {VirtIsoCell 0} }
gui_list_set_filter -id ${Hier.1} -text {*} -force
gui_change_design -id ${Hier.1} -design V1
catch {gui_list_expand -id ${Hier.1} fpuStim}
catch {gui_list_expand -id ${Hier.1} fpuStim.dut}
catch {gui_list_select -id ${Hier.1} {fpuStim.dut.add_sub}}
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Data 'Data.1'
gui_list_set_filter -id ${Data.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {LowPower 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Data.1} -text {*}
gui_list_show_data -id ${Data.1} {fpuStim.dut.add_sub}
gui_show_window -window ${Data.1}
catch { gui_list_select -id ${Data.1} {fpuStim.dut.add_sub.diffM fpuStim.dut.add_sub.absDiffM }}
gui_view_scroll -id ${Data.1} -vertical -set 300
gui_view_scroll -id ${Data.1} -horizontal -set 0
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Source 'Source.1'
gui_src_value_annotate -id ${Source.1} -switch false
gui_set_env TOGGLE::VALUEANNOTATE 0
gui_open_source -id ${Source.1}  -replace -active fpuStim /home/nguyea9/ee478/fpu/fpuStim.sv
gui_view_scroll -id ${Source.1} -vertical -set 0
gui_src_set_reusable -id ${Source.1}

# View 'Wave.1'
gui_wv_sync -id ${Wave.1} -switch false
set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_wv_zoom_timerange -id ${Wave.1} 1048795090186 1240357590187
gui_list_add_group -id ${Wave.1} -after {New Group} {fpuStim}
gui_list_add_group -id ${Wave.1} -after {New Group} {dut}
gui_list_add_group -id ${Wave.1} -after {New Group} {add_sub}
gui_list_collapse -id ${Wave.1} dut
gui_list_select -id ${Wave.1} {fpuStim.dut.add_sub.diffM }
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
gui_view_scroll -id ${Wave.1} -vertical -set 576
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

