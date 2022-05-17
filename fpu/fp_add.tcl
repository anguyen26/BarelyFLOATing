# Begin_DVE_Session_Save_Info
# DVE full session
# Saved on Mon May 9 15:49:28 2022
# Designs open: 1
#   V1: vcdplus.vpd
# Toplevel windows open: 2
# 	TopLevel.1
# 	TopLevel.2
#   Source.1: tb_fp_add
#   Wave.1: 38 signals
#   Group count = 3
#   Group tb_fp_add signal count = 8
#   Group dut signal count = 33
#   Group Group1 signal count = 1
# End_DVE_Session_Save_Info

# DVE version: S-2021.09-SP1_Full64
# DVE build date: Nov 30 2021 00:09:19


#<Session mode="Full" path="/home/nguyea9/ee478/fpu/fp_add.tcl" type="Debug">

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


# Create and position top-level window: TopLevel.1

if {![gui_exist_window -window TopLevel.1]} {
    set TopLevel.1 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.1 TopLevel.1
}
gui_show_window -window ${TopLevel.1} -show_state normal -rect {{0 77} {745 861}}

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
gui_hide_toolbar -toolbar {Testbench}

# End ToolBar settings

# Docked window settings
set HSPane.1 [gui_create_window -type HSPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 365]
catch { set Hier.1 [gui_share_window -id ${HSPane.1} -type Hier] }
gui_set_window_pref_key -window ${HSPane.1} -key dock_width -value_type integer -value 365
gui_set_window_pref_key -window ${HSPane.1} -key dock_height -value_type integer -value -1
gui_set_window_pref_key -window ${HSPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${HSPane.1} {{left 0} {top 0} {width 364} {height 418} {dock_state left} {dock_on_new_line true} {child_hier_colhier 261} {child_hier_coltype 94} {child_hier_colpd 0} {child_hier_col1 0} {child_hier_col2 1} {child_hier_col3 -1}}
set DLPane.1 [gui_create_window -type DLPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 390]
catch { set Data.1 [gui_share_window -id ${DLPane.1} -type Data] }
gui_set_window_pref_key -window ${DLPane.1} -key dock_width -value_type integer -value 390
gui_set_window_pref_key -window ${DLPane.1} -key dock_height -value_type integer -value 418
gui_set_window_pref_key -window ${DLPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${DLPane.1} {{left 0} {top 0} {width 389} {height 418} {dock_state left} {dock_on_new_line true} {child_data_colvariable 194} {child_data_colvalue 105} {child_data_coltype 94} {child_data_col1 0} {child_data_col2 1} {child_data_col3 2}}
set Console.1 [gui_create_window -type Console -parent ${TopLevel.1} -dock_state bottom -dock_on_new_line true -dock_extent 234]
gui_set_window_pref_key -window ${Console.1} -key dock_width -value_type integer -value 746
gui_set_window_pref_key -window ${Console.1} -key dock_height -value_type integer -value 234
gui_set_window_pref_key -window ${Console.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${Console.1} {{left 0} {top 0} {width 745} {height 233} {dock_state bottom} {dock_on_new_line true}}
#### Start - Readjusting docked view's offset / size
set dockAreaList { top left right bottom }
foreach dockArea $dockAreaList {
  set viewList [gui_ekki_get_window_ids -active_parent -dock_area $dockArea]
  foreach view $viewList {
      if {[lsearch -exact [gui_get_window_pref_keys -window $view] dock_width] != -1} {
        set dockWidth [gui_get_window_pref_value -window $view -key dock_width]
        set dockHeight [gui_get_window_pref_value -window $view -key dock_height]
        set offset [gui_get_window_pref_value -window $view -key dock_offset]
        if { [string equal "top" $dockArea] || [string equal "bottom" $dockArea]} {
          gui_set_window_attributes -window $view -dock_offset $offset -width $dockWidth
        } else {
          gui_set_window_attributes -window $view -dock_offset $offset -height $dockHeight
        }
      }
  }
}
#### End - Readjusting docked view's offset / size
gui_sync_global -id ${TopLevel.1} -option true

# MDI window settings
set Source.1 [gui_create_window -type {Source}  -parent ${TopLevel.1}]
gui_show_window -window ${Source.1} -show_state maximized
gui_update_layout -id ${Source.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false}}

# End MDI window settings


# Create and position top-level window: TopLevel.2

if {![gui_exist_window -window TopLevel.2]} {
    set TopLevel.2 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.2 TopLevel.2
}
gui_show_window -window ${TopLevel.2} -show_state normal -rect {{175 103} {957 899}}

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
gui_update_layout -id ${Wave.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 380} {child_wave_right 397} {child_wave_colname 196} {child_wave_colvalue 180} {child_wave_col1 0} {child_wave_col2 1}}

# End MDI window settings

gui_set_env TOPLEVELS::TARGET_FRAME(Source) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(Schematic) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(PathSchematic) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(Wave) none
gui_set_env TOPLEVELS::TARGET_FRAME(List) none
gui_set_env TOPLEVELS::TARGET_FRAME(Memory) ${TopLevel.1}
gui_set_env TOPLEVELS::TARGET_FRAME(DriverLoad) none
gui_update_statusbar_target_frame ${TopLevel.1}
gui_update_statusbar_target_frame ${TopLevel.2}

#</WindowLayout>

#<Database>

# DVE Open design session: 

if { ![gui_is_db_opened -db {vcdplus.vpd}] } {
	gui_open_db -design V1 -file vcdplus.vpd -nosource
}
gui_set_precision 10ps
gui_set_time_units 10ps
#</Database>

# DVE Global setting session: 


# Global: Bus

# Global: Expressions

# Global: Signal Time Shift

# Global: Signal Compare

# Global: Signal Groups
gui_load_child_values {tb_fp_add}
gui_load_child_values {tb_fp_add.dut}


set _session_group_69 tb_fp_add
gui_sg_create "$_session_group_69"
set tb_fp_add "$_session_group_69"

gui_sg_addsignal -group "$_session_group_69" { tb_fp_add.clk tb_fp_add.reset tb_fp_add.opA tb_fp_add.opB tb_fp_add.sum tb_fp_add.underflow tb_fp_add.overflow tb_fp_add.ClockDelay }
gui_set_radix -radix {decimal} -signals {V1:tb_fp_add.ClockDelay}
gui_set_radix -radix {twosComplement} -signals {V1:tb_fp_add.ClockDelay}

set _session_group_70 dut
gui_sg_create "$_session_group_70"
set dut "$_session_group_70"

gui_sg_addsignal -group "$_session_group_70" { tb_fp_add.dut.clk tb_fp_add.dut.reset tb_fp_add.dut.opA tb_fp_add.dut.opB }
gui_sg_addsignal -group "$_session_group_70" { {Exponent stage} } -divider
gui_sg_addsignal -group "$_session_group_70" { tb_fp_add.dut.sA tb_fp_add.dut.sB tb_fp_add.dut.eA tb_fp_add.dut.eB tb_fp_add.dut.mA tb_fp_add.dut.mB tb_fp_add.dut.diffE tb_fp_add.dut.absDiffE tb_fp_add.dut.shiftInput tb_fp_add.dut.sticky tb_fp_add.dut.subtract }
gui_sg_addsignal -group "$_session_group_70" { {Mantissa stage} } -divider
gui_sg_addsignal -group "$_session_group_70" { tb_fp_add.dut.selBigE tb_fp_add.dut.op2 tb_fp_add.dut.shiftOutput }
gui_sg_addsignal -group "$_session_group_70" { {Flag stage} } -divider
gui_sg_addsignal -group "$_session_group_70" { tb_fp_add.dut.cout tb_fp_add.dut.mSum tb_fp_add.dut.bigE tb_fp_add.dut.sumM tb_fp_add.dut.sumE tb_fp_add.dut.finalM tb_fp_add.dut.finalE tb_fp_add.dut.finalS }
gui_sg_addsignal -group "$_session_group_70" { Result } -divider
gui_sg_addsignal -group "$_session_group_70" { tb_fp_add.dut.sum tb_fp_add.dut.underflow tb_fp_add.dut.overflow }
gui_set_radix -radix {binary} -signals {V1:tb_fp_add.dut.opA}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_add.dut.opA}
gui_set_radix -radix {binary} -signals {V1:tb_fp_add.dut.opB}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_add.dut.opB}
gui_set_radix -radix {binary} -signals {V1:tb_fp_add.dut.eA}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_add.dut.eA}
gui_set_radix -radix {binary} -signals {V1:tb_fp_add.dut.eB}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_add.dut.eB}
gui_set_radix -radix {binary} -signals {V1:tb_fp_add.dut.mA}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_add.dut.mA}
gui_set_radix -radix {binary} -signals {V1:tb_fp_add.dut.mB}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_add.dut.mB}
gui_set_radix -radix {decimal} -signals {V1:tb_fp_add.dut.diffE}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_add.dut.diffE}
gui_set_radix -radix {binary} -signals {V1:tb_fp_add.dut.absDiffE}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_add.dut.absDiffE}
gui_set_radix -radix {binary} -signals {V1:tb_fp_add.dut.shiftInput}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_add.dut.shiftInput}
gui_set_radix -radix {binary} -signals {V1:tb_fp_add.dut.op2}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_add.dut.op2}
gui_set_radix -radix {binary} -signals {V1:tb_fp_add.dut.shiftOutput}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_add.dut.shiftOutput}
gui_set_radix -radix {binary} -signals {V1:tb_fp_add.dut.mSum}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_add.dut.mSum}
gui_set_radix -radix {binary} -signals {V1:tb_fp_add.dut.bigE}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_add.dut.bigE}
gui_set_radix -radix {binary} -signals {V1:tb_fp_add.dut.sumM}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_add.dut.sumM}
gui_set_radix -radix {binary} -signals {V1:tb_fp_add.dut.sumE}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_add.dut.sumE}
gui_set_radix -radix {binary} -signals {V1:tb_fp_add.dut.finalM}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_add.dut.finalM}
gui_set_radix -radix {binary} -signals {V1:tb_fp_add.dut.finalE}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_add.dut.finalE}
gui_set_radix -radix {binary} -signals {V1:tb_fp_add.dut.sum}
gui_set_radix -radix {unsigned} -signals {V1:tb_fp_add.dut.sum}

set _session_group_71 Group1
gui_sg_create "$_session_group_71"
set Group1 "$_session_group_71"

gui_sg_addsignal -group "$_session_group_71" { tb_fp_add.dut.inexact }

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 7018568



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
gui_list_set_filter -id ${Hier.1} -text {*}
gui_hier_list_init -id ${Hier.1}
gui_change_design -id ${Hier.1} -design V1
catch {gui_list_expand -id ${Hier.1} tb_fp_add}
catch {gui_list_select -id ${Hier.1} {tb_fp_add.dut}}
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Data 'Data.1'
gui_list_set_filter -id ${Data.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {LowPower 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Data.1} -text {*}
gui_list_show_data -id ${Data.1} {tb_fp_add.dut}
gui_show_window -window ${Data.1}
catch { gui_list_select -id ${Data.1} {tb_fp_add.dut.inexact }}
gui_view_scroll -id ${Data.1} -vertical -set 0
gui_view_scroll -id ${Data.1} -horizontal -set 8
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Source 'Source.1'
gui_src_value_annotate -id ${Source.1} -switch false
gui_set_env TOGGLE::VALUEANNOTATE 0
gui_open_source -id ${Source.1}  -replace -active tb_fp_add tb_fp_add.sv
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
gui_marker_set_ref -id ${Wave.1}  C1
gui_wv_zoom_timerange -id ${Wave.1} 0 10500000
gui_list_add_group -id ${Wave.1} -after {New Group} {tb_fp_add}
gui_list_add_group -id ${Wave.1} -after {New Group} {dut}
gui_list_add_group -id ${Wave.1} -after {New Group} {Group1}
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
gui_list_set_insertion_bar  -id ${Wave.1} -group Group1  -item tb_fp_add.dut.inexact -position below

gui_marker_move -id ${Wave.1} {C1} 7018568
gui_view_scroll -id ${Wave.1} -vertical -set 602
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

