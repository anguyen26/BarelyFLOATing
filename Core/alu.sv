//this module impliments a 16bit ALU that can perform 5 operations (+ - & |)
//it impliments a ripple carry adder for addtion and subtraction

// a, b - two input opperands of 32b
// ALUControl - control signal to specifiy the operation to be performed on the opperands
// FlagWrite - control signal to store the flags from current op into a reg (for CPU)
// Result - 32b output of the operation from the ALU
// ALUFlags - vector to hold the four possible flags that the ALU can throw (zero, negative, carry, overflow)
// FlagsReg - register to hold the flags given FlagWrite
module alu (
	input logic [15:0] a, b,
	input logic [2:0] ALUControl,
	output logic [15:0] Result,
	output logic [3:0] ALUFlags
);
	//this hold the second opperand that goes to the ripple carry addder in the case of subtraction
	//when it needs to be inverted
	logic [15:0] temp_op;

	//initalize rippleCarryAdder
	logic carry;
	logic [15:0] adder_out;
	rippleCarryAdder #(.N(16)) A0 (.opp0(a), .opp1(temp_op), .cin(ALUControl[0]), .cout(carry), .out(adder_out));

	//assign static bits
	always_comb begin
		if (ALUControl == 3'b000 | ALUControl == 3'b001) begin
			ALUFlags[3] = Result[15]; //negative bit is the sign bit of the result
			ALUFlags[2] = (Result == 16'b0); //zero bit if result is zero
			ALUFlags[1] = 0; //carry out
			ALUFlags[0] = (temp_op[15] && a[15] && (!Result[15])) || ((!temp_op[15]) && (!a[15]) && Result[15]);
		end
		else if(ALUControl == 3'b110) begin
			ALUFlags[3] = Result[15]; //negative bit is the sign bit of the result
			ALUFlags[2] = (Result == 16'b0); //zero bit if result is zero
			ALUFlags[1] = 0; //carry out
			ALUFlags[0] = 0;
		end
		else begin
			ALUFlags[3] = Result[15]; //negative bit is the sign bit of the result
			ALUFlags[2] = (Result == 16'b0); //zero bit if result is zero
			ALUFlags[1] = carry; //carry out
			ALUFlags[0] = 0;
		end
	end
	

	//perform combinational logic for operations
	always_comb begin
		case(ALUControl)
			//ADD
			3'b000: begin
				temp_op = b;
				Result = adder_out;
			end
			//SUB
			3'b001:begin
				temp_op = ~b;
				Result = adder_out;
			end
			//AND
			3'b010:begin
				Result = a & b;
			end
			//OR
			3'b011:begin
				Result = a | b;
			end
			//XOR
			3'b100:begin
				Result = a ^ b;
			end
			//NOT
			3'b101:begin
				Result = ~a;
			end
            3'b110: begin
                Result = b;
            end
		endcase
	end

endmodule
/*
module ALU_testbench();
	// system signals
	logic [31:0] a, b;
	logic [1:0] ALUControl;
	logic [31:0] Result;
	logic [3:0] ALUFlags;
	logic clk;
	logic [101:0] testvectors [0:15];

	//declare the design under test
	ALU DUT(a, b, ALUControl, Result, ALUFlags);

	// Set up a simulated clock.
	parameter CLOCK_PERIOD=10;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end

	initial begin
		//read in the vector file that runs through test cases for the ALU
		$readmemb("ALU_test.v", testvectors);
		for(int i = 0; i < 16; i++) begin
			{ALUControl, a, b, Result, ALUFlags} = testvectors[i]; @(posedge clk);
		end
		repeat(2) #10;
		$stop;
	end
endmodule
*/
