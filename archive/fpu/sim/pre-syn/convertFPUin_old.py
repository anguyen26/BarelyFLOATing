# converts binary output from FPU to decimal to compare with expected results
import convert
import sys
output = sys.argv[1]

fdec = open(output, 'r')
fbin = open("bin_input.txt", "w")
for line in fdec:
    tokens = line.split()
    print(tokens)
    opA = float(tokens[0])
    op = tokens[1]
    opB = float(tokens[2])
    opA = convert.dec_to_bfloat(opA)
    opB = convert.dec_to_bfloat(opB)
    if (op == '+'):
        operand = '00'
    elif (op == '-'):
        operand = '01'
    elif (op == '*'):
        operand = '10'
    else:
        operand = '11'
    print(operand+'_'+opA+'_'+opB)
    fbin.write(operand+'_'+opA+'_'+opB)
    fbin.write('\n')
fbin.write(operand+'_1111111111111111_'+opB)

fbin.close()
fdec.close()


