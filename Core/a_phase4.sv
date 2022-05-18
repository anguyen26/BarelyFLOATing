module a_phase4 (
	input logic [3:0] IN, EN,
	input logic RST,
	output logic [3:0] OUT
);
	integer i;
	always_comb begin
		if(RST) OUT = 4'b0000;
		else begin
			for(i=0; i<4; i=i+1) begin
				if(EN[i]) begin
					OUT[i] = IN[i];
				end
			end
		end
	end
endmodule
