# Begin_DVE_Session_Save_Info
# DVE full session
# Saved on Tue May 17 08:18:57 2022
# Designs open: 1
#   V1: vcdplus.vpd
# Toplevel windows open: 2
# 	TopLevel.1
# 	TopLevel.2
#   Wave.1: 48 signals
#   Group count = 11
#   Group cpuControl_testbench signal count = 0
#   Group cpuStim_1 signal count = 5
#   Group registers signal count = 1
#   Group controlUnit signal count = 1
#   Group aluBlock signal count = 9
#   Group registers_1 signal count = 8
#   Group Group1 signal count = 10
#   Group controlUnit_1 signal count = 21
#   Group aluBlock_1 signal count = 9
# End_DVE_Session_Save_Info

# DVE version: S-2021.09-SP1_Full64
# DVE build date: Nov 30 2021 00:09:19


#<Session mode="Full" path="/home/projects/ee478.2022spr/hoppii/BarelyFLOATing/Core/session.vcdplus.vpd.tcl" type="Debug">

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
gui_show_window -window ${TopLevel.1} -show_state maximized -rect {{1283 60} {2556 974}}

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
set HSPane.1 [gui_create_window -type HSPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 358]
catch { set Hier.1 [gui_share_window -id ${HSPane.1} -type Hier] }
gui_set_window_pref_key -window ${HSPane.1} -key dock_width -value_type integer -value 358
gui_set_window_pref_key -window ${HSPane.1} -key dock_height -value_type integer -value -1
gui_set_window_pref_key -window ${HSPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${HSPane.1} {{left 0} {top 0} {width 357} {height 356} {dock_state left} {dock_on_new_line true} {child_hier_colhier 261} {child_hier_coltype 94} {child_hier_colpd 0} {child_hier_col1 0} {child_hier_col2 1} {child_hier_col3 -1}}
set DLPane.1 [gui_create_window -type DLPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 383]
catch { set Data.1 [gui_share_window -id ${DLPane.1} -type Data] }
gui_set_window_pref_key -window ${DLPane.1} -key dock_width -value_type integer -value 383
gui_set_window_pref_key -window ${DLPane.1} -key dock_height -value_type integer -value 500
gui_set_window_pref_key -window ${DLPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${DLPane.1} {{left 0} {top 0} {width 382} {height 356} {dock_state left} {dock_on_new_line true} {child_data_colvariable 194} {child_data_colvalue 105} {child_data_coltype 94} {child_data_col1 0} {child_data_col2 1} {child_data_col3 2}}
set Console.1 [gui_create_window -type Console -parent ${TopLevel.1} -dock_state bottom -dock_on_new_line true -dock_extent 452]
gui_set_window_pref_key -window ${Console.1} -key dock_width -value_type integer -value 755
gui_set_window_pref_key -window ${Console.1} -key dock_height -value_type integer -value 452
gui_set_window_pref_key -window ${Console.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${Console.1} {{left 0} {top 0} {width 1273} {height 451} {dock_state bottom} {dock_on_new_line true}}
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


# Create and position top-level window: TopLevel.2

if {![gui_exist_window -window TopLevel.2]} {
    set TopLevel.2 [ gui_create_window -type TopLevel \
       -icon $::env(DVE)/auxx/gui/images/toolbars/dvewin.xpm] 
} else { 
    set TopLevel.2 TopLevel.2
}
gui_show_window -window ${TopLevel.2} -show_state maximized -rect {{0 60} {2559 977}}

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
gui_update_layout -id ${Wave.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 383} {child_wave_right 2171} {child_wave_colname 195} {child_wave_colvalue 186} {child_wave_col1 0} {child_wave_col2 1}}

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
gui_set_precision 1ps
gui_set_time_units 1ps
#</Database>

# DVE Global setting session: 


# Global: Bus

# Global: Expressions

# Global: Signal Time Shift

# Global: Signal Compare

# Global: Signal Groups
gui_load_child_values {cpuStim.testCpu.controlUnit}
gui_load_child_values {cpuStim.testCpu.aluBlock}


set _session_group_23 cpuControl_testbench
gui_sg_create "$_session_group_23"
set cpuControl_testbench "$_session_group_23"


set _session_group_24 cpuStim_1
gui_sg_create "$_session_group_24"
set cpuStim_1 "$_session_group_24"

gui_sg_addsignal -group "$_session_group_24" { cpuStim.testCpu.clk cpuStim.testCpu.reset cpuStim.testCpu.PC cpuStim.testCpu.PCNext cpuStim.testCpu.instr }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.PC}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.PC}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.PCNext}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.PCNext}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.instr}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.instr}

set _session_group_25 registers
gui_sg_create "$_session_group_25"
set registers "$_session_group_25"

gui_sg_addsignal -group "$_session_group_25" { }

set _session_group_26 $_session_group_25|
append _session_group_26 registers
gui_sg_create "$_session_group_26"
set registers|registers "$_session_group_26"

gui_sg_addsignal -group "$_session_group_26" { cpuStim.testCpu.registers.MEM cpuStim.testCpu.registers.wr_en cpuStim.testCpu.registers.wr_data cpuStim.testCpu.registers.wr_addr cpuStim.testCpu.registers.rd_addr_0 cpuStim.testCpu.registers.rd_addr_1 cpuStim.testCpu.registers.rd_data_0 cpuStim.testCpu.registers.rd_data_1 }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.registers.MEM}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.MEM}

set _session_group_27 controlUnit
gui_sg_create "$_session_group_27"
set controlUnit "$_session_group_27"

gui_sg_addsignal -group "$_session_group_27" { }

set _session_group_28 $_session_group_27|
append _session_group_28 controlUnit
gui_sg_create "$_session_group_28"
set controlUnit|controlUnit "$_session_group_28"

gui_sg_addsignal -group "$_session_group_28" { cpuStim.testCpu.controlUnit.PC cpuStim.testCpu.controlUnit.instr cpuStim.testCpu.controlUnit.FlagsReg cpuStim.testCpu.controlUnit.clk cpuStim.testCpu.controlUnit.reset cpuStim.testCpu.controlUnit.RegWrite cpuStim.testCpu.controlUnit.MemWrite cpuStim.testCpu.controlUnit.MemRead cpuStim.testCpu.controlUnit.noop cpuStim.testCpu.controlUnit.ShiftDir cpuStim.testCpu.controlUnit.keepFlags cpuStim.testCpu.controlUnit.Reg1Loc cpuStim.testCpu.controlUnit.Reg2Loc cpuStim.testCpu.controlUnit.Reg3Loc cpuStim.testCpu.controlUnit.selOpB cpuStim.testCpu.controlUnit.selOpA cpuStim.testCpu.controlUnit.ALUOp cpuStim.testCpu.controlUnit.brSel cpuStim.testCpu.controlUnit.brEx cpuStim.testCpu.controlUnit.selWrData cpuStim.testCpu.controlUnit.opcode }

set _session_group_29 aluBlock
gui_sg_create "$_session_group_29"
set aluBlock "$_session_group_29"

gui_sg_addsignal -group "$_session_group_29" { cpuStim.testCpu.aluBlock.ALUFlags cpuStim.testCpu.aluBlock.Result cpuStim.testCpu.aluBlock.adder_out cpuStim.testCpu.aluBlock.temp_op cpuStim.testCpu.aluBlock.a cpuStim.testCpu.aluBlock.b cpuStim.testCpu.aluBlock.SIZE cpuStim.testCpu.aluBlock.ALUControl cpuStim.testCpu.aluBlock.carry }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.aluBlock.SIZE}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.aluBlock.SIZE}

set _session_group_30 registers_1
gui_sg_create "$_session_group_30"
set registers_1 "$_session_group_30"

gui_sg_addsignal -group "$_session_group_30" { cpuStim.testCpu.registers.MEM cpuStim.testCpu.registers.wr_data cpuStim.testCpu.registers.rd_addr_0 cpuStim.testCpu.registers.rd_addr_1 cpuStim.testCpu.registers.wr_addr cpuStim.testCpu.registers.wr_en cpuStim.testCpu.registers.rd_data_0 cpuStim.testCpu.registers.rd_data_1 }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.registers.MEM}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.registers.MEM}

set _session_group_31 Group1
gui_sg_create "$_session_group_31"
set Group1 "$_session_group_31"

gui_sg_addsignal -group "$_session_group_31" { cpuStim.testCpu.clk cpuStim.testCpu.reset cpuStim.testCpu.PC cpuStim.testCpu.PCNext cpuStim.testCpu.PCE cpuStim.testCpu.PCNext_preStall cpuStim.testCpu.PCPlus1 cpuStim.testCpu.instr cpuStim.testCpu.instrE cpuStim.testCpu.stallF }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.PC}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.PC}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.PCNext}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.PCNext}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.PCE}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.PCE}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.PCNext_preStall}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.PCNext_preStall}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.PCPlus1}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.PCPlus1}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.instr}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.instr}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.instrE}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.instrE}

set _session_group_32 controlUnit_1
gui_sg_create "$_session_group_32"
set controlUnit_1 "$_session_group_32"

gui_sg_addsignal -group "$_session_group_32" { cpuStim.testCpu.controlUnit.Reg1Loc cpuStim.testCpu.controlUnit.PC cpuStim.testCpu.controlUnit.brEx cpuStim.testCpu.controlUnit.Reg2Loc cpuStim.testCpu.controlUnit.ALUOp cpuStim.testCpu.controlUnit.Reg3Loc cpuStim.testCpu.controlUnit.selOpA cpuStim.testCpu.controlUnit.MemRead cpuStim.testCpu.controlUnit.reset cpuStim.testCpu.controlUnit.selOpB cpuStim.testCpu.controlUnit.FlagsReg cpuStim.testCpu.controlUnit.selWrData cpuStim.testCpu.controlUnit.instr cpuStim.testCpu.controlUnit.brSel cpuStim.testCpu.controlUnit.noop cpuStim.testCpu.controlUnit.keepFlags cpuStim.testCpu.controlUnit.MemWrite cpuStim.testCpu.controlUnit.ShiftDir cpuStim.testCpu.controlUnit.clk cpuStim.testCpu.controlUnit.RegWrite cpuStim.testCpu.controlUnit.opcode }

set _session_group_33 aluBlock_1
gui_sg_create "$_session_group_33"
set aluBlock_1 "$_session_group_33"

gui_sg_addsignal -group "$_session_group_33" { cpuStim.testCpu.aluBlock.ALUFlags cpuStim.testCpu.aluBlock.Result cpuStim.testCpu.aluBlock.adder_out cpuStim.testCpu.aluBlock.temp_op cpuStim.testCpu.aluBlock.a cpuStim.testCpu.aluBlock.b cpuStim.testCpu.aluBlock.SIZE cpuStim.testCpu.aluBlock.ALUControl cpuStim.testCpu.aluBlock.carry }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.aluBlock.SIZE}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.aluBlock.SIZE}

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 1499315



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
catch {gui_list_expand -id ${Hier.1} cpuStim}
catch {gui_list_select -id ${Hier.1} {cpuStim.testCpu}}
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Data 'Data.1'
gui_list_set_filter -id ${Data.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {LowPower 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Data.1} -text {*}
gui_list_show_data -id ${Data.1} {cpuStim.testCpu}
gui_show_window -window ${Data.1}
catch { gui_list_select -id ${Data.1} {cpuStim.testCpu.instr cpuStim.testCpu.instrE }}
gui_view_scroll -id ${Data.1} -vertical -set 180
gui_view_scroll -id ${Data.1} -horizontal -set 0
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# View 'Wave.1'
gui_wv_sync -id ${Wave.1} -switch false
set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_marker_set_ref -id ${Wave.1}  C1
gui_wv_zoom_timerange -id ${Wave.1} 0 1035000
gui_list_add_group -id ${Wave.1} -after {New Group} {Group1}
gui_list_add_group -id ${Wave.1} -after {New Group} {registers_1}
gui_list_add_group -id ${Wave.1} -after {New Group} {controlUnit_1}
gui_list_add_group -id ${Wave.1} -after {New Group} {aluBlock_1}
gui_list_expand -id ${Wave.1} cpuStim.testCpu.registers.MEM
gui_list_select -id ${Wave.1} {cpuStim.testCpu.instr cpuStim.testCpu.instrE }
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[14]}}
gui_set_radix -radix decimal -signal {{cpuStim.testCpu.registers.MEM[14]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[14]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[13]}}
gui_set_radix -radix decimal -signal {{cpuStim.testCpu.registers.MEM[13]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[13]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[12]}}
gui_set_radix -radix decimal -signal {{cpuStim.testCpu.registers.MEM[12]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[12]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[11]}}
gui_set_radix -radix decimal -signal {{cpuStim.testCpu.registers.MEM[11]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[11]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[10]}}
gui_set_radix -radix decimal -signal {{cpuStim.testCpu.registers.MEM[10]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[10]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[9]}}
gui_set_radix -radix decimal -signal {{cpuStim.testCpu.registers.MEM[9]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[9]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[8]}}
gui_set_radix -radix decimal -signal {{cpuStim.testCpu.registers.MEM[8]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[8]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[7]}}
gui_set_radix -radix decimal -signal {{cpuStim.testCpu.registers.MEM[7]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[7]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[6]}}
gui_set_radix -radix decimal -signal {{cpuStim.testCpu.registers.MEM[6]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[6]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[5]}}
gui_set_radix -radix decimal -signal {{cpuStim.testCpu.registers.MEM[5]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[5]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[4]}}
gui_set_radix -radix decimal -signal {{cpuStim.testCpu.registers.MEM[4]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[4]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[3]}}
gui_set_radix -radix decimal -signal {{cpuStim.testCpu.registers.MEM[3]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[3]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[2]}}
gui_set_radix -radix decimal -signal {{cpuStim.testCpu.registers.MEM[2]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[2]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[1]}}
gui_set_radix -radix decimal -signal {{cpuStim.testCpu.registers.MEM[1]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[1]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[0]}}
gui_set_radix -radix decimal -signal {{cpuStim.testCpu.registers.MEM[0]}}
gui_set_radix -radix unsigned -signal {{cpuStim.testCpu.registers.MEM[0]}}
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
gui_list_set_insertion_bar  -id ${Wave.1} -group Group1  -item {cpuStim.testCpu.instrE[15:0]} -position below

gui_marker_move -id ${Wave.1} {C1} 1499315
gui_view_scroll -id ${Wave.1} -vertical -set 0
gui_show_grid -id ${Wave.1} -enable false
# Restore toplevel window zorder
# The toplevel window could be closed if it has no view/pane
if {[gui_exist_window -window ${TopLevel.1}]} {
	gui_set_active_window -window ${TopLevel.1}
	gui_set_active_window -window ${DLPane.1}
}
if {[gui_exist_window -window ${TopLevel.2}]} {
	gui_set_active_window -window ${TopLevel.2}
	gui_set_active_window -window ${Wave.1}
}
#</Session>

