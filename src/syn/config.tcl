
# Project and design
# ==========================================================================
set TOPLEVEL "cpu"

# Design libraries 
set DESIGN_MW_LIB_NAME "${TOPLEVEL}_lib"
set PROCESS "65GP";
set CORNER "LOW"

set TECH2ITF_MAP_FILE "star.map_9M"
set MW_TECHFILE "tsmcn65_9lmT2.tf"

source -echo -verbose ./tech_node_config.tcl
# Source files 
# ==========================================================================
set RTL_TOP \
  [list \
    "../../src/verilog/cpu.sv"\
    "../../src/verilog/mux3x4_4.sv"\
    "../../src/verilog/mux3x16_16.sv"\
    "../../src/verilog/mux4x16_16.sv"\
    "../../src/verilog/mux4x4_4.sv"\
    "../../src/verilog/mux5x16_16.sv"\
    "../../src/verilog/shifter.sv"\
    "../../src/verilog/alu.sv"\
    "../../src/verilog/cpuControl.sv"\
    "../../src/verilog/pipelineReg.sv"\
    "../../src/verilog/register.sv"\
    "../../src/verilog/regfile.sv"\
    "../../src/verilog/forwardingUnit.sv"\
    "../../src/verilog/D_FF.sv"\
    "../../src/verilog/a_phase4.sv"\
    "../../src/verilog/fp_add.sv"\
    "../../src/verilog/fp_mul.sv"\
    "../../src/verilog/fpu.sv"\
    "../../src/verilog/fp_div.sv"
  ]

set RTL_SOURCE_FILES [concat $RTL_TOP]

set RTL_DEFINES \
  [list \
    "SAPR=1"
  ]


set MW_ADDITIONAL_REFERENCE_LIBS {}
set ADDITIONAL_TARGET_LIBS {}

# Silence the unholy number of warnings that are known to be harmless
suppress_message "DPI-025"
suppress_message "PSYN-485"
# Check for latches in RTL
set_app_var hdlin_check_no_latch true
# nand2 gate name for area size calculation
set NAND2_NAME    "ND2D1"

set CLK_PORT [list \
        "clk"
        ]

# Timing uncertainties
set clk_critical_range 0.010
set clk_setup_uncertainty 0.030
set clk_hold_uncertainty 0.030
## Transition
set clk_trans 0.1
set CLK_PERIOD 10

set max_fanout 32
set max_trans 0.5

#set blanket_output_delay 0.1
#set blanket_input_delay 0.1
set blanket_output_delay [expr {0.2 * $CLK_PERIOD}]
set blanket_input_delay [expr {0.2 * $CLK_PERIOD}]

set blanket_output_drive "${LIB_WC_NAME}/INVD1/ZN"
set blanket_input_load "${LIB_WC_NAME}/INVD16/I"
# DC compile options
# ==========================================================================

# Reduce runtime
set DC_PREFER_RUNTIME 0

# Preserve design hierarchy
set DC_KEEP_HIER 0

# Register retiming
set DC_REG_RETIME 0
set DC_REG_RETIME_XFORM "multiclass"

# Logic flattening
set DC_FLATTEN 0
set DC_FLATTEN_EFFORT "medium"

# Logic structuring
set DC_STRUCTURE 0
set DC_STRUCTURE_TIMING "true"
set DC_STRUCTURE_LOGIC  "true"

set DC_GLOBAL_CLK_GATING 0

# Do an additional incremental compile for better results
set DC_COMPILE_ADDITIONAL 1

## Result generation and reporting
## ==========================================================================
set results "results"
set reports "reports"
#
#
## Define any procedures you need
## ==========================================================================
source -echo ./remove_unused_ports.tcl
