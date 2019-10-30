### Power & Type-I Error Rate


Consider testing a hypothesis (e.g, in a linear model `y=mu+b*x+e`, H0: b=0 Vs Ha: b!=0). Based on a test statistic (e.g., p-value) and a decision rule (e.g., reject if p-value<0.05) we may reject or do not reject H0. Thus, we have two possible states of nature (H0 and Ha) and  two possible decisions; the table below classifies each of these cases


|           | Do not reject H0  | Reject H0          |
|-----------|-------------------|---------------------|
| H0 holds  | True Negative  | False Positive |
| Ha holds  | False Negative | True positive  |

**Types of error**: In the table above there are two decisions that are incorrect: the False Positives (also called Type-I errors) the False Negatvies (called the Type-II errors).

Suppose we repeat the experiment a large number of times, each time rejecting or not rejecting H0 based on a sample collected from the population (i.e., repeated sampling from a population). Imagine we have an oracle and know hweather H0 or Ha holds and we count how many TN (N1), FP (N2), FN (N3) and TP (N4) we get, 


|           | Do not reject H0  | Reject H0          |
|-----------|-------------------|---------------------|
| H0 holds  | N1 | N2 |
| Ha holds  | N3 | N4  |


If H0 holds, the false discovery proportion is: N2/(N1+N2)

**Type-I error rate**: The type-I error *rate* if the probability of rejecting the null given that the null holds. This is simply E[N2/(N1+N2)].

**Power**: The power of an experiment is the probability of rejecting the null given that the alternative holds, that is power=E[N4/(N3+N4)].

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

[Main]( https://github.com/gdlc/STAT_COMP/blob/master/README.md )
