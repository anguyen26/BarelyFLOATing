// Instruction ROM.  Supports reads only, but is initialized based upon the file specified.
// All accesses are 16-bit.  Addresses are byte-addresses, and must be word-aligned (bottom
// two words of the address must be 0).
//
// To change the file that is loaded, edit the filename here:
//`define BENCHMARK "../benchmarks/custom.arm"
//`define BENCHMARK "../benchmarks/test01_MovAddSub.arm"
//`define BENCHMARK "../benchmarks/test02_AddsSubs.arm"
//`define BENCHMARK "../benchmarks/each_binary_instr.txt"
//`define BENCHMARK "../benchmarks/test03_CbzB.arm"
//`define BENCHMARK "../benchmarks/test04_LdurStur.arm"
//`define BENCHMARK "../benchmarks/test05_Blt.arm"
//`define BENCHMARK "../benchmarks/test06_MulLslLsr.arm"
//`define BENCHMARK "../benchmarks/test10_forwarding.arm"
//`define BENCHMARK "../benchmarks/test11_Sort.arm"
//`define BENCHMARK "../benchmarks/test12_Division.arm"
//`define BENCHMARK "../tests/ random25 loadInstr(.MEM(mem));
`timescale 1ns/10ps

// How many bytes are in our memory?  Must be a power of two.
`define INSTRUCT_MEM_SIZE           64
	
module instructmem_syn (
	input	logic		[15:0]	address,
	output	logic		[15:0]	instruction,
	input	logic				clk	// Memory is combinational, but used for error-checking
	);

	// The data storage itself.
	logic [15:0] mem [`INSTRUCT_MEM_SIZE-1:0];

	
	
	
	// Load the program - change the filename to pick a different program.
	random loadInstr(.MEM(mem));
	initial begin
		
		$display("Running benchmark: ", `BENCHMARK);
	end

	// Handle the reads.
	integer i;
	always_comb begin
		if (address / 4 >= `INSTRUCT_MEM_SIZE)
			instruction = 16'b11100_00000000000;
		else
			instruction = mem[address/4];
	end
		
endmodule
/*
module instructmem_testbench ();

	parameter ClockDelay = 5000;

	logic		[63:0]	address;
	logic					clk;
	logic		[31:0]	instruction;
	
	instructmem dut (.address, .instruction, .clk);
	
	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	integer i;
	initial begin
		// Read every location, including just past the end of the memory.
		for (i=0; i <= `INSTRUCT_MEM_SIZE; i = i + 4) begin
			address <= i;
			@(posedge clk); 
		end
		$stop;
		
	end
endmodule
*/
