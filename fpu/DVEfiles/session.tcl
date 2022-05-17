# Begin_DVE_Session_Save_Info
# DVE reload session
# Saved on Wed May 11 04:57:32 2022
# Designs open: 1
#   V1: /home/nguyea9/ee478/fpu/vcdplus.vpd
# Toplevel windows open: 2
# 	TopLevel.1
# 	TopLevel.2
#   Source.1: tb_fp_div
#   Wave.1: 61 signals
#   Group count = 3
#   Group tb_fp_div signal count = 12
#   Group dut signal count = 29
#   Group divMantissas signal count = 20
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
gui_update_layout -id ${Wave.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 402} {child_wave_right 546} {child_wave_colname 134} {child_wave_colvalue 264} {child_wave_col1 0} {child_wave_col2 1}}

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
gui_load_child_values {tb_fp_div.dut}
gui_load_child_values {tb_fp_div.dut.divMantissas}
gui_load_child_values {tb_fp_div}


set _session_group_25 tb_fp_div
gui_sg_create "$_session_group_25"
set tb_fp_div "$_session_group_25"

gui_sg_addsignal -group "$_session_group_25" { tb_fp_div.clk tb_fp_div.reset tb_fp_div.start tb_fp_div.opA tb_fp_div.opB tb_fp_div.quotient tb_fp_div.underflow tb_fp_div.overflow tb_fp_div.inexact tb_fp_div.valid tb_fp_div.f tb_fp_div.ClockDelay }
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.opA}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.opA}
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.opB}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.opB}
gui_set_radix -radix {decimal} -signals {V1:tb_fp_div.f}
gui_set_radix -radix {twosComplement} -signals {V1:tb_fp_div.f}
gui_set_radix -radix {decimal} -signals {V1:tb_fp_div.ClockDelay}
gui_set_radix -radix {twosComplement} -signals {V1:tb_fp_div.ClockDelay}

set _session_group_26 dut
gui_sg_create "$_session_group_26"
set dut "$_session_group_26"

gui_sg_addsignal -group "$_session_group_26" { tb_fp_div.dut.clk tb_fp_div.dut.reset tb_fp_div.dut.start tb_fp_div.dut.opA tb_fp_div.dut.opB tb_fp_div.dut.underflow tb_fp_div.dut.overflow tb_fp_div.dut.inexact tb_fp_div.dut.mValid tb_fp_div.dut.valid tb_fp_div.dut.sA tb_fp_div.dut.sB tb_fp_div.dut.sign tb_fp_div.dut.eA tb_fp_div.dut.eB tb_fp_div.dut.eDiff tb_fp_div.dut.biasedEDiff tb_fp_div.dut.mA tb_fp_div.dut.mB tb_fp_div.dut.quotient tb_fp_div.dut.finalE tb_fp_div.dut.finalM tb_fp_div.dut.eSub0 tb_fp_div.dut.eNormal0 tb_fp_div.dut.busy tb_fp_div.dut.dbz tb_fp_div.dut.mQuotient tb_fp_div.dut.r tb_fp_div.dut.shiftAmount }
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.dut.eA}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.eA}
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.dut.eB}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.eB}
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.dut.eDiff}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.eDiff}
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.dut.biasedEDiff}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.biasedEDiff}
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.dut.mA}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.mA}
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.dut.mB}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.mB}
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.dut.quotient}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.quotient}
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.dut.finalE}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.finalE}
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.dut.finalM}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.finalM}
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.dut.mQuotient}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.mQuotient}
gui_set_radix -radix {decimal} -signals {V1:tb_fp_div.dut.shiftAmount}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.shiftAmount}

set _session_group_27 divMantissas
gui_sg_create "$_session_group_27"
set divMantissas "$_session_group_27"

gui_sg_addsignal -group "$_session_group_27" { tb_fp_div.dut.divMantissas.clk tb_fp_div.dut.divMantissas.start tb_fp_div.dut.divMantissas.busy tb_fp_div.dut.divMantissas.valid tb_fp_div.dut.divMantissas.dbz tb_fp_div.dut.divMantissas.ovf tb_fp_div.dut.divMantissas.x tb_fp_div.dut.divMantissas.y tb_fp_div.dut.divMantissas.q tb_fp_div.dut.divMantissas.r tb_fp_div.dut.divMantissas.y1 tb_fp_div.dut.divMantissas.q1 tb_fp_div.dut.divMantissas.q1_next tb_fp_div.dut.divMantissas.ac tb_fp_div.dut.divMantissas.ac_next tb_fp_div.dut.divMantissas.i tb_fp_div.dut.divMantissas.WIDTH tb_fp_div.dut.divMantissas.FBITS tb_fp_div.dut.divMantissas.FBITSW tb_fp_div.dut.divMantissas.ITER }
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.dut.divMantissas.x}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.divMantissas.x}
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.dut.divMantissas.y}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.divMantissas.y}
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.dut.divMantissas.q}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.divMantissas.q}
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.dut.divMantissas.y1}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.divMantissas.y1}
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.dut.divMantissas.q1}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.divMantissas.q1}
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.dut.divMantissas.q1_next}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.divMantissas.q1_next}
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.dut.divMantissas.ac}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.divMantissas.ac}
gui_set_radix -radix {binary} -signals {V1:tb_fp_div.dut.divMantissas.ac_next}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.divMantissas.ac_next}
gui_set_radix -radix {decimal} -signals {V1:tb_fp_div.dut.divMantissas.i}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_div.dut.divMantissas.i}
gui_set_radix -radix {decimal} -signals {V1:tb_fp_div.dut.divMantissas.WIDTH}
gui_set_radix -radix {twosComplement} -signals {V1:tb_fp_div.dut.divMantissas.WIDTH}
gui_set_radix -radix {decimal} -signals {V1:tb_fp_div.dut.divMantissas.FBITS}
gui_set_radix -radix {twosComplement} -signals {V1:tb_fp_div.dut.divMantissas.FBITS}
gui_set_radix -radix {decimal} -signals {V1:tb_fp_div.dut.divMantissas.FBITSW}
gui_set_radix -radix {twosComplement} -signals {V1:tb_fp_div.dut.divMantissas.FBITSW}
gui_set_radix -radix {decimal} -signals {V1:tb_fp_div.dut.divMantissas.ITER}
gui_set_radix -radix {twosComplement} -signals {V1:tb_fp_div.dut.divMantissas.ITER}

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 928574144



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
catch {gui_list_expand -id ${Hier.1} tb_fp_div}
catch {gui_list_select -id ${Hier.1} {tb_fp_div.dut}}
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Data 'Data.1'
gui_list_set_filter -id ${Data.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {LowPower 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Data.1} -text {*}
gui_list_show_data -id ${Data.1} {tb_fp_div.dut}
gui_show_window -window ${Data.1}
catch { gui_list_select -id ${Data.1} {tb_fp_div.dut.eSub0 tb_fp_div.dut.eNormal0 }}
gui_view_scroll -id ${Data.1} -vertical -set 294
gui_view_scroll -id ${Data.1} -horizontal -set 4
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Source 'Source.1'
gui_src_value_annotate -id ${Source.1} -switch false
gui_set_env TOGGLE::VALUEANNOTATE 0
gui_open_source -id ${Source.1}  -replace -active tb_fp_div /home/nguyea9/ee478/fpu/tb_fp_div.sv
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
gui_wv_zoom_timerange -id ${Wave.1} 0 1215000000
gui_list_add_group -id ${Wave.1} -after {New Group} {tb_fp_div}
gui_list_add_group -id ${Wave.1} -after {New Group} {dut}
gui_list_add_group -id ${Wave.1} -after {New Group} {divMantissas}
gui_list_select -id ${Wave.1} {tb_fp_div.dut.eSub0 }
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
gui_list_set_insertion_bar  -id ${Wave.1} -group dut  -item tb_fp_div.dut.eNormal0 -position below

gui_marker_move -id ${Wave.1} {C1} 928574144
gui_view_scroll -id ${Wave.1} -vertical -set 525
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

