

# Get variable definitions
source ${SRC_DIR}/config.tcl
source ${SRC_DIR}/phys_vars.tcl
source ${SRC_DIR}/common_procs.tcl

set_dont_touch [get_nets adc_*]

# PORT PROTECTION DIODES (OPTIONAL)
# ==========================================================================
if {$USE_ANTENNA_DIODES && $PORT_PROTECTION_DIODE != ""} {
   ## Optionally insert a diode before routing to avoid antenna's on the ports of the block
   remove_attribute $PORT_PROTECTION_DIODE dont_use
   set ports [remove_from_collection [get_ports * -filter "direction==in"] [get_ports $PORT_PROTECTION_DIODE_EXCLUDE_PORTS]]
   insert_port_protection_diodes \
      -prefix port_protection_diode \
      -diode_cell [get_lib_cells $PORT_PROTECTION_DIODE] \
      -port $ports \
      -ignore_dont_touch
   legalize_placement
}

# ROUTE!
# ==========================================================================

# Connect PG
derive_pg_connection -reconnect -all
verify_pg_nets

set_route_zrt_common_options \
   -extra_nonpreferred_direction_wire_cost_multiplier_by_layer_name {{M3 2}}

# Build buffer trees for high fanout nets.
remove_ideal_network -all
if {$BUILD_BUFFER_TREES} {
   if {$BUFFER_TREE_NET_NAMES != ""} {
      set hfo_nets [get_nets $BUFFER_TREE_NET_NAMES]
      create_buffer_tree -from $hfo_nets
      report_buffer_tree -from $hfo_nets -hierarchy -nosplit
   }
}

# Route any critical nets
if {$CRITICAL_NETS != ""} {
   route_zrt_group -nets $CRITICAL_NETS
}

# Attempt to fix hold violations during routing
set_fix_hold [all_clocks]


# Route
set route_opt_args "-effort $ROUTE_OPT_EFFORT"
echo "route_opt $route_opt_args"
eval "route_opt $route_opt_args"

# Remove the blockage you created before clockopt
remove_routing_blockage [get_routing_blockage -type metal]
remove_routing_blockage [get_routing_blockage -type via]

#route_opt -effort $ROUTE_OPT_EFFORT -initial_route_only
#insert_zrt_redundant_vias
#route_opt -skip_initial_route

# Insert filler
insert_stdcell_filler \
   -cell_with_metal $FILL_CELLS \
   -connect_to_power VDD \
   -connect_to_ground VSS \
   -respect_keepout

# Connect PG
derive_pg_connection -power_net VDD -power_pin VDD -ground_net VSS -ground_pin VSS -create_ports all
verify_pg_nets

# Check LVS/DRC
# ==========================================================================
verify_zrt_route
verify_lvs -ignore_min_area
