// forwarding tracks the destination addresses at the EX and MEM stages and compares them to the registers being read in regfile.
// Whether the addresses match while the write enables at the EX and MEM stages are true is reflected in .
// forwarding tracks the destination addresses and write enables at the EX and MEM stages and compares them to the registers
// being read in the RF stage to determine if data can be forwarded
module forwarding(addrA, addrB, ex_wa, ex_we, mem_wa, mem_we, selData1, selData2, noop);
	input logic [3:0] addrA, addrB, ex_wa, mem_wa;
	input logic ex_we, mem_we, noop;
	output logic [1:0] selData1, selData2;

	logic fwdEx1, fwdEx2, fwdMem1, fwdMem2;
	
	// data is forwarded from the ex stage if the register addresses match, write enable is true, and the operation isn't a NOOP
	assign fwdEx1 = (addrA == ex_wa) & ex_we & (!noop);
	assign fwdEx2 = (addrB == ex_wa) & ex_we & (!noop);
	// data is forwarded from the mem stage if the register addresses match, write enable is true, and the operation isn't a NOOP
	assign fwdMem1 = (addrA == mem_wa) & mem_we & (!noop);
	assign fwdMem2 = (addrB == mem_wa) & mem_we & (!noop);
	
	// selData1 and selData2 are 2-bit signals that control muxes in the top-level module. The muxes output data from the RF, EX, or 
	// MEM stage based on these signals
	// 00 - no forwarding
	// 01 - forward from EX stage
	// 10 - forward from MEM stage
	// 11 - forward from EX stage (destination addresses match both EX and MEM stage, but data from EX stage is the latest update
	assign selData1 = {fwdMem1, fwdEx1};
	assign selData2 = {fwdMem2, fwdEx2};
endmodule
/*
// forwarding_testbench tests all cases of addresses matching/not matching and write enables being true/false. 
module forwarding_testbench();
	logic [4:0] addrA, addrB, ex_wa, mem_wa;
	logic ex_we, mem_we;
	logic [1:0] selData1, selData2;
	
	forwarding dut(addrA, addrB, ex_wa, ex_we, mem_wa, mem_we, selData1, selData2);
	
	initial begin
		// address at EX stage matches addrA
		addrA=5'b00001; addrB=5'b00010; ex_wa=5'b00001; ex_we=0; mem_wa=5'b00000; mem_we=1; #10;
		addrA=5'b00001; addrB=5'b00010; ex_wa=5'b00001; ex_we=1; mem_wa=5'b00000; mem_we=1; #10; // EX write enable becomes true
		// address at MEM stage matches addrA
		addrA=5'b00011; addrB=5'b00010; ex_wa=5'b00001; ex_we=1; mem_wa=5'b00011; mem_we=0; #10;
		addrA=5'b00011; addrB=5'b00010; ex_wa=5'b00001; ex_we=1; mem_wa=5'b00011; mem_we=1; #10; // MEM write enable becomes true
		// addresses at both EX and MEM stages match addrA
		addrA=5'b00011; addrB=5'b00010; ex_wa=5'b00011; ex_we=1; mem_wa=5'b00011; mem_we=1; #10;
		
		// address at EX stage matches addrB
		addrA=5'b00001; addrB=5'b00100; ex_wa=5'b00100; ex_we=0; mem_wa=5'b00000; mem_we=1; #10;
		addrA=5'b00001; addrB=5'b00100; ex_wa=5'b00100; ex_we=1; mem_wa=5'b00000; mem_we=1; #10; // EX write enable becomes true
		// address at MEM stage matches addrB
		addrA=5'b00001; addrB=5'b00101; ex_wa=5'b00100; ex_we=1; mem_wa=5'b00101; mem_we=0; #10;
		addrA=5'b00001; addrB=5'b00101; ex_wa=5'b00100; ex_we=1; mem_wa=5'b00101; mem_we=1; #10; // MEM write enable becomes true
		// address at both the EX and MEM stages match addrB
		addrA=5'b00001; addrB=5'b00101; ex_wa=5'b00101; ex_we=1; mem_wa=5'b00101; mem_we=1; #10;
		
		// no addresses match addrA or addrB (test no forwarding)
		addrA=5'b00001; addrB=5'b00010; ex_wa=5'b00011; ex_we=1; mem_wa=5'b00100; mem_we=1; #10;
	end
endmodule
*/
