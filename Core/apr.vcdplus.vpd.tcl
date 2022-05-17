# Begin_DVE_Session_Save_Info
# DVE full session
# Saved on Sat May 14 19:34:58 2022
# Designs open: 1
#   V1: vcdplus.vpd
# Toplevel windows open: 2
# 	TopLevel.1
# 	TopLevel.2
#   Source.1: 
#   Wave.1: 19 signals
#   Group count = 3
#   Group Group1 signal count = 0
#   Group Top signal count = 3
#   Group Regfile signal count = 16
# End_DVE_Session_Save_Info

# DVE version: S-2021.09-SP1_Full64
# DVE build date: Nov 30 2021 00:09:19


#<Session mode="Full" path="/home/projects/ee478.2022spr/hoppii/BarelyFLOATing/Core/apr.vcdplus.vpd.tcl" type="Debug">

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
gui_show_window -window ${TopLevel.1} -show_state normal -rect {{1288 65} {2556 974}}

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
set HSPane.1 [gui_create_window -type HSPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 357]
catch { set Hier.1 [gui_share_window -id ${HSPane.1} -type Hier] }
gui_set_window_pref_key -window ${HSPane.1} -key dock_width -value_type integer -value 357
gui_set_window_pref_key -window ${HSPane.1} -key dock_height -value_type integer -value -1
gui_set_window_pref_key -window ${HSPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${HSPane.1} {{left 0} {top 0} {width 356} {height 352} {dock_state left} {dock_on_new_line true} {child_hier_colhier 261} {child_hier_coltype 94} {child_hier_colpd 0} {child_hier_col1 0} {child_hier_col2 1} {child_hier_col3 -1}}
set DLPane.1 [gui_create_window -type DLPane -parent ${TopLevel.1} -dock_state left -dock_on_new_line true -dock_extent 382]
catch { set Data.1 [gui_share_window -id ${DLPane.1} -type Data] }
gui_set_window_pref_key -window ${DLPane.1} -key dock_width -value_type integer -value 382
gui_set_window_pref_key -window ${DLPane.1} -key dock_height -value_type integer -value 352
gui_set_window_pref_key -window ${DLPane.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${DLPane.1} {{left 0} {top 0} {width 381} {height 352} {dock_state left} {dock_on_new_line true} {child_data_colvariable 194} {child_data_colvalue 105} {child_data_coltype 94} {child_data_col1 0} {child_data_col2 1} {child_data_col3 2}}
set Console.1 [gui_create_window -type Console -parent ${TopLevel.1} -dock_state bottom -dock_on_new_line true -dock_extent 451]
gui_set_window_pref_key -window ${Console.1} -key dock_width -value_type integer -value 1273
gui_set_window_pref_key -window ${Console.1} -key dock_height -value_type integer -value 451
gui_set_window_pref_key -window ${Console.1} -key dock_offset -value_type integer -value 0
gui_update_layout -id ${Console.1} {{left 0} {top 0} {width 1268} {height 450} {dock_state bottom} {dock_on_new_line true}}
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
gui_update_layout -id ${Wave.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 368} {child_wave_right 900} {child_wave_colname 166} {child_wave_colvalue 198} {child_wave_col1 0} {child_wave_col2 1}}

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
gui_bus_create -name EXP:R10 {{cpuStim_apr.aprCpu.MEM[160]} {cpuStim_apr.aprCpu.MEM[161]} {cpuStim_apr.aprCpu.MEM[162]} {cpuStim_apr.aprCpu.MEM[163]} {cpuStim_apr.aprCpu.MEM[164]} {cpuStim_apr.aprCpu.MEM[165]} {cpuStim_apr.aprCpu.MEM[166]} {cpuStim_apr.aprCpu.MEM[167]} {cpuStim_apr.aprCpu.MEM[168]} {cpuStim_apr.aprCpu.MEM[169]} {cpuStim_apr.aprCpu.MEM[170]} {cpuStim_apr.aprCpu.MEM[171]} {cpuStim_apr.aprCpu.MEM[172]} {cpuStim_apr.aprCpu.MEM[173]} {cpuStim_apr.aprCpu.MEM[174]} {cpuStim_apr.aprCpu.MEM[175]}}
gui_bus_create -name EXP:R11 {{cpuStim_apr.aprCpu.MEM[176]} {cpuStim_apr.aprCpu.MEM[177]} {cpuStim_apr.aprCpu.MEM[178]} {cpuStim_apr.aprCpu.MEM[179]} {cpuStim_apr.aprCpu.MEM[180]} {cpuStim_apr.aprCpu.MEM[181]} {cpuStim_apr.aprCpu.MEM[182]} {cpuStim_apr.aprCpu.MEM[183]} {cpuStim_apr.aprCpu.MEM[184]} {cpuStim_apr.aprCpu.MEM[185]} {cpuStim_apr.aprCpu.MEM[186]} {cpuStim_apr.aprCpu.MEM[187]} {cpuStim_apr.aprCpu.MEM[188]} {cpuStim_apr.aprCpu.MEM[189]} {cpuStim_apr.aprCpu.MEM[190]} {cpuStim_apr.aprCpu.MEM[191]}}
gui_bus_create -name EXP:R12 {{cpuStim_apr.aprCpu.MEM[192]} {cpuStim_apr.aprCpu.MEM[193]} {cpuStim_apr.aprCpu.MEM[194]} {cpuStim_apr.aprCpu.MEM[195]} {cpuStim_apr.aprCpu.MEM[196]} {cpuStim_apr.aprCpu.MEM[197]} {cpuStim_apr.aprCpu.MEM[198]} {cpuStim_apr.aprCpu.MEM[199]} {cpuStim_apr.aprCpu.MEM[200]} {cpuStim_apr.aprCpu.MEM[201]} {cpuStim_apr.aprCpu.MEM[202]} {cpuStim_apr.aprCpu.MEM[203]} {cpuStim_apr.aprCpu.MEM[204]} {cpuStim_apr.aprCpu.MEM[205]} {cpuStim_apr.aprCpu.MEM[206]} {cpuStim_apr.aprCpu.MEM[207]}}
gui_bus_create -name EXP:R13 {{cpuStim_apr.aprCpu.MEM[208]} {cpuStim_apr.aprCpu.MEM[209]} {cpuStim_apr.aprCpu.MEM[210]} {cpuStim_apr.aprCpu.MEM[211]} {cpuStim_apr.aprCpu.MEM[212]} {cpuStim_apr.aprCpu.MEM[213]} {cpuStim_apr.aprCpu.MEM[214]} {cpuStim_apr.aprCpu.MEM[215]} {cpuStim_apr.aprCpu.MEM[216]} {cpuStim_apr.aprCpu.MEM[217]} {cpuStim_apr.aprCpu.MEM[218]} {cpuStim_apr.aprCpu.MEM[219]} {cpuStim_apr.aprCpu.MEM[220]} {cpuStim_apr.aprCpu.MEM[221]} {cpuStim_apr.aprCpu.MEM[222]} {cpuStim_apr.aprCpu.MEM[223]}}
gui_bus_create -name EXP:R14 {{cpuStim_apr.aprCpu.MEM[224]} {cpuStim_apr.aprCpu.MEM[225]} {cpuStim_apr.aprCpu.MEM[226]} {cpuStim_apr.aprCpu.MEM[227]} {cpuStim_apr.aprCpu.MEM[228]} {cpuStim_apr.aprCpu.MEM[229]} {cpuStim_apr.aprCpu.MEM[230]} {cpuStim_apr.aprCpu.MEM[231]} {cpuStim_apr.aprCpu.MEM[232]} {cpuStim_apr.aprCpu.MEM[233]} {cpuStim_apr.aprCpu.MEM[234]} {cpuStim_apr.aprCpu.MEM[235]} {cpuStim_apr.aprCpu.MEM[236]} {cpuStim_apr.aprCpu.MEM[237]} {cpuStim_apr.aprCpu.MEM[238]} {cpuStim_apr.aprCpu.MEM[239]}}
gui_bus_create -name EXP:R0 {{cpuStim_apr.aprCpu.MEM[0]} {cpuStim_apr.aprCpu.MEM[1]} {cpuStim_apr.aprCpu.MEM[2]} {cpuStim_apr.aprCpu.MEM[3]} {cpuStim_apr.aprCpu.MEM[4]} {cpuStim_apr.aprCpu.MEM[5]} {cpuStim_apr.aprCpu.MEM[6]} {cpuStim_apr.aprCpu.MEM[7]} {cpuStim_apr.aprCpu.MEM[8]} {cpuStim_apr.aprCpu.MEM[9]} {cpuStim_apr.aprCpu.MEM[10]} {cpuStim_apr.aprCpu.MEM[11]} {cpuStim_apr.aprCpu.MEM[12]} {cpuStim_apr.aprCpu.MEM[13]} {cpuStim_apr.aprCpu.MEM[14]} {cpuStim_apr.aprCpu.MEM[15]}}
gui_bus_create -name EXP:R1 {{cpuStim_apr.aprCpu.MEM[16]} {cpuStim_apr.aprCpu.MEM[17]} {cpuStim_apr.aprCpu.MEM[18]} {cpuStim_apr.aprCpu.MEM[19]} {cpuStim_apr.aprCpu.MEM[20]} {cpuStim_apr.aprCpu.MEM[21]} {cpuStim_apr.aprCpu.MEM[22]} {cpuStim_apr.aprCpu.MEM[23]} {cpuStim_apr.aprCpu.MEM[24]} {cpuStim_apr.aprCpu.MEM[25]} {cpuStim_apr.aprCpu.MEM[26]} {cpuStim_apr.aprCpu.MEM[27]} {cpuStim_apr.aprCpu.MEM[28]} {cpuStim_apr.aprCpu.MEM[29]} {cpuStim_apr.aprCpu.MEM[30]} {cpuStim_apr.aprCpu.MEM[31]}}
gui_bus_create -name EXP:R2 {{cpuStim_apr.aprCpu.MEM[32]} {cpuStim_apr.aprCpu.MEM[33]} {cpuStim_apr.aprCpu.MEM[34]} {cpuStim_apr.aprCpu.MEM[35]} {cpuStim_apr.aprCpu.MEM[36]} {cpuStim_apr.aprCpu.MEM[37]} {cpuStim_apr.aprCpu.MEM[38]} {cpuStim_apr.aprCpu.MEM[39]} {cpuStim_apr.aprCpu.MEM[40]} {cpuStim_apr.aprCpu.MEM[41]} {cpuStim_apr.aprCpu.MEM[42]} {cpuStim_apr.aprCpu.MEM[43]} {cpuStim_apr.aprCpu.MEM[44]} {cpuStim_apr.aprCpu.MEM[45]} {cpuStim_apr.aprCpu.MEM[46]} {cpuStim_apr.aprCpu.MEM[47]}}
gui_bus_create -name EXP:R3 {{cpuStim_apr.aprCpu.MEM[48]} {cpuStim_apr.aprCpu.MEM[49]} {cpuStim_apr.aprCpu.MEM[50]} {cpuStim_apr.aprCpu.MEM[51]} {cpuStim_apr.aprCpu.MEM[52]} {cpuStim_apr.aprCpu.MEM[53]} {cpuStim_apr.aprCpu.MEM[54]} {cpuStim_apr.aprCpu.MEM[55]} {cpuStim_apr.aprCpu.MEM[56]} {cpuStim_apr.aprCpu.MEM[57]} {cpuStim_apr.aprCpu.MEM[58]} {cpuStim_apr.aprCpu.MEM[59]} {cpuStim_apr.aprCpu.MEM[60]} {cpuStim_apr.aprCpu.MEM[61]} {cpuStim_apr.aprCpu.MEM[62]} {cpuStim_apr.aprCpu.MEM[63]}}
gui_bus_create -name EXP:R4 {{cpuStim_apr.aprCpu.MEM[64]} {cpuStim_apr.aprCpu.MEM[65]} {cpuStim_apr.aprCpu.MEM[66]} {cpuStim_apr.aprCpu.MEM[67]} {cpuStim_apr.aprCpu.MEM[68]} {cpuStim_apr.aprCpu.MEM[69]} {cpuStim_apr.aprCpu.MEM[70]} {cpuStim_apr.aprCpu.MEM[71]} {cpuStim_apr.aprCpu.MEM[72]} {cpuStim_apr.aprCpu.MEM[73]} {cpuStim_apr.aprCpu.MEM[74]} {cpuStim_apr.aprCpu.MEM[75]} {cpuStim_apr.aprCpu.MEM[76]} {cpuStim_apr.aprCpu.MEM[77]} {cpuStim_apr.aprCpu.MEM[78]} {cpuStim_apr.aprCpu.MEM[79]}}
gui_bus_create -name EXP:R5 {{cpuStim_apr.aprCpu.MEM[80]} {cpuStim_apr.aprCpu.MEM[81]} {cpuStim_apr.aprCpu.MEM[82]} {cpuStim_apr.aprCpu.MEM[83]} {cpuStim_apr.aprCpu.MEM[84]} {cpuStim_apr.aprCpu.MEM[85]} {cpuStim_apr.aprCpu.MEM[86]} {cpuStim_apr.aprCpu.MEM[87]} {cpuStim_apr.aprCpu.MEM[88]} {cpuStim_apr.aprCpu.MEM[89]} {cpuStim_apr.aprCpu.MEM[90]} {cpuStim_apr.aprCpu.MEM[91]} {cpuStim_apr.aprCpu.MEM[92]} {cpuStim_apr.aprCpu.MEM[93]} {cpuStim_apr.aprCpu.MEM[94]} {cpuStim_apr.aprCpu.MEM[95]}}
gui_bus_create -name EXP:R6 {{cpuStim_apr.aprCpu.MEM[96]} {cpuStim_apr.aprCpu.MEM[97]} {cpuStim_apr.aprCpu.MEM[98]} {cpuStim_apr.aprCpu.MEM[99]} {cpuStim_apr.aprCpu.MEM[100]} {cpuStim_apr.aprCpu.MEM[101]} {cpuStim_apr.aprCpu.MEM[102]} {cpuStim_apr.aprCpu.MEM[103]} {cpuStim_apr.aprCpu.MEM[104]} {cpuStim_apr.aprCpu.MEM[105]} {cpuStim_apr.aprCpu.MEM[106]} {cpuStim_apr.aprCpu.MEM[107]} {cpuStim_apr.aprCpu.MEM[108]} {cpuStim_apr.aprCpu.MEM[109]} {cpuStim_apr.aprCpu.MEM[110]} {cpuStim_apr.aprCpu.MEM[111]}}
gui_bus_create -name EXP:R7 {{cpuStim_apr.aprCpu.MEM[112]} {cpuStim_apr.aprCpu.MEM[113]} {cpuStim_apr.aprCpu.MEM[114]} {cpuStim_apr.aprCpu.MEM[115]} {cpuStim_apr.aprCpu.MEM[116]} {cpuStim_apr.aprCpu.MEM[117]} {cpuStim_apr.aprCpu.MEM[118]} {cpuStim_apr.aprCpu.MEM[119]} {cpuStim_apr.aprCpu.MEM[120]} {cpuStim_apr.aprCpu.MEM[121]} {cpuStim_apr.aprCpu.MEM[122]} {cpuStim_apr.aprCpu.MEM[123]} {cpuStim_apr.aprCpu.MEM[124]} {cpuStim_apr.aprCpu.MEM[125]} {cpuStim_apr.aprCpu.MEM[126]} {cpuStim_apr.aprCpu.MEM[127]}}
gui_bus_create -name EXP:R8 {{cpuStim_apr.aprCpu.MEM[128]} {cpuStim_apr.aprCpu.MEM[129]} {cpuStim_apr.aprCpu.MEM[130]} {cpuStim_apr.aprCpu.MEM[131]} {cpuStim_apr.aprCpu.MEM[132]} {cpuStim_apr.aprCpu.MEM[133]} {cpuStim_apr.aprCpu.MEM[134]} {cpuStim_apr.aprCpu.MEM[135]} {cpuStim_apr.aprCpu.MEM[136]} {cpuStim_apr.aprCpu.MEM[137]} {cpuStim_apr.aprCpu.MEM[138]} {cpuStim_apr.aprCpu.MEM[139]} {cpuStim_apr.aprCpu.MEM[140]} {cpuStim_apr.aprCpu.MEM[141]} {cpuStim_apr.aprCpu.MEM[142]} {cpuStim_apr.aprCpu.MEM[143]}}
gui_bus_create -name EXP:R9 {{cpuStim_apr.aprCpu.MEM[144]} {cpuStim_apr.aprCpu.MEM[145]} {cpuStim_apr.aprCpu.MEM[146]} {cpuStim_apr.aprCpu.MEM[147]} {cpuStim_apr.aprCpu.MEM[148]} {cpuStim_apr.aprCpu.MEM[149]} {cpuStim_apr.aprCpu.MEM[150]} {cpuStim_apr.aprCpu.MEM[151]} {cpuStim_apr.aprCpu.MEM[152]} {cpuStim_apr.aprCpu.MEM[153]} {cpuStim_apr.aprCpu.MEM[154]} {cpuStim_apr.aprCpu.MEM[155]} {cpuStim_apr.aprCpu.MEM[156]} {cpuStim_apr.aprCpu.MEM[157]} {cpuStim_apr.aprCpu.MEM[158]} {cpuStim_apr.aprCpu.MEM[159]}}

# Global: Expressions

# Global: Signal Time Shift

# Global: Signal Compare

# Global: Signal Groups


set _session_group_4 Group1
gui_sg_create "$_session_group_4"
set Group1 "$_session_group_4"


set _session_group_5 Top
gui_sg_create "$_session_group_5"
set Top "$_session_group_5"

gui_sg_addsignal -group "$_session_group_5" { cpuStim_apr.aprCpu.reset cpuStim_apr.aprCpu.clk cpuStim_apr.aprCpu.PC }
gui_set_radix -radix {decimal} -signals {V1:cpuStim_apr.aprCpu.PC}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim_apr.aprCpu.PC}

set _session_group_6 Regfile
gui_sg_create "$_session_group_6"
set Regfile "$_session_group_6"

gui_sg_addsignal -group "$_session_group_6" { cpuStim_apr.aprCpu.MEM EXP:R14 EXP:R13 EXP:R12 EXP:R11 EXP:R10 EXP:R9 EXP:R8 EXP:R7 EXP:R6 EXP:R5 EXP:R4 EXP:R3 EXP:R2 EXP:R1 EXP:R0 }
gui_set_radix -radix {decimal} -signals {V1:cpuStim_apr.aprCpu.MEM}
gui_set_radix -radix {unsigned} -signals {V1:cpuStim_apr.aprCpu.MEM}
gui_set_radix -radix {decimal} -signals {EXP:R14}
gui_set_radix -radix {unsigned} -signals {EXP:R14}
gui_set_radix -radix {decimal} -signals {EXP:R13}
gui_set_radix -radix {unsigned} -signals {EXP:R13}
gui_set_radix -radix {decimal} -signals {EXP:R12}
gui_set_radix -radix {unsigned} -signals {EXP:R12}
gui_set_radix -radix {decimal} -signals {EXP:R11}
gui_set_radix -radix {unsigned} -signals {EXP:R11}
gui_set_radix -radix {decimal} -signals {EXP:R10}
gui_set_radix -radix {unsigned} -signals {EXP:R10}
gui_set_radix -radix {decimal} -signals {EXP:R9}
gui_set_radix -radix {unsigned} -signals {EXP:R9}
gui_set_radix -radix {decimal} -signals {EXP:R8}
gui_set_radix -radix {unsigned} -signals {EXP:R8}
gui_set_radix -radix {decimal} -signals {EXP:R7}
gui_set_radix -radix {unsigned} -signals {EXP:R7}
gui_set_radix -radix {decimal} -signals {EXP:R6}
gui_set_radix -radix {unsigned} -signals {EXP:R6}
gui_set_radix -radix {decimal} -signals {EXP:R5}
gui_set_radix -radix {unsigned} -signals {EXP:R5}
gui_set_radix -radix {decimal} -signals {EXP:R4}
gui_set_radix -radix {unsigned} -signals {EXP:R4}
gui_set_radix -radix {decimal} -signals {EXP:R3}
gui_set_radix -radix {unsigned} -signals {EXP:R3}
gui_set_radix -radix {decimal} -signals {EXP:R2}
gui_set_radix -radix {unsigned} -signals {EXP:R2}
gui_set_radix -radix {decimal} -signals {EXP:R1}
gui_set_radix -radix {unsigned} -signals {EXP:R1}
gui_set_radix -radix {decimal} -signals {EXP:R0}
gui_set_radix -radix {unsigned} -signals {EXP:R0}

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 1690330



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
catch {gui_list_expand -id ${Hier.1} cpuStim_apr}
catch {gui_list_select -id ${Hier.1} {cpuStim_apr.aprCpu}}
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 1

# Data 'Data.1'
gui_list_set_filter -id ${Data.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {LowPower 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Data.1} -text {*}
gui_list_show_data -id ${Data.1} {cpuStim_apr.aprCpu}
gui_show_window -window ${Data.1}
catch { gui_list_select -id ${Data.1} {cpuStim_apr.aprCpu.MEM }}
gui_view_scroll -id ${Data.1} -vertical -set 0
gui_view_scroll -id ${Data.1} -horizontal -set 0
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 1

# Source 'Source.1'
gui_src_value_annotate -id ${Source.1} -switch false
gui_set_env TOGGLE::VALUEANNOTATE 0
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
gui_wv_zoom_timerange -id ${Wave.1} 0 1790000
gui_list_add_group -id ${Wave.1} -after {New Group} {Top}
gui_list_add_group -id ${Wave.1} -after {New Group} {Regfile}
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
gui_list_set_insertion_bar  -id ${Wave.1} -group Regfile  -item EXP:R0 -position below

gui_marker_move -id ${Wave.1} {C1} 1690330
gui_view_scroll -id ${Wave.1} -vertical -set 0
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

