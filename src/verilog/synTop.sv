// This module is simmilar to top.sv but it annotates with syn timing

module top(
    input logic clk, reset
);

    logic [15:0] dataOut, aluOutput, ReadData2E, PC, instr;
    logic MemWriteE, MemReadE;

    cpu core(.clk, .reset, .PC, .instr, .dataOut, .aluOutput, .MemWriteE, .MemReadE,
        .ReadData2E);
	
    instructmem instructionMemory(.address(PC), .instruction(instr), .clk);
	
    datamem dataMemory(.address(aluOutput), .write_enable(MemWriteE), 
        .read_enable(MemReadE), .write_data(ReadData2E), .clk, .reset, 
        .read_data(dataOut));

    initial begin 
        $sdf_annotate("../../sapr/syn/results/cpu.syn.sdf", core);
    end
endmodule
