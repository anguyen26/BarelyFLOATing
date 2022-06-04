# Project and design
# ==========================================================================

set PROCESS "65GP"; # 65LP or 65GP
set CORNER "LOW"

# ICC runtime 
# ==========================================================================

if {$TOOL_NAME == "ICC"} {
    set_fast_mode "false" ;           # Forces place_opt/route_opt to run with low effort
    set_host_options -max_cores $env(CPU_CORES);
}

# Silence the unholy number of warnings that are known to be harmless
suppress_message "DPI-025"
suppress_message "PSYN-485"

# Library setup
# ==========================================================================

set TOPLEVEL "cpu"
set DESIGN_MW_LIB_NAME "${TOPLEVEL}_lib"

source -echo -verbose ./tech_node_config.tcl

set TECH2ITF_MAP_FILE "star.map_9M"
set MW_TECHFILE "tsmcn65_9lmT2.tf"

# nand2 gate name for area size calculation
set NAND2_NAME    "ND2D1"

set MW_ADDITIONAL_REFERENCE_LIBS {}
set ADDITIONAL_TARGET_LIBS {}
set ADDITIONAL_SYMBOL_LIBS {}

set design_name ${TOPLEVEL}

# POWER NETWORK CONFIG
# ==========================================================================
# - Script expects all of these to be in the run directory

set RING_FILE "rings.tpl"
set RING_VSS_NAME "core_ring_vss"
set RING_VDD_NAME "core_ring_vdd"
set MESH_FILE "mesh.tpl"
set LOWER_MESH_NAME "core_lower_mesh"
set UPPER_MESH_NAME "core_upper_mesh"
set CUSTOM_POWER_PLAN_SCRIPT "macro_power.tcl"

# FUNCTIONAL CONFIG
# ==========================================================================


# Power and ground net names 
set POWER_NET  "VDD"
set GROUND_NET "VSS"
set LIB_POWER_PIN "VDD"
set LIB_GROUND_PIN "VSS"

# Insert metal fill as a finishing step (or not)
set INSERT_METAL_FILL 0

# Placement options
set LOW_POWER_PLACEMENT 0
set PLACE_OPT_EFFORT "medium"
set TWO_PASS_PLACEOPT 0

# Pinplacement
set PINPLACEMENT_TXT "${SRC_DIR}/pin_placement.txt"
set PINPLACEMENT_TCL "${SRC_DIR}/pin_placement.tcl"

# Set Min/Max Routing Layers and routing directions
set MAX_ROUTING_LAYER "M7"
set MIN_ROUTING_LAYER "M1"
set HORIZONTAL_ROUTING_LAYERS "M2 M4 M6 M8"
set VERTICAL_ROUTING_LAYERS "M3 M5 M7 M9"


if {$TOOL_NAME != "PTPX"} {
    if {[current_design_name] != ""} {
	set_preferred_routing_direction \
	    -layers $HORIZONTAL_ROUTING_LAYERS \
	    -direction horizontal

	set_preferred_routing_direction \
	    -layers $VERTICAL_ROUTING_LAYERS \
	    -direction vertical

	if { $MAX_ROUTING_LAYER != ""} {set_ignored_layers -max_routing_layer $MAX_ROUTING_LAYER}
	if { $MIN_ROUTING_LAYER != ""} {set_ignored_layers -min_routing_layer $MIN_ROUTING_LAYER}
    }
}


# Min/Max routing layers for the clock
set CLOCK_ROUTING_LAYERS {M1 M2 M3 M4 M5 M6 M7}

if {$TOOL_NAME == "ICC"} {
   # Zroute and the common router do not respect macro blockage layers by default
   set_route_zrt_common_options -global_max_layer_mode hard
   set_route_zrt_common_options \
       -read_user_metal_blockage_layer "true" \
       -wide_macro_pin_as_fat_wire "true"
}

# Names of the clocks/clock trees in the design
set CLOCKS [list \
    "clk_cpu" \
]

# Shield the clock nets
set SHIELD_CLOCK 0

# Analyze the clock tree subcircuit with SPICE
set ANALYZE_CLOCK_WITH_SPICE 0

# Any critical nets to route before general signal routing
set CRITICAL_NETS ""

# Build a buffer tree for the reset signal (should be mutually exclusive with CRITICAL_NETS)
set BUILD_BUFFER_TREES 1
set BUFFER_TREE_NET_NAMES {reset_i}
# Routing optimization effort
set ROUTE_OPT_EFFORT "medium"
set MAX_DETAIL_ROUTE_ITER 40 ; # Default is 40

# Diode insertion for antenna violations, and ESD
set FIX_ANTENNA 1
set USE_ANTENNA_DIODES 1
set PORT_PROTECTION_DIODE ""
set PORT_PROTECTION_DIODE_EXCLUDE_PORTS ""
set ROUTING_DIODES "ANTENNA"

# Replace fill cells with decap at the end 
set FINISH_WITH_DECAP 1
set DECAP_CELLS {DCAP16 DCAP8 DCAP4 DCAP}
set FILL_CELLS {FILL8 FILL4 FILL2 FILL1}

# RESULT GENERATION AND REPORTING
# ==========================================================================
set reports "reports" ; # Directory for reports
set results "results" ; # For generated design files

# MISC
# ==========================================================================
# - Useful for iterating on specific segments of the flow
if {$TOOL_NAME == "ICC"} {
   alias rst0  "close_mw_cel;open_mw_cel ${design_name}_init;       source ${SRC_DIR}/floorplan.tcl -echo"
   alias rst1  "close_mw_cel;open_mw_cel ${design_name}_prepns;     source ${SRC_DIR}/power.tcl -echo"
   alias rst2  "close_mw_cel;open_mw_cel ${design_name}_preplaceopt;source ${SRC_DIR}/placeopt.tcl -echo"
   alias rst3  "close_mw_cel;open_mw_cel ${design_name}_preclock;   source ${SRC_DIR}/clocks.tcl -echo"
   alias rst4  "close_mw_cel;open_mw_cel ${design_name}_preroute;   source ${SRC_DIR}/route.tcl -echo"
   alias rst5  "close_mw_cel;open_mw_cel ${design_name}_prefinish;  source ${SRC_DIR}/finishing.tcl -echo"
}

# source common tcl functions
# ==========================================================================
source ${SRC_DIR}/create_metal_blockage.tcl
source ${SRC_DIR}/create_via_blockage.tcl
