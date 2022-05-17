import convert
import sys
output = sys.argv[1]

fbin = open(output, 'r')
fdec = open("fp_output_dec.txt", "w")
for line in fbin:
    tokens = line.split()
    print(tokens)
    num = convert.bfloat_to_dec(tokens[0])
    fdec.write(str(num))
    if (tokens[1] == '1'):
        fdec.write('\tunderflow')
    if (tokens[2] == '1'):
        fdec.write('\toverflow')
    if (tokens[3] == '1'):
        fdec.write('\tinexact')
    fdec.write('\n')

fbin.close()
fdec.close()


