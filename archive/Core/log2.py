from math import log

f = open("expected_log.txt", 'w')
n = 128
base = 2
x = 128
y = 0.0
x = 1.0 / x
f.write("0.0\n")
for i in range (1,n):
	f.write(str(((x-1)**i)/i) + '\n')
	if(i % 2) == 0:
		#print(str(i) + ": y += " + str(((x-1)**i)/i))
		y += ((x-1)**i)/i
	else:
		#print(str(i) + ": y -= " + str(((x-1)**i)/i))
		y -= ((x-1)**i)/i

y = y / log(base)
