

### Type-I error and power in a linear model

The following function, simulateds data for a linear model of the form `Y=mu+xb+e`.

```r
simData=function(N,R2){
  b=sqrt(R2)
  x=rnorm(N)
  signal=100+x*b 
  vE=1-R2
  error=rnorm(sd=sqrt(vE),n=N) 
  y=signal+error
  return(data.frame(x=x,b=b,y=y))
}
 
```

*Example*

```r
  TMP=simData(100000,.2)
  var(TMP$x*TMP$b)/var(TMP$y)
  fm=lm(y~x,data=TMP)
```

**Task: Power Estimation using Monte Carlo Simulations**

Using the function provided above, estimate the power to detect an association between x and y for `R2=0.1` and `N=c(10,20,50,100)` using Monte Carlo simulations.

Hints:

  - Create a matrix (e.g., `REJECT`) with 5,000 rows (MC simulations) and 4 columns (values of N).
  - Then, to run your Monte Carlo Simulations, use two loops

```r
 N=c(10,20,50,100)
 R2=0.1

 for(i in 1:4){
   n=N[i]
   for(j in 1:5000){
      # Simulate your data
      # fit a linear model y~x to the simulated data
      # extract the pValue=summary(fm)$coef[2,4]
      # store in REJECT[j,i] a boolean indicating whether the p-value is smaller than 0.05
   }
 }
```

The proportion of times that you rejected for each column of `REJECT` is an estimate of the power to detect a significant association between y and x for the assumed sample size and R2.


## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. If you have multiple files to submit, at least one of them is named as `assignment.R`.  You may submit your answer to Gradescope as many times as needed.

Include in your script the `simData()` function (defined above), the `R2=0.1` and sample sizes (`N=c(10,20,50,100)`) values, and the code that creates and fills with TRUE/FALSE the matrix `REJECT`. We will evaluate your results using

```r
  power=colMeans(REJECT)
```

And check that your power results are close (up to Monte Carlo Error) to the true power of each sample size.

