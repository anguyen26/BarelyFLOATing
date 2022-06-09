// Top level CPU testbench that writes the state of the CPU at the end of sim to files

`timescale 1ps/1ps
module cpuStim();

	parameter ClockDelay = 20000;
	
	logic clk, reset;
	
	//instantiate top level design
	top testCpu(.*);
	
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
        
    // run until end instruction is reached
		while(testCpu.core.instr != 16'b11100_00000000000 & testCpu.core.instr != 16'b1110011111111111) begin
            @(posedge clk);
        end
		
        for (i = 0; i < 10; i++) begin
			@(posedge clk); // Clear Pipeline
		end

		$display("%t Test Done", $time);

		// write result files
		f1 = $fopen("convertMe.txt", "w");
		$fwrite(f1,"%b\n", testCpu.dataMemory.mem[1]);
        $fclose(f1);

		f2 = $fopen("log2_result.txt", "w");
		$fwrite(f2, "%b", testCpu.core.registers.MEM[1]); //log2 result
        $fclose(f2);

        $finish;
		$stop;
	end
	
endmodule
