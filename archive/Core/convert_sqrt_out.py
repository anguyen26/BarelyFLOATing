# converts sqrt bin to dec
import convert

fbin = open("sqrt_result.txt", 'r')
fdec = open("sqrt_result_dec.txt", 'w')

for line in fbin:
	num = convert.bfloat_to_dec(line)
	fdec.write(str(num) + "\n")

fdec.close()
fbin.close()
