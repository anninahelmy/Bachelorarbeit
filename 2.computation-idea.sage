#product computation
v = [var('v_%d' %(i)) for i in range(5)]
n = len(v)
l = floor(log(n,2)) + 1
a = [var('a_%d' %(i) + '%d' %(j)) for i in range(n) for j in (1..l)]
all = (n*l) #the amount of variables given

for i in range(l,all+l,l):
        for h in range(l):
            for j in range(l,all):
                pr = prod(a[k] for k in range(i-l, i-l+h))
                eq = a[j] == a[j-l]+ pr
                    
                print(eq)
