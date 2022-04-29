//ripple carry adder with parameterized input

// opp0, opp1 - two n bit inputs to be added
// cin, cout - basic carry in/out signals
// out - output (nbit) of the add operation
module rippleCarryAdder #(parameter N = 32) (opp0, opp1, cin, cout, out);
	input logic [N-1:0] opp0, opp1;
	input logic cin;
	output logic cout;
	output logic [N-1:0] out;
	
	//setup variables that will be used
	logic [N-1:0] A, B;
	logic [N:0] cout_prev;
	assign cout_prev[0] = cin;
	assign cout = cout_prev[N];

	genvar i;

	//basic ripple carry adder
	generate
		for (i=0; i < N; i++) begin : adders
			//take the two bits @i and pass them to a full adder and wire the Couts and ins
			fullAdder FA_i (.A(opp0[i]), .B(opp1[i]), .CIN(cout_prev[i]), .SUM(out[i]), .COUT(cout_prev[i+1]));
		end
   endgenerate
endmodule 
/*
//test a smaller verison of the ripple carry adder at a smaller size
module rippleCarryAdder_tb();
	// system signals
	logic [23:0] opp0, opp1, out;
	logic clk;

	//declare the design under test
	rippleCarryAdder #(.N(24)) DUT (opp0, opp1, out);

	// Set up a simulated clock
	parameter period = 10;
	initial begin
		clk <= 0;
		forever #(period/2) clk <= ~clk;
	end

	//test some edge cases and random inputs
	initial begin
		opp0 <= 24'b000000000000000000000000; opp1 <= 24'b000000000000000000000000;	@(posedge clk);
		opp0 <= 24'b001010100100101010000100; opp1 <= 24'b111111010011111111010100;	@(posedge clk);
		opp0 <= 24'b010001111101010000000000; opp1 <= 24'b000000010100000001000000;	@(posedge clk);
		opp0 <= 24'b011111100000001010110000; opp1 <= 24'b000011111100000011000000;	@(posedge clk);
		@(posedge clk);
		$stop;
	end
endmodule
*/
