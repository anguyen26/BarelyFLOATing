// Take in write and read adresses and determines where to forward data from

module forwardingUnit(
	input logic [3:0] 	RA1, RA2, WA3W,
	input logic 		RegWriteW,
	output logic 		Forward1, Forward2
);

	//logic to hold matching locations
	logic Match_1, Match_2;

	//Decode match from Writeback
	assign Match_1 = (RA1 == WA3W); 
	assign Match_2 = (RA2 == WA3W);

	//Cases for forwarding addr1
	always_comb begin
		if(Match_1 & RegWriteW)	Forward1 = 1'b1;
		else 			Forward1 = 1'b0;
	end

	//Cases for forwarding addr2
	always_comb begin
		if(Match_2 & RegWriteW)	Forward2 = 1'b1;
		else 			Forward2 = 1'b0;
	end

endmodule
