# set search path, target lib, link path.
# Specify the libraries, tluplus files, import ddc file.
set TSMCPATH /home/lab.apps/vlsiapps/kits/tsmc/N65RF/1.0c/digital
set TARGETCELLLIB $TSMCPATH/Front_End/timing_power_noise/CCS/tcbn65gplus_200a
set search_path   [concat  $search_path $TARGETCELLLIB ./db  $synopsys_root/libraries/syn]
lappend search_path [glob $TSMCPATH/Back_End/milkyway/tcbn65gplus_200a/cell_frame/tcbn65gplus/LM/*]
set target_library "tcbn65gpluswc0d72_ccs.db tcbn65gplusbc0d88_ccs.db tcbn65gplustc0d8_ccs.db"
set symbol_library tcbn65gplustc0d8_ccs.db
set link_path {"*" tcbn65gpluswc0d72_ccs.db tcbn65gplusbc0d88_ccs.db tcbn65gplustc0d8_ccs.db }

set mw_techfile_path $TSMCPATH/Back_End/milkyway/tcbn65gplus_200a/techfiles
set mw_tech_file $mw_techfile_path/tsmcn65_9lmT2.tf
set mw_reference_library $TSMCPATH/Back_End/milkyway/tcbn65gplus_200a/frame_only/tcbn65gplus
create_mw_lib -technology $mw_tech_file -mw_reference_library $mw_reference_library cpu_design      
open_mw_lib cpu_design

set_tlu_plus_files \
-max_tluplus $mw_techfile_path/tluplus/cln65g+_1p09m+alrdl_rcbest_top2.tluplus \
-min_tluplus $mw_techfile_path/tluplus/cln65g+_1p09m+alrdl_rcworst_top2.tluplus \
-tech2itf_map $mw_techfile_path/tluplus/star.map_9M


#################################### cpu #####################################
# Read Design
set RTLPATH ../../src/verilog
# read_file will analyze (read,check) and elaborate(GTech map, DW map) the design in one shot.
set my_excludes [list $RTLPATH/oldCpu.sv]
read_file $RTLPATH -exclude $my_excludes -recursive -autoread -top cpu -format sverilog

#Define environment
set_operating_conditions -analysis_type bc_wc  -min BC0D88COM -max WC0D72COM  -max_library tcbn65gpluswc0d72_ccs -min_library tcbn65gplusbc0d88_ccs
set_min_library tcbn65gpluswc0d72_ccs.db -min_version tcbn65gplusbc0d88_ccs.db

#Loading and drive settings. 
set_driving_cell -lib_cell INVD1 reset
set_driving_cell -lib_cell INVD1 clk 
set_driving_cell -lib_cell INVD1 dataOut 
set_driving_cell -lib_cell INVD1 instr 
# set_load for outputs
set_load [load_of tcbn65gpluswc0d72_ccs/INVD1/I] [get_ports aluOutput]
set_load [load_of tcbn65gpluswc0d72_ccs/INVD1/I] [get_ports MemWriteE]
set_load [load_of tcbn65gpluswc0d72_ccs/INVD1/I] [get_ports MemReadE]
set_load [load_of tcbn65gpluswc0d72_ccs/INVD1/I] [get_ports ReadData2E]
set_load [load_of tcbn65gpluswc0d72_ccs/INVD1/I] [get_ports PC]

#connect referenced library components to the current design
link

#Define design constraints
set_max_transition 0.8 [get_designs cpu]
set_max_fanout 20 cpu
create_clock -name "clk" -period 10 -waveform {0 1} [get_ports clk]
set_clock_uncertainty -setup 0.05 [get_clocks]
set_clock_uncertainty -hold 0.01 [get_clocks]
set_clock_transition 0.05 [get_clocks]
set_input_delay 0.1 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]
set_fix_hold {clk}

#multicycle paths
set_multicycle_path -setup 2 -through {FPU}
set_multicycle_path -hold 1 -through {FPU}

#Compile ultra will take care of ungrouping and flattening for improved performance. 
set_critical_range 0.1 $current_design
# set_dont_touch instructionMemory/address*
compile_ultra -no_autoungroup -no_boundary_optimization
check_design

#write out design files
file mkdir reports
report_power > reports/cpu.power
report_constraint -verbose > reports/cpu.constraint
report_constraint -all_violators > reports/cpu.violation
report_timing -path full -delay max -max_paths 5   -nworst 2 > "reports/timing.max.fullpath.rpt"
report_timing -path full -delay min -max_paths 5   -nworst 2 > "reports/timing.min.fullpath.rpt"
report_timing -from FPU/divide/opA -to FPU/divide/quotient > "reports/timing.fpu.rpt"
report_area -hierarchy > "reports/area.rpt"
write_sdc  reports/cpu.sdc
file mkdir db
write -h cpu -output ./db/cpu.db
file mkdir design_files
write_sdf -context verilog -version 1.0 design_files/cpu.syn.sdf
write -h -f verilog cpu -output design_files/cpu.syn.v -pg
file mkdir ddc
write_file -format ddc -hierarchy -output ddc/DIG_TOP.ddc
exit
