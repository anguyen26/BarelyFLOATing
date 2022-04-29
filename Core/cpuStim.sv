`timescale 1ps/1ps
module cpuStim();

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
		reset <= 1; @(posedge clk);
		reset <= 0;
		repeat(10) begin
			@(posedge clk); // Fill Pipeline
		end
		while(testCpu.instr != 16'b11100_00000000000) begin
			@(posedge clk);
		end
		for (i = 0; i < 10; i++) begin
			@(posedge clk); // Clear Pipeline
		end
		$display("%t Test Done", $time);
        f = $fopen("sv_output.txt", "w");
        $fwrite(f, "Register content:\n");
        for (int i=0; i<16; i++) begin
            $fwrite(f, "%d = %d\n", i, testCpu.registers.MEM[i]);
        end
        $fclose(f);
//		$stop;
        $finish;
	end
	
endmodule
