// mux3x16_16 takes 3 data input 16b and 2 select bit, 
// then copies one of the input bits to the output based on the selection bit
`timescale 1ps/1ps
module mux2(
	input logic [7:0] i0, i1,
	input logic sel,
	output logic [7:0] out
    );

	always_comb begin
		case(sel)
			1'b0: out = i0;
			1'b1: out = i1;
		endcase
	end
endmodule
