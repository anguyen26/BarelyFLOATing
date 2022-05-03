# Begin_DVE_Session_Save_Info
# DVE full session
# Saved on Mon May 2 00:36:11 2022
# Designs open: 1
#   V1: vcdplus.vpd
# Toplevel windows open: 2
# 	TopLevel.1
# 	TopLevel.2
#   Wave.1: 72 signals
#   Group count = 8
#   Group cpuControl_testbench signal count = 20
#   Group cpuStim_1 signal count = 9
#   Group registers signal count = 12
#   Group controlUnit signal count = 21
#   Group aluBlock signal count = 14
#   Group Group1 signal count = 5
#   Group Group2 signal count = 6
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
gui_show_window -window ${TopLevel.1} -show_state minimized -rect {{526 187} {1274 974}}

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
set HSPane.1 [gui_create_window -type HSPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 368]
catch { set Hier.1 [gui_share_window -id ${HSPane.1} -type Hier] }
gui_set_window_pref_key -window ${HSPane.1} -key dock_width -value_type integer -value 368
gui_set_window_pref_key -window ${HSPane.1} -key dock_height -value_type integer -value -1
gui_set_window_pref_key -window ${HSPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${HSPane.1} {{left 0} {top 0} {width 367} {height 500} {dock_state left} {dock_on_new_line true} {child_hier_colhier 255} {child_hier_coltype 88} {child_hier_colpd 0} {child_hier_col1 0} {child_hier_col2 1} {child_hier_col3 -1}}
set DLPane.1 [gui_create_window -type DLPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 393]
catch { set Data.1 [gui_share_window -id ${DLPane.1} -type Data] }
gui_set_window_pref_key -window ${DLPane.1} -key dock_width -value_type integer -value 393
gui_set_window_pref_key -window ${DLPane.1} -key dock_height -value_type integer -value 500
gui_set_window_pref_key -window ${DLPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${DLPane.1} {{left 0} {top 0} {width 392} {height 500} {dock_state left} {dock_on_new_line true} {child_data_colvariable 194} {child_data_colvalue 105} {child_data_coltype 94} {child_data_col1 0} {child_data_col2 1} {child_data_col3 2}}
set Console.1 [gui_create_window -type Console -parent ${TopLevel.1} -dock_state bottom -dock_on_new_line true -dock_extent 155]
gui_set_window_pref_key -window ${Console.1} -key dock_width -value_type integer -value 755
gui_set_window_pref_key -window ${Console.1} -key dock_height -value_type integer -value 155
gui_set_window_pref_key -window ${Console.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${Console.1} {{left 0} {top 0} {width 748} {height 154} {dock_state bottom} {dock_on_new_line true}}
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
gui_show_window -window ${TopLevel.2} -show_state maximized -rect {{3 60} {1276 974}}

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
gui_update_layout -id ${Wave.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 409} {child_wave_right 859} {child_wave_colname 152} {child_wave_colvalue 253} {child_wave_col1 0} {child_wave_col2 1}}

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
gui_load_child_values {cpuStim.testCpu}
gui_load_child_values {cpuStim}
gui_load_child_values {cpuStim.testCpu.regWrMux}
gui_load_child_values {cpuStim.testCpu.regWriteMux}
gui_load_child_values {cpuStim.testCpu.instructionMemory}
gui_load_child_values {cpuStim.testCpu.controlUnit}
gui_load_child_values {cpuControl_testbench}
gui_load_child_values {cpuStim.testCpu.aluBlock}
gui_load_child_values {cpuStim.testCpu.registers}


set _session_group_1 cpuControl_testbench
gui_sg_create "$_session_group_1"
set cpuControl_testbench "$_session_group_1"

gui_sg_addsignal -group "$_session_group_1" { cpuControl_testbench.instr cpuControl_testbench.negative cpuControl_testbench.zero cpuControl_testbench.overflow cpuControl_testbench.alu_zero cpuControl_testbench.clk cpuControl_testbench.reset cpuControl_testbench.Reg2Loc cpuControl_testbench.RegWrite cpuControl_testbench.MemWrite cpuControl_testbench.MemRead cpuControl_testbench.MemToReg cpuControl_testbench.BrTaken cpuControl_testbench.UncondBr cpuControl_testbench.ALUSrc cpuControl_testbench.ShiftDir cpuControl_testbench.nineOrTwelve cpuControl_testbench.keepFlags cpuControl_testbench.ALUOp cpuControl_testbench.calcSrc }

set _session_group_2 cpuStim_1
gui_sg_create "$_session_group_2"
set cpuStim_1 "$_session_group_2"

gui_sg_addsignal -group "$_session_group_2" { cpuStim.ClockDelay cpuStim.clk cpuStim.reset cpuStim.testCpu.PC cpuStim.testCpu.PCNext cpuStim.testCpu.instr cpuStim.testCpu.linkBrAddr cpuStim.testCpu.brExcAddr cpuStim.testCpu.shiftedBranchAddr }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.ClockDelay}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.ClockDelay}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.PC}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.PC}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.PCNext}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.PCNext}
gui_set_radix -radix {binary} -signals {V1:cpuStim.testCpu.instr}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.instr}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.linkBrAddr}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.linkBrAddr}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.brExcAddr}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.brExcAddr}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.shiftedBranchAddr}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.shiftedBranchAddr}

set _session_group_3 registers
gui_sg_create "$_session_group_3"
set registers "$_session_group_3"

gui_sg_addsignal -group "$_session_group_3" { cpuStim.testCpu.whichMOV cpuStim.testCpu.registers.wr_data cpuStim.testCpu.registers.rd_addr_0 cpuStim.testCpu.registers.rd_addr_1 cpuStim.testCpu.registers.wr_addr cpuStim.testCpu.regWriteAddr cpuStim.testCpu.registers.wr_en cpuStim.testCpu.registers.rd_data_0 cpuStim.testCpu.registers.rd_data_1 cpuStim.testCpu.registers.MEM cpuStim.testCpu.registers.clk }
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

set _session_group_4 $_session_group_3|
append _session_group_4 regWrMux
gui_sg_create "$_session_group_4"
set registers|regWrMux "$_session_group_4"

gui_sg_addsignal -group "$_session_group_4" { cpuStim.testCpu.regWrMux.i0 cpuStim.testCpu.regWrMux.i1 cpuStim.testCpu.regWrMux.i2 cpuStim.testCpu.regWrMux.i3 cpuStim.testCpu.regWrMux.sel cpuStim.testCpu.regWrMux.out }
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

gui_sg_move "$_session_group_4" -after "$_session_group_3" -pos 1 

set _session_group_5 controlUnit
gui_sg_create "$_session_group_5"
set controlUnit "$_session_group_5"

gui_sg_addsignal -group "$_session_group_5" { cpuStim.testCpu.controlUnit.PC cpuStim.testCpu.controlUnit.instr cpuStim.testCpu.controlUnit.FlagsReg cpuStim.testCpu.controlUnit.clk cpuStim.testCpu.controlUnit.reset cpuStim.testCpu.controlUnit.RegWrite cpuStim.testCpu.controlUnit.MemWrite cpuStim.testCpu.controlUnit.MemRead cpuStim.testCpu.controlUnit.ShiftDir cpuStim.testCpu.controlUnit.noop cpuStim.testCpu.controlUnit.keepFlags cpuStim.testCpu.controlUnit.Reg1Loc cpuStim.testCpu.controlUnit.Reg2Loc cpuStim.testCpu.controlUnit.Reg3Loc cpuStim.testCpu.controlUnit.selOpB cpuStim.testCpu.controlUnit.selOpA cpuStim.testCpu.controlUnit.ALUOp cpuStim.testCpu.controlUnit.brSel cpuStim.testCpu.controlUnit.brEx cpuStim.testCpu.controlUnit.selWrData cpuStim.testCpu.controlUnit.opcode }
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

set _session_group_6 aluBlock
gui_sg_create "$_session_group_6"
set aluBlock "$_session_group_6"

gui_sg_addsignal -group "$_session_group_6" { cpuStim.testCpu.aluBlock.a cpuStim.testCpu.aluBlock.b cpuStim.testCpu.aluBlock.ALUControl cpuStim.testCpu.aluBlock.Result cpuStim.testCpu.aluBlock.ALUFlags cpuStim.testCpu.aluBlock.temp_op cpuStim.testCpu.aluBlock.carry cpuStim.testCpu.aluBlock.adder_out cpuStim.testCpu.aluBlock.SIZE cpuStim.testCpu.instructionMemory.address cpuStim.testCpu.instructionMemory.instruction cpuStim.testCpu.instructionMemory.clk cpuStim.testCpu.instructionMemory.i cpuStim.testCpu.instructionMemory.mem }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.aluBlock.SIZE}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.aluBlock.SIZE}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.instructionMemory.address}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.instructionMemory.address}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.instructionMemory.i}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.instructionMemory.i}

set _session_group_7 Group1
gui_sg_create "$_session_group_7"
set Group1 "$_session_group_7"

gui_sg_addsignal -group "$_session_group_7" { cpuStim.testCpu.instructionMemory.address cpuStim.testCpu.instructionMemory.instruction cpuStim.testCpu.instructionMemory.clk cpuStim.testCpu.instructionMemory.i cpuStim.testCpu.instructionMemory.mem }
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.instructionMemory.address}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim.testCpu.instructionMemory.address}
gui_set_radix -radix {decimal} -signals {V1:cpuStim.testCpu.instructionMemory.i}
gui_set_radix -radix {twosComplement} -signals {V1:cpuStim.testCpu.instructionMemory.i}

set _session_group_8 Group2
gui_sg_create "$_session_group_8"
set Group2 "$_session_group_8"

gui_sg_addsignal -group "$_session_group_8" { cpuStim.testCpu.regWriteMux.i0 cpuStim.testCpu.regWriteMux.i1 cpuStim.testCpu.regWriteMux.i2 cpuStim.testCpu.regWriteMux.i3 cpuStim.testCpu.regWriteMux.sel cpuStim.testCpu.regWriteMux.out }

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 97304



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
catch {gui_list_expand -id ${Hier.1} cpuStim.testCpu}
catch {gui_list_select -id ${Hier.1} {cpuStim.testCpu.regWriteMux}}
gui_view_scroll -id ${Hier.1} -vertical -set 96
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Data 'Data.1'
gui_list_set_filter -id ${Data.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {LowPower 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Data.1} -text {*}
gui_list_show_data -id ${Data.1} {cpuStim.testCpu.regWriteMux}
gui_show_window -window ${Data.1}
catch { gui_list_select -id ${Data.1} {cpuStim.testCpu.regWriteMux.i0 cpuStim.testCpu.regWriteMux.i1 cpuStim.testCpu.regWriteMux.i2 cpuStim.testCpu.regWriteMux.i3 cpuStim.testCpu.regWriteMux.sel cpuStim.testCpu.regWriteMux.out }}
gui_view_scroll -id ${Data.1} -vertical -set 0
gui_view_scroll -id ${Data.1} -horizontal -set 0
gui_view_scroll -id ${Hier.1} -vertical -set 96
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
gui_wv_zoom_timerange -id ${Wave.1} 19190 113897
gui_list_add_group -id ${Wave.1} -after {New Group} {cpuStim_1}
gui_list_add_group -id ${Wave.1} -after {New Group} {registers}
gui_list_add_group -id ${Wave.1} -after {{cpuStim.testCpu.whichMOV[15:0]}} {registers|regWrMux}
gui_list_add_group -id ${Wave.1} -after {New Group} {controlUnit}
gui_list_add_group -id ${Wave.1} -after {New Group} {aluBlock}
gui_list_add_group -id ${Wave.1} -after {New Group} {Group1}
gui_list_add_group -id ${Wave.1} -after {New Group} {Group2}
gui_list_collapse -id ${Wave.1} registers|regWrMux
gui_list_expand -id ${Wave.1} cpuStim.testCpu.registers.MEM
gui_list_select -id ${Wave.1} {cpuStim.testCpu.regWriteMux.out }
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
gui_list_set_insertion_bar  -id ${Wave.1} -group Group2  -item {cpuStim.testCpu.regWriteMux.out[3:0]} -position below

gui_marker_move -id ${Wave.1} {C1} 97304
gui_view_scroll -id ${Wave.1} -vertical -set 1533
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

