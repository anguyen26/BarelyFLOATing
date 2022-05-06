module tb_fp_add();
    logic [15:0] opA, opB, sum;

    fp_add dut(.opA, .opB, .sum);
    initial begin
        $vcdpluson;
        opA = 16'b0_10000101_1001000;
        opB = 16'b0_01111110_0000000;
        #10;
        $finish;
    end
endmodule
