##weight computation
P1 = PolynomialRing(GF(2), 'v', 4); P1
P1.inject_variables()
P2 = PolynomialRing(P1, 4,3, var_array=('a')); P2
P2.inject_variables()

n = 4
l = floor(log(n,2)) + 1
all = (n*l)

v = (1,0,1,1)

L0 = vector(P2.gen(i) for i in range(l))
L1 = vector(P2.gen(i) for i in range(l))
print(L0)
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
print(L0)

#in L0 the weight of a is saved

##weight constraint part 1
P3 = PolynomialRing(P2, 'f', l); P3
P3.inject_variables()
f = vector(P3.gen(i) for i in range(l))
t = (1,1,0,1,1)

for j in range(l):
    f[j] = prod((L0[h] + t[h] + 1) for h in range(j+1, l)) * (L0[j] + t[j])
print("vector f_j:")
print(f)

##create polynomial F
F = sum(f[l-1] * (t[j] + 1) for j in range(0,l) )
print("Polynomial F. F is 0 iff weight of a is smaller than t, 0 otherwise: ")
print(F)
