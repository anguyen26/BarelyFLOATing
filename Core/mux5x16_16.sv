// mux5x16_16 takes 5 data input 16b and 3 select bit, 
// then copies one of the input bits to the output based on the selection bit
`timescale 1ps/1ps
module mux5x16_16(
	input logic [15:0] i0, i1, i2, i3, i4,
	input logic [2:0] sel,
	output logic [15:0] out
);

	always_comb begin
		case(sel)
			3'b000: out = i0;
			3'b001: out = i1;
			3'b010: out = i2;
			3'b011: out = i3;
			3'b100: out = i4;
		endcase
	end
endmodule
