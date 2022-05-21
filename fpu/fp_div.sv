module fp_div(
    input logic clk, reset, start,
    input logic [15:0] opA, opB,
    output logic [15:0] quotient,
    output logic underflow, overflow, inexact, valid, busy
    );

    logic sA, sB, sign;
    logic [7:0] eA, eB, eDiff, biasedEDiff, finalE;
    logic [6:0] mA, mB, finalM;
    logic mValid, dbz, ovf;
    logic [7:0] mQuotient, r, shiftAmount;
    logic sticky, eSub0, eNormal0;
    
    assign sA = opA[15];
    assign eA = opA[14:7];
    assign mA = opA[6:0];
    assign sB = opB[15];
    assign eB = opB[14:7];
    assign mB = opB[6:0];

    /////////////////////////////////////////////////////////
    // Divide mantissas
    // ------------------------------

    div divMantissas(.clk, .reset, .start, .busy, .valid(mValid), .dbz, .ovf, 
        .x({1'b1, mA}), .y({1'b1, mB}), .q(mQuotient), .r);

    /////////////////////////////////////////////////////////
    // Subtract exponents
    // ------------------------------

    assign eDiff = eA - eB;
    assign biasedEDiff = eDiff + 127;
    assign eSub0 = (biasedEDiff == 8'd0) ? 1'b1 : 1'b0;
        
    /////////////////////////////////////////////////////////
    // Normalize
    // ------------------------------
    
    assign sign = sA ^ sB;
    always_comb begin
        casez(mQuotient)
            8'b1???????: shiftAmount = 0;
            8'b01??????: shiftAmount = 1;
            8'b001?????: shiftAmount = 2;
            8'b0001????: shiftAmount = 3;
            8'b00001???: shiftAmount = 4;
            8'b000001??: shiftAmount = 5;
            8'b0000001?: shiftAmount = 6;
            8'b00000001: shiftAmount = 7;
            8'b00000000: shiftAmount = 8;
            default: shiftAmount = 10;
        endcase
    end

    assign finalM = mQuotient << shiftAmount;
    assign finalE = biasedEDiff - shiftAmount;
    assign eNormal0 = (finalE == 8'd0) ? 1'b1 : 1'b0;
    assign sticky = (r != 8'd0);

    always_ff @(posedge clk) begin
        if (reset) begin
            valid <= 1'b1;
        end
        else if (mValid) begin
            quotient <= {sign, finalE, finalM[6:0]};
            overflow <= 1'b0;
            inexact <= sticky;
            underflow <= (eSub0 | eNormal0) & sticky;
            valid <= 1'b1;
        end
        else begin
            quotient <= quotient;
            overflow <= overflow;
            inexact <= inexact;
            underflow <= underflow;
            valid <= 1'b0;
        end
    end

endmodule

