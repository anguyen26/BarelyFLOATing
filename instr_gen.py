# This generates NUM_INSTR random instructions in assembly.
# Some simplifications have been made to make it easier to write this module:
# - Branches can only branch forward to prevent infinite loops
# - Every BL instruction is coupled with a BX instruction
# - BX is only used if BL is used first
# - If one branch instruction is written, another branch instruction
# can't be written until the label that the branch jumps to has been 
# written. If the branch is a BL instruction, a new branch instruction
# isn't written until after BX.
# - Rn for LDR and STR will always be 0. 

import random

NUM_INSTR = 64
instrs = [
        "MOVS",
        "MOV",      
        "ADDS",     
        "ADDSI",    
        "ADD",      
        "SUBS",     
        "SUBSI",    
        "SUB",      
        "CMP",      
        "ANDS",     
        "EORS",     
        "ORRS",     
        "MVNS",     
        "LSLS",     
        "LSRS",     
        "ASRS",     
        "STR",     
        "LDR",      
        "RORS",     
        "B"        
        ]

conds = ["EQ", "NE", "CS", "CC", "MI", "PL", "VS", "VC", "HI", "LS", "GE", "LT", "GT", "LE", "AL"]

print(instrs[:len(instrs)-1])

f = open("assembly_instr.txt", 'w');

instrLeft = NUM_INSTR
count = False
count4BL = False
sinceBranch = 0
sinceLabel = 0
instrWasBL = False
writeBDone = True
randNum = 0
randNumBL = 0

for i in range(NUM_INSTR):
    instrLeft-=1
    if (writeBDone):
        instr = random.choice(instrs)
    else:
        instr = random.choice(instrs[:len(instrs)-1])
    toPrint = ' '
    
    if count4BL:
        sinceLabel+=1
        if (sinceLabel == randNumBL):
            instr = "BX"
            writeBDone = True
            count4BL = False

    if count:
        sinceBranch+=1
        if (sinceBranch == randNum):
            toPrint=str(randNum) + toPrint
            if (instrWasBL):
                instrWasBL = False 
                sinceLabel = 0
                countForBL = True
            else:
                writeBDone = True
            count = False

    if instr == "B":
        writeBDone = False
        randNum = random.randint(1,instrLeft)
        sinceBranch = 0
        count = True


    # MOVS needs low registers
    if instr == "MOVS":
        rd = 'R'+str(random.randint(0,7))
        im8 = str(random.randint(0,2**8-1))
        toPrint += instr + ' ' + rd + ', #' + im8 + '\n'
    elif instr == "MOV":
        rd = 'R'+str(random.randint(0,12))
        rm = 'R'+str(random.randint(0,12))
        toPrint += instr + ' ' + rd + ', ' + rm + '\n'
    elif instr == "ADDSI":
        rd = 'R'+str(random.randint(0,7))
        rn = 'R'+str(random.randint(0,7))
        im3 = str(random.randint(0,2**3-1))
        toPrint += instr[:len(instr)-1] + ' '
        toPrint += rd + ', ' + rn + ', #' + im3 + '\n'
    elif instr == "ADDS":
        rd = 'R'+str(random.randint(0,7))
        rn = 'R'+str(random.randint(0,7))
        rm = 'R'+str(random.randint(0,7))
        toPrint += instr + ' ' + rd + ', ' + rn + ', ' + rm + '\n'
    elif instr == "ADD":
        im7 = str(random.randint(0,31)*4)
        toPrint += instr + ' SP, SP, '
        toPrint += '#' + im7 + '\n'
    elif instr == "SUBSI":
        rd = 'R'+str(random.randint(0,7))
        rn = 'R'+str(random.randint(0,7))
        im3 = str(random.randint(0,2**3-1))
        toPrint += instr[:len(instr)-1] + ' '
        toPrint += rd + ', ' + rn + ', #' + im3 + '\n'
    elif instr == "SUBS":
        rd = 'R'+str(random.randint(0,7))
        rn = 'R'+str(random.randint(0,7))
        rm = 'R'+str(random.randint(0,7))
        toPrint += instr + ' ' + rd + ', ' + rn + ', ' + rm + '\n'
    elif instr == "SUB":
        im7 = str(random.randint(0,31)*4)
        toPrint += instr + ' SP, SP, '
        toPrint += '#' + im7 + '\n'
    elif instr == "STR" or  instr == "LDR":
        toPrint += 'MOVS R0, #0\n' # helps constrain memaddr to be aligned
        rd = 'R'+str(random.randint(0,7))
        im5 = str(random.randint(0,7)*4)
        toPrint += ' ' + instr + ' ' + rd + ', ' + '[R0, #' + im5 + ']' + '\n'
    elif instr == "B":
        instr = random.choice(["B", "BL", "BCOND"])
        print(instr)
        if instr == "BCOND":
            rn = 'R'+str(random.randint(0,7))
            rm = 'R'+str(random.randint(0,7))
            toPrint += 'CMP ' + rn + ', ' + rm + '\n'
            cond = random.choice(conds)
            toPrint += ' B' + cond + ' '
        else:
            toPrint += instr + ' '
        if instr == "BL":
            randNumBL = random.randint(1,instrLeft-randNum)
            instrWasBL = True
        toPrint += str(randNum) + '\n'
    elif instr == "BX":
        toPrint += instr + ' ' + 'R14\n'
    else : #CMP, ANDS, EORS, ORRS, MVNS, LSLS, LSRS, ASRS, RORS
        rd = 'R'+str(random.randint(0,7))
        rm = 'R'+str(random.randint(0,7))
        toPrint += instr + ' ' + rd + ', ' + rm + '\n'
    f.write(toPrint)

f.close()

