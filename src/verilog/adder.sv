// Creates a N bit adder
`timescale 1ps/1ps
module adder #(parameter N = 16) (in1, in2, out, cout);
	input  logic [N-1:0] in1, in2;
	output logic [N-1:0] out;
	output logic cout;
	
	// Carry outs
	logic [N-2:0] middleCarryOuts;

	// Adder for the bottom bit
	full_adder bottomBit(.a(in1[0]), .b(in2[0]), .cin(1'b0), .cout(middleCarryOuts[0]), .s(out[0]));
	
	// Generate the middle bit full adders and connect each cin to the previous cout
	genvar i;
	generate
		for (i = 1; i < N-1; i++) begin: eachBit
			full_adder genAdder(.a(in1[i]), .b(in2[i]), .cin(middleCarryOuts[i-1]), .cout(middleCarryOuts[i]), .s(out[i]));
		end
	endgenerate
	
	// Top bit of the full add
	full_adder topBit(.a(in1[N-1]), .b(in2[N-1]), .cin(middleCarryOuts[N-2]), .cout(cout), .s(out[N-1]));

endmodule
/*
// Tests that the adder outputs the sum of the two inputs
module adder_testbench();
	logic in1, in2;
	logic out, cout;
	
	integer i;
	
	adder dut(.*);
	
	initial begin
		in1 = 64'd0; in2 = 64'd1; #200;
		in1 = 64'd1; in2 = 64'd0; #200;
		in1 = 64'd20; in2 = 64'd42; #200;
		in1 = 64'd0; in2 = 64'd0; #200;
	$stop;
	end
endmodule
*/
