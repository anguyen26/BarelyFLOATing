
set TOOL_NAME "DC"

# begin timing
set start_time [clock seconds] ; echo [clock format ${start_time} -gmt false]
echo [pwd]
print_suppressed_messages

remove_design -all

# Multicore acceleration
if {$TOOL_NAME != "PTPX"} {
    if {$env(CPU_CORES) > 16} {
        set_host_options -max_cores 16;
    } else {
        set_host_options -max_cores $env(CPU_CORES);
    }
}

# Configuration                                                               #
#=============================================================================#

# Get configuration settings
source -echo -verbose ./config.tcl

# Read technology library                                                     #
#=============================================================================#
source -echo -verbose ./library.tcl

## Read design RTL                                                             #
##=============================================================================#
source -echo -verbose ./verilog.tcl
#
## Set design constraints                                                      #
##=============================================================================#
source -echo -verbose ./constraints.tcl

# source -echo -verbose ./dont_use.tcl
# Synthesize                                                                  #
#=============================================================================#

# Prevent assignment statements in the Verilog netlist.
set_fix_multiple_port_nets -all -buffer_constants

# Run topdown synthesis
# (this should be set already)
current_design $TOPLEVEL

check_design > "./$reports/check_design_warnings.rpt"
# Set the compilation options
if {$DC_FLATTEN} {
   set_flatten true -effort $DC_FLATTEN_EFFORT
}
if {$DC_STRUCTURE} {
   set_structure true -timing $DC_STRUCTURE_TIMING -boolean $DC_STRUCTURE_LOGIC
}

set COMPILE_ARGS [list]
if {$DC_KEEP_HIER} {
    lappend COMPILE_ARGS "-no_autoungroup"
    # lappend COMPILE_ARGS "-no_boundary_optimization"
}
if {$DC_REG_RETIME} {
    set_optimize_registers -async_transform $DC_REG_RETIME_XFORM \
	-sync_transform  $DC_REG_RETIME_XFORM
    lappend COMPILE_ARGS "-retime"
}

# Check for design errors
check_design -summary
check_design > "./$reports/check_design.rpt"

eval compile_ultra $COMPILE_ARGS 

# Second pass, if enabled
if {$DC_COMPILE_ADDITIONAL} {
   compile_ultra -incremental
}

# Remove unused ports                                                         #
#=============================================================================#
remove_unused_ports

# Reports generation                                                          #
#=============================================================================#
source -echo -verbose ./reports.tcl

# Generate design data                                                        #
#=============================================================================#
source -echo -verbose ./generate.tcl

# Report runtime and quit
#=============================================================================#

# Error/warning summary
print_message_info

# Print runtime
set end_time [clock seconds]; echo [string toupper inform:] End time [clock format ${end_time} -gmt false]
echo "[string toupper inform:] Time elapsed: [format %02d \
                     [expr ($end_time - $start_time)/86400]]d \
                    [clock format [expr ($end_time - $start_time)] \
                    -format %Hh%Mm%Ss -gmt true]"

exit
