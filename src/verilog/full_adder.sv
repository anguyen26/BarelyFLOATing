// full_adder takes single-bit a, b, and cin, adds all 3 bits together, then outputs the sum as s and the carry-over bit as cout
`timescale 1ps/1ps
module full_adder(a, b, cin, cout, s);
	input logic a, b, cin;
	output logic cout, s;
	
	// Create intermediate values for cout
	logic c1, c2, c3;
	
	// sum = a xor b xor cin
	xor #50 sumOut (s, a, b, cin);
	
	// cout = a&b | a&cin | b&cin
	and #50 c1And (c1, a, b);
	and #50 c2And (c2, a, cin);
	and #50 c3And (c3, b, cin);
	
	or #50 coutOr (cout, c1, c2, c3);
endmodule
/*
// full_adder_testbench tests all possible combinations of a, b, and cin
module full_adder_testbench();
	logic a, b, cin;
	logic cout, s;
	
	integer i;
	
	full_adder dut(.*);
	
	initial begin
	for (i = 0; i < 8; i++) begin
		{a, b, cin} = i; #200;
	end
	$stop;
	end
endmodule
*/
