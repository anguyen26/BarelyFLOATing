//Decoder control logic for ARM processor

`timescale 1ps/1ps
module cpuControl(
	input logic [15:0] 	PC,
	// Current Instruction being ran by CPU
	input logic [15:0] 	instr,

	// Flags and clk/reset
	input logic [3:0] 	FlagsReg,
	input logic 		clk, reset,
	
	// Control signals for datapath
	output logic 		RegWrite, MemWrite, MemRead,
	output logic [1:0] 	ShiftDir,
	output logic [3:0] 	keepFlags,
	output logic [1:0] 	Reg1Loc, Reg2Loc, Reg3Loc,
	output logic [2:0] 	selOpB,
	output logic 		selOpA, ALUorFPU,

	// Controls the operation the ALU / FPU will perform
	output logic [2:0] 	ALUOp,
	output logic [1:0] 	FPUOp,
	// Controls manipulation of PC
	output logic [1:0] 	brSel,
	output logic 		brEx, Branch,
	output logic [1:0] 	selWrData
);

	logic [9:0] opcode;
	assign opcode =  instr[15:6];

    always_comb begin
		// MOVE =========================================
		casez (opcode)
			// MOVS
			10'b0010?_?????: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0; 
 				MemRead = 0;
				keepFlags = 4'b1100;
				Reg1Loc = 'X;
				Reg2Loc = 'X;
				Reg3Loc = 2'b10;
 				selOpA = 'X;
 				selOpB = 'X;
                ShiftDir = 'X;
 				ALUOp = 'X;
				FPUOp = 2'b11;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'd2;
			end
			//MOV
			10'b010001100_?: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0; 
				MemRead = 0;
				keepFlags = 4'b0000;
                Reg1Loc = 'X;
				Reg2Loc = 2'b11;
				Reg3Loc = 2'b00;
 				selOpA = 3'd0;
 				selOpB = 3'd0;
 				ALUOp = 3'd6;
                FPUOp = 'X;
				brSel = 2'b11;
				brEx = 0;
                ShiftDir = 'X;
 				selWrData = 2'b01;
			end
		// ADD =========================================
			// ADDS (imm)
			10'b0001110_???: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b1111;
				Reg1Loc = 2'd1;
                Reg2Loc = 'X;
				Reg3Loc = 2'b00;
 				selOpA = 1'b0;
 				selOpB = 3'd1;
				ALUOp = 3'b000;
                FPUOp = 'X;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b01;
                ShiftDir = 'X;
			end
			// ADDS (reg)
			10'b0001100_???: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b1111;
				Reg1Loc = 2'd1;
				Reg2Loc = 2'b00;
				Reg3Loc = 2'b00;
 				selOpA = 1'b0;
 				selOpB = 3'b0;
				ALUOp = 3'b000;
                FPUOp = 'X;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b01;
                ShiftDir = 'X;
			end
			// ADD
			10'b101100000_?: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b0000;
				Reg1Loc = 'X;
				Reg2Loc = 'X;
				Reg3Loc = 2'b01;
 				selOpA = 1'b0;
 				selOpB = 3'd2;
				ALUOp = 3'b000;
                FPUOp = 'X;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b01;
                ShiftDir = 'X;
			end
		// SUBTRACT =========================================
			// SUBS (imm)
			10'b0001111_???: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b1111;
				Reg1Loc = 2'd1;
                Reg2Loc = 'X;
				Reg3Loc = 2'b00;
 				selOpA = 1'b0;
 				selOpB = 3'd1;
                FPUOp = 'X;
				ALUOp = 3'b001;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b01;
                ShiftDir = 'X;
			end
			// SUBS (reg)
			10'b0001101_???: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b1111;
				Reg1Loc = 2'd1;
				Reg2Loc = 2'b00;
				Reg3Loc = 2'b00;
 				selOpA = 1'b0;
 				selOpB = 3'b0;
				ALUOp = 3'b001;
                FPUOp = 'X;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b01;
                ShiftDir = 'X;
			end
			// SUB
			10'b101100001_?: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b0000;
				Reg1Loc = 'X;
				Reg2Loc = 'X;
				Reg3Loc = 2'b01;
 				selOpA = 1'b0;
 				selOpB = 3'd2;
                FPUOp = 'X;
				ALUOp = 3'b001;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b01;
                ShiftDir = 'X;
			end
		// COMPARE =========================================
			// CMP
			10'b0100001010: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 0;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b1111;
				Reg1Loc = 2'b10;
				Reg2Loc = 2'b01;
                Reg3Loc = 'X;
 				selOpA = 1'b0;
 				selOpB = 3'd0;
                FPUOp = 'X;
				ALUOp = 3'b001;
				brSel = 2'b11;
				brEx = 0;
                ShiftDir = 'X;
                selWrData = 'X;
			end
		// LOGICAL =========================================
			// ANDS
			10'b0100000000: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b1100;
				Reg1Loc = 2'b01;
				Reg2Loc = 2'b10;
				Reg3Loc = 2'b00;
 				selOpA = 1'b0;
 				selOpB = 3'd0;
                FPUOp = 'X;
				ALUOp = 3'b010;
                ShiftDir = 'X;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b01;
			end
			// EORS
			10'b0100000001: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b1100;
				Reg1Loc = 2'b01;
				Reg2Loc = 2'b10;
				Reg3Loc = 2'b00;
 				selOpA = 1'b0;
 				selOpB = 3'd0;
                FPUOp = 'X;
				ALUOp = 3'd4;
                ShiftDir = 'X;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b01;
			end
			// ORRS
			10'b0100001100: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b1100;
				Reg1Loc = 2'b01;
				Reg2Loc = 2'b10;
				Reg3Loc = 2'b00;
 				selOpA = 1'b0;
 				selOpB = 3'd0;
                FPUOp = 'X;
				ALUOp = 3'd3;
                ShiftDir = 'X;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b01;
			end
			// MVNS
			10'b0100001111: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b1100;
				Reg1Loc = 2'b01;
				Reg2Loc = 2'b10;
				Reg3Loc = 2'b00;
 				selOpA = 1'b0;
 				selOpB = 3'd0;
				ALUOp = 3'd5;
                FPUOp = 'X;
                ShiftDir = 'X;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b01;
			end
		// ROTATE =========================================
			// LSLS
			10'b0100000010: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b1100;
				Reg1Loc = 2'b01;
				Reg2Loc = 2'b10;
				Reg3Loc = 2'b00;
 				ShiftDir = 2'd0;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b00;
			end
			// LSRS
			10'b0100000011: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b1100;
				Reg1Loc = 2'b01;
				Reg2Loc = 2'b10;
				Reg3Loc = 2'b00;
 				ShiftDir = 2'd1;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b00;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
			end
			// ASRS
			10'b0100000100: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b1100;
				Reg1Loc = 2'b01;
				Reg2Loc = 2'b10;
				Reg3Loc = 2'b00;
 				ShiftDir = 2'd2;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b00;
			end
			// RORS
			10'b0100000111: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b1100;
				Reg1Loc = 2'b01;
				Reg2Loc = 2'b10;
				Reg3Loc = 2'b00;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
 				ShiftDir = 2'd3;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b00;
			end
		// STORE =========================================
			// STR
			10'b01100_?????: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 0;
				MemWrite = 1;
				MemRead = 0;
				keepFlags = 4'b1100;
				Reg1Loc = 2'b01;
 				Reg2Loc = 2'b10;
				Reg3Loc = 2'b00;
 				selOpA = 1'b0;
 				selOpB = 3'd3;
                FPUOp = 'X;
                ShiftDir = 'X;
				ALUOp = 3'd0;
				brSel = 2'b11;
				brEx = 0;
                selWrData = 'X;
			end
		// LOAD =========================================
			// LDR
			10'b01101_?????: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 1;
				keepFlags = 4'b1100;
				Reg1Loc = 2'b01;
                Reg2Loc = 'X;
				Reg3Loc = 2'b00;
 				selOpA = 1'b0;
 				selOpB = 3'd3;
				ALUOp = 3'd0;
                FPUOp = 'X;
                ShiftDir = 'X;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'd3;
			end
		// BRANCH =========================================
			// BEQ
			10'b1101_0000??: begin
				ALUorFPU = 0;
				Branch = 1;
				RegWrite = 0;
				MemWrite = 0;
				keepFlags = 4'b0000;
				brSel = FlagsReg[2] ? 2'b01 : 2'b11;
				brEx = 0;
                MemRead = 'X;
                Reg1Loc = 'X;
                Reg2Loc = 'X;
                Reg3Loc = 'X;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
                ShiftDir = 'X;
                selWrData = 'X;
			end
			// BNE
			10'b1101_0001??: begin
				ALUorFPU = 0;
				Branch = 1;
				RegWrite = 0;
				MemWrite = 0;
				keepFlags = 4'b0000;
				brSel = FlagsReg[2] ? 2'b11 : 2'b01;
				brEx = 0;
                MemRead = 'X;
                Reg1Loc = 'X;
                Reg2Loc = 'X;
                Reg3Loc = 'X;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
                ShiftDir = 'X;
                selWrData = 'X;
			end
			// BCS
			10'b1101_0010??: begin
				ALUorFPU = 0;
				Branch = 1;
				RegWrite = 0;
				MemWrite = 0;
				keepFlags = 4'b0000;
				brSel = FlagsReg[1] ? 2'b01 : 2'b11;
				brEx = 0;
                MemRead = 'X;
                Reg1Loc = 'X;
                Reg2Loc = 'X;
                Reg3Loc = 'X;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
                ShiftDir = 'X;
                selWrData = 'X;
			end
			// BCC
			10'b1101_0011??: begin
				ALUorFPU = 0;
				Branch = 1;
				RegWrite = 0;
				MemWrite = 0;
				keepFlags = 4'b0000;
				brSel = FlagsReg[1] ? 2'b11 : 2'b01;
				brEx = 0;
                MemRead = 'X;
                Reg1Loc = 'X;
                Reg2Loc = 'X;
                Reg3Loc = 'X;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
                ShiftDir = 'X;
                selWrData = 'X;
			end
			// BMI
			10'b1101_0100??: begin
				ALUorFPU = 0;
				Branch = 1;
				RegWrite = 0;
				MemWrite = 0;
				keepFlags = 4'b0000;
				brSel = FlagsReg[3] ? 2'b01 : 2'b11;
				brEx = 0;
                MemRead = 'X;
                Reg1Loc = 'X;
                Reg2Loc = 'X;
                Reg3Loc = 'X;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
                ShiftDir = 'X;
                selWrData = 'X;
			end
			// BPL
			10'b1101_0101??: begin
				ALUorFPU = 0;
				Branch = 1;
				RegWrite = 0;
				MemWrite = 0;
				keepFlags = 4'b0000;
				brSel = FlagsReg[3] ? 2'b11 : 2'b01;
				brEx = 0;
                MemRead = 'X;
                Reg1Loc = 'X;
                Reg2Loc = 'X;
                Reg3Loc = 'X;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
                ShiftDir = 'X;
                selWrData = 'X;
			end
			// BVS
			10'b1101_0110??: begin
				ALUorFPU = 0;
				Branch = 1;
				RegWrite = 0;
				MemWrite = 0;
				keepFlags = 4'b0000;
				brSel = FlagsReg[0] ? 2'b01 : 2'b11;
				brEx = 0;
                MemRead = 'X;
                Reg1Loc = 'X;
                Reg2Loc = 'X;
                Reg3Loc = 'X;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
                ShiftDir = 'X;
                selWrData = 'X;
			end
			// BVC
			10'b1101_0111??: begin
				ALUorFPU = 0;
				Branch = 1;
				RegWrite = 0;
				MemWrite = 0;
				keepFlags = 4'b0000;
				brSel = FlagsReg[0] ? 2'b11 : 2'b01;
				brEx = 0;
                MemRead = 'X;
                Reg1Loc = 'X;
                Reg2Loc = 'X;
                Reg3Loc = 'X;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
                ShiftDir = 'X;
                selWrData = 'X;
			end
			// BHI
			10'b1101_1000??: begin
				ALUorFPU = 0;
				Branch = 1;
				RegWrite = 0;
				MemWrite = 0;
				keepFlags = 4'b0000;
				brSel = (FlagsReg[1] & !FlagsReg[2]) ? 2'b01 : 2'b11;
				brEx = 0;
                MemRead = 'X;
                Reg1Loc = 'X;
                Reg2Loc = 'X;
                Reg3Loc = 'X;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
                ShiftDir = 'X;
                selWrData = 'X;
			end
			// BLS
			10'b1101_1001??: begin
				ALUorFPU = 0;
				Branch = 1;
				RegWrite = 0;
				MemWrite = 0;
				keepFlags = 4'b0000;
				brSel = (!FlagsReg[1] | FlagsReg[2]) ? 2'b01 : 2'b11;
				brEx = 0;
                MemRead = 'X;
                Reg1Loc = 'X;
                Reg2Loc = 'X;
                Reg3Loc = 'X;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
                ShiftDir = 'X;
                selWrData = 'X;
			end
			// BGE
			10'b1101_1010??: begin
				ALUorFPU = 0;
				Branch = 1;
				RegWrite = 0;
				MemWrite = 0;
				keepFlags = 4'b0000;
				brSel = (FlagsReg[3] == FlagsReg[0]) ? 2'b01 : 2'b11;
				brEx = 0;
                MemRead = 'X;
                Reg1Loc = 'X;
                Reg2Loc = 'X;
                Reg3Loc = 'X;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
                ShiftDir = 'X;
                selWrData = 'X;
			end
			// BLT
			10'b1101_1011??: begin
				ALUorFPU = 0;
				Branch = 1;
				RegWrite = 0;
				MemWrite = 0;
				keepFlags = 4'b0000;
				brSel = (!FlagsReg[3] == FlagsReg[0]) ? 2'b01 : 2'b11;
				brEx = 0;
                MemRead = 'X;
                Reg1Loc = 'X;
                Reg2Loc = 'X;
                Reg3Loc = 'X;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
                ShiftDir = 'X;
                selWrData = 'X;
			end
			// BGT
			10'b1101_1100??: begin
				ALUorFPU = 0;
				Branch = 1;
				RegWrite = 0;
				MemWrite = 0;
				keepFlags = 4'b0000;
				brSel = (!FlagsReg[2] & (FlagsReg[3] == FlagsReg[0])) ? 2'b01 : 2'b11;
				brEx = 0;
                MemRead = 'X;
                Reg1Loc = 'X;
                Reg2Loc = 'X;
                Reg3Loc = 'X;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
                ShiftDir = 'X;
                selWrData = 'X;
			end
			// BLE
			10'b1101_1101??: begin
				ALUorFPU = 0;
				Branch = 1;
				RegWrite = 0;
				MemWrite = 0;
				keepFlags = 4'b0000;
				brSel = (FlagsReg[2] | (!FlagsReg[3] == FlagsReg[0])) ? 2'b01 : 2'b11;
				brEx = 0;
                MemRead = 'X;
                Reg1Loc = 'X;
                Reg2Loc = 'X;
                Reg3Loc = 'X;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
                ShiftDir = 'X;
                selWrData = 'X;
			end
			// BAL
			10'b1101_1110??: begin
				ALUorFPU = 0;
				Branch = 1;
				RegWrite = 0;
				MemWrite = 0;
				keepFlags = 4'b0000;
				brSel = 2'b01;
				brEx = 0;
                MemRead = 'X;
                Reg1Loc = 'X;
                Reg2Loc = 'X;
                Reg3Loc = 'X;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
                ShiftDir = 'X;
                selWrData = 'X;
			end

			// Unconditional Branching
			// B
			10'b11100_?????: begin
				ALUorFPU = 0;
				Branch = 1;
				RegWrite = 0;
				MemWrite = 0;
				keepFlags = 4'b0000;
				brSel = 2'b10;
				brEx = 0;
                MemRead = 'X;
                Reg1Loc = 'X;
                Reg2Loc = 'X;
                Reg3Loc = 'X;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
                ShiftDir = 'X;
                selWrData = 'X;
			end
			// BL
			10'b0100010100: begin
				ALUorFPU = 0;
				Branch = 1;
				RegWrite = 1;
				MemWrite = 0;
                MemRead = 'X;
				keepFlags = 4'b0000;
                Reg1Loc = 'X;
                Reg2Loc = 'X;
				Reg3Loc = 2'b11;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
                ShiftDir = 'X;
                selWrData = 'X;
				brSel = 2'b00;
				brEx = 0;
				selWrData = 2'b10;
			end
			// BX
			10'b010001110_?: begin
				ALUorFPU = 0;
				Branch = 1;
				RegWrite = 0;
				MemWrite = 0;
                MemRead = 'X;
                keepFlags = 'X;
                Reg1Loc = 'X;
				Reg2Loc = 2'b11;
                Reg3Loc = 'X;
                selOpA = 'X;
                selOpB = 'X;
                ALUOp = 'X;
                FPUOp = 'X;
                ShiftDir = 'X;
				brSel = 2'bX;
				brEx = 1;
                selWrData = 'X;
			end
		// NONE =========================================
			// NOOP
			10'b1011111100: begin
				ALUorFPU = 0;
				Branch = 0;
				RegWrite = 0;
				MemWrite = 0;
                MemRead = 'X;
				keepFlags = 4'b0000;
				brSel = 2'b11;
				brEx = 0;
				Reg1Loc = 'X;
				Reg2Loc = 'X;
				Reg3Loc = 'X;
 				selOpA = 'X;
 				selOpB = 'X;
				FPUOp = 'X;
                ALUOp = 'X;
                ShiftDir = 'X;
                selWrData = 'X;
			end
		// Floating Point ================================
			// FADD
			10'b01110_00???: begin
				ALUorFPU = 1;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b0000;
				Reg1Loc = 2'd1;
				Reg2Loc = 2'd0;
				Reg3Loc = 2'd0;
 				selOpA = 1'b0;
 				selOpB = 3'b010;
				FPUOp = 2'b00;
                ALUOp = 'X;
                ShiftDir = 'X;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b01;
			end
			// FSUB
			10'b01110_01???: begin
				ALUorFPU = 1;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b0000;
				Reg1Loc = 2'd1;
				Reg2Loc = 2'd0;
				Reg3Loc = 2'd0;
 				selOpA = 1'b0;
 				selOpB = 3'b010;
                ALUOp = 'X;
				FPUOp = 2'b01;
                ShiftDir = 'X;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b01;
			end
			// FMUL
			10'b01110_10???: begin
				ALUorFPU = 1;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b0000;
				Reg1Loc = 2'd1;
				Reg2Loc = 2'd0;
				Reg3Loc = 2'd0;
 				selOpA = 1'b0;
 				selOpB = 3'b010;
				FPUOp = 2'b10;
                ALUOp = 'X;
                ShiftDir = 'X;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b01;
			end
			// FDIV
			10'b01110_11???: begin
				ALUorFPU = 1;
				Branch = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b0000;
				Reg1Loc = 2'd1;
				Reg2Loc = 2'd0;
				Reg3Loc = 2'd0;
 				selOpA = 1'b0;
 				selOpB = 3'b010;
				FPUOp = 2'b11;
                ALUOp = 'X;
                ShiftDir = 'X;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b01;
			end
			// FCMP
			10'b01111_00000: begin
				ALUorFPU = 1;
				Branch = 0;
				RegWrite = 0;
				MemWrite = 0;
				MemRead = 0;
				keepFlags = 4'b1111;
				Reg1Loc = 2'd2;
				Reg2Loc = 2'd1;
                Reg3Loc = 'X;
 				selOpA = 1'b0;
 				selOpB = 3'b010;
				FPUOp = 2'b01;
                ALUOp = 'X;
                ShiftDir = 'X;
				brSel = 2'b11;
				brEx = 0;
 				selWrData = 2'b01;
			end
            default: begin
				ALUorFPU = '0;
				Branch = '0;
				RegWrite = '0;
				MemWrite = '0;
				MemRead = '0;
				keepFlags = '0;
				Reg1Loc = '0;
				Reg2Loc = '0;
                Reg3Loc = '0;
 				selOpA = '0;
 				selOpB = '0;
				FPUOp = '0;
                ALUOp = '0;
				brSel = '0;
				brEx = '0;
 				selWrData = '0;
                ShiftDir = '0;
            end
		endcase
	end
endmodule

/*
// Tests that control logic operates properly for each type of instruction used in the benchmark tests
module cpuControl_testbench();
	// Current Instruction being ran by CPU
	logic [31:0] instr;
	// Flags and clk/reset
	logic negative, zero, overflow, alu_zero, clk, reset;
	
	// The control logics used by the cpu datapath
	logic Reg2Loc, RegWrite, MemWrite, MemRead,
					 MemToReg, BrTaken, UncondBr, ALUSrc, 
					 ShiftDir, nineOrTwelve, keepFlags;

	// Controls the operation the ALU will perform
	logic [2:0] ALUOp;
	// Controls the output of the execution stage
	logic [1:0] calcSrc;

	initial begin
		negative = 0; zero = 0; overflow = 0; alu_zero = 0; #10;
		instr = 32'b10010001000000000000001111100000; #500; // ADDI
		instr = 32'b00010100000000000000000000000000; #500; // B
		instr = 32'b11101011000111110000000000101000; #500; // SUBS
		instr = 32'b11111000000000000001000010000011; #500; // STUR
		instr = 32'b11111000010000000000001111101111; #500; // LDUR
		instr = 32'b01010100000000000000000010001011; #500; // B.LT
	end
endmodule */
