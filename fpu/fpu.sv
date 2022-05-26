module fpu(
    input logic clk, reset,
    input logic [15:0] opA, opB,
    input logic [1:0] op,
    input logic start,
    output logic [15:0] result,
    output logic overflow, underflow, inexact, valid, busy
);

    logic [15:0] newOpB;
    logic [15:0] sum, product, quotient;
    logic aUnderflow, aOverflow, aInexact,
            pUnderflow, pOverflow, pInexact,
            qUnderflow, qOverflow, qInexact;
    logic [1:0] hold_op;

    assign newOpB = (op == 2'd0) ? opB : {~opB[15], opB[14:0]};
    fp_add add_sub(.clk, .reset, .opA, .opB(newOpB), .sum,
        .underflow(aUnderflow), .overflow(aOverflow), .inexact(aInexact));

    fp_mul multiply(.clk, .reset, .opA, .opB, .product, .underflow(pUnderflow),
        .overflow(pOverflow), .inexact(pInexact));

    fp_div divide(.clk, .reset, .opA, .opB, .quotient,
        .underflow(qUnderflow), .overflow(qOverflow), .inexact(qInexact));

    always_ff @(posedge clk) begin
        hold_op <= op;
    end

    always_comb begin
        case(op)
            2'b00: begin
                result = sum;
                overflow = aOverflow;
                underflow = aUnderflow;
                inexact = aInexact;
            end
            2'b01: begin
                result = sum;
                overflow = aOverflow;
                underflow = aUnderflow;
                inexact = aInexact;
            end
            2'b10: begin
                result = product;
                overflow = pOverflow;
                underflow = pUnderflow;
                inexact = pInexact;
            end
            2'b11: begin
                result = quotient;
                overflow = qOverflow;
                underflow = qUnderflow;
                inexact = qInexact;
            end
        endcase
    end

endmodule
