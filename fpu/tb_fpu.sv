module tb_fpu();
    logic clk, reset;
    logic [15:0] opA, opB;
    logic [1:0] op;
    logic [15:0] result;
    logic overflow, underflow, inexact;

	parameter ClockDelay = 10000;
	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end

    fpu dut(.clk, .reset, .opA, .opB, .op, .result, 
        .underflow, .overflow, .inexact);

    integer f;    
    initial begin
        f = $fopen("fp_output.txt", "w");
        repeat(3) @(posedge clk);
        while(1) begin
            $fwrite(f, "%b\t %b %b %b\n", 
                dut.result, dut.underflow, dut.overflow, dut.inexact); 
            @(posedge clk);
        end
    end


    initial begin
        $vcdpluson;
        reset <= 1; @(posedge clk);
        reset <= 0;
        ///////////////////////////////////////////////////////////
        // Test add
        // --------------------------------------------------------
        op <= 2'd0;
        // 100 + 0.5 = 100.5
        opA <= 16'b0_10000101_1001000;
        opB <= 16'b0_01111110_0000000;
        @(posedge clk);
        // 100 - 0.5 = 99.5
        opA <= 16'b0_10000101_1001000;
        opB <= 16'b1_01111110_0000000;
        @(posedge clk);
        // -100 + 0.5 = -99.5
        opA <= 16'b1_10000101_1001000;
        opB <= 16'b0_01111110_0000000;
        @(posedge clk);
        // -0.5 + 100 = 99.5
        opA <= 16'b1_01111110_0000000;
        opB <= 16'b0_10000101_1001000;
        @(posedge clk);
        // 0.5 - 100 = -99.5
        opA <= 16'b0_01111110_0000000;
        opB <= 16'b1_10000101_1001000;
        @(posedge clk);
        // -100 - 0.5 = -100.5
        opA <= 16'b1_10000101_1001000;
        opB <= 16'b1_01111110_0000000;
        @(posedge clk);
        // 127.5 + 0.5 = 128, normalize 
        opA <= 16'b0_10000101_1111111;
        opB <= 16'b0_01111110_1000000;
        @(posedge clk);
        // result = 0_11111111_0000000, overflow = 1
        opA <= 16'b0_11111110_1111110;
        opB <= 16'b0_11111101_0000010;
        @(posedge clk);
        // 100 + .52734375 = 100.52734375, inexact = 1
        opA <= 16'b0_10000101_1001000;
        opB <= 16'b0_01111110_0000111;
        @(posedge clk);
        ///////////////////////////////////////////////////////////
        // Test subtract
        // --------------------------------------------------------
        op <= 2'd1;
        // 100 - 0.5 = 99.5
        opA <= 16'b0_10000101_1001000;
        opB <= 16'b0_01111110_0000000;
        @(posedge clk);
        // 100 - -0.5 = 100.5
        opA <= 16'b0_10000101_1001000;
        opB <= 16'b1_01111110_0000000;
        @(posedge clk);
        // -100 - 0.5 = -100.5
        opA <= 16'b1_10000101_1001000;
        opB <= 16'b0_01111110_0000000;
        @(posedge clk);
        // -0.5 - 100 = -100.5
        opA <= 16'b1_01111110_0000000;
        opB <= 16'b0_10000101_1001000;
        @(posedge clk);
        // 0.5 - -100 = 100.5
        opA <= 16'b0_01111110_0000000;
        opB <= 16'b1_10000101_1001000;
        @(posedge clk);
        // -100 - -0.5 = -99.5
        opA <= 16'b1_10000101_1001000;
        opB <= 16'b1_01111110_0000000;
        @(posedge clk);
        // 66 - 64.5 = 1.5, normalize 
        opA <= 16'b0_10000101_0000100;
        opB <= 16'b0_10000101_0000001;
        @(posedge clk);
        // result = 0_11111111_0000000, overflow = 1
        opA <= 16'b0_11111110_1111110;
        opB <= 16'b1_11111101_0000010;
        @(posedge clk);
        // 100 - .52734375 = 99...., inexact = 1
        opA <= 16'b0_10000101_1001000;
        opB <= 16'b0_01111110_0000111;
        @(posedge clk);
        @(posedge clk);
        $finish;
        $fclose(f);
    end
endmodule
