module fp_add(
    input logic [15:0] opA, opB,
    output logic [15:0] sum
    );

    logic subE_cout, overflow;
    logic [7:0] fullMA, fullMB, diffE, absDiffE, shiftInput, shiftOutput, op2, mSum, bigE, finalM, finalE;


    assign fullMA = {1'b1, opA[6:0]};
    assign fullMB = {1'b1, opB[6:0]};

    // subtract exponents
    adder #(8) subE(.in1(opA[14:7]), .in2(~opB[14:7]), .cin(1'b1), .out(diffE), .cout(subE_cout));

    mux2 selDiffE(.i0(diffE), .i1(~diffE+1), .sel(diffE[7]), .out(absDiffE)); 
    mux2 selM1(.i0(fullMB), .i1(fullMA), .sel(diffE[7]), .out(shiftInput));
    mux2 selM2(.i0(fullMA), .i1(fullMB), .sel(diffE[7]), .out(op2));


    assign shiftOutput = shiftInput >> absDiffE;
    
    // add 
    adder #(8) addM(.in1(shiftOutput), .in2(op2), .cin(1'b0), .out(mSum), .cout(overflow));
    assign underflow = mSum[7];
    
    // normalize
    mux2 selBigE(.i0(opA[14:7]), .i1(opB[14:7]), .sel(diffE[7]), .out(bigE));
    mux2 selNormalE(.i0(bigE), .i1(bigE+1), .sel(overflow), .out(finalE));
    mux2 selNormalM(.i0(mSum), .i1(mSum>>1), .sel(overflow), .out(finalM));

    // TODO: figure out sign bits
    assign sum = {opA[15], finalE, finalM[6:0]};
endmodule
