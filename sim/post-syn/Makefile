TEST=simpleSqrt
NUM_TESTS=32
TESTID=1
PASSED=0

# runs 32 random sqrt(x) calcs
32sqrt:
	@ python3 clean_sqrt.py
	@ i=1; while [[ $$i -le $(NUM_TESTS) ]] ; do \
		echo 'Running test #' $$i '...' ; \
		$(MAKE) sqrt TESTID=$$i -i --no-print-directory; \
		((i = i + 1)) ; \
		echo '--------------------------------------' ; \
	done
	@ python3 sqrt.py
	@ python3 convert_sqrt_out.py
	@ python3 compare_sqrt.py

log2: edit_tb vcs print_log2_result compare_to_log
sqrt: dec_to_fp edit_tb vcs
simple: edit_tb 
	@ python3 clean_sqrt.py
	$(MAKE) vcs
	python3 convert_sqrt_out.py
	cat sqrt_result_dec.txt
	$(MAKE) read_out
	cat converted.txt
bench: edit_tb vcs

edit_tb:
	@ sed -i 's;^`define\(.*\)";`define BENCHMARK "../../src/assembler/$(TEST).v"; g' \
		../../src/verilog/instructmem.sv

print_log2_result:
	@ echo "log2(x) =" \
	$$(cat log2_result.txt); \
        echo $

compare_to_log:
	@ python3 convert_log.py log2_error.txt
	@ python3 compare_log.py log_output_dec.txt expected_log.txt

dec_to_fp:
	@ python3 convert_x.py

vcs:
	@ echo "Running instructions on BarelyFLOATing CPU..."
	@ vcs -f cpu.include +v2k -R -sverilog -full64 -debug_pp \
		-timescale=1ns/10ps -l cpu.log
	@ sed -i 's,^[ \t]*,,' sv_output.txt
	@ sed -i 's,=[ \t]*,= ,' sv_output.txt
	@ sed -i 's,\[[ \t]*,[,' sv_output.txt

dve:
	@ dve -full64 -vpd vcdplus.vpd -session session.vcdplus.vpd.tcl &

read_out:
	@ echo "Converting binary results to decimal..."
	@ python3 convertFPUout.py convertMe.txt
