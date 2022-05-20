TEST=random

# generates random instructions and tests them
all: instr_gen edit_tb iarm vcs compare

# user sets $TEST and runs test
# run 'make custom' to rerun the last random test that was generated
custom: edit_tb iarm vcs compare

gcd:
	sed -i 's;^`define\(.*\)";`define BENCHMARK "../assembler/gcd.v"; g' \
		Core/instructmem.sv
	make -C Core vcs

fib:
	sed -i 's;^`define\(.*\)";`define BENCHMARK "../assembler/fibonacci.v"; g' \
		Core/instructmem.sv
	make -C Core vcs

acker:
	sed -i 's;^`define\(.*\)";`define BENCHMARK "../assembler/ackermann.v"; g' \
		Core/instructmem.sv
	make -C Core vcs

simple:
	sed -i 's;^`define\(.*\)";`define BENCHMARK "../assembler/simpleAckermann.v"; g' \
		Core/instructmem.sv
	make -C Core vcs

edit_tb:
	sed -i 's;^with\(.*\);with open("tests/$(TEST).txt", "r") as f:;g' \
		iarm-master/run_iarm.py
	sed -i 's;^`define\(.*\)";`define BENCHMARK "../tests/$(TEST).arm"; g' \
		Core/instructmem.sv

instr_gen:
	@ echo "Generating random instructions..."
	python3 tests/instr_gen.py
	@ echo "Converting assembly instructions to binary..."
	python3 tests/assem_to_bin.py random > tests/notes_assem_to_bin.txt

iarm:
	@ echo "Running instructions on iarm..."
	@ python3 iarm-master/run_iarm.py | python3 iarm-master/format_iarm.py
	mv debug_iarm.txt iarm-master/.

vcs:
	@ echo "Running instructions on BarelyFLOATing CPU..."
	make -C Core vcs

dve:
	make -C Core dve

compare: 
	@ echo "Comparing expected results to actual results..."
	@ diff -cs iarm-master/iarm_output.txt Core/sv_output.txt
