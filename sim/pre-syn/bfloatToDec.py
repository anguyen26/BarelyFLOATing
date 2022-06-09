# takes file of floating point and converts to decimal
import convert
import sys
binarytxt = sys.argv[1]
dectxt = sys.argv[2]

fbin = open(binarytxt, 'r')
fdec = open(dectxt, "a")
for line in fbin:
    num = convert.bfloat_to_dec(line)
    print(num)
    fdec.write(str(num))
    fdec.write('\n')

fbin.close()
fdec.close()


