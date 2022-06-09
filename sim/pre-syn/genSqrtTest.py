# converts randomly generated x (for sqrt) to fp
import convert
import math
import random

fdec = open("sqrt_input.txt", 'a')

# generate random x & record
num = random.uniform(0, 1000)
fdec.write(str(num) + "\n")
num = convert.dec_to_bfloat(num)
fdec.close()

# edit datamem.sv
with open("../../src/verilog/datamem.sv", "r") as file:
    data = file.readlines()

data[41] = '\t\t\tmem[0] <= 16\'b' + str(num) + ';\n'

with open("../../src/verilog/datamem.sv", "w") as file:
    file.writelines(data)
