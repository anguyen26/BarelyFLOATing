// This top level module connects the CPU Core to the instruction/data memory

module top(
    input logic clk, reset
);
    
    // module interconnects
    logic [15:0] dataOut, aluOutput, ReadData2E, PC, instr;
    logic MemWriteE, MemReadE;

    //instantiate cpu core
    cpu core(.clk, .reset, .PC, .instr, .dataOut, .aluOutput, .MemWriteE, .MemReadE,
        .ReadData2E);
	
    instructmem instructionMemory(.address(PC), .instruction(instr), .clk);
	
    datamem dataMemory(.address(aluOutput), .write_enable(MemWriteE), 
        .read_enable(MemReadE), .write_data(ReadData2E), .clk, .reset, 
        .read_data(dataOut));

endmodule
