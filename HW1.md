Due October 2nd in D2L


#### (1) Develop a function that will take a formula `y~x1+x2,...,` and a data frame `data=..` and will, internally, produce the incidence matrix for the linear model and produce a table equal to the one
returned by `summary(lm(y~x1+x2....))`. Carry all the computations using matrix and scalar computations (you are not allowed to use `lm` or other R functions designed for least squares regression (e.e., `lsfit`).

Use the following simulation to compare your results with those of `summary(lm(y~...))`.

Your report must show:
 - The function (the function must take a formula of the form `y~x+z+...`, and a data frame as input, it must return a table equivalent to that of `summary(lm(y~...))` and internally all the quantities should be derived using matrix or scalar operations, i.e., do not use `lm` or similar functions inside your function)).
 - The ouput of comparison with `lm`

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

### (2) F-test (and the `anova()` function) and Wald's test

For hypothesis testing involving just 1 DF (i.e., imposing only one restriction, e.g., H0: bj=0) we can use a t-test. However, for tests involving more than 1 df we should use other tests.

Recall the [Gout](https://raw.githubusercontent.com/gdlc/STAT_COMP/master/goutData.txt) data set and consider a regression of the form: `fm1: su~race+sex+age`.

**2.1**) Fit the model, report results, and summarize in no more than three sentences your conclusions.

**2.2**) Consider now expanding the model to inclue race-by-sex interactions, fit the model (`fm2<-lm(su~race+race*sex+age)`) and report your results.

**2.3**) Consider now testing the hypothesis that sex has any effect on su, that is whether sex has an effect that is the same for white and black people, or an effect that is different in black and white people. To test this hypothesis, you should compare the model `fm2` with a null model that does not include sex, e.g., `fm0: su~race+age`. This test involves 2df because we impose the restriction that the main and interaction effects involving sex are equal to zero. You can test this hypothesis using `anova(fm2,fm0)`. Conduct the test, report the results, and summarize your conclusions in no more than 2 sentences directly related to the hypothesis being tested.

**2.4**) Reproducing the results of the F-test: Review the F-statistic in the [class notes](https://github.com/gdlc/STAT_COMP/blob/master/OLS.pdf) and develop a function that takes as input two `lm` objects and return a table identical to the one produced by `anova()`.


