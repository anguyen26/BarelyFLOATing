import sys
iarm_output = sys.stdin.read()
print("iarm output = " + iarm_output)
iarm_output = iarm_output[1:len(iarm_output)-1]
f = open("iarm_output.txt", "w")
f.write("Register content:\n")
words = []
words = iarm_output.split()
regDict = {}
i = 0
while (i < len(words)):
    word = words[i]
    if (word[1] == 'R'):
        regNum = int(word[2:len(word)-2])
        # f.write(word[2:len(word)-2] + " = ")
        value = words[i+1]
        value = value[:len(value)-1]
        if (int(value) > 65536):
            binValue = bin(int(value))
            binValue = binValue[len(binValue)-16:]
            value = str(int(binValue,2))
        # f.write(value[:len(value)-1] + '\n')
        regDict.update({regNum:value})
    i = i+2

for i in range(15):
    if i in regDict:
        f.write(str(i) + " = " + regDict.get(i) + "\n")
    else:
        f.write(str(i) + " = 0\n")
# subtract 1 from PC register bc sv version has PC's indexed
f.write("15 = " + str(int(str(regDict.get(15)))-1) + "\n")
    
f.close()


