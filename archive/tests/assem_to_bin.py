import sys
test = sys.argv[1]
instrs = {
        "MOVS":     "00100",
        "MOV":      "010001100", 
        "ADDS":     "0001100", 
        "ADDSI":    "0001110",
        "ADD":      "101100000", 
        "SUBS":     "0001101",
        "SUBSI":    "0001111", 
        "SUB":      "101100001", 
        "CMP":      "0100001010", 
        "ANDS":     "0100000000", 
        "EORS":     "0100000001", 
        "ORRS":     "0100001100", 
        "MVNS":     "0100001111", 
        "LSLS":     "0100000010", 
        "LSRS":     "0100000011", 
        "ASRS":     "0100000100", 
        "STR":      "01100", 
        "LDR":      "01101", 
        "BCOND":    "1101", 
        "B":        "11100", 
        "BL":       "0100010100", 
        "BX":       "010001110", 
        "RORS":     "0100000111"
        }
        
conds = ["EQ", "NE", "CS", "CC", "MI", "PL", "VS", "VC", "HI", "LS", "GE", "LT", "GT", "LE", "AL"]

# fAssem = open("assembly_instr.txt", 'r');
# fBin = open("binary_instr.txt", 'w');
# fAssem = open("each_assembly_instr.txt", 'r');
# fBin = open("each_binary_instr.txt", 'w');
assem_file = 'tests/' + test + ".txt"
bin_file = 'tests/' + test + ".arm"
fAssem = open(assem_file, 'r');
fBin = open(bin_file, 'w');
# fAssem = open('random.txt', 'r');
# fBin = open("testt.arm", 'w');

for line in fAssem:
    words = []
    regs = []
    # put words in a list
    for word in line.split():
        words.append(word)
    # take off label if there is one
    if (line[0] != ' '):
        words = words[1:]
    instr = words[0]
    if (instr != 'NOOP'): 
        for token in words:
            if token != words[0]:
                if token[0] == 'R':
                    regs.append(int(token[1]))
                elif token[0] == '[':
                    regs.append(int(token[2]))
                elif token[len(token)-1] == ']':
                    imm = int(token[1:len(token)-1])
                elif token != 'SP,': # token[0] = #
                    if (token[0] == '#'):
                        imm = int(token[1:])
                    else:
                        imm = int(token)
        print(regs)
        # Handle immediates
        if (len(regs)==2) & ((instr == "ADDS") | (instr == "SUBS")):
            instr = instr + "I"
        # Handle Bcond case
        if (instr[0] == 'B') & (len(instr)==3):
            instr_bin= str(instrs.get('BCOND'))
        else:    
            instr_bin= str(instrs.get(instr))
        print(instr)
        # write instruction code
        fBin.write(instr_bin)
        # write immediate
        if (instr == "ADDSI") | (instr == "SUBSI"):
            print(1)
            fBin.write('_' + format(imm, '03b'))
        elif (instr == "ADD") | (instr == "SUB"):
            print(2)
            fBin.write('_' + format(imm, '07b'))
        elif (instr[0] == "B") & (instr != "BX"):
            print(3)
            if len(instr) == 1:
                fBin.write('_' + format(imm, '011b'))
            elif instr == "BL":
                print("imm="+str(imm))
                fBin.write(format(imm, '06b'))
            else: #BCOND
                condCode = conds.index(instr[1:3])
                fBin.write('_' + format(condCode, '04b'))
                fBin.write('_' + format(imm, '08b'))
        elif (instr == "LDR") | (instr == "STR"):
            print(3.5)
            fBin.write('_' + format(imm, '05b'))
        # write reg #'s
        if instr == "MOV":
            print(4)
            fBin.write('_' + format(regs[1], '04b'))
            fBin.write('_' + format(regs[0], '03b'))
        elif instr == "BX":
            print(5)
            fBin.write(format(regs[0], '04b') + '_000')
        else:
            print(6)
            for i in range(len(regs)-1,-1,-1):
                print(i)
                fBin.write('_' + format(regs[i], '03b'))
            if instr == "MOVS":
                print(7)
                fBin.write('_' + format(imm, '08b'))
    else:
        fBin.write('1011_1111_0000_0000')
    fBin.write('    //' + line)

fBin.write('11100_00000000000     // B stop\n')
 

fAssem.close()
fBin.close()



