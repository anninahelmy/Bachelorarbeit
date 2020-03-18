@interact
def displaySystem(A='[(1,0,1),(1,1,0), (1,0,1)]',  b='[2,1,-2]', auto_update=False):
    A = matrix(eval(A))
    b = vector(eval(b))
    numberOfVariables = A.ncols()
    numberEquations = len(b)
    X = [var('x_%d'%i) for i in [1..numberOfVariables]]
    A,b
    equations = [A[i]*vector(X)==b[i] for i in range(numberEquations)]
    newtext='\n'.join(map(str, equations))
    new = newtext.replace('==', '=')
    new = new.replace('*', '')
    print(new)
