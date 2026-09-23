Create an R-function that will fit a linear model via least-squares, use the example below to compare your results with `lm()`. In your function you can use all the matrix operations that we discussed in class. However, you cannot use `lm()` or similar built functions to fit OLS.

Recall that in a linear model **y=Xb+e**, the least-squares estimate of **b** is the solution to the following system **X'Xb=X'y**.


```r
 set.seed(12345)
 n=100
 x1=rbinom(size=1,n=n,prob=.5)
 x2=sample(c('A','B'),size=n,replace=TRUE)
 mu=100
 
 signal=100 + x1*2 + I(x2=='B')*(-1)
 error=rnorm(n)
 y=signal+error
 
 summary(lm(y~x1+x2))
 
```
Our final goal is to implement `summary(lm(y~X))` using our own functions. 

In this in-class assignment we will focus on getting estimates (we will work SE, p-values, etc. in a future in-class assignment).

Our target is a function like this one

```r
 fitOLS=function(model,data){
    # 1) using model and data, create the model matrix (X)
    # 2) extract from the model and data the response, label it as y
    # 3) Use matrix operations to get OLS estimates
    # 4) Return estimates
 }
```

You may want to split the above tasks in three pieces: 

 - `getXy(model,data)`, takes a formula (`model`) and a data.frame (`data`) and returns a list with `y` and `X`.
 - `fitOLS.Xy(X,y)`, takes a numeric matrix (`X`) and a numeric vector (`y`) and returns OLS estimates
 - `fitOLS(model,data)`, inside it calls `getXy()` and then calls `fitOLS()` and the output of `getXy()`.

To test your functions you may want to use this toy data set (we will test it with another one)

```
# Run the top example first
DATA = data.frame(y=y,x1=x1,x2=x2)
```

## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) that contains the definition of the function `fitOLS()` and other functions that this function may use. We will test `fitOLS()` with an arbitrary data set.

