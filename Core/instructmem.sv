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
`define BENCHMARK "../tests/random.arm"
`timescale 1ns/10ps

// How many bytes are in our memory?  Must be a power of two.
`define INSTRUCT_MEM_SIZE           64
	
module instructmem (
	input	logic		[15:0]	address,
	output	logic		[15:0]	instruction,
	input	logic				clk	// Memory is combinational, but used for error-checking
	);

	// The data storage itself.
	logic [15:0] mem [`INSTRUCT_MEM_SIZE-1:0];

	/*
	// Force %t's to print in a nice format.
	initial $timeformat(-9, 2, " ns", 10);

	// Make sure size is a power of two and reasonable.
	initial assert((`INSTRUCT_MEM_SIZE & (`INSTRUCT_MEM_SIZE-1)) == 0 && `INSTRUCT_MEM_SIZE > 4);
	
	// Make sure accesses are reasonable.
	always_ff @(posedge clk) begin
		if (address != 'x) begin // address or size could be all X's at startup, so ignore this case.
			assert(address[1:0] == 0);	// Makes sure address is aligned.
			assert(address + 3 < `INSTRUCT_MEM_SIZE);	// Make sure address in bounds.
		end
	end
	
	
	
	// Load the program - change the filename to pick a different program.
	initial begin
		$readmemb(`BENCHMARK, mem);
		$display("Running benchmark: ", `BENCHMARK);
	end
	*/

	// Handle the reads.
	integer i;
	always_comb begin
		/*
		if (address + 3 >= `INSTRUCT_MEM_SIZE)
			instruction = 'x;
		else
			instruction = mem[address/4];
		*/
		case(address/4)
			16'd0:	instruction = 16'b0100001111_011_111 ;   // MVNS R7, R3
			16'd1:	instruction = 16'b01101_10000_001_001;    // LDR R1, [R1, #16]
			16'd2:	instruction = 16'b0100001010_011_010 ;   // CMP R2, R3
			16'd3:	instruction = 16'b0001110_011_011_001;    // ADDS R1, R3, #3
			16'd4:	instruction = 16'b0001101_000_011_010;    // SUBS R2, R3, R0
			16'd5:	instruction = 16'b0100000100_001_110 ;   // ASRS R6, R1
			16'd6:	instruction = 16'b0100000001_011_010 ;   // EORS R2, R3
			16'd7:	instruction = 16'b101100001_0110100  ;  // SUB SP, SP, #52
			16'd8:	instruction = 16'b0100000010_100_001 ;   // LSLS R1, R4
			16'd9:	instruction = 16'b101100000_0100100  ;  // ADD SP, SP, #36
			16'd10:	instruction = 16'b01101_11000_001_011;    // LDR R3, [R1, #24]
			16'd11:	instruction = 16'b01101_01000_000_010;    // LDR R2, [R0, #8]
			16'd12:	instruction = 16'b0100001100_001_111 ;   // ORRS R7, R1
			16'd13:	instruction = 16'b0100000111_001_110 ;   // RORS R6, R1
			16'd14:	instruction = 16'b0100001111_110_000 ;   // MVNS R0, R6
			16'd15:	instruction = 16'b0100001010_011_100 ;   // CMP R4, R3
			16'd16:	instruction = 16'b1101_1001_00011010 ;   // BLS 26
			16'd17:	instruction = 16'b1011_1111_0000_0000;    // NOOP
			16'd18:	instruction = 16'b00100_101_01000110 ;   // MOVS R5, #70
			16'd19:	instruction = 16'b0100000100_101_110 ;   // ASRS R6, R5
			16'd20:	instruction = 16'b010001100_0001_101 ;   // MOV R5, R1
			16'd21:	instruction = 16'b0001101_101_100_110;    // SUBS R6, R4, R5
			16'd22:	instruction = 16'b0100000010_011_101 ;   // LSLS R5, R3
			16'd23:	instruction = 16'b0100000001_110_101 ;   // EORS R5, R6
			16'd24:	instruction = 16'b0100001111_011_110 ;   // MVNS R6, R3
			16'd25:	instruction = 16'b0001100_101_001_101;    // ADDS R5, R1, R5
			16'd26:	instruction = 16'b0100000100_110_110 ;   // ASRS R6, R6
			16'd27:	instruction = 16'b0100001100_101_111 ;   // ORRS R7, R5
			16'd28:	instruction = 16'b0100001111_101_001 ;   // MVNS R1, R5
			16'd29:	instruction = 16'b00100_111_10000000 ;   // MOVS R7, #128
			16'd30:	instruction = 16'b01101_00000_010_011;    // LDR R3, [R2, #0]
			16'd31:	instruction = 16'b0100001100_000_011 ;   // ORRS R3, R0
			16'd32:	instruction = 16'b0001101_111_111_001;    // SUBS R1, R7, R7
			16'd33:	instruction = 16'b0100000011_100_101 ;   // LSRS R5, R4
			16'd34:	instruction = 16'b0100001010_111_100 ;   // CMP R4, R7
			16'd35:	instruction = 16'b01100_01100_101_011;    // STR R3, [R5, #12]
			16'd36:	instruction = 16'b01100_00000_010_100;    // STR R4, [R2, #0]
			16'd37:	instruction = 16'b0100000111_110_111 ;   // RORS R7, R6
			16'd38:	instruction = 16'b01101_10100_001_010;    // LDR R2, [R1, #20]
			16'd39:	instruction = 16'b0001110_011_011_011;    // ADDS R3, R3, #3
			16'd40:	instruction = 16'b0001101_100_111_111;    // SUBS R7, R7, R4
			16'd41:	instruction = 16'b0001100_011_001_011;    // ADDS R3, R1, R3
			16'd42:	instruction = 16'b101100001_0101100  ;  //26 SUB SP, SP, #44
			16'd43:	instruction = 16'b0100001010_100_001 ;   // CMP R1, R4
			16'd44:	instruction = 16'b0100001111_110_110 ;   // MVNS R6, R6
			16'd45:	instruction = 16'b0100001100_001_100 ;   // ORRS R4, R1
			16'd46:	instruction = 16'b010001100_0100_000 ;   // MOV R0, R4
			16'd47:	instruction = 16'b0100000001_100_100 ;   // EORS R4, R4
			16'd48:	instruction = 16'b0001100_011_111_011;    // ADDS R3, R7, R3
			16'd49:	instruction = 16'b101100000_1001100  ;  // ADD SP, SP, #76
			16'd50:	instruction = 16'b0100000111_011_110 ;   // RORS R6, R3
			16'd51:	instruction = 16'b0100000100_100_100 ;   // ASRS R4, R4
			16'd52:	instruction = 16'b0100000100_011_011 ;   // ASRS R3, R3
			16'd53:	instruction = 16'b010001100_1011_110 ;   // MOV R6, R11
			16'd54:	instruction = 16'b0001101_011_001_101;    // SUBS R5, R1, R3
			16'd55:	instruction = 16'b01100_01100_000_110;    // STR R6, [R0, #12]
			16'd56:	instruction = 16'b101100000_0111100  ;  // ADD SP, SP, #60
			16'd57:	instruction = 16'b0100000000_001_110 ;   // ANDS R6, R1
			16'd58:	instruction = 16'b0100000111_101_010 ;   // RORS R2, R5
			16'd59:	instruction = 16'b0100001111_100_001 ;   // MVNS R1, R4
			16'd60:	instruction = 16'b0100000001_111_011 ;   // EORS R3, R7
			16'd61:	instruction = 16'b010001100_0000_100 ;   // MOV R4, R0
			16'd62:	instruction = 16'b010001100_0001_010 ;   // MOV R2, R1
			16'd63:	instruction = 16'b0100000011_000_110 ;   // LSRS R6, R0
			16'd64:	instruction = 16'b01100_11100_111_111;    // STR R7, [R7, #28]
			16'd65:	instruction = 16'b11100_00000000000  ;   // B stop
		endcase
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
