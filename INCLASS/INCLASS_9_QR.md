## IN-CLASS 9

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

**2)** Solve the system using the QR decomposition and create a function `fitLMQR(X,y), that will produce the same estimates as those of `coef(lm(y~X))`.


**3)** Create a funciton `solveSys(C,r,tol=1e-5,maxIter=1000)` that would produce and return the value of the coefficients for the last iteration. You can find an outline [here](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/GaussSeidel.md). The function should take three arguments: `C`, `r`, and `maxIter=1000`. Initialization: `b=r/diag(C)`.

**Note**: When running `solveSysGS(crossprod(X),crossprod(X,y))` with enough `maxIter` (e.g., `maxIter>=1000`) its output should be almost the same as `coef(lm(y~X-1))`. You can verify that by ploting what your function returns versus the OLS estimates obtained using `lm()`, all the points should be very close to the 45-degree line (`abline(a=0,b=1)`). You can also check `max(abs(x-y))` where `x` and `y` are the estimates reported by `lm()` and the ones you obtained using `solveSysGS()`. The maximumb absolute-value difference should be very semall.



## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. If you have multiple files to submit, at least one of them is named as `assignment.R`.  You may submit your answer to Gradescope as many times as needed.

  - Include in your script the declaration of the two functions mentioned above. We will test the functions with arbitrary examples.
