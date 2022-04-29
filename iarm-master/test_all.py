# This tests each instruction 1 time. 

import iarm.arm
interp = iarm.arm.Arm()

interp.evaluate("""
    MOVS R4, #129    
    MOV R2, R4      
    ADDS R5, R4, R4  
    ADDS R7, R2, #5 
    ADD SP, SP, #92  
    SUBS R0, R5, R6  
    SUBS R5, R3, #5  
    SUB SP, SP, #68  
    ANDS R2, R5      
    EORS R1, R5      
    ORRS R7, R0      
    MVNS R4, R2      
    MOVS R0, #3
    LSLS R4, R0      
    LSRS R1, R0
    ASRS R4, R0
    RORS R7, R0
    MOVS R0, #0
    STR R7, [R0, #24]
    LDR R0, [R0, #24]
    CMP R4, R7       
    BNE 3
    MOVS R1, #1
    MOVS R2, #2
3 MOVS R3, #3
    B 2
    MOVS R4, #4
2 MOVS R5, #5
    BL 4
    MOVS R6, #6
    B 5
    MOVS R7, #7
4 MOVS R1, #8
    BX R14
    MOVS R2, #9
5 MOVS R3, #10
    MOVS R4, #11     
""")

interp.run()
print(interp.register)

