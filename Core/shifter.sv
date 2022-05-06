module shifter(
	input logic	signed	[15:0]	value,
	input logic	[1:0]				mode, // 0: LSL, 1: LSR, 2: ASR, 3: ROR
	input	logic signed		[15:0]		distance,
	output logic signed [15:0]	result
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
	logic	[15:0]	value;
	logic [1:0]	mode;
	logic [15:0]		distance;
	logic [15:0]	result;
	
	shifter dut (.value, .mode, .distance, .result);
	
	integer i, dir;
	initial begin
        
		value = 64'hDEADBEEFDECAFBAD;
		for(dir=0; dir<2; dir++) begin
			direction <= dir[0];
			for(i=0; i<64; i++) begin
				distance <= i; #10;
			end
		end
        
        $vcdpluson;
        value = 16'b1011100001101011;
        distance = 16'd6;
        for (int i=0; i<4; i++) begin
            mode = i; #10;
        end
        distance = 16'b1111100001101011;
        for (int i=0; i<4; i++) begin
            mode = i; #10;
        end
        $finish;
	end
endmodule
*/
