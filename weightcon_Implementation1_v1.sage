#weight computation

#create variables
P1 = PolynomialRing(GF(2), 'v', 4); P1
P1.inject_variables()
P2 = PolynomialRing(P1, 5,3, var_array=('a')); P2
P2.inject_variables()


#length of vector v, set this manually
n = 4

l = floor(log(n,2)) + 1
#.gens(): Returns a tuple whose entries are the generators for this object, in order.
a = P2.gens()
v = P1.gens()
all = (n*l)

#create list of product - step by step
L = []
for i in range(l,all+l,l):
    for h in range(l):
        L.append(prod(a[k] for k in range(i-l, i-l+h)))

#create list of vector v = (v1, v1, v1, v2, v2, v2, ...)
V = []
for m in range(n):
    for n in range(l):
        V.append(P1.gen(m))
       
    
# create equations
EQ = []
for j in range(l,all):
    EQ.append(a[j-l] +V[j-l]*L[j-l] + a[j])
print(EQ)


P3 = PolynomialRing(P2, 't', l); P3
P3.inject_variables()
T = vector(P3.gen(i) for i in range(l))
f = []
z = []

for j in range(all-2*l,all-l):
    z.append(EQ[j])
print(z)
#create f_j
for j in range(l):
    f.append(prod((z[h] + T[h] + 1) for h in range (j+1,l)) * (a[j] + T[j]))
print(f)

##create polynomial F
F = sum(f[j] * (T[j] + 1) for j in range(0,l) )
print("\n Polynomial F. F is 0 iff weight of a is smaller than t, 1 otherwise: \n ")
print(F)
