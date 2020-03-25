@interact
def inputMatrix(A='[(1,0,1),(1,1,0), (1,0,1)]',  b='[1,0,1]', auto_update=False):
    A = matrix(eval(A))
    b = vector(eval(b))
    print(A,b)
    numberOfEquations = len(b)
    numberOfVariables = A.ncols()
    P = PolynomialRing(GF(2), A.nrows(), names ="x")
    print((A*vector(P.gen(i) for i in range(numberOfVariables))-b).list())
