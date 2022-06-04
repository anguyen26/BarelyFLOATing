import sys

expected = sys.argv[1]
actual = sys.argv[2]
f1 = open(actual, 'r')
f2 = open(expected, 'r')

fdiff = open("log_diff.txt", 'w')

for (line1, line2) in zip(f1, f2):
    diff = float(line1)-float(line2)
    fdiff.write(str(diff))
    fdiff.write('\n')

f1.close()
f2.close()
fdiff.close()
