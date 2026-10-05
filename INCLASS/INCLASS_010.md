## INCLASS 10: Gauss-Seidel


Write a function `solveGS=function(C,r,tol=1e-5,maxiter)` that solves a system of linear equations of the form $\mathbf{C\hat{b}=r}$. 

In the context of a linear model $\mathbf{C=X'X}$ and $\mathbf{r=X'y}$ using the Gauss-seidel algorithm.

Your function should stop the iterations whenever the maximum difference with previous coefficients is smaller than `tol` or `maxiter` was reached.


You can use this dummy example to test your code

```
 n=500
 p=5
 X=matrix(nrow=n,ncol=p,data=rnorm(n*p))
 y=X[,3]-X[,5]+rnorm(n)
 
 C=crossprod(X)
 r=crossprod(X,y)
 bHat=solve(C,r)

 ```

## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below.

Include in your script the definition of the functions `solveGS()`, we will test both functions with an arbitrary example. 





