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
	
	integer i, f, f1;
	
	initial begin
        $vcdpluson;
        $vcdplusmemon;
        //i=0;
		reset <= 1; @(posedge clk);
		repeat(3) begin
			@(posedge clk); // Reset Pipeline
		end
		reset <= 0;
/*
        repeat(35) begin
            i++;
            $display("%b", testCpu.instr);
            $display("%d", i);
            @(posedge clk);
        end
        */
		while(testCpu.instr != 16'b11100_00000000000 & testCpu.instr != 16'b1110011111111111) begin
            //i++;
            //$display("%b", testCpu.instr);
            //$display("%d", i);
			// f = $fopen("debug_sv.txt", "w");
			// for (int i=0; i<15; i++) begin
			// 	$fwrite(f, "%d = %d\n", i, testCpu.registers.MEM[i]);
			// end
			// $fwrite(f, "15 = %d\n", testCpu.registers.r15);
			// $fwrite(f, "Memory content:\n");
			// for (int i=0; i<65536; i++) begin
			// 	if (testCpu.dataMemory.mem[i] != 16'd0) begin;
			// 	    $fwrite(f, "mem[%d] = %d\n", i, testCpu.dataMemory.mem[i]);
			// 	end
			// end
		    @(posedge clk);
			// $fclose(f);
		end

		for (i = 0; i < 10; i++) begin
			@(posedge clk); // Clear Pipeline
		end
		$display("%t Test Done", $time);

		f = $fopen("sv_output.txt", "w");
		f1 = $fopen("convertMe.txt", "w");
		$fwrite(f, "Register content:\n");
		for (int i=0; i<15; i++) begin
		    // $fwrite(f, "%d = %d\n", i, testCpu.registers.MEM[i]);
		    $fwrite(f, "%d = %b\n", i, testCpu.registers.MEM[i]);
		end
		$fwrite(f, "15 = %d\n", testCpu.registers.r15);
		$fwrite(f, "Memory content:\n");
		for (int i=0; i<65536; i++) begin
		    if (testCpu.dataMemory.mem[i] != 16'd0) begin;
		        // $fwrite(f, "mem[%d] = %d\n", i, testCpu.dataMemory.mem[i]);
                $fwrite(f, "mem[%d] = %b\n", i, testCpu.dataMemory.mem[i]);
		        $fwrite(f1,"%b\n", testCpu.dataMemory.mem[i]);
		    end
		end
		$fclose(f);
        $finish;
		$stop;
	end
	
endmodule
