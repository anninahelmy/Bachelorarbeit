#create variables of vector in GF(2)
P1 = PolynomialRing(GF(2), 'v', 5); P1
P1.inject_variables()


n = 5 #length of vector v, set this manually

l = floor(log(n,2)) + 1

#create variables a_ij in GF(2)
P2 = PolynomialRing(GF(2), 5,3, var_array=('a')); P2
P2.inject_variables()

#the amount of variables a_ij given
all = (n*l)

#create a list of all a_ij, with a_0 = (a_00,...a_0l) = (0,...0)
A = []
for z in range(l):
    for j in range(all):
        A.append(a[j])
        A[z]=0
        
#create list of product - step by step
L = []
for i in range(l,all+l,l):
    for h in range(l):
        L.append(prod(A[k] for k in range(i-l, i-l+h)))
#create list of vector à la (v1, v1, v1, v2, v2, v2, ...) <- here l would be 3
V = []
for m in range(n):
    for n in range(l):
        V.append(v[m])
        
#create equations
for j in range(l,all):
    for n in range(l):
        eq = A[j] == A[j-l]+ L[j-l]*V[j-l]
    print(eq)
