

# This file was *autogenerated* from the file /Users/annina/Bachelorarbeit/Bachelorarbeit/2.computation-idea.sage
from sage.all_cmdline import *   # import sage library

_sage_const_5 = Integer(5); _sage_const_2 = Integer(2); _sage_const_1 = Integer(1)#product computation
v = [var('v_%d' %(i)) for i in range(_sage_const_5 )]
n = len(v)
l = floor(log(n,_sage_const_2 )) + _sage_const_1 
a = [var('a_%d' %(i) + '%d' %(j)) for i in range(n) for j in (ellipsis_iter(_sage_const_1 ,Ellipsis,l))]
all = (n*l) #the amount of variables given

for i in range(l,all+l,l):
        for h in range(l):
            for j in range(l,all):
                pr = prod(a[k] for k in range(i-l, i-l+h))
                eq = a[j] == a[j-l]+ pr
                    
                print(eq)

