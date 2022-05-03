
`timescale 1ps/1ps
module cpu(clk, reset);
	input logic clk, reset;
	
	// Program Counter logic
	logic [15:0] PC, PCNext;
	
	// Branch logic
	logic [15:0] condBrAddr, uncondBrAddr, selectedBranch,
					 shiftedSelectedAddr, branchAddr, noBranchAddr;

	// Instruction Logic	 
	logic [15:0] instr;
	
	// ALU and RegFile Data logics
	logic [15:0] ReadData1, ReadData2, selectedData2, imm3, imm5, imm7, imm8,
					 selectedExtended, aluOutput, shiftOutput,
					 computationResult, dataOut, opA, opB, whichMOV, 
                     			 regWrData, MOVorLR;
	
	// Used to determine what data register should come out of ReadData2
	logic [3:0] reg1Addr, reg2Addr,  regWriteAddr, sp, lp;
	// Used to determine which operation the ALU should do
	logic [2:0] ALUOp;
	// Choose between the ALU output, Multiplier Output, or Shifter Output
	logic [1:0] calcSrc;
	// ALU Flag values and stored flag values
	logic [3:0] ALUFlags;
	logic [3:0] FlagsReg;
	logic rf_zero;

	// Interconnects for branch logic
	logic [15:0] pcOffset, linkBrAddr, brExcAddr, shiftedBranchAddr;
	
	// Control Logic
	logic RegWrite, MemWrite, MemRead,
		  ALUSrc, ShiftDir, brEx, noop;
	logic [3:0] keepFlags;
	logic [1:0] brSel, Reg1Loc, Reg2Loc, Reg3Loc, selWrData;		
    logic selOpA;
    logic [3:0] selOpB;
				
	//********************************************************************************************\\
	//************************************* Instruction Fetch ************************************\\
	//********************************************************************************************\\

	// Outputs next PC every clock cycle
	register PCRegister(.dataIn(PCNext), .dataOut(PC), .writeEnable(1'b1), .reset, .clk);
	
	// Outputs the instruction that correlates with the current clock cycle's PC
	instructmem instructionMemory(.address(PC), .instruction(instr), .clk);

	//********************************************************************************************\\
	//************************************** Register Fetch **************************************\\
	//********************************************************************************************\\
    // SP register is R13
    assign sp = 4'b1101;
    // LR register is R14 
    assign lr = 4'b1110; 
	// Selects in from either	   			Rm/Rn 		 SP=R13
	//							   			other		 SUB/ADD
    // 00: Rn (for add, etc.) or Rm (for rotate & logical)
    // 01: SP (for SUB/ADD)
    // 10: PC (for BL)

    // 1: Rn (for ADDS/SUBS), Rm (for Rotate, Logical); 0: SP 
	// assign reg1Addr = Reg1Loc ? ({1'b0, instr[5:3]}) : sp;
    mux3x4_4 reg1AddrMux(.i0(sp), .i1({1'b0, instr[5:3]}), .i2({1'b0, instr[2:0]}), .sel(Reg1Loc), .out(reg1Addr));
    // 1: Rd (for Rotate, Logical); 0: Rm (for ADDS/SUBS)
    // assign reg2Addr = Reg2Loc ? ({1'b0, instr[2:0]}) : ({1'b0, instr[5:3]});
    mux4x4_4 reg2AddrMux(.i0({1'b0, instr[8:6]}), .i1({1'b0, instr[5:3]}), .i2({1'b0, instr[2:0]}), .i3(instr[6:3]), .sel(Reg2Loc), .out(reg2Addr));
	
    // Selects the regWriteAddr
    // 00: Rd for ADDS/SUBS
    // 01: SP for ADD/SUB
    // 10: Rd for MOVS
    // 11: LR for BL
	mux4x4_4 regWriteMux(.i0({1'b0, instr[2:0]}), .i1(4'b1101), .i2({1'b0, instr[10:8]}), .i3(4'b1110), .sel(Reg3Loc), .out(regWriteAddr));



	
	// Instantiates the register files. Write address and RegWrite are controlled by the Write Back stage. 
	regfile registers(.clk, .reset, .wr_en(RegWrite), .wr_data(regWrData), .PC, .wr_addr(regWriteAddr), .rd_data_0(ReadData1), .rd_data_1(ReadData2), 
						.rd_addr_0(reg1Addr), .rd_addr_1(reg2Addr));

	
	//*************** Control Unit *****************\\

	// Takes in the instructions and alu flags, then outputs control logic.
	// Other flags do not need to be changed since they will be updated in the EX stage of the previous instruction, which happens
	// at the same time as this RF stage for the branch instruction
	cpuControl controlUnit(.PC, .instr, .FlagsReg, .Reg1Loc, .Reg2Loc, .Reg3Loc, .RegWrite, 
						.MemWrite, .MemRead, .ShiftDir, .keepFlags, .ALUOp, 
						.noop, .brSel, .brEx, .clk, .reset, .selWrData, .selOpA, .selOpB);

	//************ Calculate Next PC **************\\
	
	// Sign extends the branch immediate values
	assign condBrAddr = 	{{8{instr[7]}}, {instr[7:0]}};
	assign uncondBrAddr = 	{{5{instr[10]}}, {instr[10:0]}};
	assign linkBrAddr = 	{{10{instr[5]}}, {instr[5:0]}};
	assign brExcAddr = 		ReadData2;
    
	// selects which immediate to use
	mux4x16_16 branchAddrMux(.i0(linkBrAddr), .i1(condBrAddr), .i2(uncondBrAddr), .i3(16'd1), .sel(brSel), .out(branchAddr));
    assign shiftedBranchAddr = branchAddr << 2;
    // add to PC
	adder brancherAdder(.in1(PC), .in2(shiftedBranchAddr), .out(pcOffset), .cout());

	// Chooses between either the normal PC offset from standard branch or branch exchange
	assign PCNext = brEx ? (brExcAddr << 2) : pcOffset;

	
	//********************************************************************************************\\
	//**************************************** Execution *****************************************\\
	//********************************************************************************************\\

	// Sign extend immidates
	//imm3 for ADDS/SUBS
	assign imm3 = {{13{1'b0}}, {instr[8:6]}};
	//imm5 for LDR/STR
	assign imm7 = {{9{1'b0}}, {instr[6:0]}};
	//imm7 for ADD/SUB
	assign imm5 = {{11{1'b0}}, {instr[10:6]}};
	
	// Chooses which extended imm to use
	// mux4x16_16 immMux(.i0(imm3), .i1(imm5), .i2(imm7), .i3(imm8), .sel(EX_37), .out(selectedExtended));

	// Selects operand A for ALU
    assign opA = selOpA ? PC : ReadData1;
    // Selects operand B for ALU
    mux5x16_16 opBMux(.i0(ReadData2), .i1(imm3), .i2(imm7), .i3(imm5), .i4(16'd1), .sel(selOpB), .out(opB));

	// Instantiates the ALU
	ALU aluBlock(.a(opA), .b(opB), .ALUControl(ALUOp), .Result(aluOutput), .ALUFlags);
	
	// Determines whether to set the system flags to the new values from ALU based on the instruction
	register_4 FlagsRegister(.dataIn(ALUFlags), .dataOut(FlagsReg), .writeEnable(keepFlags), .reset(reset), .clk(clk));
	//assign FlagsReg = keepFlags ? FlagsReg : ALUFlags;

	// Shifts ReadData1 left or right based on a given distance from the instruction. ShiftDirection is determined by control unit
	shifter shiftBlock(.value(ReadData2), .direction(EX_SD), .distance(ReadData1), .result(shiftOutput));
	
	//********************************************************************************************\\
	//*************************************** Data Memory ****************************************\\
	//********************************************************************************************\\
	

	// Instantiates the Data Memory with 8 byte transfer size since we want to write 8 bytes at a time
	datamem dataMemory(.address(aluOutput), .write_enable(memWrite), .read_enable(memRead), .write_data(ReadData2), .clk, 
							.xfer_size(4'd4), .read_data(dataOut));
	
	// Chooses whether the output of the data memory or alu will go to the write of the reg file
	// assign MEM_WriteData = MEM_MemToReg ? dataOut : MEM_compData;

	//********************************************************************************************\\
	//*************************************** Write Back ****************************************\\
	//********************************************************************************************\\
	
	assign imm8 = {{8{1'b0}}, {instr[7:0]}};
	// Select type of MOV
    // 1: MOVS, 0: MOV/LR
	assign whichMOV = instr[13] ? imm8 : ReadData2;
	logic [15:0] PCPlus1;
	adder LRAdder(.in1(PC), .in2(16'd4), .out(PCPlus1), .cout());
	assign MOVorLR = brSel[0] ? whichMOV : (PCPlus1 >> 2);

    // Based on the instruction choose between the ALU ouput/shifter output/MOV output
	mux4x16_16 regWrMux(.i0(shiftOutput), .i1(aluOutput), .i2(MOVorLR), .i3(dataOut), .sel(selWrData), .out(regWrData));

endmodule
