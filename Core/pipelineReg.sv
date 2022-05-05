module pipelineReg #(parameter bitWidth = 32) (
	input logic [bitWidth-1:0] D,
	input logic en, clear, clk,
	output logic [bitWidth-1:0] Q
);

	always_ff @(posedge clk) begin
		if(clear) Q <= 'b0;
		else if(en) Q <= D;
	end

endmodule

/*module pipelineReg_tb();
	parameter bitWidth = 16;
	parameter depth = 3;
	logic [bitWidth-1:0] D [0:depth-1];
	logic [bitWidth-1:0] Q [0:depth-1];
	logic en, clear, clk;

	// generate clock with 100ps clk period 
    initial begin
        clk = 'b1;
        forever #50 clk = ~clk;
    end

    //initialize DUT 
    pipelineReg #(.bitWidth(bitWidth), .depth(depth)) DUT(.D, .en, .clear, .clk, .Q);

    initial begin

    	en = 1; clear = 0; @(posedge clk);
        //start by loading data
        D[0] = 4'h0001; D[1] = 4'h0002; D[2] = 4'h0003; @(posedge clk);

        //disable
        en = 0; @(posedge clk);

        //cycle stall for a while
        repeat(5) @(posedge clk);

        //re-enable and write more data
        en = 1; @(posedge clk);
        D[0] = 4'h0004; D[1] = 4'h0005; D[2] = 4'h0006; @(posedge clk);

        D[0] = 4'h0007; D[1] = 4'h0008; D[2] = 4'h0009; @(posedge clk);

        //disable and "try" to write
        en = 0; @(posedge clk);
        D[0] = 4'h1111;  D[1] = 4'h2222; D[2] = 4'h3333; @(posedge clk);

        //clear out reg
        clear = 1; @(posedge clk);
		repeat(5) @(posedge clk);
		@(posedge clk);
        $stop;
    end
endmodule
*/


