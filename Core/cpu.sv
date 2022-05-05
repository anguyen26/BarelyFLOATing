`timescale 1ps/1ps
module cpu(
	input logic clk, reset
);
	
	// Program Counter logic
	logic [15:0] 	PC, PCNext;
	logic [15:0] 	PCPlus1;
	
	// Branch logic
	logic [15:0] 	condBrAddr, uncondBrAddr, selectedBranch,
					shiftedSelectedAddr, branchAddr, noBranchAddr;

	// Instruction Logic	 
	logic [15:0] 	instr, instrE;
	
	// ALU and RegFile Data logics
	logic [15:0] 	ReadData1, ReadData2, selectedData2, imm3, imm5, imm7, imm8,
					selectedExtended, aluOutput, shiftOutput,
					computationResult, dataOut, opA, opB, whichMOV, 
					regWrData, MOVorLR;

	logic [15:0]	ReadData1E, ReadData2E, selectedData2E, imm3, imm5, imm7, imm8,
					selectedExtendedE, aluOutputE, shiftOutputE,
					computationResultE, dataOutE, opAE, opBE, whichMOVE, 
					regWrDataE, MOVorLRE;
	
	// Used to determine what data register should come out of ReadData2
	logic [3:0] 	reg1Addr, reg2Addr,  regWriteAddr;
	logic [3:0] 	reg1AddrE, reg2AddrE,  regWriteAddrE;
	// Used to determine which operation the ALU should do
	logic [2:0] 	ALUOp, ALUOpE;
	// ALU Flag values and stored flag values
	logic [3:0] 	ALUFlags;
	logic [3:0] 	FlagsReg;

	// Interconnects for branch logic
	logic [15:0] 	pcOffset, linkBrAddr, brExcAddr, shiftedBranchAddr;
	
	// Control Logic
	logic 			RegWrite, MemWrite, MemRead, ALUSrc, brEx, selOpA;
	logic [1:0] 	ShiftDir, brSel, Reg1Loc, Reg2Loc, Reg3Loc, selWrData;
	logic [3:0] 	keepFlags, selOpB;

	logic 			RegWriteE, MemWriteE, MemReadE, ALUSrcE, brExE, selOpAE;
	logic [1:0] 	ShiftDirE, brSelE, Reg1LocE, Reg2LocE, Reg3LocE, selWrDataE;
	logic [3:0] 	keepFlagsE, selOpBE;
				
	//********************************************************************************************\\
	//************************************* Instruction Fetch ************************************\\
	//********************************************************************************************\\

	// Outputs next PC every clock cycle
	register PCRegister(.dataIn(PCNext), .dataOut(PC), .writeEnable(1'b1), .reset, .clk);
	
	// Outputs the instruction that correlates with the current clock cycle's PC
	instructmem instructionMemory(.address(PC), .instruction(instr), .clk);

	//********************************************************************************************\\
	//************************************** Register Fetch **************************************\\

	//selects reg1Addr & reg2Addr (for reads)
	mux3x4_4 reg1AddrMux(.i0(4'b1101), .i1({1'b0, instr[5:3]}), .i2({1'b0, instr[2:0]}), .sel(Reg1Loc), .out(reg1Addr));
	mux4x4_4 reg2AddrMux(.i0({1'b0, instr[8:6]}), .i1({1'b0, instr[5:3]}), .i2({1'b0, instr[2:0]}), .i3(instr[6:3]), .sel(Reg2Loc), .out(reg2Addr));
	
	// Selects the regWriteAddr
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


	// Pipeline signals from Fetch/Decode
	pipelineReg #(.bitWidth(16)) decodeToExec0 (.D(instr), .Q(instrE), .en(1'b1), .clear(1'b0), .clk);
	
	pipelineReg #(.bitWidth(16)) decodeToExec1 (.D(ReadData1), .Q(ReadData1E), .en(1'b1), .clear(1'b0), .clk);
	pipelineReg #(.bitWidth(16)) decodeToExec2 (.D(ReadData2), .Q(ReadData2E), .en(1'b1), .clear(1'b0), .clk);
	pipelineReg #(.bitWidth(16)) decodeToExec3 (.D(opA), .Q(opAE), .en(1'b1), .clear(1'b0), .clk);
	pipelineReg #(.bitWidth(16)) decodeToExec4 (.D(opB), .Q(opBE), .en(1'b1), .clear(1'b0), .clk);
	pipelineReg #(.bitWidth(3)) decodeToExec5 (.D(ALUOp), .Q(ALUOpE), .en(1'b1), .clear(1'b0), .clk);
	pipelineReg #(.bitWidth(2)) decodeToExec6 (.D(ShiftDir), .Q(ShiftDirE), .en(1'b1), .clear(1'b0), .clk);
	pipelineReg #(.bitWidth(16)) decodeToExec7 (.D(PC), .Q(PCE), .en(1'b1), .clear(1'b0), .clk);
	pipelineReg #(.bitWidth(1)) decodeToExec8 (.D(selOpA), .Q(selOpAE), .en(1'b1), .clear(1'b0), .clk);
	pipelineReg #(.bitWidth(4)) decodeToExec9 (.D(selOpB), .Q(selOpBE), .en(1'b1), .clear(1'b0), .clk);
	pipelineReg #(.bitWidth(1)) decodeToExec10 (.D(MemWrite), .Q(MemWriteE), .en(1'b1), .clear(1'b0), .clk);
	pipelineReg #(.bitWidth(2)) decodeToExec11 (.D(ShiftDir), .Q(ShiftDirE), .en(1'b1), .clear(1'b0), .clk);
	pipelineReg #(.bitWidth(1)) decodeToExec12 (.D(MemRead), .Q(MemReadE), .en(1'b1), .clear(1'b0), .clk);
	pipelineReg #(.bitWidth(2)) decodeToExec13 (.D(selWrData), .Q(selWrDataE), .en(1'b1), .clear(1'b0), .clk);
	

	// Sign extend immidates
	//imm3 for ADDS/SUBS
	assign imm3 = {{13{1'b0}}, {instrE[8:6]}};
	//imm5 for LDR/STR
	assign imm7 = {{9{1'b0}}, {instrE[6:0]}};
	//imm7 for ADD/SUB
	assign imm5 = {{11{1'b0}}, {instrE[10:6]}};

	// Selects operand A for ALU
	assign opAE = selOpAE ? PCE : ReadData1E;
	// Selects operand B for ALU
	mux5x16_16 opBMux(.i0(ReadData2E), .i1(imm3), .i2(imm7), .i3(imm5), .i4(16'd1), .sel(selOpBE), .out(opBE));

	// Instantiates the ALU
	ALU aluBlock(.a(opAE), .b(opBE), .ALUControl(ALUOpE), .Result(aluOutput), .ALUFlags);
	
	// Determines whether to set the system flags to the new values from ALU based on the instruction
	register_4 FlagsRegister(.dataIn(ALUFlags), .dataOut(FlagsReg), .writeEnable(keepFlags), .reset, .clk);
	//assign FlagsReg = keepFlags ? FlagsReg : ALUFlags;

	// Shifts ReadData1 left or right based on a given distance from the instruction. ShiftDirection is determined by control unit
	shifter shiftBlock(.value(ReadData2E), .mode(ShiftDirE), .distance(ReadData1E), .result(shiftOutput));
	

	//********************************************************************************************\\
	//*************************************** Data Memory ****************************************\\
	//********************************************************************************************\\
	

	// Instantiates the Data Memory 65k x 16b
	datamem dataMemory(.address(aluOutput), .write_enable(MemWriteE), .read_enable(MemReadE), .write_data(ReadData2E), .clk, .reset, .read_data(dataOut));


	//********************************************************************************************\\
	//*************************************** Write Back ****************************************\\
	//********************************************************************************************\\
	

	assign imm8 = {{8{1'b0}}, {instrE[7:0]}};
	// Select type of MOV
	assign whichMOV = instrE[13] ? imm8 : ReadData2E;
	adder LRAdder(.in1(PC), .in2(16'd4), .out(PCPlus1), .cout());
	assign MOVorLR = brSelE[0] ? whichMOV : (PCPlus1 >> 2);

	// Based on the instruction choose between the ALU ouput/shifter output/MOV output
	mux4x16_16 regWrMux(.i0(shiftOutput), .i1(aluOutput), .i2(MOVorLR), .i3(dataOut), .sel(selWrDataE), .out(regWrData));


endmodule
