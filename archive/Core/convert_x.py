# converts randomly generated x (for sqrt) to fp
import convert
import math
import random

fbin = open("input_x_fp.txt", 'w')
fdec = open("input_x_dec.txt", 'a')

num = random.uniform(0, 1000)
fdec.write(str(num) + "\n")
num = convert.dec_to_bfloat(num)
fbin.write(str(num) + "\n")

fbin.close()
fdec.close()
