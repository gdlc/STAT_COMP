Create an R-function that will fit a linear model via least-squares, use the example below to compare your results with `lm()`. In your function you can use all the matrix operations that we discussed in class. However, you cannot use `lm()` or similar built functions to fit OLS.

Recall that in a linear model **y=Xb+e**, the least-squares estimate of **b** is the solution to the following system **X'Xb=X'y**.


```r
 n=300
 x1=rbinom(size=1,n=n,prob=.5)
 x2=rnorm(n)
 mu=100
 b1=2
 b2=-3
 
 signal=mu + x1*b1 + x2*b2
 error=rnorm(n)
 y=signal+error
 
 summary(lm(y~x1+x2))
 
```
Our final goal is to implement `summary(lm(y~X))` using our own functions. Build the following functions one by one:

**1)** `getXy`: this function receives the formula and data, and outputs a list with two elements `X` and `y`:

```
DATA = data.frame(y=y,z1=x1,z2=x2)
tmp = getXy(y~z1+z2,DATA)
```
Then `tmp$X` is a matrix with three columns `(Intercept)`, `z1` and `z2`, and `tmp$Y` is a vector containing the response `y`.

**Hint:** Inside `getXy()` consider using `model.matrix()`.

**2)** `fitXy`: this function receives the two outputs from `getXy`, and outputs the coefficient estimates.

## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. If you have multiple files to submit, at least one of them is named as `assignment.R`.  You may submit your answer to Gradescope as many times as needed.

  - Include in your script the declaration of the three functions mentioned above. We will test the functions with arbitrary examples.

