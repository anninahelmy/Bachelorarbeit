P1 = PolynomialRing(GF(2), 'v', 5); P1
P1.inject_variables()
P2 = PolynomialRing(P1, 5,3, var_array=('a')); P2
P2.inject_variables()

n = 5
l = floor(log(n,2)) + 1
all = (n*l)

v = vector(P1.gens())

w = [1,0,0,1,1]

L0 = vector(P2.gen(i) for i in range(l))
L1 = vector(P2.gen(i) for i in range(l))


#product
for i in range(n):
    for j in range(l):
        if j == 0:
            L0[j] = L0[0]
        else:
            L0[j] = L0[j]*L0[j-1]
    
    #first equations
    for j in range(l):
        if j == 0:
            L1[j] = L0[j] + w[i]
        else:
            L1[j] = L0[j].quo_rem(L0[j-1])[0] + L0[j-1]*w[i]

    L0 = L1
print(L0)
