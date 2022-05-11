# set search path, target lib, link path.
set TSMCPATH /home/lab.apps/vlsiapps/kits/tsmc/N65RF/1.0c_cdb/digital
set TARGETCELLLIB $TSMCPATH/Front_End/timing_power_noise/CCS/tcbn65gplus_200a
set search_path   [concat  $search_path $TARGETCELLLIB ./db  $synopsys_root/libraries/syn]
lappend search_path [glob $TSMCPATH/Back_End/milkyway/tcbn65gplus_200a/cell_frame/tcbn65gplus/LM/*]
set target_library "tcbn65gpluswc0d72_ccs.db tcbn65gplusbc0d88_ccs.db tcbn65gplustc0d8_ccs.db"
set symbol_library tcbn65gplustc0d8_ccs.db
set link_path {"*" tcbn65gpluswc0d72_ccs.db tcbn65gplusbc0d88_ccs.db tcbn65gplustc0d8_ccs.db }

#Create a MW design lib map to techfile, reference library (of stdcell for example)
#Milky way variable settings. Same as topo for the most part.
set mw_techfile_path /home/lab.apps/vlsiapps/kits/tsmc/N65RF/1.0c_cdb/digital/Back_End/milkyway/tcbn65gplus_200a/techfiles
set mw_tech_file $mw_techfile_path/tsmcn65_9lmT2.tf
set mw_reference_library $TSMCPATH/Back_End/milkyway/tcbn65gplus_200a/frame_only/tcbn65gplus
create_mw_lib -technology $mw_tech_file -mw_reference_library $mw_reference_library cpu_design      
open_mw_lib cpu_design

#Read in the verilog, uniquify and save the CEL view.
import_designs ../syn/design_files/cpu.syn.v -format verilog -top cpu

#set up tlu_plus files (for virtual route and post route extraction)
set_tlu_plus_files \
-max_tluplus $mw_techfile_path/tluplus/cln65g+_1p09m+alrdl_rcbest_top2.tluplus \
-min_tluplus $mw_techfile_path/tluplus/cln65g+_1p09m+alrdl_rcworst_top2.tluplus \
-tech2itf_map $mw_techfile_path/tluplus/star.map_9M

#perform consistency checks across all libraries (both logic and physical libraries)
set_check_library_options -all
check_library
check_tlu_plus_files

#connect/link all referenced library components to the current design
link

#Power Mapping
derive_pg_connection -power_net VDD -power_pin VDD\
                     -ground_net VSS -ground_pin VSS\
                     -create_ports "top"
derive_pg_connection -power_net VDD -ground_net VSS\
                     -tie
check_mv_design -power_nets

#Read timing and apply constraints
read_sdc ./cpu.sdc
check_timing

#Check for false or multicycle path settings, any disabled arcs and case_analysis settings
report_timing_requirements
report disable_timing
report_case_analysis

#Define environment
set_operating_conditions -analysis_type bc_wc  -min BC0D88COM -max WC0D72COM  -max_library tcbn65gpluswc0d72_ccs -min_library tcbn65gplusbc0d88_ccs
set_min_library tcbn65gpluswc0d72_ccs.db -min_version tcbn65gplusbc0d88_ccs.db

#Loading and drive settings. 
# set_drive_cell for inputs
set_driving_cell -lib_cell INVD1 reset
set_driving_cell -lib_cell INVD1 clk

link

#Define design constraints
set_max_transition 0.1 [get_designs cpu]
set_max_fanout 6 cpu
create_clock -name "clk" -period 2 -waveform {0 1} [get_ports clk] 
set_clock_uncertainty -setup 0.05 clk
set_clock_uncertainty -hold 0.01 clk
set_clock_transition 0.05 [get_clocks]
set_input_delay 0.1 -clock clk [remove_from_collection [all_inputs] [get_ports clk]]

#Check clock health and assumptions
report_clock -skew
report_clock

#Apply timing and optimization control. 
#set_dont_use and set_prefer -min<hold_fixing_cells> are likely candidates 
set_app_var timing_enable_multiple_clocks_per_reg true
set_fix_multiple_port_nets -all -buffer_constants
group_path -name INPUTS -from [all_inputs]
group_path -name OUTPUTS -to [all_outputs]

#Check that timing constraints are all good
set_zero_interconnect_delay_mode true
report_constraint -all
report_timing
set_zero_interconnect_delay_mode false

#save current milkyway Design so you can obtain it again with open_mw_cel ....
save_mw_cel -as cpu_data_setup

#Now you're ready to floorplan the design
create_floorplan -control_type aspect_ratio\
                 -core_aspect_ratio 1\
                 -core_utilization 0.8\
                 -left_io2core 3\
                 -right_io2core 3\
                 -top_io2core 3\
                 -bottom_io2core 3

#Plan your power. The outer ring extends out to hit the pin and inner stripe shrinks to cover the core.
 create_rectangular_rings  -nets  {VSS VDD}\
                          -around core\
                          -left_segment_layer M2 \
                          -left_segment_width 1\
                          -right_segment_layer M2\
                          -right_segment_width 1\
                          -bottom_segment_layer M1\
                          -bottom_segment_width 1\
                          -top_segment_layer M1 \
                          -top_segment_width 1\
                          -left_offset 0.5\
                          -right_offset 0.5\
                          -bottom_offset 0.5\
                          -top_offset 0.5
create_power_straps -direction horizontal\
                     -extend_high_ends to_boundary_and_generate_pins  \
                     -extend_low_ends to_boundary_and_generate_pins  \
                     -nets  {VSS VDD}  \
                     -layer M1 \
                     -width 0.33  \
                     -configure rows \
                     -step 3.6 \
                     -pitch_within_group 1.8



#Run placement, fixing timing violations and congestion. 
create_fp_placement 

#save current design
save_mw_cel -as cpu_post_place

#define clock contrains
set cts_force_user_constraints true
set_max_transition 1 [get_clocks clk]
set_clock_tree_options  -clock_trees clk\
                        -layer_list {M1 M2 M3 M4 M5 M6 M7}\
                        -target_skew 0.1\
                        -max_capacitance [load_of tcbn65gpluswc0d72_ccs/INVD8/I]\
                        -max_transition 0.15\
                        -max_fanout 8\
                        -max_rc_delay 0.3\
                        -use_default_routing_for_sinks 1\
                        -logic_level_balance true

clock_opt -inter_clock_balance\
          -update_clock_latency\
          -operating_condition max\
          -only_cts

route_zrt_group -all_clock_nets -reuse_existing_global_route true

#save current design
save_mw_cel -as cpu_post_clk_route

#Fills empty spaces in std cell rows w/ filler cells
insert_stdcell_filler -cell_with_metal {GFILL10 GFILL4 GFILL3 GFILL2 GFILL1}\
                      -connect_to_power "VDD"\
                      -connect_to_ground "VSS"

#Finally, connect all power and ground pins
derive_pg_connection -cells [get_cells] -power_net VDD -ground_net VSS

#Route
route_opt

#Run DRC, LVS
signoff_drc -check_all_layers
list_drc_error_types
set short_errors [get_drc_errors -type {Short}]
verify_lvs

#save the final design
save_mw_cel -as cpu_post_route

#Avoid issues with upper/lower case confusion esp with spice.
define_name_rules STANDARD -case
change_names -rules STANDARD

#Parasitics write out
extract_rc
write_parasitics

report_constraints -all_violators -verbose -nosplit > cpu.apr.constraint
report_timing -path end  -delay max -max_paths 200 -nosplit > cpu.apr.paths.max.rpt
# report_timing -path full -delay max -max_paths 50  -nosplit > fsm.apr.full_paths.max.rpt
report_timing -path end  -delay min -max_paths 200 -nosplit > cpu.apr.paths.min.rpt
# report_timing -path full -delay min -max_paths 50  -nosplit > fsm.apr.full_paths.min.rpt

#Write out design data
write_def -lef may_need_for_rotated_vias.lef \
          -output "cpu.def"\
          -all_vias

#Write out Verilog of finalized design
write_verilog cpu.apr.v \
              -unconnected_ports

#Write out delay and constraints
write_sdf -context verilog -version 1.0 cpu.apr.sdf
