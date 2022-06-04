# converts binary output from FPU to decimal to compare with expected results
import convert
import sys
output = sys.argv[1]

fbin = open(output, 'r')
fdec = open("converted.txt", "w")
for line in fbin:
    num = convert.bfloat_to_dec(line)
    fdec.write(str(num))
    fdec.write('\n')

fbin.close()
fdec.close()


