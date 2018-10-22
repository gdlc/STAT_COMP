### Family-Wise Error Reate, False Discovery Rate (FDR) and power 


Consider testing a hypothesis (e.g, H0: b=0 Vs Ha: b!=0). This hypothesis may or may not hold  (rows in the table below), and our
decision may be to reject it or not to reject it (columns). The table below classifies each of the four possible cases:

and we may reject the null or fail to reject it (columns).

|           | Do not reject H0  | Reject H0          |
|-----------|-------------------|---------------------|
| H0 holds  | True Negative  | False Positive |
| Ha holds  | False Negative | True positive  |


Suppose we conduct N tests(N=N1+N2+N3+N4) with the following outcome

|           | Do not reject H0  | Reject H0          |
|-----------|-------------------|---------------------|
| H0 holds  | N1 | N2 |
| Ha holds  | N3 | N4  |


From the above table we can define the following (empirical) proportions

 -  Proportion of false discoveries given that H0 holds: N2/(N1+N2)
 - (FDP) Proportion of false discoveries among the discoveries: N2/(N2+N4)
 - (TDP) Proportion of true discoveries given that HA holds: N4/(N3+N4)

**Definitions**:

The expected value of these proportions gives the Type-I error rate, false discovery rate and power of our experiment/test. 
More precisely
 
 
   - Type-I error rate: P(reject|H0 holds)=E[N2/(N1+N2)]
   - Power:  P(Reject|Ha)=E[N4/(N3+N4)]
   - False discovery rate (FDR): E[N2/(N2+N4)]

  
#### Estimating Type-I error rate, False Discover Rate and Power using Monte Carlo Simulations

The following example shows how to estimate type-I error rate, power and FDR for a single test. 

The model we use is a simple linear regression model of the form: 

          `y=mu+x*b+e` 


where the signal to noise ratio is R2/(1-R2), that is the model has an R-squared equal to R2 (in the simulation we will vary R2 from 0 to 0.1).

To simulate from this model we use the following assumptions: `e~N(0,1-R2)`, `x~N(0,1)` and `b=sqrt(R2)`.


```r
  R2=c(0,.01,.03,.05,.1) # Model R-sq.
  N=50 # sample size
  nRep=10000 # number of Monte Carlo replicates
  significance=0.05 # significance for rejection
   
  countRejections=rep(0, length(R2)) # We count rejections for every scenario
  for(i in 1:length(R2)){ # loop over values of R-squared
      message("R-sq=",R2[i])
      b=sqrt(R2[i])
      for(j in 1:nRep){
        x=rnorm(N)
        signal=x*b
        error=rnorm(sd=sqrt(1-R2[i]),n=N) 
        y=signal+error
        fm=lsfit(y=y,x=x) # equivalent to lm (i.e., fits model via OLS) but faster
        reject=(ls.print(fm,print.it = F)$coef[[1]][2,4]<significance) 
        countRejections[i]=countRejections[i]+reject # TRUE is interpreted as 1 and FALSE as 0
      }
  }
  
  plot(y=countRejections/nRep,type='o',col=2,x=R2,ylab='Power',xlab='R2',ylim=c(0,1))
  abline(h=significance,col=4,lty=2,main='Power Curve',ylim=c(0,1))
```

**In-class 1**: 

    - Produce an R-script to esitmate power over a grid of values of R-squared (from 0 to 0.1, as above) and sample size N=10,20,30,50,100).
    - Present a plot with sample R-squared (i.e., effect size) in the X-axis, power in the Y-axis and separate lines for each of the sample sizes.
    - Submit pdf (or html) and R-Markdown in D2L at the end of the class.
    

