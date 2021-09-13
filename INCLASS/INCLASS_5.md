

Create an R-function that will fit a linear model via least-squares, use the example below to compare your results with `lm()`. In your function you can use all the matrix operations that we discuss today.

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

**Suggested outline for problem 2**
   - Create the incidence matrix X for the model y=Xb+e, recall that for an 'intercept' the 1st column of X must be a vector of 1's, thus, `X=cbind(1,x1,x2)`
   - Compute the cross-products involved in the normal equations `C=X'X` and `rhs=X'y`,
   - Use solve to obtain bHat,
   - Return


