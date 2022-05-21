TEST=fpuTest
NUM_TESTS=50
TESTID=1
PASSED=0

# runs saved random benchmarks (rb)
all:
	@ i=1; while [[ $$i -le $(NUM_TESTS) ]]  ; do \
		$(MAKE) rb_run1 TEST=rand_benchmarks/random$$i TESTID=$$i -i --no-print-directory; \
		((i = i + 1)) ; \
		echo '--------------------------------------' ; \
	done
	@ $(MAKE) report --no-print-directory

# creates new random benchmarks (cb) and runs them
create:
	@ i=31; while [[ $$i -le $(NUM_TESTS) ]] ; do \
		echo 'Running test #' $$i '...' ; \
		$(MAKE) cb_run1 TESTID=$$i -i --no-print-directory; \
		((i = i + 1)) ; \
		echo '--------------------------------------' ; \
	done
	@ $(MAKE) report --no-print-directory

# generates random instructions and tests them
cb_run1: instr_gen cb_edit_tb iarm vcs cb_compare

rb_run1: rb_edit_tb vcs rb_compare

# user sets $TEST and runs test
# run 'make custom' to rerun the last random test that was generated
custom: rb_edit_tb iarm vcs rb_compare

# runs user set $TEST on only the RTL
custom_RTL: rb_edit_tb vcs 

cb_edit_tb:
	@ sed -i 's;^with\(.*\);with open("tests/$(TEST).txt", "r") as f:;g' \
		iarm-master/run_iarm.py
	@ sed -i 's;^`define\(.*\).arm";`define BENCHMARK "../tests/$(TEST).arm"; g' \
		Core/instructmem.sv
rb_edit_tb:
	@ sed -i 's;^`define\(.*\).arm";`define BENCHMARK "../tests/$(TEST).arm"; g' \
		Core/instructmem.sv

instr_gen:
	@ echo "Generating random instructions..."
	@ python3 tests/instr_gen.py
	@ echo "Converting assembly instructions to binary..."
	@ python3 tests/assem_to_bin.py random > tests/notes_assem_to_bin.txt

iarm:
	@ echo "Running instructions on iarm..."
	@ python3 iarm-master/run_iarm.py | python3 iarm-master/format_iarm.py
	@ mv debug_iarm.txt iarm-master/.

vcs:
	@ echo "Running instructions on BarelyFLOATing CPU..."
	@ make -C Core vcs

dve:
	@ make -C Core dve

rb_compare:
	@ echo "Comparing expected results to actual results..."
	@ diff -cs tests/rand_benchmarks/iarm_output$(TESTID).txt Core/sv_output.txt > comp_output.txt
	@ $(MAKE) rb_report_compare --no-print-directory

cb_compare: 
	@ echo "Comparing expected results to actual results..."
	@ diff -cs iarm-master/iarm_output.txt Core/sv_output.txt > comp_output.txt
	@ $(MAKE) cb_report_compare --no-print-directory

cb_report_compare:
	@ if [ $(shell wc -l comp_output.txt | cut -f1 -d' ') = 1 ]; then \
		echo Test \#$(TESTID) passed ; \
		cp tests/random.arm tests/new_benchmarks/random$(TESTID).arm ; \
		cp tests/random.txt tests/new_benchmarks/random$(TESTID).txt ; \
		cp iarm-master/iarm_output.txt tests/new_benchmarks/iarm_output$(TESTID).txt ; \
		echo 1 >> count_passed.txt ; \
	else \
		echo Test \#$(TESTID) failed ; \
		diff -cs iarm-master/iarm_output.txt Core/sv_output.txt ; \
		cp tests/random.arm tests/cb_failed/random$(TESTID).arm ; \
		cp tests/random.txt tests/cb_failed/random$(TESTID).txt ; \
		cp iarm-master/iarm_output.txt tests/cb_failed/iarm_output$(TESTID).txt ; \
		cp Core/sv_output.txt tests/cb_failed/sv_output$(TESTID).txt ; \
		cp Core/vcdplus.vpd tests/cb_failed/vcdplus$(TESTID).vpd ; \
	fi

rb_report_compare:
	@ if [ $(shell wc -l comp_output.txt | cut -f1 -d' ') = 1 ]; then \
		echo Test \#$(TESTID) passed ; \
		echo 1 >> count_passed.txt ; \
	else \
		echo Test \#$(TESTID) failed ; \
		diff -cs tests/rand_benchmarks/iarm_output$(TESTID).txt Core/sv_output.txt ; \
		cp Core/sv_output.txt tests/rb_failed/sv_output$(TESTID).txt ; \
		cp Core/vcdplus.vpd tests/rb_failed/vcdplus$(TESTID).vpd ; \
	fi

report:
	@ count=$(shell wc -l count_passed.txt | cut -f1 -d' ') ;\
	echo $$count out of $(NUM_TESTS) tests passed
	@ rm -f count_passed.txt
	@ rm -f comp_output.txt
