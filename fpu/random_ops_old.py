import random
import decimal

NUM_OPS = 50
ops = ['+','-','*','/']
for i in range(NUM_OPS):
    x_exp = random.randint(-37,37)
    x = decimal.Decimal('%s%d.%de%d' \
        % (random.choice(['-','']), random.randint(0,9),
            random.randint(0,999), x_exp))
    y = decimal.Decimal('%s%d.%de%d' \
        % (random.choice(['-','']), random.randint(0,9),
            random.randint(0,99999), 
            random.randint(max(x_exp-8,-38),min(38,x_exp+8))))
            #x_exp))
    op = random.choice(ops)
    print(str(x)+' '+op+' '+str(y))
