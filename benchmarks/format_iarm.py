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
        # f.write(value[:len(value)-1] + '\n')
        regDict.update({regNum:value})
    i = i+2

for i in range(16):
    if i in regDict:
        f.write(str(i) + " = " + regDict.get(i) + "\n")
    else:
        f.write(str(i) + " = x\n")
    
f.close()


