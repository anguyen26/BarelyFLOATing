`timescale 1ps/1ps
module cpuStim_post();

	parameter ClockDelay = 20000;
	
	logic clk, reset;
	logic [14:0][15:0] MEM;
	logic [15:0] PC;
	assign PC = PC >> 2;
	
	cpu testCpu(.clk, .reset, .MEM);
	
	initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	integer i, f;
	
	initial begin
	$sdf_annotate("../sapr/syn/design_files/cpu.syn.sdf", testCpu);
        $vcdpluson;
		reset <= 1; repeat(10) @(posedge clk);
		reset <= 0;
		repeat(80) begin
			@(posedge clk); // Fill Pipeline
		end
		/*
		while(testCpu.instr != 16'b11100_00000000000) begin
		    f = $fopen("debug_sv.txt", "w");
		    for (int i=0; i<15; i++) begin
		        $fwrite(f, "%d = %d\n", i, testCpu.regfile.MEM[i]);
		    end
		    $fwrite(f, "15 = %d\n", testCpu.regfile.r15);
		    $fwrite(f, "Memory content:\n");
		    for (int i=0; i<65536; i++) begin
		        if (testCpu.dataMemory.mem[i] != 16'd0) begin;
		            $fwrite(f, "mem[%d] = %d\n", i, testCpu.dataMemory.mem[i]);
		        end
		    end
			@(posedge clk);
		end
		*/
        /*
		for (i = 0; i < 10; i++) begin
			@(posedge clk); // Clear Pipeline
		end
        */
		$display("%t Test Done", $time);
	
        f = $fopen("sv_output.txt", "w");
        $fwrite(f, "Register content:\n");
        for (int i=0; i<15; i++) begin
            $fwrite(f, "%d = %d\n", i, MEM[i]);
        end
        $fwrite(f, "15 = %d\n", PC);
	/*
        $fwrite(f, "Memory content:\n");
        for (int i=0; i<65536; i++) begin
            if (testCpu.dataMemory.mem[i] != 16'd0) begin;
                $fwrite(f, "mem[%d] = %d\n", i, testCpu.dataMemory.mem[i]);
            end
        end
	*/
        $fclose(f);
	
//		$stop;
        $finish;
	end
	
endmodule
