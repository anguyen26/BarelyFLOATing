module fp_add(
    input logic clk, reset,
    input logic [15:0] opA, opB,
    output logic [15:0] sum,
    output logic underflow, overflow, inexact
    );

    // Exponent Stage
    logic sA, sB;
    logic [7:0] eA, eB;
    logic [6:0] mA, mB;
    
    logic keepSA, keepSB;
    logic [7:0] keepEA, keepEB, diffE, absDiffE, shiftInput, shiftOutput, op2;
    logic [6:0] keepMA, keepMB;
    logic sticky, subtract;

    // Mantissa Stage
    logic keepSA2, keepSB2;
    logic [7:0] keepEA2, keepEB2, mSum;
    logic keepSticky;
    logic cout, selBigE, keepSubtract;

    // Flag stage
    logic keepSA3, finalS;
    logic [7:0] keepEA3, keepEB3;
    logic keepSticky2, keepSubtract2, keepSelBigE;
    logic [7:0] bigE, sumM, sumE, finalM, finalE;
     
    /////////////////////////////////////////////////////////
    // Match exponents
    // ------------------------------
    
    assign sA = opA[15];
    assign eA = opA[14:7];
    assign mA = opA[6:0];
    assign sB = opB[15];
    assign eB = opB[14:7];
    assign mB = opB[6:0];

    // subtract exponents
    assign diffE = eA - eB;
    assign absDiffE = diffE[7] ? ~diffE+1 : diffE;

    // select operand w/ smaller exponent to shift mantissa to the right
    assign shiftInput = diffE[7] ? {1'b1, mA} : {1'b1, mB};
    
    always_comb begin
        case(absDiffE)
            8'd0: sticky = 1'b0;
            8'd1: sticky = shiftInput[0];
            8'd2: sticky = shiftInput[1:0];
            8'd3: sticky = shiftInput[2:0];
            8'd4: sticky = shiftInput[3:0];
            8'd5: sticky = shiftInput[4:0];
            8'd6: sticky = shiftInput[5:0];
            8'd7: sticky = shiftInput[6:0];
            8'd8: sticky = shiftInput;
        endcase
    end
    
    assign subtract = sA ^ sB;
    
    always_ff @(posedge clk) begin
        shiftOutput <= shiftInput >> absDiffE;
        op2 <= diffE[7] ? {1'b1, mB} : {1'b1, mA};
    end

    always_ff @(posedge clk) begin
        keepSA <= sA;
        keepSB <= sB;
        keepEA <= eA;
        keepEB <= eB;
        keepSticky <= sticky;
        keepSubtract <= subtract;
        selBigE <= diffE[7];
    end
    
    /////////////////////////////////////////////////////////
    // Add mantissas
    // ------------------------------
    
    always_ff @(posedge clk) begin
        {cout, mSum} <= keepSubtract ? (op2 - shiftOutput) : 
                                     (op2 + shiftOutput);
    end
    // adder #(8) addM(.in1(shiftOutput), .in2(op2), .cin(subtract), .out(mSum), .cout(overflow));
    // assign underflow = mSum[7];
    always_ff @(posedge clk) begin
        keepSticky2 <= keepSticky;
        keepSubtract2 <= keepSubtract;
        keepSA2 <= keepSA;
        keepSB2 <= keepSB;
        keepEA2 <= keepEA;
        keepEB2 <= keepEB;
        keepSelBigE <= selBigE;
    end
    
    /////////////////////////////////////////////////////////
    // Normalize & set flags 
    // ------------------------------

    // Normalize
    assign finalS = (keepSubtract2 & selBigE) ? keepSB2 : keepSA2;
    assign bigE = selBigE ? keepEB2 : keepEA2;
    assign sumE = cout ? (bigE+1) : (bigE);
    assign sumM = cout ? (mSum>>1) : (mSum);
    
    // Handle special cases
    assign finalM = (sumE == 8'b11111111) ? 8'd0 : sumM;
    assign finalE = sumE;

    // TODO: figure out sign bits
    always_ff @(posedge clk) begin
        sum <= {finalS, finalE, finalM[6:0]};
        overflow <= (sumE == 8'b11111111) ? 1'b1 : 1'b0;
        underflow <= (finalE == 8'd0 & keepSticky2) ? 1'b1 : 1'b0;
        inexact <= keepSticky2;
    end
endmodule
