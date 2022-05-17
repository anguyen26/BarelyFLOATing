TEST=fibonacci


# generates random instructions and tests them
allRTL: instr_gen edit_tb iarm vcs compare

# run 'make custom' to rerun the last random test that was generated
customRTL: instr_syn_bench edit_tb vcs compare

simPost: vcs_post dve

#converts and loads data into imem then synthesizes design, the compares vs golden module
allSYN: instr_gen instr_syn syn vcs_post compare clean

#runs one of the benchmark random tests on syn core
customSYN: instr_syn_bench edit_iarm iarm syn vcs_post compare clean

simAPR: vcs_apr edit_iarm iarm compare clean

# synthesizes the core RTL with the local tcl scrips
syn: 
	make -C sapr/syn syn
apr:
	make -C sapr/apr apr


edit_tb:
	sed -i 's;^with\(.*\);with open("tests/$(TEST).txt", "r") as f:;g' \
		iarm-master/run_iarm.py
	sed -i 's;^`define\(.*\).arm";`define BENCHMARK "../tests/$(TEST).arm"; g' \
		Core/instructmem.sv

edit_iarm:
	sed -i 's;^with\(.*\);with open("tests/rand_benchmarks/$(TEST).txt", "r") as f:;g' \
		iarm-master/run_iarm.py


instr_gen:
	@ echo "Generating random instructions..."
	python3 tests/instr_gen.py
	@ echo "Converting assembly instructions to binary..."
	python3 tests/assem_to_bin.py random > tests/notes_assem_to_bin.txt

instr_syn:
	python3 tests/syn_instr_gen.py $(TEST)

instr_syn_bench:
	python3 tests/syn_benchmark.py $(TEST) 

	
iarm:
	@ echo "Running instructions on iarm..."
	@ python3 iarm-master/run_iarm.py | python3 iarm-master/format_iarm.py
	mv debug_iarm.txt iarm-master/.

vcs:
	@ echo "Running instructions on BarelyFLOATing CPU..."
	make -C Core vcs

vcs_post:
	@ echo "Running instructions on BarelyFLOATing CPU..."
	make -C Core vcs_post

vcs_apr:
	@ echo "Running instructions on APR Design..."
	make -C Core vcs_apr

dve:
	make -C Core dve

compare: 
	@ echo "Comparing expected results to actual results..."
	@ diff -cs iarm-master/iarm_output.txt Core/sv_output.txt

clean:
	-rm sapr/syn/*.pvl
	-rm sapr/syn/*.syn
	-rm sapr/syn/*.txt
	-rm sapr/syn/*.mr
	-rm sapr/syn/*.svf
	-rm sapr/syn/*.log
	-rm -r sapr/syn/alib-52/
	-rm -rf sapr/syn/cpu_design/
	-rm -rf sapr/apr/cpu_design/
	-find sapr/apr/ ! -name Makefile ! -name *.sdf ! -name *.v -type f -delete
	-rm command.log
