Due Sept 31st on D2L


#### (1) Develop a function that will take a formula `y~x1+x2,...,` and a data frame `data=..` and will, internally, produce the incidence matrix for the linear model and produce a table equal to the one
returned by `summary(lm(y~x1+x2....))`. Carry all the computations using matrix and scalar computations (you are not allowed to use `lm` or other R functions designed for least squares regression (e.e., `lsfit`).

Use the following simulation to compare your results with those of `summary(lm(y~...))`.

Your report must show:
 - The function
 - The ouput of a comparison with `lm`

```r
  n=100
  b=c(4,-4,3)
  p=length(b)
  x1=rnorm(n)
  x2=runif(n)
  x3=rbinom(n,size=1,prob=.3)
  signal=20+cbind(x1,x2,x3)%*%b
  error=rnorm(n=n,sd=sd(signal))
  y=signal+error
```

### (2) Scatter-plot smoothing

