# ==========================================================================
# CTS & CLOCK ROUTING
# ==========================================================================

# Get variable definitions
source ${SRC_DIR}/config.tcl
source ${SRC_DIR}/phys_vars.tcl
source ${SRC_DIR}/common_procs.tcl

# Make sure placement is good before CTS
check_legality -verbose

# Remove the ideal network before CTS
#remove_ideal_network [all_fanout -flat -clock_tree]

# Define the non-default routing rule for clock shielding (min widths)
define_routing_rule shield_rule \
    -shield_widths   {M1 0.1 M2 0.1 M3 0.1 M4 0.1 M5 0.1 M6 0.3} \
    -shield_spacings {M1 0.1 M2 0.1 M3 0.1 M4 0.1 M5 0.1 M6 0.3}

set CLK_BUFF [remove_from_collection [get_lib_cells */CKBD*] [get_lib_cells */CKBD2*]]
set CLK_INVS [remove_from_collection [get_lib_cells */CKND*] [get_lib_cells */CKND2*]]

set_clock_tree_references -references [concat $CLK_INVS $CLK_BUFF]
set_clock_tree_references -sizing_only -references [concat $CLK_INVS $CLK_BUFF]
# Set options for compile_clock_tree (all are pretty much default, except the routing rule)
set_clock_tree_options \
   -layer_list_for_sinks $CLOCK_ROUTING_LAYERS \
   -layer_list $CLOCK_ROUTING_LAYERS \
   -use_leaf_routing_rule_for_sinks 0 \
   -max_transition 0.080 \
   -leaf_max_transition 0.080 \
   -use_leaf_max_transition_on_exceptions TRUE \
   -use_leaf_max_transition_on_macros TRUE \
   -max_capacitance 0.08 \
   -max_fanout 12 \
   -target_early_delay 0.000 \
   -target_skew 0.000 \
   -gate_sizing TRUE \
   -buffer_sizing TRUE 
#   -buffer_relocation TRUE \
#   -gate_relocation TRUE
#   -routing_rule shield_rule

set_clock_tree_exceptions -float_pins [get_ports cpu_clk_o]\
                          -float_pin_max_delay_rise 0.04\
                          -float_pin_max_delay_fall 0.04\
                          -float_pin_min_delay_rise 0.04\
                          -float_pin_min_delay_fall 0.04

set_clock_tree_exceptions -float_pins [get_ports acc_clk_o]\
                          -float_pin_max_delay_rise 0.04\
                          -float_pin_max_delay_fall 0.04\
                          -float_pin_min_delay_rise 0.04\
                          -float_pin_min_delay_fall 0.04

#Block off metal layers from being routed
create_metal_blockage 8 10


#Run the clock!
set_fix_hold [all_clocks]
clock_opt

# Fix hold violations
#psynopt -only_hold_time

# Pre-route shielding
if {$SHIELD_CLOCK} {
create_zrt_shield \
   -mode new \
   -with_ground VSS \
   -preferred_direction_only true
}

# check status
#report_clock_tree \
#   -level_info \
#   -settings \
#   -structure \
#   -summary \
#   -histogram_transition $reports/clocktree.hist.transition \
#   -histogram_capacitance $reports/clocktree.hist.cap \
#   -histogram_rcdelay $reports/clocktree.hist.rcdelay

# Check again in case hold fixing broke stuff
verify_zrt_route

# Save current design (checkpoint)
save_mw_cel -as ${design_name}_postclk

# Analyze clock tree result with SPICE
# TODO update this
if {$ANALYZE_CLOCK_WITH_SPICE} {
   set source_pin    [get_pins "osc_0/vout"]
   set sink_pins     [get_pins */CP]
   set spicelib      "../src/lib/stdLibs.ctl"
   set driver_subckt "$TSMC_PATH/Back_End/spice/tcbn65gplus_200a/tcbn65gplus_200a.spi"
   analyze_subcircuit \
      -from $source_pin \
      -to $sink_pins \
      -clock "dco_clk" \
      -name  "dco_clk" \
      -simulator hspice64 \
      -output_directory clk_analysis \
      -spice_header_file $spicelib \
      -driver_subckt_file $driver_subckt \
      -input_rise_transition 0.01 \
      -input_fall_transition 0.01
}
