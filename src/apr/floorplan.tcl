
# Load variable definitions
source ${SRC_DIR}/config.tcl
source ${SRC_DIR}/phys_vars.tcl


derive_pg_connection -power_net $POWER_NET -power_pin $LIB_POWER_PIN -ground_net $GROUND_NET -ground_pin $LIB_GROUND_PIN
derive_pg_connection

# Place pins
if {[file isfile $PINPLACEMENT_TXT]} {
    exec python ${SRC_DIR}/gen_pin_placement.py -t $PINPLACEMENT_TXT -o $PINPLACEMENT_TCL
    }

if {[file isfile $PINPLACEMENT_TCL]} {
    # Fix the pin metal layer change problem
    set_fp_pin_constraints -hard_constraints {layer location} -block_level -use_physical_constraints on
    source $PINPLACEMENT_TCL
}

# Set the shape and size of the core

create_floorplan -control_type width_and_height \
                 -core_width  [expr $CORE_WIDTH] \
                 -core_height [expr $CORE_HEIGHT] \
                 -left_io2core $POWER_RING_CHANNEL_WIDTH \
                 -right_io2core $POWER_RING_CHANNEL_WIDTH \
                 -top_io2core $POWER_RING_CHANNEL_WIDTH \
                 -bottom_io2core $POWER_RING_CHANNEL_WIDTH \
                 -flip_first_row

cut_row -all
add_row \
   -within [get_attribute [get_core_area] bbox] \
   -top_offset $CELL_HEIGHT \
   -bottom_offset $CELL_HEIGHT
   
#-flip_first_row \


