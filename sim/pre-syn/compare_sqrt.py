import math

finput = open("sqrt_input.txt", 'r')
foutput = open("converted.txt", 'r')
fdiff = open("sqrt_diff.txt", 'w')
fraw = open("sqrt_diff_raw.txt", 'w')
error = []

for (lineIn, lineOut) in zip(finput, foutput):
    expected = math.sqrt(float(lineIn))
    diff = expected - float(lineOut)
    error.append(abs(diff))
    fraw.write(str(diff) + "\n")
    fdiff.write("===============================\n")
    fdiff.write("----sqrt(" + str(lineIn.split("\n")[0]) + ")----\n")
    fdiff.write("expected: " + str(expected) + "\n")
    fdiff.write("calculated: " + str(lineOut))
    fdiff.write("error = " + str(diff) + "\n")
    
max_error = max(error)
fdiff.write("===============================\n")
fdiff.write("===============================\n")
# fdiff.write("MAX ERROR = " + str(max_error) + "\n")
fdiff.write("Square root computations completed within accuracy of +/-" + str(max_error)+'\n') 
# print("View sqrt_diff.txt for details") 
finput.close()
foutput.close()
fdiff.close()
fraw.close()
