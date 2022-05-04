module shifter(
	input 	logic	signed		[15:0]	value,
	input 	logic				[1:0]	mode, // 0: LSL, 1: LSR, 2: ASR, 3: ROR
	input 	logic signed		[15:0]	distance,
	output 	logic signed 		[15:0]	result, result2
	);
	
	logic signed [15:0] distancePrime;
	logic [15:0] ROT, ROTPrime;
	assign distancePrime = distance * -1;
	assign ROT = (distance % 16) + 1;
	assign ROTPrime = (distancePrime % 16) + 1;

	always_comb begin
		case(distance[15])
			1: begin
				
				case(mode)
					0: result = $signed(value >> distancePrime);
					1: result = $signed(value << distancePrime);
					2: result = $signed(value << distancePrime);
					3: result = $signed((value >> 16-distancePrime) | (value << distancePrime)); //This might be broken
					default: result = 16'd0;
				endcase
			end
			0: begin
				case(mode)
					0: result = $signed(value << distance);
					1: result = $signed(value >> distance);
					2: result = $signed(value >>> distance);
					3: result = $signed((value << 16-ROT) | (value >> ROT));  //This works 
					default: result = 16'd0;
				endcase
			end
		endcase
	end

endmodule

/*
module shifter_testbench();
	logic signed	[15:0]	value;
	logic 			[1:0]	mode;
	logic signed 	[15:0]	distance;
	logic signed	[15:0]	result;
	
	shifter dut (.value, .mode, .distance, .result);
	
	initial begin     
        $vcdpluson;
        value = 16'b1011100001101011;
        value2 = 16'b1011100001101011;
        distance = 16'd6;
        for (int i=0; i<4; i++) begin
            mode = i; #10;
        end
        distance = 16'b1111111111111101;
        for (int i=0; i<4; i++) begin
            mode = i; #10;
        end
        $stop;
	end
endmodule
*/
