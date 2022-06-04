 MOVS 0, #134
 MOVS 6, #7
 LSLS 0, 0, 6 // R0 = 128
 MOVS 1, #127
 MOVS 6, #7
 LSLS 1, 1, 6
 MOVS 4, #0
 MOVS 5, #1
 MOVS 6, #8
 LSLS 5, 5, 6
 MOVS 6, #127
 ADDS 5, 5, 6
 MOVS 6, #7
 LSLS 5, 5, 6
 MOVS 2, #124
 MOVS 6, #7
 LSLS 2, 2, 6
 MOVS 7, #1
 MOVS 6, #14
 LSLS 7, 7, 6
 FDIV 3, 0, 1
 FSUB 3, 3, 1
 FCMP 3, 4
 BGE #2
 FMUL 3, 3, 5
 FCMP 3, 2
 BLE #5
 FDIV 6, 0, 1
 FADD 6, 1, 6
 FDIV 1, 6, 7
 B #-10
 MOVS 0, #0 // store result in dataMem[0]
 STR 1, [0, #0]
 B #0
