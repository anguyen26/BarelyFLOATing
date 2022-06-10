// This module is simmilar to cpuStim.sv but its renamed for consistency
// so that the proper module name shows up in vcs

`timescale 1ns/1ns
module aprCpuStim();

	parameter ClockDelay = 10;
	
	logic clk, reset;

	top testTop(.*);
	
	initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	integer i, f, f1, f2, f3, f4;
	
	initial begin
        $vcdpluson;
        $vcdplusmemon;
        //i=0;
		reset <= 1; @(posedge clk);
		repeat(3) begin
			@(posedge clk); // Reset Pipeline
		end
		reset <= 0;
        
		while(testTop.core.instr != 16'b11100_00000000000 & testTop.core.instr != 16'b1110011111111111) begin
			@(posedge clk);
		end 
		
        for (i = 0; i < 10; i++) begin
			@(posedge clk); // Clear Pipeline
		end
		$display("%t Test Done", $time);

		f1 = $fopen("convertMe.txt", "w");
		$fwrite(f1,"%b\n", testTop.dataMemory.mem[1]);
        $fclose(f1);
        $finish;
		$stop;
	end
	
endmodule
