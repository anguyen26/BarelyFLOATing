TEST=log2
NUM_TESTS=1
TESTID=1
PASSED=0

# runs 32 random sqrt(x) calcs
sqrt:
	@ rm -f sqrt_input.txt
	@ rm -f converted.txt
	@ i=1; while [[ $$i -le $(NUM_TESTS) ]] ; do \
		echo 'Running test #' $$i '...' ; \
		$(MAKE) simpleSqrt TEST=simpleSqrt TESTID=$$i -i --no-print-directory; \
		((i = i + 1)) ; \
		echo '--------------------------------------' ; \
	done
	@ echo "Comparing expected results to actual results..."
	@ python3 compare_sqrt.py

log2: edit_tb vcs print_log2_result compare_to_log

# runs 1 random sqrt(x) calc
simpleSqrt: edit_tb 
	@ echo 'Generating random input...'
	@ echo 'Input ='
	@ python3 genSqrtTest.py
	@ $(MAKE) vcs
	@ $(MAKE) read_vcs_out

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
	@ echo "Running algorithm on BarelyFLOATing CPU..."
	@ vcs -f cpu.include +v2k -R -sverilog -full64 -debug_pp \
		-timescale=1ns/10ps -l cpu.log
	@ sed -i 's,^[ \t]*,,' sv_output.txt
	@ sed -i 's,=[ \t]*,= ,' sv_output.txt
	@ sed -i 's,\[[ \t]*,[,' sv_output.txt

dve:
	@ dve -full64 -vpd vcdplus.vpd -session session.vcdplus.vpd.tcl &

read_vcs_out:
	@ echo "Converting binary results to decimal..."
	@ echo "Result ="
	@ python3 bfloatToDec.py convertMe.txt converted.txt
