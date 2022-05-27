NOOP
MOVS 0, #7      // R0 = shift amount
MOVS 1, #133
LSLS 1, 1, 0
MOVS 2, #127
ORRS 1, 2       // R1 = 127.5
MOVS 2, #126
LSLS 2, 2, 0
MOVS 3, #64
ORRS 2, 3       // R2 = 0.5
FADD 3, 1, 2
MOVS 4, #133
LSLS 4, 4, 0
MOVS 5, #4
ORRS 4, 5       // R4 = 66
MOVS 5, #133
LSLS 5, 5, 0
MOVS 6, #1
ORRS 5, 6       // R5 = 64.5
FSUB 6, 4, 5
STR 1, [7, #0] 
STR 2, [7, #1] 
STR 3, [7, #2] 
STR 4, [7, #3] 
STR 5, [7, #4] 
STR 6, [7, #5] 
MOVS 1, #132
LSLS 1, 1, 0
MOVS 2, #32
ORRS 1, 2       // R1 = 40
MOVS 0, #15     // R0 = shift amount for sign bit
MOVS 2, #1
LSLS 2, 2, 0
MOVS 0, #7     // R0 = shift amount for exponent
MOVS 3, #60
LSLS 3, 3, 0
ORRS 2, 3       // R2 needs mantissa still
MOVS 3, #96
ORRS 2, 3       // R2 = -1.2e-20
FMUL 3, 1, 2
MOVS 4, #132
LSLS 4, 4, 0    // R4 = 32
MOVS 0, #15     // R0 = shift amount for sign bit
MOVS 5, #1
LSLS 5, 5, 0
MOVS 0, #7     // R0 = shift amount for exponent
MOVS 6, #127
LSLS 6, 6, 0
ORRS 5, 6
MOVS 6, #8
ORRS 5, 6       // R5 = -1.0625
FDIV 6, 4, 5
STR 1, [7, #6] 
STR 2, [7, #7] 
STR 3, [7, #8] 
STR 4, [7, #9] 
STR 5, [7, #10] 
STR 6, [7, #11] 
idle:
NOOP
B idle
  

