# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "mux3x4_4.sv"
vlog "mux4x4_4.sv"
vlog "mux3x16_16.sv"
vlog "mux4x16_16.sv"

vlog "full_adder.sv"
vlog "shifter.sv"
vlog "adder.sv"
vlog "fullAdder.sv"
vlog "alu.sv"
vlog "cpuControl.sv"
vlog "D_FF.sv"
vlog "register.sv"
vlog "register_2.sv"
vlog "register_3.sv"
vlog "register_4.sv"
vlog "register_5.sv"
vlog "regfile.sv"
vlog "datamem.sv"
vlog "instructmem.sv" 
vlog "rippleCarryAdder.sv"

vlog "forwarding.sv"

vlog "cpu.sv"
vlog "cpuStim.sv"



# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work cpuStim
# vsim -voptargs="+acc" -t 1ps -lib work forwarding_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do wave.do

# Set the window types
view wave
view structure
view signals


# Run the simulation
run -all