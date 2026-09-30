

Recall that in a linear model $y=Xb+\varepsilon$, the least-squares estimate of $b$ is the solution to the following system of equations

$$[X'X]\hat{b}=X'y$$

The sampling variance of the OLS estimates is


$$Var(b)=[X'X]^{-1}\sigma^2_{\varepsilon}$$

The SE of the OLS estimates are the square-root of the diagonal elements of the above (co)variance matrix.

The error variance can be estimated using 

$$\hat{\sigma^2_{\varepsilon}}=\frac{RSS(\hat{b})}{n-p}$$

where $p$ is the rank of $X$.

Your task will consist of developing a function `fitOLS(model,data)` that will take a formula (model) and a data frame (data) and will return a matrix or data frame with the same columns as that of `summary(lm(model,data=data))$coef`.


You can test your function using this simple data set (we will test your function against `lm()` using an arbitrary data set. The assigment has 4 points, Q1 checks estimates, Q2 checks SE, Q3 checks the z-statistic, and Q4 checks p-values.


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

## Submission to Gradescope

## If you see two "test case passed" in the std output but still see "test failed" in the grade, please email me for override.

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. If you have multiple files to submit, at least one of them is named as `assignment.R`.  You may submit your answer to Gradescope as many times as needed.

  - Include in your script the declaration of `fitOLS()` function–we will test the functions with arbitrary examples.

