// mux2xn_n takes 2 data input n'b and 1 select bit, 
// then copies one of the input bits to the output based on the selection bit
`timescale 1ps/1ps
module mux2xn_n #(parameter N=16) (
	input logic [N-1:0] i0, i1,
	input logic sel,
	output logic [N-1:0] out
);

	always_comb begin
		case(sel)
			1'b0: out = i0;
			1'b1: out = i1;
		endcase
	end
endmodule
