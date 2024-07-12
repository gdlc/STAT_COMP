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

```

**1)** Solve the system using the QR decomposition and create a function `solveSysQR`. Function `solveSysQR` receives two arguments `C` and `r`, and outputs a vector which matches the output of `solve`.

**2)** Solve the system using the QR decomposition and create a function `fitLMQR`. Given `fitLMQR(cbind(1,X),y)`, its outputs is the same as `coef(lm(y~X))`.

**3)** Solve the system using the SVD decomposition and create a function `fitLMSVD`. Given `fitLMSVD(cbind(1,X),y)`, its outputs is the same as `coef(lm(y~X))`.

**4)** Create a funciton `solveSys(C,r,tol=1e-5,maxIter=1000)` that would produce and return a list of two elements: (1) a solution to the system **Cb=r** using the Gauss-Seidel algorithm, and (2) a table with the history of all iterations (each row is an iteration). You can find an outline [here](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/GaussSeidel.md). There are four input arguments `C`, `rhs`, `tol=1e-5`, and `maxIter=1000` (You may change the `tol` and `maxIter` value). If the change in the next update is less than `tol`, we output the result. The function should

[1] When running `solveSysGS(crossprod(X),crossprod(X,y))` with proper `tol` and `maxIter`, its output is almost the same as `coef(lm(y~X-1))`.

[2] When the number of iterations exceeds `maxIter`, output `NA` to show that the algorithm does not converge given the current configuration.

