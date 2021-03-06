// Runs the CPU for a fixed number of cycles
// Only used for debugging infinite loops

`timescale 1ps/1ps
module cpuStim_fixed();

	parameter ClockDelay = 10000;
	
	logic clk, reset;
	
	cpu testCpu(.*);
	
	initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	integer i, f;
	
	initial begin
        $vcdpluson;
        $vcdplusmemon;
		reset <= 1; @(posedge clk);
		repeat(3) begin
			@(posedge clk); // Run
		end
		reset <= 0;
		while(testCpu.instr != 16'b1110011111111111) begin
        // repeat(2000) begin
			@(posedge clk); // Run
		end

		$display("%t Test Done", $time);
		f = $fopen("sv_output.txt", "w");
		$fwrite(f, "Register content:\n");
		for (int i=0; i<15; i++) begin
		    $fwrite(f, "%d = %d\n", i, testCpu.registers.MEM[i]);
		end
		$fwrite(f, "15 = %d\n", testCpu.registers.r15);
		$fwrite(f, "Memory content:\n");
		for (int i=0; i<65536; i++) begin
		    if (testCpu.dataMemory.mem[i] != 16'd0) begin;
		        $fwrite(f, "mem[%d] = %d\n", i, testCpu.dataMemory.mem[i]);
		    end
		end
		$fclose(f);
		$finish;
	end
	
endmodule
