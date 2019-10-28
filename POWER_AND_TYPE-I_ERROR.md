### Power & Type-I Error Rate


Consider testing a hypothesis (e.g, in a linear model `y=mu+b*x+e`, H0: b=0 Vs Ha: b!=0). 

This hypothesis may or may not hold  (rows in the table below), and our decision may be to: (i) reject or (ii) fail to reject H0 (columns). The table below classifies each of the four possible cases we can encounter regarding the state of nature and our decision:


|           | Do not reject H0  | Reject H0          |
|-----------|-------------------|---------------------|
| H0 holds  | True Negative  | False Positive |
| Ha holds  | False Negative | True positive  |


Suppose we conduct N tests(N=N1+N2+N3+N4) with the following outcome

|           | Do not reject H0  | Reject H0          |
|-----------|-------------------|---------------------|
| H0 holds  | N1 | N2 |
| Ha holds  | N3 | N4  |


From the above table we can define the following proportions

 -  Proportion of false discoveries given that H0 holds: N2/(N1+N2)
 - (FDP) Proportion of false discoveries among the discoveries: N2/(N2+N4)
 - (TDP) Proportion of true discoveries given that HA holds: N4/(N3+N4)

**Definitions**:

The expected value of these proportions gives the Type-I error rate, false discovery rate and power of our experiment/test, resepectively:
 
   - **Type-I error rate**: P(reject|H0 holds)=E[N2/(N1+N2)]
   - **Power**:  P(Reject|Ha)=E[N4/(N3+N4)]
   - **False discovery rate** (FDR): E[N2/(N2+N4)]

In simple cases (e.g., comparison of two means) power and Type-I error rate can be computed anlythically. 
However, for more involved tests, anlythical derivations are not always available. 
In these cases we can estimate the above quantities using Monte Carlo simulations. 
The underlying idea is to replicate the process of (conceptual) repeated sampling from the population for a very large number of times so that the empirical proportions provide a good approximation to the underlying probabilities (or expected rates). 

The example below illustrates how to estimate power using a simpe linear regression model as an example.

#### Example

Power and error rates depend on three main factors: (i) sample size, (ii) the signal-to-noise ratio, and (iii) the test statistics and the decision rule used to reject H0.


```r
  R2=0.01 # Model R-sq.
  N=50 # sample size
  nRep=10000 # number of Monte Carlo replicates
   
  countRejections=rep(0, length(R2)) # We count rejections for every scenario
  b=sqrt(R2)
  pValues=rep(NA,nRep)
  
  for(i in 1:nRep){
      x=rnorm(N)
      signal=x*b # var(xb)=var(x)*var(b)=var(x)b^2=R2
      error=rnorm(sd=sqrt(1-R2),n=N) 
      y=signal+error
      fm=lsfit(y=y,x=x) # equivalent to lm (i.e., fits model via OLS) but faster
      pValues[i]=ls.print(fm,print.it = FALSE)$coef[[1]][2,4]
  }
  
  reject=pValues<.05 # decision rule
  mean(reject) # since we are simulating under Ha this estimates power
  
```

**Suggestion**: Set R2=0, the resulting rejection rate will then be an estimate of Type-I Error rate. If the test is correct
it should be close to the chosen significance level.

