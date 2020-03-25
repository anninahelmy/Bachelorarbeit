A = matrix(4, 4, [1,0,1,1,1,1,1,1,0,1,0,1,0,0,0,1])
b = (-1)*vector([1,0,1,0])
numberOfVariables = A.ncols()
P=PolynomialRing(GF(2),A.nrows(),names="x")
(A*vector(P.gen(i) for i in range(numberOfVariables))-b).list()

