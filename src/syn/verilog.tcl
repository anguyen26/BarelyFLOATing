
# Read in the design RTL
# ======================================
set_svf ./$results/$TOPLEVEL.syn.svf
define_design_lib WORK -path ./tmp/WORK

puts $RTL_SOURCE_FILES

analyze -format sverilog $RTL_SOURCE_FILES -define $RTL_DEFINES
set_app_var template_parameter_style "%d"
elaborate $TOPLEVEL
link

current_design $TOPLEVEL
