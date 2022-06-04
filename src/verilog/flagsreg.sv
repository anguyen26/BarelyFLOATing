module flagsreg(
    input logic clk, reset,
    input logic [3:0] in, en,
    output logic [3:0] out
);

    always_ff @(posedge clk) begin
        if (reset) begin
            out = 4'd0;
        end
        else begin
            if (en[0]) out[0] = 1'b1;
            else out[0] = 1'b0;
            if (en[1]) out[1] = 1'b1;
            else out[1] = 1'b0;
            if (en[2]) out[2] = 1'b1;
            else out[2] = 1'b0;
            if (en[3]) out[3] = 1'b1;
            else out[3] = 1'b0;
        end
    end
endmodule
