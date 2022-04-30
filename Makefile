TEST=?

benchmark: set_benchmark iarm vcs compare

set_benchmark:
	sed -i 's;^with\(.*\);with open("benchmarks/$(TEST).txt", "r") as f:;g' \
		iarm-master/run_iarm.py
	sed -i 's;^`define\(.*\).arm";`define BENCHMARK "../benchmarks/$(TEST).arm"; g' \
		Core/instructmem.sv
instr_gen:
	@ echo "Generating random instructions..."
	python3 instr_gen.py
	@ echo "Converting assembly instructions to binary..."
	python3 assem_to_bin.py

iarm:
	@ echo "Running instructions on iarm..."
	@ python3 iarm-master/run_iarm.py | python3 format_iarm.py

vcs:
	@ echo "Running instructions on BarelyFLOATing CPU..."
	make -C Core vcs

dve:
	make -C Core dve

compare: 
	@ echo "Comparing expected results to actual results..."
	@ diff -cs iarm_output.txt Core/sv_output.txt
