`timescale 1ps/1ps
module controlStim_post();

	parameter ClockDelay = 20000;
	
	logic 		clk, reset;
	logic [15:0]	PC, instr;
	logic 		RegWrite, MemWrite, MemRead, ALUSrc, brEx, selOpA;
	logic [1:0] 	ShiftDir, brSel, Reg1Loc, Reg2Loc, Reg3Loc, selWrData;
	logic [3:0] 	keepFlags, FlagsReg;
	logic [2:0]	selOpB, ALUOp;
	
	cpuControl dut(.PC, .instr, .FlagsReg, .Reg1Loc, .Reg2Loc, .Reg3Loc, .RegWrite, 
			.MemWrite, .MemRead, .ShiftDir, .keepFlags, .ALUOp, 
			.brSel, .brEx, .clk, .reset, .selWrData, .selOpA, .selOpB);
	
	initial $timeformat(-9, 2, " ns", 10);

	initial begin // Set up the clock
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
	end
	
	integer i, f;
	
	initial begin
	$sdf_annotate("../sapr/syn/design_files/cpu.syn.sdf", dut);
        $vcdpluson;
		reset <= 1; @(posedge clk);
		reset <= 0;
		repeat(10) begin
			@(posedge clk); // startup
		end
		PC <= 16'd0; instr <= 16'b0100001111_011_111; FlagsReg <= 4'b0000;  @(posedge clk);
		PC <= 16'd4; instr <= 16'b01101_10000_001_001; FlagsReg <= 4'b0000;  @(posedge clk);
		
        $finish;
	end
	
endmodule
