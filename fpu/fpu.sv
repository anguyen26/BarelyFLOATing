module fpu(
	input logic clk, reset,
	input logic [15:0] opA, opB,
	input logic [1:0] op,
	output logic [15:0] result,
	output logic [3:0] FPUFlags,
	output logic overflow, underflow, inexact
);

	logic [15:0] newOpB;
	logic [15:0] sum, product, quotient;
	logic aUnderflow, aOverflow, aInexact,
			pUnderflow, pOverflow, pInexact,
			qUnderflow, qOverflow, qInexact;
	logic cout;

	assign newOpB = (op == 2'd0) ? opB : {~opB[15], opB[14:0]};
	fp_add add_sub(.clk, .reset, .opA, .opB(newOpB), .sum,
		.underflow(aUnderflow), .overflow(aOverflow), .inexact(aInexact), .cout);

	fp_mul multiply(.clk, .reset, .opA, .opB, .product, .underflow(pUnderflow),
		.overflow(pOverflow), .inexact(pInexact));

	fp_div divide(.clk, .reset, .opA, .opB, .quotient,
		.underflow(qUnderflow), .overflow(qOverflow), .inexact(qInexact));

	//assign flags bits
	assign FPUFlags[3] = result[15]; //N-flag is the sign bit of the result
	assign FPUFlags[2] = (result[14:0] == 15'b0); //Z-flag if result is zero
	assign FPUFlags[1] = cout; //C-flag
	assign FPUFlags[0] = overflow; //O-flag

	always_comb begin
		case(op)
			2'b00: begin
				result = sum;
				overflow = aOverflow;
				underflow = aUnderflow;
				inexact = aInexact;
			end
			2'b01: begin
				result = sum;
				overflow = aOverflow;
				underflow = aUnderflow;
				inexact = aInexact;
			end
			2'b10: begin
				result = product;
				overflow = pOverflow;
				underflow = pUnderflow;
				inexact = pInexact;
			end
			2'b11: begin
				result = quotient;
				overflow = qOverflow;
				underflow = qUnderflow;
				inexact = qInexact;
			end
		endcase
	end

endmodule
