H = Matrix([[1,1,0,1,1,0,0], [1,0,1,1,0,1,0], [0,1,1,1,0,0,1]])
s = vector([1,1,0])
numberOfVariables = H.ncols()
P.<v0,v1,v2,v3,v4,v5,v6,a0,a1,a2, b0,b1,b2> = PolynomialRing(GF(2));
P.inject_variables()
v = [P.gen(i) for i in range(7)]
b = [P.gen(i) for i in range(10,13)]
n = numberOfVariables
l = floor(log(n,2)) + 1
all = (n*l)

L0 = vector(P.gen(i) for i in range(7,10))
L1 = vector(P.gen(i) for i in range(7,10))


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
    
t = vector([1,0,0])
f = []

#create f_j
for j in range(l):
    f.append(prod((b[h] + t[h] + 1) for h in range (j+1,l)) * (b[j] + t[j]))

#create polynomial F
F = sum((f[j] * (t[j] + 1)) for j in range(0,l) )


S = (H*vector(P.gen(i) for i in range(numberOfVariables))-s).list()
S = S + L0.list()
S = S+ [F]
S = S + [a0,a1,a2]
for i in range(13):
    S.append(P.gen(i)^2 + P.gen(i))

print(S)
I = ideal(S)
for sol in I.variety():
    print(sol[a0],sol[a1],sol[a2],sol[v0],sol[v1],sol[v2],sol[v3],sol[v4],sol[v5],sol[v6],sol[b0],sol[b1],sol[b2])
   


