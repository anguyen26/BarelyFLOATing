
# Get variable definitions
source ${SRC_DIR}/config.tcl
source ${SRC_DIR}/phys_vars.tcl
source ${SRC_DIR}/common_procs.tcl

# Clean slate in case we are rerunning
remove_power_plan_regions -all

# Create power plan regions
# ============================

# Create a power plan region for the core
set core_ppr_name "ppr_core"
create_power_plan_regions $core_ppr_name \
   -core

# Constrain the core rings
# =============================

# Ring-related spacings and variables
set hlay    $RING_HLAYER      ; # horizontal ring layer
set vlay    $RING_VLAYER      ; # vertical ring layer
set rw      $POWER_RING_WIDTH ; # ring width
set vss_os  $POWER_RING_SPACE ; # offset relative to core edge
set vdd_os [expr $vss_os+$POWER_RING_WIDTH+$POWER_RING_CLEARANCE]

set vss_ring_strategy_name "vss_ring"
set vdd_ring_strategy_name "vdd_ring"

# Set the strategies for the rings
set_power_ring_strategy $vss_ring_strategy_name \
   -power_plan_regions $core_ppr_name \
   -nets {VSS} \
   -template ${SRC_DIR}/${RING_FILE}:${RING_VSS_NAME}($hlay,$vlay,$rw,$vss_os)
set_power_ring_strategy $vdd_ring_strategy_name \
   -power_plan_regions $core_ppr_name \
   -nets {VDD} \
   -template ${SRC_DIR}/${RING_FILE}:${RING_VDD_NAME}($hlay,$vlay,$rw,$vdd_os)

# Constrain the core meshes
# =============================

# Specify the lower mesh (only reaches to up to the core boundary)
#  - num_m1m2: total number of m1/m2 straps for the core
#     - Must divide by two because the # is created for both VDD and VSS
set num_m1m2 [expr int($CORE_HEIGHT_IN_SUPERTILES*$SUPERTILE_SIZE/2)]
set lower_mesh_strategy_name "lower_mesh"
set_power_plan_strategy $lower_mesh_strategy_name \
   -power_plan_regions $core_ppr_name \
   -nets {VDD VSS} \
   -template ${SRC_DIR}/${MESH_FILE}:${LOWER_MESH_NAME}($num_m1m2,0,0,0,0,0)

# Specify the upper mesh separately, since it should hit the core rings
#  - The reason we specify this separately is that the lower mesh should only reach up to
#    the boundary of legal placement, while the upper mesh should keep going and via onto
#    the core rings
set upper_mesh_strategy_name "upper_mesh"
set_power_plan_strategy $upper_mesh_strategy_name \
   -power_plan_regions $core_ppr_name \
   -extension [list {nets: {VDD VSS}} [list "stop:" "first_target"]] \
   -nets {VDD VSS} \
   -template ${SRC_DIR}/${MESH_FILE}:${UPPER_MESH_NAME}(0,0)

# Compile everything
# =============================

# Create the core rings
compile_power_plan -ring -strategy $vss_ring_strategy_name
compile_power_plan -ring -strategy $vdd_ring_strategy_name

# Create core power mesh
compile_power_plan -strategy $upper_mesh_strategy_name
compile_power_plan -strategy $lower_mesh_strategy_name

# Via hack
# =============================

# Create M1/M2 vias
# - For some reason M1/M2 vias aren't automatically created during the core mesh creation. So we
#   have to turn the "trim_straps" option off in the mesh template file for M1 and M2, otherwise
#   no M1 straps get created (M2/M3 vias are created so M2 isn't trimmed, though). We also then
#   have to create these vias ourselves
create_preroute_vias \
   -nets {VDD VSS} \
   -from_object_strap \
   -to_object_strap \
   -from_layer M2 \
   -to_layer   M1 \
   -advanced_via_rule


