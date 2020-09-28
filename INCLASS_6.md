## IN-CLASS 5: Implementing the [Gauss-Seidel](https://github.com/gdlc/STAT_COMP/blob/master/LinearAlgebra.md#gauss-seidel) algorithm.

**Task:** Create a funciton `solveSys(C,r,to1e-5)` that would produce and return a solution to the system **Cb=r** using the Gauss-Seidel algorithm. You can find an outline [here](https://github.com/gdlc/STAT_COMP/blob/master/LinearAlgebra.md#gauss-seidel).

You can test your code using the following example

```r
 n=500
 p=5
 X=matrix(nrow=n,ncol=p,data=rnorm(n*p))
 y=X[,3]-X[,5]+rnorm(n)
 
 C=crossprod(X)
 r=crossprod(X,y)
 # compare your results with solve(C,r)
```
