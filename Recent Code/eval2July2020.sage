#Implementation 1
H = Matrix([[1,1,0,1,1,0,0], [1,0,1,1,0,1,0], [0,1,1,1,0,0,1]])
s = vector([0,1,1])
numberOfVariables = H.ncols()
P = PolynomialRing(GF(2),numberOfVariables,names="v"); P
P.inject_variables()
v = P.gens()

P2 = PolynomialRing(P, 4,3, var_array=('a')); P2
P2.inject_variables()

n = 3
l = floor(log(n,2)) + 1
all = (n*l)

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


P3 = PolynomialRing(P2, 't', l); P3
P3.inject_variables()
t = vector([0,0,1])
L0 = L0[::-1][:]#least significant bit last(umgedreht!)
f = []

#create f_j
for j in range(l):
    f.append(prod((L0[h] + t[h] + 1) for h in range (j+1,l)) * (L0[j] + t[j]))

#create polynomial F
F = sum(f[j] * (t[j] + 1) for j in range(0,l) )

print('parity check: \n')
print((H*vector(P.gen(i) for i in range(numberOfVariables))-s).list())
print('\n L0: \n')
print(L0)
print('\n F: \n')
print(F)

#Output:
#Defining v0, v1, v2, v3, v4, v5, v6
#Defining a00, a01, a02, a10, a11, a12, a20, a21, a22, a30, a31, a32
#Defining t0, t1
#parity check:
#
#[v0 + v1 + v3 + v4, v0 + v2 + v3 + v5 + 1, v1 + v2 + v3 + v6 + 1]
#
# L0:
#
#((v0 + v1 + v2)*a00 + a01 + v0*v1 + v0*v2 + v1*v2, a00 + v0 + v1 + v2)
#
# F:
#
#(v0 + v1 + v2)*a00^2 + a00*a01 + (v0^2 + v0*v1 + v1^2 + v0*v2 + v1*v2 + v2^2 + v0 + v1 + v2 + 1)*a00 + (v0 + v1 + v2 + 1)*a01 + v0^2*v1 + v0*v1^2 + v0^2*v2 + v0*v1*v2 + v1^2*v2 + v0*v2^2 + v1*v2^2 + v0*v1 + v0*v2 + v1*v2 + v0 + v1 + v2
#

#Implementation 2:
H = Matrix([[1,1,0,1,1,0,0], [1,0,1,1,0,1,0], [0,1,1,1,0,0,1]])
s = vector([0,1,1])
numberOfVariables = H.ncols()
P = PolynomialRing(GF(2),numberOfVariables,names="v"); P
P.inject_variables()
v = P.gens()

#create variables
P2 = PolynomialRing(P, 4,3, var_array=('a')); P2
P2.inject_variables()

n = 3
l = floor(log(n,2)) + 1
all = (n*l)

#.gens(): Returns a tuple whose entries are the generators for this object, in order.
a = P2.gens()

#create list of product - step by step
L = []
for i in range(l,all+l,l):
    for h in range(l):
        L.append(prod(a[k] for k in range(i-l, i-l+h)))

#create list of vector v = (v1, v1, v1, v2, v2, v2, ...)
V = []
for m in range(n):
    for n in range(l):
        V.append(P.gen(m))

# create equations
EQ = []
for j in range(l,all+l):
    EQ.append(a[j-l] +V[j-l]*L[j-l] + a[j])

t = vector([0,0,0,1])
f = []

for j in range(all,all+l):
    print(a[j])

#create f_j
for j in range(l):
    f.append(prod((a[all+h] + t[h] + 1) for h in range (j+1,l)) * (a[all+j] + t[j]))

##create polynomial F
F = sum(f[j] * (t[j] + 1) for j in range(0,l) )


print('parity check: \n')
print((H*vector(P.gen(i) for i in range(numberOfVariables))-s).list())
print('\n L0: \n')
print(EQ)
print('\n F: \n')
print(F)

#Output:
#Defining v0, v1, v2, v3, v4, v5, v6
#Defining a00, a01, a02, a10, a11, a12, a20, a21, a22, a30, a31, a32
#a20
#a21
#parity check:
#
#[v0 + v1 + v3 + v4, v0 + v2 + v3 + v5 + 1, v1 + v2 + v3 + v6 + 1]
#
# L0:
#
#[a00 + a02 + v0, v0*a00 + a01 + a10, a02 + a11 + v1, v1*a02 + a10 + a12, a11 + a20 + v2, v2*a11 + a12 + a21]
#
# F:
#
#a20*a21 + a20 + a21








