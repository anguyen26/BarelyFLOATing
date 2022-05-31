import sys

f1 = open("sqrt_result_dec.txt", 'r')
f2 = open("expected_sqrt.txt", 'r')
f3 = open("input_x_dec.txt", 'r')

fdiff = open("sqrt_diff.txt", 'w')
fraw = open("sqrt_diff_raw.txt", 'w')

for (line1, line2, line3) in zip(f1, f2, f3):
    diff = float(line1)-float(line2)
    fraw.write(str(diff) + "\n")
    fdiff.write("===============================\n")
    fdiff.write("----sqrt(" + str(line3.split("\n")[0]) + ")----\n")
    fdiff.write("expected: " + str(line2))
    fdiff.write("calculated: " + str(line1))
    fdiff.write("ERROR = " + str(diff) + "\n")

f1.close()
f2.close()
f3.close()
fdiff.close()
fraw.close()
