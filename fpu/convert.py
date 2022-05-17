import math

def bfloat_to_dec(bits):
    sign = bits[0]
    # print(sign)
    exponent = bits[1:9]
    # print(exponent)
    mantissa = bits[9:]
    # print(mantissa)
    sign_dec = (-1)**int(sign)
    # print(sign_dec)
    exponent_dec = int(exponent, 2)
    exponent_dec = 2**(exponent_dec-127)
    # print(exponent_dec)
    mantissa_dec = int(mantissa, 2)
    mantissa_dec = 1 + (mantissa_dec * 2**-7)
    # print(mantissa_dec)
    dec = sign_dec * exponent_dec * mantissa_dec
    return dec

test1 = bfloat_to_dec('0100001000000000')
print("test1="+str(test1))
test2 = bfloat_to_dec('1011111110001000')
print("test2="+str(test2))
#test3 = bfloat_to_dec('0000000011100000')
#print("test3="+str(test3))
#test1 = bfloat_to_dec('0111111101111111')
#print(test1)
#test2 = bfloat_to_dec('0011111100000111')
#print(test2)

def dec_to_bfloat(num):
    if (num < 0):
        sign = 1
    else:
        sign = 0
    exponent = math.log2(num)
    exponent = math.floor(exponent)
    mantissa = num / (2**exponent)
    mantissa = mantissa - 1

    # format exponent
    exponent = exponent + 127
    exponent = format(exponent, '08b')
    print(exponent)

    # format mantissa
    mantissa = mantissa * (2**7)
    mantissa = format(int(mantissa), '07b')
    print(mantissa)

    binary = str(sign) + exponent + mantissa
    return binary

test1 = dec_to_bfloat(30.12)
print("30.12="+str(test1))
test2 = dec_to_bfloat(1)
print("1="+str(test2))
#test3 = dec_to_bfloat(0)
#print("0="+str(test3))
