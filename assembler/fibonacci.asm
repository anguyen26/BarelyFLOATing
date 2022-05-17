// filename: fibonacci.asm
//
// Description: Assembly program that computes the first 10 fibonacci numbers

// Start at the main function
    B main

// Compute a fibonacci number (F_n), given the previous two (F_{n-1} and F_{n-2})
// That is, F_n = F_{n-1} + F_{n-2}
// Inputs:
//      - Register 0: F_{n-1}
//      - Register 1: F_{n-2}
// Outputs:
//      - Register 2: F_n
fibonacci:
    ADDS 2, 0, 1     // F_n = F_{n-1} + F_{n-2}
    BX 14           // return

// main function
main:
    MOVS 0, #1      // F_1 = 1
    MOVS 1, #1      // F_2 = 1
    // for loop to compute the next 8 fibonacci numbers:
    MOVS 3, #0      // i = 0
    MOVS 4, #7      // i_max = 7
    for_fibonacci:
        CMP 4, 3
        BHI end_for_fibonacci   // If i >= i_max, exit the for loop
        BL fibonacci    // Call the fibonacci function. F_{3+i} will be stored in register 2
        MOV 0, 1        // Move the two most recently computed fibonacci numbers to registers 0 and 1
        MOV 1, 2
        ADDS 3, 3, #1   // i = i + 1
        B for_fibonacci
    end_for_fibonacci:
    MOV 3, 2    // Copy the result to register 3
    end:
        NOOP
        B end
