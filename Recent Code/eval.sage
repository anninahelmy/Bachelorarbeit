#1.Juli 2020

#Code Eval Instance:
#n=4
#H = [(1,0,1,0), (1,1,0,1)]
#s = (0,1)
#t = 1


#Implementation 2
H = Matrix([[1,0,1,0],[1,1,0,1]])
s = vector([0,1])
numberOfVariables = H.ncols()
P = PolynomialRing(GF(2),numberOfVariables,names="v"); P
P.inject_variables()
v = P.gens()

P2 = PolynomialRing(P1, 5,3, var_array=('a')); P2
P2.inject_variables()

n = 4
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
t = vector([0,0,0,1])
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

#OUTPUT
#Defining v0, v1, v2, v3
#Defining a00, a01, a02, a10, a11, a12, a20, a21, a22, a30, a31, a32, a40, a41, a42
#Defining t0, t1, t2
#parity check:
#
#[v0 + v2, v0 + v1 + v3 + 1]
#
# L0:
#
#((v0*v1 + v0*v2 + v1*v2 + v0*v3 + v1*v3 + v2*v3)*a00^2 + (v0 + v1 + v2 + v3)*a00*a01 + (v0^2*v1 + v0^2*v2 + v0*v1*v2 + v1^2*v2 + v0^2*v3 + v0*v1*v3 + v1^2*v3 + v0*v2*v3 + v1*v2*v3 + v2^2*v3)*a00 + (v0*v1 + v0*v2 + v1*v2 + v0*v3 + v1*v3 + v2*v3)*a01 + a02 + v0^2*v1*v2 + v0*v1^2*v2 + v0^2*v1*v3 + v0*v1^2*v3 + v0^2*v2*v3 + v0*v1*v2*v3 + v1^2*v2*v3 + v0*v2^2*v3 + v1*v2^2*v3, (v0 + v1 + v2 + v3)*a00 + a01 + v0*v1 + v0*v2 + v1*v2 + v0*v3 + v1*v3 + v2*v3, a00 + v0 + v1 + v2 + v3)
#
# F:
#
#(v0^2*v1 + v0*v1^2 + v0^2*v2 + v0*v1*v2 + v1^2*v2 + v0*v2^2 + v1*v2^2 + v0^2*v3 + v0*v1*v3 + v1^2*v3 + v0*v2*v3 + v1*v2*v3 + v2^2*v3 + v0*v3^2 + v1*v3^2 + v2*v3^2)*a00^4 + (v0^2 + v0*v1 + v1^2 + v0*v2 + v1*v2 + v2^2 + v0*v3 + v1*v3 + v2*v3 + v3^2)*a00^3*a01 + (v0 + v1 + v2 + v3)*a00^2*a01^2 + (v0*v1^3 + v0*v1^2*v2 + v0*v2^3 + v1*v2^3 + v0*v1^2*v3 + v0*v2^2*v3 + v1*v2^2*v3 + v0*v3^3 + v1*v3^3 + v2*v3^3 + v0^2*v1 + v0*v1^2 + v0^2*v2 + v0*v1*v2 + v1^2*v2 + v0*v2^2 + v1*v2^2 + v0^2*v3 + v0*v1*v3 + v1^2*v3 + v0*v2*v3 + v1*v2*v3 + v2^2*v3 + v0*v3^2 + v1*v3^2 + v2*v3^2 + v0*v1 + v0*v2 + v1*v2 + v0*v3 + v1*v3 + v2*v3)*a00^3 + (v0^3 + v0^2*v1 + v1^3 + v0^2*v2 + v1^2*v2 + v2^3 + v0^2*v3 + v1^2*v3 + v2^2*v3 + v3^3 + v0^2 + v0*v1 + v1^2 + v0*v2 + v1*v2 + v2^2 + v0*v3 + v1*v3 + v2*v3 + v3^2 + v0 + v1 + v2 + v3)*a00^2*a01 + (v0^2 + v0*v1 + v1^2 + v0*v2 + v1*v2 + v2^2 + v0*v3 + v1*v3 + v2*v3 + v3^2 + v0 + v1 + v2 + v3)*a00*a01^2 + (v0 + v1 + v2 + v3)*a00^2*a02 + a00*a01*a02 + (v0^4*v1 + v0^4*v2 + v0^2*v1^2*v2 + v0*v1^3*v2 + v1^4*v2 + v0^2*v1*v2^2 + v0*v1*v2^3 + v0^4*v3 + v0^2*v1^2*v3 + v0*v1^3*v3 + v1^4*v3 + v0^2*v1*v2*v3 + v0^2*v2^2*v3 + v1^2*v2^2*v3 + v0*v2^3*v3 + v1*v2^3*v3 + v2^4*v3 + v0^2*v1*v3^2 + v0^2*v2*v3^2 + v0*v1*v2*v3^2 + v1^2*v2*v3^2 + v0*v1*v3^3 + v0*v2*v3^3 + v1*v2*v3^3 + v0^3*v1 + v0^3*v2 + v0^2*v1*v2 + v1^3*v2 + v0*v1*v2^2 + v0^3*v3 + v0^2*v1*v3 + v1^3*v3 + v0^2*v2*v3 + v1^2*v2*v3 + v2^3*v3 + v0*v1*v3^2 + v0*v2*v3^2 + v1*v2*v3^2 + v0*v1^2 + v0*v2^2 + v1*v2^2 + v0*v3^2 + v1*v3^2 + v2*v3^2 + v0*v1 + v0*v2 + v1*v2 + v0*v3 + v1*v3 + v2*v3 + v0 + v1 + v2 + v3)*a00^2 + (v0^3*v1 + v0^3*v2 + v0*v1^2*v2 + v1^3*v2 + v0*v1*v2^2 + v0^3*v3 + v0*v1^2*v3 + v1^3*v3 + v0*v1*v2*v3 + v0*v2^2*v3 + v1*v2^2*v3 + v2^3*v3 + v0*v1*v3^2 + v0*v2*v3^2 + v1*v2*v3^2 + v0^2*v1 + v0^2*v2 + v0*v1*v2 + v1^2*v2 + v0^2*v3 + v0*v1*v3 + v1^2*v3 + v0*v2*v3 + v1*v2*v3 + v2^2*v3 + v0^2 + v0*v1 + v1^2 + v0*v2 + v1*v2 + v2^2 + v0*v3 + v1*v3 + v2*v3 + v3^2 + v0 + v1 + v2 + v3 + 1)*a00*a01 + (v0^2*v1 + v0*v1^2 + v0^2*v2 + v0*v1*v2 + v1^2*v2 + v0*v2^2 + v1*v2^2 + v0^2*v3 + v0*v1*v3 + v1^2*v3 + v0*v2*v3 + v1*v2*v3 + v2^2*v3 + v0*v3^2 + v1*v3^2 + v2*v3^2 + v0*v1 + v0*v2 + v1*v2 + v0*v3 + v1*v3 + v2*v3)*a01^2 + (v0^2 + v0*v1 + v1^2 + v0*v2 + v1*v2 + v2^2 + v0*v3 + v1*v3 + v2*v3 + v3^2 + v0 + v1 + v2 + v3 + 1)*a00*a02 + (v0 + v1 + v2 + v3 + 1)*a01*a02 + (v0^4*v1^2 + v0^3*v1^3 + v0^4*v1*v2 + v0^3*v1^2*v2 + v0^2*v1^3*v2 + v0^4*v2^2 + v0*v1^3*v2^2 + v1^4*v2^2 + v0^3*v2^3 + v0^2*v1*v2^3 + v0*v1^2*v2^3 + v1^3*v2^3 + v0^4*v1*v3 + v0^3*v1^2*v3 + v0^2*v1^3*v3 + v0^4*v2*v3 + v0*v1^3*v2*v3 + v1^4*v2*v3 + v0^3*v2^2*v3 + v0*v1^2*v2^2*v3 + v1^3*v2^2*v3 + v0^2*v2^3*v3 + v0*v1*v2^3*v3 + v1^2*v2^3*v3 + v0^4*v3^2 + v0*v1^3*v3^2 + v1^4*v3^2 + v0^2*v1*v2*v3^2 + v0*v2^3*v3^2 + v1*v2^3*v3^2 + v2^4*v3^2 + v0^3*v3^3 + v0^2*v1*v3^3 + v0*v1^2*v3^3 + v1^3*v3^3 + v0^2*v2*v3^3 + v1^2*v2*v3^3 + v0*v2^2*v3^3 + v1*v2^2*v3^3 + v2^3*v3^3 + v0^3*v1^2 + v0^3*v1*v2 + v0^3*v2^2 + v0^2*v1*v2^2 + v0*v1^2*v2^2 + v1^3*v2^2 + v0^3*v1*v3 + v0^3*v2*v3 + v0*v1^2*v2*v3 + v1^3*v2*v3 + v0*v1*v2^2*v3 + v0^3*v3^2 + v0^2*v1*v3^2 + v0*v1^2*v3^2 + v1^3*v3^2 + v0^2*v2*v3^2 + v1^2*v2*v3^2 + v0*v2^2*v3^2 + v1*v2^2*v3^2 + v2^3*v3^2 + v0^3*v1 + v0^2*v1^2 + v0^3*v2 + v0*v1^2*v2 + v1^3*v2 + v0^2*v2^2 + v0*v1*v2^2 + v1^2*v2^2 + v0^3*v3 + v0*v1^2*v3 + v1^3*v3 + v0*v1*v2*v3 + v0*v2^2*v3 + v1*v2^2*v3 + v2^3*v3 + v0^2*v3^2 + v0*v1*v3^2 + v1^2*v3^2 + v0*v2*v3^2 + v1*v2*v3^2 + v2^2*v3^2 + v0^2*v1 + v0^2*v2 + v0*v1*v2 + v1^2*v2 + v0^2*v3 + v0*v1*v3 + v1^2*v3 + v0*v2*v3 + v1*v2*v3 + v2^2*v3 + v0^2 + v0*v1 + v1^2 + v0*v2 + v1*v2 + v2^2 + v0*v3 + v1*v3 + v2*v3 + v3^2 + v0 + v1 + v2 + v3 + 1)*a00 + (v0^3*v1^2 + v0^2*v1^3 + v0^3*v1*v2 + v0^2*v1^2*v2 + v0*v1^3*v2 + v0^3*v2^2 + v1^3*v2^2 + v0^2*v2^3 + v1^2*v2^3 + v0^3*v1*v3 + v0^2*v1^2*v3 + v0*v1^3*v3 + v0^3*v2*v3 + v1^3*v2*v3 + v0^2*v2^2*v3 + v0*v1*v2^2*v3 + v1^2*v2^2*v3 + v0*v2^3*v3 + v1*v2^3*v3 + v0^3*v3^2 + v1^3*v3^2 + v0*v1*v2*v3^2 + v2^3*v3^2 + v0^2*v3^3 + v1^2*v3^3 + v2^2*v3^3 + v0^2*v1^2 + v0^2*v1*v2 + v0*v1^2*v2 + v0^2*v2^2 + v1^2*v2^2 + v0^2*v1*v3 + v0*v1^2*v3 + v0^2*v2*v3 + v0*v1*v2*v3 + v1^2*v2*v3 + v0*v2^2*v3 + v1*v2^2*v3 + v0^2*v3^2 + v1^2*v3^2 + v2^2*v3^2 + v0^2*v1 + v0*v1^2 + v0^2*v2 + v0*v1*v2 + v1^2*v2 + v0*v2^2 + v1*v2^2 + v0^2*v3 + v0*v1*v3 + v1^2*v3 + v0*v2*v3 + v1*v2*v3 + v2^2*v3 + v0*v3^2 + v1*v3^2 + v2*v3^2 + v0*v1 + v0*v2 + v1*v2 + v0*v3 + v1*v3 + v2*v3 + v0 + v1 + v2 + v3 + 1)*a01 + (v0^2*v1 + v0*v1^2 + v0^2*v2 + v0*v1*v2 + v1^2*v2 + v0*v2^2 + v1*v2^2 + v0^2*v3 + v0*v1*v3 + v1^2*v3 + v0*v2*v3 + v1*v2*v3 + v2^2*v3 + v0*v3^2 + v1*v3^2 + v2*v3^2 + v0*v1 + v0*v2 + v1*v2 + v0*v3 + v1*v3 + v2*v3 + v0 + v1 + v2 + v3 + 1)*a02 + v0^4*v1^2*v2 + v0^2*v1^4*v2 + v0^4*v1*v2^2 + v0*v1^4*v2^2 + v0^3*v1*v2^3 + v0*v1^3*v2^3 + v0^4*v1^2*v3 + v0^2*v1^4*v3 + v0^4*v1*v2*v3 + v0*v1^4*v2*v3 + v0^4*v2^2*v3 + v0^3*v1*v2^2*v3 + v0^2*v1^2*v2^2*v3 + v0*v1^3*v2^2*v3 + v1^4*v2^2*v3 + v0^2*v1*v2^3*v3 + v0*v1^2*v2^3*v3 + v0^2*v2^4*v3 + v1^2*v2^4*v3 + v0^4*v1*v3^2 + v0*v1^4*v3^2 + v0^4*v2*v3^2 + v0^2*v1^2*v2*v3^2 + v1^4*v2*v3^2 + v0*v1*v2^3*v3^2 + v0*v2^4*v3^2 + v1*v2^4*v3^2 + v0^3*v1*v3^3 + v0*v1^3*v3^3 + v0^3*v2*v3^3 + v0^2*v1*v2*v3^3 + v0*v1^2*v2*v3^3 + v1^3*v2*v3^3 + v0*v1*v2^2*v3^3 + v0*v2^3*v3^3 + v1*v2^3*v3^3 + v0^3*v1^2*v2 + v0^2*v1^3*v2 + v0^3*v1*v2^2 + v0*v1^3*v2^2 + v0^3*v1^2*v3 + v0^2*v1^3*v3 + v0^3*v1*v2*v3 + v0^2*v1^2*v2*v3 + v0*v1^3*v2*v3 + v0^3*v2^2*v3 + v1^3*v2^2*v3 + v0^2*v2^3*v3 + v1^2*v2^3*v3 + v0^3*v1*v3^2 + v0*v1^3*v3^2 + v0^3*v2*v3^2 + v0^2*v1*v2*v3^2 + v0*v1^2*v2*v3^2 + v1^3*v2*v3^2 + v0*v1*v2^2*v3^2 + v0*v2^3*v3^2 + v1*v2^3*v3^2 + v0^3*v1*v2 + v0*v1^3*v2 + v0^2*v1*v2^2 + v0*v1^2*v2^2 + v0^3*v1*v3 + v0*v1^3*v3 + v0^3*v2*v3 + v1^3*v2*v3 + v0*v1*v2^2*v3 + v0*v2^3*v3 + v1*v2^3*v3 + v0^2*v1*v3^2 + v0*v1^2*v3^2 + v0^2*v2*v3^2 + v0*v1*v2*v3^2 + v1^2*v2*v3^2 + v0*v2^2*v3^2 + v1*v2^2*v3^2 + v0^2*v1*v2 + v0*v1^2*v2 + v0^2*v1*v3 + v0*v1^2*v3 + v0^2*v2*v3 + v0*v1*v2*v3 + v1^2*v2*v3 + v0*v2^2*v3 + v1*v2^2*v3 + v0^2*v1 + v0*v1^2 + v0^2*v2 + v0*v1*v2 + v1^2*v2 + v0*v2^2 + v1*v2^2 + v0^2*v3 + v0*v1*v3 + v1^2*v3 + v0*v2*v3 + v1*v2*v3 + v2^2*v3 + v0*v3^2 + v1*v3^2 + v2*v3^2 + v0*v1 + v0*v2 + v1*v2 + v0*v3 + v1*v3 + v2*v3 + v0 + v1 + v2 + v3
#
#







#Implementation 1

H = Matrix([[1,0,1,0],[1,1,0,1]])
s = vector([0,1])
numberOfVariables = H.ncols()
P = PolynomialRing(GF(2),numberOfVariables,names="v"); P
P.inject_variables()
v = P.gens()

#create variables
P2 = PolynomialRing(P1, 5,3, var_array=('a')); P2
P2.inject_variables()


#length of vector v, set this manually
n = 4
l = floor(log(n,2)) + 1

#.gens(): Returns a tuple whose entries are the generators for this object, in order.
a = P2.gens()
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


#OUTPUT
#Defining v0, v1, v2, v3
#Defining a00, a01, a02, a10, a11, a12, a20, a21, a22, a30, a31, a32, a40, a41, a42
#a40
#a41
#a42
#parity check:
#
#[v0 + v2, v0 + v1 + v3 + 1]
#
# L0:
#
#[a00 + a10 + v0, v0*a00 + a01 + a11, v0*a00*a01 + a02 + a12, a10 + a20 + v1, v1*a10 + a11 + a21, v1*a10*a11 + a12 + a22, a20 + a30 + v2, v2*a20 + a21 + a31, v2*a20*a21 + a22 + a32, a30 + a40 + v3, v3*a30 + a31 + a41, v3*a30*a31 + a32 + a42]
#
# F:
#
#a40*a41*a42 + a40*a41 + a40*a42 + a41*a42 + a40 + a41 + a42
