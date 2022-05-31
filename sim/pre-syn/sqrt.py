import math

fin = open("input_x_dec.txt", 'r')
fout = open("expected_sqrt.txt", 'w')
for line in fin:
	fout.write(str(math.sqrt(float(line))) + "\n")

fin.close()
fout.close()
