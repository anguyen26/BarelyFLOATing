import sys
test = sys.argv[1]

bin_file = 'tests/rand_benchmarks/' + test + ".arm"
fBin = open(bin_file, 'r')
fVer = open('Core/random.sv', 'w')
	
fVer.write('module random (output logic [63:0][15:0] MEM);\n\n')
i = 0
for line in fBin:
	words = []
	# put words in a list
	for word in line.split():
		words.append(word)

	# write instruction code
	fVer.write('	assign MEM[' + str(i) + '] = 16\'b' + words[0] + ';\n')

	i = i + 1
fVer.write('\nendmodule')
fVer.close()
fBin.close()

