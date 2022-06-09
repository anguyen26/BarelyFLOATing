
# ==========================================================================
# TIMING CONSTRAINTS
# ==========================================================================

# Read timing and apply constraints from synthesis
read_sdc ./$design_name.syn.sdc
check_timing

# Set setup/hold derating factors
# - 0% derate
set_timing_derate -early 1.0
set_timing_derate -late  1.0

# 04272021
# set_max_transition 0.20 [current_design]
# Check for false or multicycle path settings, any disabled arcs and case_analysis settings
#report_timing_requirements
#report_disable_timing
#report_case_analysis
set CLK_PORT [list clk]
group_path -name "Inputs"       -from [remove_from_collection [all_inputs] [get_ports $CLK_PORT]]
group_path -name "Outputs"      -to [all_outputs]
group_path -name "Feedthroughs" -from [remove_from_collection [all_inputs] [get_ports $CLK_PORT]] \
                                -to [all_outputs]
group_path -name "Regs_to_Regs" -from [all_registers] -to [all_registers]

# Check clock health and assumptions
report_clock -skew
report_clock

#set_false_path -from [get_clock dco_clk] -to [get_clock buck_clk]
#set_false_path -to [get_clock dco_clk] -from [get_clock buck_clk]
# Ensure that no net drives multiple ports, buffer logic constants instead of duplicating
set_fix_multiple_port_nets -all -buffer_constants

set BUFF_CELLS [list \
    "INVD1" \
    "INVD2" \
    "INVD4" \
    "BUFFD1" \
    "BUFFD2" \
    "BUFFD4"
]

set_ahfs_options \
        -default_reference $BUFF_CELLS

report_ahfs_options
