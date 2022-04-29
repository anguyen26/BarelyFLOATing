
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
					 computationResult, dataOut;
	
	// Used to determine what data register should come out of ReadData2
	logic [3:0] reg1Addr, reg2Addr,  regWriteAddr;
	// Used to determine which operation the ALU should do
	logic [2:0] ALUOp;
	// Choose between the ALU output, Multiplier Output, or Shifter Output
	logic [1:0] calcSrc;
	// ALU Flag values and stored flag values
	logic [3:0] ALUFlags;
	logic [3:0] FlagsReg;
	logic rf_zero;

	// Interconnects for branch logic
	logic [15:0] pcOffset, linkBrAddr, brExcAddr;
	
	// Control Logic
	logic Reg1Loc, RegWrite_Control, MemWrite, MemRead, MemToReg,
		  ALUSrc, ShiftDir, brEx, noop;
	logic [3:0] keepFlags;
	logic [1:0] brSel, Reg2Loc, Reg3Loc, ImmSrc;
			
	//************** For pipelining *************\\
	// The registers and bits below hold the outputs of the control unit so that they can be used in the correct stage of the pipeline
	// RF stage needs the whole instruction register since control logic is computed in the RF stage
	logic [15:0] RFinstr;
	logic [15:0] RegStagePC;
	
	// EX stage needs the whole instruction register since it contains operands, plus all control logic for ALU
	logic [15:0] EXinstr;
	logic EX_SD, EX_ALUSrc;
	logic [3:0] EX_keepFlags;
	logic [1:0] EX_calcSrc, EX_37, EX_Reg3Loc;
	logic [2:0] EX_ALUOp;
	// To hold output of MOV
	logic [15:0] whichMOV;
	
	// MEM stage needs all control logic for the memory module
	logic [15:0] MEM_compData, MEMData2, MEM_WriteData;
	logic EX_MemWrite, MEM_MemWrite, EX_MemRead, MEM_MemRead, EX_MemToReg, MEM_MemToReg;
	
	// WB stage needs control logic for the regfile
	logic [15:0] WB_WriteData;
	logic EX_RegWrite, MEM_RegWrite, WB_RegWrite;
	
	//************** For forwarding *************\\
	logic [15:0] RFData1, RFData2, EXData1, EXData2;
	logic [1:0] selData1, selData2;
	logic [3:0] mem_wa, wb_wa;
	logic rf_we, ex_we, mem_we;
				
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
	
	// Passes the instruction from the IF stage to the RF stage
	register hold_instr(.dataIn(instr), .dataOut(RFinstr), .writeEnable(1'b1), .reset, .clk);	
	register regProgramCounter(.dataIn(PC), .dataOut(RegStagePC), .writeEnable(1'b1), .reset, .clk);

	//****************** RegFile *******************\\

	// Selects in from either	   			Rm/Rn 		 SP=R13
	//							   			other		 SUB/ADD
	assign reg1Addr = Reg1Loc ? ({1'b0, RFinstr[5:3]}) : 4'b1101;
	mux4x4_4 reg2AddrMux(.i0({1'b0, RFinstr[8:6]}), .i1({1'b0, RFinstr[5:3]}), .i2({1'b0, RFinstr[2:0]}), .i3(RFinstr[6:3]), .sel(Reg2Loc), .out(reg2Addr));

	
	// Instantiates the register files. Write address and RegWrite are controlled by the Write Back stage. 
	regfile registers(.clk(!clk), .wr_en(WB_RegWrite), .wr_data(WB_WriteData), .wr_addr(wb_wa), .rd_data_0(ReadData1), .rd_data_1(ReadData2), 
						.rd_addr_0(reg1Addr), .rd_addr_1(reg2Addr));
			
	//**************** Forwarding ******************\\
	
	// Instantiates forwarding module
	forwarding fwd(.addrA(reg1Addr), .addrB(reg2Addr), .ex_wa(regWriteAddr), .ex_we(EX_RegWrite), .mem_wa, .mem_we(MEM_RegWrite), .selData1, .selData2, .noop);
	
	// Selects whether data ouput from Register Fetch stage is from regfile, or forwarded from execute or mem stage based on outputs from
	// the forwarding module. If data from both execute and memory stages could be forwarded, data from execute stage is forwarded. 
	mux4x16_16 selRFOut1(.out(RFData1), .i0(ReadData1), .i1(computationResult), .i2(MEM_WriteData), .i3(computationResult), .sel(selData1));
	mux4x16_16 selRFOut2(.out(RFData2), .i0(ReadData2), .i1(computationResult), .i2(MEM_WriteData), .i3(computationResult), .sel(selData2));
	
	//*************** Control Unit *****************\\

	// Takes in the instructions and alu flags, then outputs control logic.
	// Other flags do not need to be changed since they will be updated in the EX stage of the previous instruction, which happens
	// at the same time as this RF stage for the branch instruction
	cpuControl controlUnit(.PC, .instr(RFinstr), .FlagsReg, .Reg2Loc, .Reg3Loc, .RegWrite(RegWrite_Control), 
						.MemWrite, .MemRead, .MemToReg, .ALUSrc, .ALUOp, .Reg1Loc, 
						.ShiftDir, .calcSrc, .ImmSrc, .keepFlags, .noop, .brSel, .brEx, .clk, .reset);

	//************ Calculate Next PC **************\\
	
	// Sign extends the branch immediate values
	assign condBrAddr = 	{{8{RFinstr[7]}}, {RFinstr[7:0]}};
	assign uncondBrAddr = 	{{5{RFinstr[10]}}, {RFinstr[10:0]}};
	assign linkBrAddr = 	{{10{RFinstr[5]}}, {RFinstr[5:0]}};
	assign brExcAddr = 		{{12{1'b0}}, {RFinstr[6:3]}};

	//selects which immidate to use
	mux4x16_16 branchAddrMux(.i0(linkBrAddr), .i1(condBrAddr), .i2(uncondBrAddr), .i3(16'b0000000000000100), .sel(brSel), .out(branchAddr));
	//add to PC
	adder brancherAdder(.in1(PC), .in2(branchAddr), .out(pcOffset), .cout());

	// Chooses between either the normal PC offset from standard branch or branch exchange
	assign PCNext = brEx ? brExcAddr : pcOffset;

	
	//********************************************************************************************\\
	//**************************************** Execution *****************************************\\
	//********************************************************************************************\\
	
	// Passes the instruction from the RF stage to the EX stage 
	register hold_instr2(.dataIn(RFinstr), .dataOut(EXinstr), .writeEnable(1'b1), .reset, .clk);
	
	// Passes data output from the RF stage to the EX stage 
	register hold_reg1(.dataIn(RFData1), .dataOut(EXData1), .writeEnable(1'b1), .reset, .clk);
	register hold_reg2(.dataIn(RFData2), .dataOut(EXData2), .writeEnable(1'b1), .reset, .clk);
	
	// Passes control signals computed in the RF stage to the ALU in the EX stage
	register_2 holdImmSrc(.dataIn(ImmSrc), .dataOut(EX_37), .writeEnable(1'b1), .reset, .clk);	
	D_FF holdShiftDir1(.q(EX_SD), .d(ShiftDir), .reset, .clk);	
	register_2 holdcalcSrc1(.dataIn(calcSrc), .dataOut(EX_calcSrc), .writeEnable(1'b1), .reset, .clk);	
	D_FF holdALUSrc1(.q(EX_ALUSrc), .d(ALUSrc), .reset, .clk);	
	register_3 holdALUOp1(.dataIn(ALUOp), .dataOut(EX_ALUOp), .writeEnable(1'b1), .reset, .clk);
	register_4 holdKeepFlags(.dataIn(keepFlags), .dataOut(EX_keepFlags), .writeEnable(1'b1), .reset, .clk);

	// Passes control for REG write Addr to the EX stage to be selected
	register_2 holdReg3Loc(.dataIn(Reg3Loc), .dataOut(EX_Reg3Loc), .writeEnable(1'b1), .reset, .clk);

	// Sign extend immidates
	//imm3
	assign imm3 = {{13{1'b0}}, {EXinstr[8:6]}};
	//imm5
	assign imm5 = {{11{1'b0}}, {EXinstr[6:0]}};
	//imm7
	assign imm7 = {{9{1'b0}}, {EXinstr[10:6]}};
	//imm8
	assign imm8 = {{8{1'b0}}, {EXinstr[7:0]}};
	
	// Chooses which extended imm to use
	mux4x16_16 immMux(.i0(imm3), .i1(imm5), .i2(imm7), .i3(imm8), .sel(EX_37), .out(selectedExtended));

	// Chooses whether to use the extended immediate value or the register value
	assign selectedData2 = EX_ALUSrc ? selectedExtended : EXData2;
	
	// Instantiates the ALU
	ALU aluBlock(.a(EXData1), .b(selectedData2), .ALUControl(EX_ALUOp), .Result(aluOutput), .ALUFlags);
	
	// Determines whether to set the system flags to the new values from ALU based on the instruction
	assign FlagsReg = EX_keepFlags ? FlagsReg : ALUFlags;

	// Shifts ReadData1 left or right based on a given distance from the instruction. ShiftDirection is determined by control unit
	shifter shiftBlock(.value(EXData1), .direction(EX_SD), .distance(EXinstr[5:3]), .result(shiftOutput));
	
	// Select type of MOV
	assign whichMOV = EX_ALUSrc ? imm8 : {{12{1'b0}}, {EXinstr[6:3]}};

	// Based on the instruction choose between the ALU ouput/shifter output/MOV output
	mux3x16_16 computationSelMux(.i0(shiftOutput), .i1(aluOutput), .i2(whichMOV), .sel(EX_calcSrc), .out(computationResult));

	// Selects the regWriteAddr (SP, MOVS, other)
	mux3x4_4 regWriteMux(.i0({1'b0, EXinstr[2:0]}), .i1(4'b1101), .i2({1'b0, EXinstr[10:8]}), .sel(EX_Reg3Loc), .out(regWriteAddr));
	
	//********************************************************************************************\\
	//*************************************** Data Memory ****************************************\\
	//********************************************************************************************\\
	
	// Passes data output from the EX stage 
	register hold_comp(.dataIn(computationResult), .dataOut(MEM_compData), .writeEnable(1'b1), .reset, .clk);
	register hold_regData(.dataIn(EXData2), .dataOut(MEMData2), .writeEnable(1'b1), .reset, .clk);
	
	// Passes control logic computed in the RF stage through the EX stage and to the MEM stage for the memory unit
	D_FF hold_memWr1(.q(EX_MemWrite), .d(MemWrite), .reset, .clk);
	D_FF hold_memWr2(.q(MEM_MemWrite), .d(EX_MemWrite), .reset, .clk);
	
	D_FF hold_memRd1(.q(EX_MemRead), .d(MemRead), .reset, .clk);
	D_FF hold_memRd2(.q(MEM_MemRead), .d(EX_MemRead), .reset, .clk);
	
	// Passes write address from EX stage to MEM stage for forwarding
	register_4 mem_hold_wrAddr(.dataIn(regWriteAddr), .dataOut(mem_wa), .writeEnable(1'b1), .reset, .clk);

	// Instantiates the Data Memory with 8 byte transfer size since we want to write 8 bytes at a time
	datamem dataMemory(.address(MEM_compData), .write_enable(MEM_MemWrite), .read_enable(MEM_MemRead), .write_data(MEMData2), .clk, 
							.xfer_size(4'd4), .read_data(dataOut));
	
	// Passes control logic computed in the RF stage through the EX stage and to the MEM stage to control the mux below
	D_FF hold_mem2reg1(.q(EX_MemToReg), .d(MemToReg), .reset, .clk);
	D_FF hold_mem2reg2(.q(MEM_MemToReg), .d(EX_MemToReg), .reset, .clk);
	
	// Chooses whether the output of the data memory or alu will go to the write of the reg file
	assign MEM_WriteData = MEM_MemToReg ? dataOut : MEM_compData;

	//********************************************************************************************\\
	//*************************************** Write Back *****************************************\\
	//********************************************************************************************\\
	
	// Passes data output and the write address from the MEM stage 
	register hold_writeData(.dataIn(MEM_WriteData), .dataOut(WB_WriteData), .writeEnable(1'b1), .reset, .clk);
	register_4 wb_hold_wrAddr(.dataIn(mem_wa), .dataOut(wb_wa), .writeEnable(1'b1), .reset, .clk);
	
	// Pass the RegWrite flag so it goes to the write back stage
	D_FF hold_regWr1(.q(EX_RegWrite), .d(RegWrite_Control), .reset, .clk);
	D_FF hold_regWr2(.q(MEM_RegWrite), .d(EX_RegWrite), .reset, .clk);
	D_FF hold_regWr3(.q(WB_RegWrite), .d(MEM_RegWrite), .reset, .clk);
endmodule
