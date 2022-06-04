vcs:
	vcs -f cpu.include +v2k -R +lint=all -sverilog -full64 -debug_pp \
		-timescale=1ns/10ps -l cpu.log
	sed -i 's,^[ \t]*,,' sv_output.txt
	sed -i 's,=[ \t]*,= ,' sv_output.txt
	sed -i 's,\[[ \t]*,[,' sv_output.txt
dve:
	dve -full64 -vpd vcdplus.vpd &
