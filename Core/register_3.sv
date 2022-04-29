// register with width of 3, holds 3 bits and only updates when writeEnable is true on a rising clock edge
`timescale 1ps/1ps
module register_3 #(parameter WIDTH=64) (dataIn, dataOut, writeEnable, reset, clk);
	output logic [2:0] dataOut;
	input  logic [2:0] dataIn;
	input  logic writeEnable, clk, reset;
	logic [2:0] regData, regDataNew, regDataOld;
	logic notWriteEnable;
	
	not #50 notWrEn(notWriteEnable, writeEnable);
	
	genvar i;
	
	// adds enable function to the D_FF module and combines 3 of them to create an enabled register
	generate
		for(i = 0; i < 3; i++) begin : regDFF
			// q = (en & new_d) | (!en & old_d)
			and #50 newData(regDataNew[i], writeEnable, dataIn[i]);
			and #50 oldData(regDataOld[i], notWriteEnable, dataOut[i]);
			or #50 storedData(regData[i], regDataNew[i], regDataOld[i]);
			
			D_FF dff (.q(dataOut[i]), .d(regData[i]), .reset, .clk);
		end
	endgenerate
	
endmodule
/*	
// register_testbench tests that the register is only updated when enable is true and holds the data that is written to it. 
module register_3_testbench();
	logic clk, reset, writeEnable;
	logic [2:0] dataOut;
	logic [2:0] dataIn;
	
	register_3 dut(.dataIn, .dataOut, .writeEnable, .reset, .clk);
	
	parameter CLOCK_PERIOD=1000;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end
	
	initial begin
		reset <= 1;	dataIn <= 3'b0;	writeEnable <= 0;	@(posedge clk); 
		reset <= 0; dataIn <= '1;								@(posedge clk); // write without enable
												writeEnable <= 1; @(posedge clk); // write with enable
						dataIn <= 53; 		writeEnable <= 0; @(posedge clk); // write again without enable
																		@(posedge clk); 
						dataIn <= 23;		writeEnable <= 1; @(posedge clk); // write with enable
																		@(posedge clk);
						dataIn <= 5; 								@(posedge clk); // change dataIn during enable
																		@(posedge clk);
						dataIn <= 3'b111; 			@(posedge clk); // Test absolute maximum
						writeEnable <= 0;							@(posedge clk); // Disable write enable 
						dataIn <= 0;								@(posedge clk); // Set new data to 0
						writeEnable <= 1;							@(posedge clk); // Write 0 to the register
																	@(posedge clk);
		$stop;
	end
endmodule
*/
