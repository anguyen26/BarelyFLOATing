// x = 0
// y = log2(x) = 1
// iterations = 2 (default 128)
// i = 3
// j = 4
// calc eg = 5
// calc eg = 6
// ln2 = 7

setup:
	//load x (fp) = 128
	MOVS 0, #134
	MOVS 6, #7
	LSLS 0, 0, 6

	//take inverse of x
	//approx only valid for 0<x<2
	//ln(1/x)=-ln(x) so we just * by -1
	MOVS 5, #127 //fp ep of 1
	MOVS 6, #7
	LSLS 5, 5, 6
	FDIV 0, 5, 0 //x = 1/x
	FSUB 0, 0, 5 //x -- (x-1 only used)

	//load iteration const = 128
	MOVS 2, #134
	MOVS 6, #7
	LSLS 2, 2, 6

	//load i=1
	MOVS 3, #127
	MOVS 6, #7
	LSLS 3, 3, 6

calc:
	//for i in ange (1,iterations)
for1:
	FCMP 3, 2
	BGE endfor1 //if i>=iterations done

	//else (i<iterations)
	MOVS 5, #128 //set 5 = fp(2)
	MOVS 6, #7
	LSLS 5, 5, 6
	
	MOVS 5, #127 //init 5 = 1fp
	MOVS 7, #7
	LSLS 5, 5, 7
	MOV 7, 5

	//calculate the next term in the series
	//store in 5 (initially 1 fp)
	MOVS 4, #0 //j = 0
	//for(j=0, j<i, j++)
	for2:
		FCMP 4, 3 //j-i?
		BGE endfor2 //j>=i
		FMUL 5, 5, 0 //R5 = 5 * (x-1)
		FADD 4, 4, 7 //j++
		B for2
	endfor2:
	
	FDIV 5, 5, 3 //result = esult / i
	
	MOVS 7, #1
	LSLS 5, 5, 7 //result = abs(result)
	LSRS 5, 5, 7

	FADD 1, 1, 5 //y=y+result

	MOVS 5, #127 //restore 5 = fp1
	MOVS 6, #7
	LSLS 5, 5, 6
	FADD 3, 3, 5 //i++
	B for1
endfor1:

	//load ln2=0.69140625
	MOVS 7, #126
	MOVS 6, #7
	LSLS 7, 7, 6
	MOVS 6, #49
	ADDS 7, 7, 6
	//FDIV 1, 1, 7 //y = y / ln2

end:
	B end

