
# PLACEMENT OPTIMIZATION
# ================================

# Get variable definitions
source ${SRC_DIR}/config.tcl
source ${SRC_DIR}/phys_vars.tcl

# some helpers
set CORE_BBOX [join [get_core_bbox]]
set CORE_LLX  [lindex $CORE_BBOX 0]
set CORE_LLY  [lindex $CORE_BBOX 1]
set CORE_URX  [lindex $CORE_BBOX 2]
set CORE_URY  [lindex $CORE_BBOX 3]

#set m_b $MIN_SPACE
#set m_t $MIN_SPACE
#set m_l [expr 2*$CELL_HEIGHT]
#set m_r [expr 2*$CELL_HEIGHT]
#set_keepout_margin \
#   -type hard \
#   -macro_instances [all_macro_cells] \
#   -outer [list $m_l $m_b $m_r $m_t]

# Optimize
set place_opt_args "-effort $PLACE_OPT_EFFORT -congestion"

# Power optimization
if {$LOW_POWER_PLACEMENT} {
   set_optimize_pre_cts_power_options -low_power_placement true
   set place_opt_args "$place_opt_args -power"
}

echo "place_opt $place_opt_args"
eval "place_opt $place_opt_args"

# Two pass place_opt
if {$TWO_PASS_PLACEOPT} {
   remove_buffer_tree -all
   create_placement
   extract_rc -estimate
   create_placement -timing_driven
   create_buffer_tree
   lappend place_opt_args "-skip_initial_placement"

   echo "place_opt $place_opt_args"
   eval "place_opt $place_opt_args"
}

# Insert filler
# - I forget why I did this...leave it for now
set pg_bbox [list \
   [list [expr $CORE_LLX + 2*$MIN_SPACE] [expr $CORE_LLY + 2*$MIN_SPACE]] \
   [list [expr $CORE_URX - 2*$MIN_SPACE] [expr $CORE_URY + 2*$MIN_SPACE]] \
]
insert_stdcell_filler \
   -cell_with_metal {FILL8 FILL4 FILL2 FILL1} \
   -respect_keepout
   #-bounding_box $pg_bbox \

# Connect all power and ground pins
derive_pg_connection -all -reconnect -create_ports all
verify_pg_nets

# Temporarily set interconnect delays to zero and check for constraint violations
# - if we can't meet timing here, we probably need to re-floorplan
set_zero_interconnect_delay_mode true
report_constraint -all -nosplit >   "./$reports/constraint_zero_delay.rpt"
report_timing -delay max -nosplit > "./$reports/paths_zero_delay.max.rpt"
report_timing -delay min -nosplit > "./$reports/paths_zero_delay.min.rpt"
set_zero_interconnect_delay_mode false

