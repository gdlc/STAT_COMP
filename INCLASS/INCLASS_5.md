

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
Start by building a function that takes the incidence matrix **X** and the response **y** as inputs. Your function should return a matrix similar to the one produced by `summary(lm(y~X))`.

Once you succeed at develping the funciton, consider making a variant of this function that will take a formula and a data frame as inputs, something like this: `myOLS(y~BMI+age,data=...)`
