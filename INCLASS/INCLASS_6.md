## IN-CLASS 6

### Solving systems of equations using the QR-decompositin and using the [Gauss-Seidel](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/GaussSeidel.md) algorithm.

Use the code below to generate a system of 5 equations on 5 uknowns (**Cb=r**).

```r
 n=500
 p=5
 X=matrix(nrow=n,ncol=p,data=rnorm(n*p))
 y=X[,3]-X[,5]+rnorm(n)
 
 C=crossprod(X)
 r=crossprod(X,y)
 # compare your results with solve(C,r)
```


**1)** Solve the system using the QR decomposition, check your results agains `solve(C,r)` and `lm(y~X-1)`.


**2)** Create a funciton `solveSys(C,r,to1e-5)` that would produce and return a solution to the system **Cb=r** using the Gauss-Seidel algorithm. You can find an outline [here](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/GaussSeidel.md).

