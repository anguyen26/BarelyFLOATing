import iarm.arm
interp = iarm.arm.Arm()

# Link register (stores the link register of the current instruction + 1)

# Note this format doesn't work for branch because branch needs labels 
# to be loaded, but this is nice if you want to do non-branch instrs and 
# print each instr and the result after each instr
instrs = [
    " MOVS R4, #129",    
    " MOV R2, R4",        
    " ADDS R5, R4, R4",   
    " ADDS R7, R2, #5",   
    " ADD SP, SP, #92",    
    " SUBS R0, R5, R6",    
    " SUBS R5, R3, #5",    
    " SUB SP, SP, #68",    
    " ANDS R2, R5",
    " EORS R1, R5",
    " ORRS R7, R0",
    " MVNS R4, R2",
    " MOVS R0, #3",
    " LSLS R4, R0",
    " LSRS R1, R0",
    " ASRS R4, R0",
"    MOVS R0, #0",
"    STR R7, [R0, #24]",
"    LDR R0, [R0, #24]",
"    CMP R4, R7",
        ]
for i in range(len(instrs)):
    print(instrs[i])
    interp.evaluate(instrs[i])
    interp.run()
    print(interp.register)

