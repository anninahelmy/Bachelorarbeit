

# This file was *autogenerated* from the file /Users/annina/Bachelorarbeit/Bachelorarbeit/weightcomp.sage
from sage.all_cmdline import *   # import sage library

_sage_const_1 = Integer(1); _sage_const_0 = Integer(0)
a = vector([_sage_const_1 ,_sage_const_0 ,_sage_const_1 ,_sage_const_0 , _sage_const_1 , _sage_const_1 ])
length = len(a)
binary_counter = zero_vector(length)
counter = _sage_const_0 
for i in range(length):
    if (a[i] == _sage_const_1 ):
        counter = counter + _sage_const_1 
        binary = Integer(counter).bits()
        binary_counter[i] = counter
        counter
    else:
        counter = counter
        binary = Integer(counter).bits()
        binary_counter[i] = counter
        
    print(Integer(binary_counter[i]).bits())
    

