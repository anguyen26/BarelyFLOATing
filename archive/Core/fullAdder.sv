//takes in two 1bit numbers as well as a carry in and
//outputs the sum and carry out

// A, B - two bits to be added
// CIN - carry in bit for addition
// SUM - output sum of the two bits
// COUT - if a carry out is made 
module fullAdder (
	input logic A, B, CIN,
	output logic SUM, COUT
);
	
	//sum is always the XOR of the two values and Cin
	assign SUM = A ^ B ^ CIN;
	//carry out is high if we every have 1 + 1 or higher
	assign COUT = (A & B) | (A & CIN) | (B & CIN);

endmodule
/*
module fullAdder_tb();
	// system signals
	logic A, B, CIN, SUM, COUT;
	logic clk;

	//declare the design under test
	fullAdder DUT(A, B, CIN, SUM, COUT);

	//simulated clock
	parameter period = 10;
	initial begin
		clk <= 0;
		forever #(period/2) clk <= ~clk;
	end

	//full coverage test
	initial begin
		A <= 0; B <= 0; CIN <= 0;	@(posedge clk);
		A <= 0; B <= 1; 				@(posedge clk);
		A <= 1; B <= 0; 				@(posedge clk);
		A <= 1; B <= 1; 				@(posedge clk);
							 				@(posedge clk);
		A <= 0; B <= 0; CIN <= 1;  @(posedge clk);
		A <= 0; B <= 1; 				@(posedge clk);
		A <= 1; B <= 0; 				@(posedge clk);
		A <= 1; B <= 1; 				@(posedge clk);
							 				@(posedge clk);
		$stop;
	end
endmodule
*/
