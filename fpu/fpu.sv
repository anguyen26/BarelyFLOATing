module fpu(
    input logic clk, reset,
    input logic [15:0] opA, opB,
    input logic [1:0] op,
    output logic [15:0] result,
    output logic overflow, underflow, inexact
);

    logic [15:0] newOpB;
    
    // Opcodes:
    // 00: add
    // 01: sub
    // 10: mul
    // 11: div

    assign newOpB = (op == 2'd0) ? opB : {~opB[15], opB[14:0]};
    fp_add add_sub(.clk, .reset, .opA, .opB(newOpB), .sum(result),
        .underflow, .overflow, .inexact);

endmodule
