module fpuStim();
    logic clk, reset;
    logic [15:0] opA, opB;
    logic [1:0] op;
    logic start;
    logic [15:0] result;
    logic overflow, underflow, inexact, valid, busy;
    logic [7:0] address;
    logic [3:0] count;
    
	parameter ClockDelay = 10e6;
	initial begin 
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

    fpu dut(.clk, .reset, .opA, .opB, .op, .start, .result, 
        .underflow, .overflow, .inexact, .valid, .busy);
	
    opmem ops(.clk, .reset, .address, .opA, .opB, .op);

    // Counter for div
    always_ff @(posedge clk) begin
        if (start) begin
            count <= 4'd0;
        end else begin
            count <= count + 1;
        end
    end

	// Handle the read from operation memory.
    always_ff @(posedge clk) begin
        if (reset) begin
            address <= 8'd0;
        end else if (start | busy) begin
            address <= address;
        end else begin
            address <= address + 1;
        end
    end

    // Handle controls for div module
    always_comb begin
        if ((op == 2'd3) & (valid)) begin
            start = 1'b1;
        end else begin
            start = 1'b0;
        end
    end

    integer f;    
    initial begin
        f = $fopen("fp_output.txt", "w");
        repeat(3) @(posedge clk);
        while(1) begin
            if (dut.hold_op == 2'd3) begin
                repeat(17) @(posedge clk);
                $fwrite(f, "%t %b\t %b %b %b\n", 
                    $time, dut.result, dut.underflow, dut.overflow, dut.inexact);
            end
            else begin
                $fwrite(f, "%t %b\t %b %b %b\n", 
                    $time, dut.result, dut.underflow, dut.overflow, dut.inexact);
            end
            @(posedge clk);
        end
    end
    
    initial begin
        $vcdpluson;
        $vcdplusmemon;
        reset <= 1; @(posedge clk);
        reset <= 0; @(posedge clk);
        while (opA != 16'b1111111111111111) begin
            @(posedge clk);
        end
        $finish;
        $fclose(f);
    end
endmodule
