a = vector([1,0,1,0, 1, 1])
length = len(a)
binary_counter = zero_vector(length)
counter = 0
for i in range(length):
    if (a[i] == 1):
        counter = counter + 1
        binary = Integer(counter).bits()
        binary_counter[i] = counter
        counter
    else:
        counter = counter
        binary = Integer(counter).bits()
        binary_counter[i] = counter
        
    print(Integer(binary_counter[i]).bits())
    
