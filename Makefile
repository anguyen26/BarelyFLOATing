TEST=random

# generates random instructions and tests them
all: instr_gen edit_tb iarm vcs compare

# user sets $TEST and runs test
custom: edit_tb iarm vcs compare

edit_tb:
	sed -i 's;^with\(.*\);with open("tests/$(TEST).txt", "r") as f:;g' \
		iarm-master/run_iarm.py
	sed -i 's;^`define\(.*\).arm";`define BENCHMARK "../tests/$(TEST).arm"; g' \
		Core/instructmem.sv

instr_gen:
	@ echo "Generating random instructions..."
	python3 tests/instr_gen.py
	@ echo "Converting assembly instructions to binary..."
	python3 tests/assem_to_bin.py random > notes_assem_to_bin.txt

iarm:
	@ echo "Running instructions on iarm..."
	@ python3 iarm-master/run_iarm.py | python3 iarm-master/format_iarm.py

vcs:
	@ echo "Running instructions on BarelyFLOATing CPU..."
	make -C Core vcs

dve:
	make -C Core dve

compare: 
	@ echo "Comparing expected results to actual results..."
	@ diff -cs iarm-master/iarm_output.txt Core/sv_output.txt
