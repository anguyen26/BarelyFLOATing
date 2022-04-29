// mux4x16_16 takes 4 data input 16b and 2 select bit, 
// then copies one of the input bits to the output based on the selection bit
`timescale 1ps/1ps
module mux4x16_16(
	input logic [15:0] i0, i1, i2, i3,
	input logic [1:0] sel,
	output logic [15:0] out
);

	always_comb begin
		case(sel)
			2'b00: out = i0;
			2'b01: out = i1;
			2'b10: out = i2;
			2'b11: out = i3;
		endcase
	end
endmodule