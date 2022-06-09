
# CONFIGURATION
# ==========================================================================

set TOOL_NAME "ICC"

# directory where tcl src is located 
set SRC_DIR "../../src/apr"

# start timing
set start_time [clock seconds]; echo [clock format $start_time -gmt false]

remove_design -all

source ${SRC_DIR}/config.tcl -echo -verbose
source ${SRC_DIR}/phys_vars.tcl -echo -verbose

file mkdir $results
file mkdir $reports

# remove unused ports?
source -echo ./remove_unused_ports.tcl

source ${SRC_DIR}/library.tcl -echo -verbose

# READ DESIGN
# ==========================================================================
# Read in the verilog, uniquify and save the CEL view.
import_designs ../syn/results/$design_name.syn.v -format verilog -top $design_name
link

remove_unused_ports

# TIMING CONSTRAINTS
# ==========================================================================
source ${SRC_DIR}/constraints.tcl -echo
save_mw_cel -as ${design_name}_init

# FLOORPLAN CREATION
# =========================================================================
# Create core shape and pin placement
source ${SRC_DIR}/floorplan.tcl -echo

# PHYSICAL POWER NETWORK
# ==========================================================================
save_mw_cel -as ${design_name}_prepns
source ${SRC_DIR}/power.tcl -echo

# PLACEMENT OPTIMIZATION
# ==========================================================================
save_mw_cel -as ${design_name}_preplaceopt
source ${SRC_DIR}/placeopt.tcl -echo

# CTS & CLOCK ROUTING
# ==========================================================================
save_mw_cel -as ${design_name}_preclock
source ${SRC_DIR}/clocks.tcl

# SIGNAL ROUTING
# ==========================================================================
save_mw_cel -as ${design_name}_preroute
source ${SRC_DIR}/route.tcl -echo

# FINAL FINISHING
# ==========================================================================
save_mw_cel -as ${design_name}_prefinished
source ${SRC_DIR}/finishing.tcl -echo

# GENERATE DESIGN FILES AND REPORTS
# ==========================================================================
save_mw_cel -as ${design_name}_finished
source ${SRC_DIR}/generate.tcl -echo
save_mw_cel -as ${design_name}


# DRC
# ==========================================================================
# report_drc -highlight -color green
source ${SRC_DIR}/report_drc.tcl -echo

# RUNTIME and MESSAGE SUMMARY
# ==========================================================================

print_message_info

set end_time [clock seconds]; echo [string toupper inform:] End time [clock format ${end_time} -gmt false]

# Total script wall clock run time
echo "[string toupper inform:] Time elapsed: [format %02d \
                     [expr ($end_time - $start_time)/86400]]d \
                    [clock format [expr ($end_time - $start_time)] \
                    -format %Hh%Mm%Ss -gmt true]"
