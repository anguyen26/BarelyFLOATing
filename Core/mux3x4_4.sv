// mux3x4_4 takes 3 data input 4b and 2 select bit, 
// then copies one of the input bits to the output based on the selection bit
`timescale 1ps/1ps
module mux3x4_4(
	input logic [3:0] i0, i1, i2,
	input logic [1:0] sel,
	output logic [3:0] out
);

	always_comb begin
		case(sel)
			2'b00: out = i0;
			2'b01: out = i1;
			2'b10: out = i2;
		endcase
	end
endmodule