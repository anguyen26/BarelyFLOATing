f1 = open('output.txt', 'r')
f2 = open('fp_output_dec.txt', 'r')

i=0
matched = True

for line1 in f1:
    i+=1
    for line2 in f2:
        tokens = line2.split()
        # ignore underflow and overflow results
        if (line2[0] != 'U') & (line2[0] != 'O'):
            expected = format(float(line1), '.1E')
            # ignore results that are out of range
            if (float(expected) < 1e+38) & (float(expected) > 1e-38):
                # for inexact results, round coefficient to the tenths place
                if (line2[0] == 'I'):
                    actual = tokens[1]
                    actual = format(float(actual), '.1E')
                    if (float(expected) > 0):
                        roundedExpected = float(expected[0:3])
                    else:
                        roundedExpected = float(expected[0:4])
                    if (float(actual) > 0):
                        roundedActual = float(actual[0:3])
                    else:
                        roundedActual = float(actual[0:4])
                    # if the result is less than 10, give more slack because
                    # shifted bits have more impact for smaller numbers
                    if (abs(float(roundedExpected)) < 10):
                        if (abs(roundedActual) - abs(roundedExpected) > 10):
                            matched = False
                            print("Line #"+str(i)+":")
                            print("Expected: "+str(roundedExpected))
                            print("Actual: "+str(roundedActual))
                    else: 
                        if (roundedActual - roundedExpected > 0.5):
                            matched = False
                            print("Line #"+str(i)+":")
                            print("Expected: "+str(roundedExpected))
                            print("Actual: "+str(roundedActual))
                # if results are exact..
                else:
                    if (line1 != line2):
                        matched = False
                        print("Line #"+str(i)+":")
                        print("Expected: "+line1[:len(line1)-1])
                        print("Actual: "+line2[:len(line2)-1])
        break
if matched:
    print("Outputs match!")
f1.close()
f2.close()
