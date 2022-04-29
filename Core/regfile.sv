//impliments a register file 16 bits
 
// wr_data - data to write
// wr_en - write enable 
// wr_addr - address for writing
// rd_addr_0, rd_addr_1 - addresses for reading from the regfile (async)
// rd_data_0, rd_data_1	- data for specified address (async)
// clk - system clock 
module regfile (
	input logic clk, wr_en,
	input logic [15:0] wr_data,
	input logic [3:0] wr_addr,
	input logic [3:0] rd_addr_0, rd_addr_1,
	output logic [15:0] rd_data_0, rd_data_1
);

	//main memory within the regfile
	logic [15:0][15:0] MEM;

	//write data on positive edge of clock when wr_en is high
	always_ff @(posedge clk) begin
		if(wr_en) begin
			MEM[wr_addr] <= wr_data;
		end
	end

	//async reads
	assign rd_data_0 = MEM[rd_addr_0];	
	assign rd_data_1 = MEM[rd_addr_1];

endmodule
/*
module regfile_testbench();
	// system signals
	logic clk, wr_en;
	logic [31:0] wr_data, rd_data_0, rd_data_1;
	logic [3:0] wr_addr, rd_addr_0, rd_addr_1;	 

	// regfile instantion.
	regfile dut (wr_data, wr_en, wr_addr, rd_addr_0, rd_addr_1, rd_data_0, rd_data_1, clk);

	// Set up a simulated clock.
	parameter CLOCK_PERIOD=10;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
	end

	initial begin
		//write ocurring at the next clock edge after wr_en going high
		wr_data <= 32'b11011101101101010010100001110110; wr_en <= 1'b1; wr_addr <= 4'b0000; rd_addr_0 <= 4'b0000; rd_addr_1 <= 4'b0001; #10;
		repeat(2) #10;
		
		//make sure rd_addrs and outputs both change combintationlly
		wr_en <= 1'b0; rd_addr_0 <= 4'b0001; rd_addr_1 <= 4'b0000; #10;
		repeat(2) #10;
		$stop;
	end

endmodule
*/
