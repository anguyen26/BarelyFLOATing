all: vcs read_out

vcs:
	vcs -f fp.include +v2k -R +lint=all -sverilog -full64 -debug_pp \
		-timescale=1ns/10ps -l fp.log
read_out:
	python3 convertFPUout.py fp_output.txt
	cat fp_output_dec.txt

dve:
	dve -full64 -vpd vcdplus.vpd &
