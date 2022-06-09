module top(
    input logic clk, reset
);

    logic [15:0] dataOut, aluOutput, ReadData2E, PC, instr;
    logic MemWriteE, MemReadE;
    wire VDD, VSS;

    assign VDD = 1'b1;
    assign VSS = 1'b0;

    cpu core(.clk, .reset, .PC, .instr, .dataOut, .aluOutput, .MemWriteE, .MemReadE,
        .ReadData2E, .VDD, .VSS);
	
    instructmem instructionMemory(.address(PC), .instruction(instr), .clk);
	
    datamem dataMemory(.address(aluOutput), .write_enable(MemWriteE), 
        .read_enable(MemReadE), .write_data(ReadData2E), .clk, .reset, 
        .read_data(dataOut));

    initial begin 
        $sdf_annotate("../../sapr/apr/results/cpu.apr.sdf", core);
    end
endmodule
