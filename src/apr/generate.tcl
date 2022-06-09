
# GENERATE DESIGN FILES
# ==========================================================================

# Case sensitive (avoid issues with spice)
define_name_rules STANDARD -case
change_names -rules STANDARD

# SPEF
extract_rc
write_parasitics \
   -output ./$results/$design_name.apr.spef \
   -no_name_mapping

# LEF+DEF
write_def -lef ./$results/$design_name.lef \
          -output ./$results/$design_name.def \
          -all_vias

# Verilog
write_verilog ./$results/$design_name.no_pg.apr.v \
    -unconnected_ports \
    -no_core_filler_cells \
    -diode_ports \
    -supply_statement "none"

write_verilog ./$results/$design_name.apr.v \
    -pg \
    -unconnected_ports \
    -no_core_filler_cells \
    -diode_ports \
    -supply_statement "none"
# SDF
write_sdf -context verilog ./$results/$design_name.apr.sdf

# SDC
write_sdc -nosplit $results/$design_name.apr.sdc

#Investigate the need to do this...
foreach powerNet [list VDD VSS] {
create_port -direction inout $powerNet
connect_net $powerNet [get_ports $powerNet] 
}

change_selection [get_net_shapes -filter \
"(net_type == Ground || net_type == Power) && route_type == \"P/G Strap\""]
convert_wire_to_pin [get_selection]

#Fram generation.. THIS METHOD NEEDS GOOD ALIGNMENT OF THE TRACK TO THE CENTER OF THE POWER PIN!!!!!!
# change_selection [get_net_shapes -filter \
#   "(net_type == Ground || net_type == Power) && (route_type == \"P/G Strap\" || route_type == \"P/G Ring\")"]
# foreach_in_collection shape [get_selection] {
#     set bbox [get_attribute $shape bbox]
#     set layer [get_attribute $shape layer]
#     set owner_net [get_attribute $shape owner_net]
#     create_terminal -bbox $bbox -layer $layer -port $owner_net
# }
#  convert_wire_to_pin [get_selection]
  create_macro_fram -extract_blockage_by_block_core_with_margin {M8 -1 M9 -1}



# GENERATE REPORTS
# ==========================================================================

# Timing
check_timing > "./$reports/check_timing.rpt"
report_constraints -all_violators -verbose -nosplit > "./$reports/constraints.rpt"
report_timing -path end  -delay max -max_paths 200 -nosplit > "./$reports/paths.max.rpt"
report_timing -path full -delay max -max_paths 50  -nosplit > "./$reports/full_paths.max.rpt"
report_timing -path end  -delay min -max_paths 200 -nosplit > "./$reports/paths.min.rpt"
report_timing -path full -delay min -max_paths 50  -nosplit > "./$reports/full_paths.min.rpt"

# Area
report_area -physical -hier -nosplit > "./$reports/area.rpt"

# Power and backannotation
report_power -verbose -hier -nosplit > "./$reports/power.hier.rpt"
report_power -verbose -nosplit > "./$reports/power.rpt"
report_saif -hier > "./$reports/saif_anno.rpt"
report_saif -missing >> "./$reports/saif_anno.rpt"

# Floorplanning and placement
report_fp_placement > "./$reports/placement.rpt"

# Clocking
report_clock_tree -nosplit > "./$reports/clocktree.rpt"

# QoR
report_qor -nosplit > "./$reports/qor.rpt"

