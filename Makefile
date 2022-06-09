# synthesizes the core RTL with the local tcl scrips
syn: 
	make -C sapr/syn syn
apr:
	make -C sapr/apr apr

vcs_apr:
	@ echo "Running instructions on APR Design..."
	make -C sim/post-apr vcs

vcs_syn:
	@ echo "Running instructions on SYN Design..."
	make -C sim/post-syn vcs

vcs:
	@ echo "Running instructions on Verilog Design..."
	make -C sim/pre-syn vcs

dve_apr:
	make -C sim/post-apr dve

dve_syn:
	make -C sim/post-syn dve

dve:
	make -C sim/pre-syn dve
