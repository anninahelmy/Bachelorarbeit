H = Matrix([[1,1,0,1,1,0,0], [1,0,1,1,0,1,0], [0,1,1,1,0,0,1]])
s = vector([0,1,1])

n = H.ncols()
l = floor(log(n,2)) + 1
all = (n*l)

P0 = PolynomialRing(GF(2),n,names="v"); P0
P0.inject_variables()
v = P0.gens()

P1 = PolynomialRing(P0, n+1,l, var_array=('a')); P1
P1.inject_variables()

P2 = PolynomialRing(P1, l, names = "b"); P2
P2.inject_variables()
b = P2.gens()

L0 = vector(P2.gen(i) for i in range(l))
L1 = vector(P2.gen(i) for i in range(l))


#product
for i in range(n):
    for j in range(l):
        if j == 0:
            L0[j] = L0[0]
        else:
            L0[j] = L0[j]*L0[j-1]
    #equations
    for j in range(l):
        if j == 0:
            L1[j] = L0[j] + v[i]
        else:
            L1[j] = L0[j]/L0[j-1] + L0[j-1]*v[i]
    L0 = L1[:]

for j in range(l):
    L0[j] = L0[j] + b[j]


P3 = PolynomialRing(P2, 't', l); P3
P3.inject_variables()
T = P3.gens()
f = []

#create f_j
for j in range(l):
    f.append(prod((L0[h] + T[h] + 1) for h in range (j+1,l)) * (L0[j] + T[j]))

#create polynomial F
F = sum(f[j] * (T[j] + 1) for j in range(0,l) )

print('parity check: \n')
print((H*vector(P0.gen(i) for i in range(n))-s).list())
print('\n L0: \n')
print(L0)
print('\n f_j: \n')
print(f)
print('\n F: \n')
print(F)

#-----------------------------------------------
H = Matrix([[1,1,0,1,1,0,0], [1,0,1,1,0,1,0], [0,1,1,1,0,0,1]])
s = vector([0,1,1])
numberOfVariables = H.ncols()
P0 = PolynomialRing(GF(2),numberOfVariables,names="v"); P0
P0.inject_variables()
v = P0.gens()

n = numberOfVariables
l = floor(log(n,2)) + 1
all = (numberOfVariables*l)

#create variables
P1 = PolynomialRing(P0, n+1,l, var_array=('a')); P1
P1.inject_variables()


#.gens(): Returns a tuple whose entries are the generators for this object, in order.
a = P1.gens()

#create list of product - step by step
L = []
for i in range(l,all+l,l):
    for h in range(l):
        L.append(prod(a[k] for k in range(i-l, i-l+h)))
print('L: \n')
print(L)

#create list of vector v = (v1, v1, v1, v2, v2, v2, ...)
V = []
for m in range(n):
    for n in range(l):
        V.append(P0.gen(m))
print(V)

# create equations
EQ = []
for j in range(l,all+l):
    EQ.append(a[j-l] +V[j-l]*L[j-l] + a[j])
print(EQ)

P3 = PolynomialRing(P1, 't', l); P3
P3.inject_variables()
T = P3.gens()
f = []
#create f_j
for j in range(l):
    f.append(prod((a[all+h] + T[h] + 1) for h in range (j+1,l)) * (a[all+j] + T[j]))

##create polynomial F
F = sum(f[j] * (T[j] + 1) for j in range(0,l) )


print('parity check: \n')
print((H*vector(P0.gen(i) for i in range(numberOfVariables))-s).list())
print('equations: \n')
print(EQ)
print('\n f_j: \n')
print(f)
print('\n F: \n')
print(F)

