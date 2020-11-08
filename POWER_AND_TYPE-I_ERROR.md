### Power & Type-I Error Rate



Consider testing a hypothesis (e.g, in a linear model **y=Xb+e**, H<sub>0</sub>: b<sub>j</sub>=0 Vs H<sub>a</sub>: b<sub>j</sub>&#8800;0). Based on a test statistic (e.g., p-value) and a decision rule (e.g., reject if p-value<0.05). We have two possible states of nature (H<sub>0</sub>/H<sub>a</sub>) and  two possible decisions (reject/do not reject); the table below classifies each of these cases


|           | Do not reject H<sub>0</sub>  | Reject H<sub>0</sub>          |
|-----------|-------------------|---------------------|
| H<sub>0</sub> holds  | True Negative  | False Positive |
| H<sub>a</sub> holds  | False Negative | True positive  |

**Types of error**: In the table above there are two decisions that are incorrect: the False Positives (also called Type-I errors) the False Negatvies (called the Type-II errors).

Suppose we repeat the experiment a large number of times, each time collecting data, rejecting or not rejecting H0 based on a sample collected from the population (i.e., repeated sampling from a population). Imagine we have an oracle and know whether H<sub>0</sub> or H<sub>a</sub> holds and we count how many TN (N1), FP (N2), FN (N3) and TP (N4) we get, 


|           | Do not reject H0  | Reject H0          |
|-----------|-------------------|---------------------|
|  H<sub>0</sub> holds  | N1 | N2 |
| H<sub>a</sub> holds  | N3 | N4  |


If H<sub>0</sub> holds (first row in the above-table), the false discovery proportion is: N2/(N1+N2)

The **type-I error rate** is the probability of rejecting the null given that the null is true, that is p(rejecting|H<sub>0</sub> holds)= E[N2/(N1+N2)].

The **power** of an experiment is the probability of rejecting the null given that the alternative holds, that is power=p(rejecting|H<sub>a</sub>)=E[N4/(N3+N4)].

In cases where we know the sampling distribution of the test statistic, power and Type-I error rate can be computed anlythically. However, in many cases we don't know the sampling distribution of the test statistic; in these cases we can estimate power and type-I error rate using Monte Carlo simulations.

## 1) Analythical approach


#### Example 1: Comparing two means

Suppose we want to test whether the mean of two groups are different. Data consists of measurment of an outcome  in each of the groups: **y**<sub>1</sub>=(y<sub>1(1)</sub>,y<sub>1(2)</sub>,...,y<sub>1(n1)</sub>)  and **y**<sub>2</sub>=(y<sub>2(1)</sub>,y<sub>2(2)</sub>,...,y<sub>2(n2)</sub>).

The Null and alternative hypothesis are: H<sub>0</sub>:  E[y<sub>1(i)</sub>]=E[y<sub>2(i)</sub>]  Vs H<sub>a</sub>:  E[y<sub>1(i)</sub>]&#8800;E[y<sub>2(i)</sub>] 

To test these hypothesis we estimate both means using the sample mean of the data (yBar1=mean(y1), yBar2=mean(y2)).  The t-statistic for the test is


tStat= (yBar1-yBar2)/SE

where SE=sqrt(V1+V2); here V1 and V2 are the variances of each of the means, which are equal to 

V1=Var[y1]/n1, V2=Var[y2]/n2.

**Type-I error rate**: Recall that the type-I error rate is the probability of rejecting the null given that the null holds (in this case given that the two means are equal).

  - If data is normal, each of the means follow a normal distribution yBar1~N(mu1, V1) and yBar2~N(mu2,V2).
  - Thus (yBar1-yBar2)~N(mu1-mu2, V1+V2), which under the null becomes (yBar1-yBar2)~N(0, V1+V2).
  - Furthermore, under the null, the standarized difference (or t-statistic) (yBar1-yBar2)/SE  ~ t(n1+n2-2)  or (yBar1-yBar2)/SE  ~ N(0,1) if DF is large enough, say>50.
  
  
 What is the type-I error rate if our decision rule is reject if |t-stat|>2?
 
 The probability of having t-stat>2 under the null is `pt(df=DF,q=2,lower.tail=FALSE)`, and the probability of t-stat< -2 is `pt(df=DF,q=-2)`; therefore, considering that the t-distribution is symmetric, the expected type-I error rate is:  `pt(-abs(tStat))*2`.



**Power**



#### Example 2: Linear regression


For a linear model **y=Xb+e** consider testing whether the jth coefficient is different than zero, that is

H<sub>0</sub>: b<sub>j</sub>=0 Vs H<sub>a</sub>: b<sub>j</sub>&#8800;0). 


If the errors are IID normal, since the OLS estimates are unbiased, the sampling distribution of OLS estimate of the jth coefficient bHat<sub>j</sub> is

bHat<sub>j</sub>~N(b<sub>j</sub>,V<sub>j</sub>) 

where V<sub>j</sub> is the jth diagonal entry of `varE*(X'X)^-1` (see [notes on OLS](https://github.com/gdlc/STAT_COMP/blob/master/OLS.pdf) for more details). 

Therefore, the standardized coefficient, z<sub>j</sub>=bHat<sub>j</sub>/SE<sub>j</sub>~N(b<sub>j</sub>,1), here SE<sub>j</sub>=sqrt(V<sub>j</sub>).

**Type-I error**

Suppose we reject if abs(z<sub>j</sub>)>1.96, what is the probability of rejecting the null if the null holds?

  - If H<sub>0</sub> holds, b<sub>j</sub>=0; thus, z<sub>j</sub>=bHat<sub>j</sub>/SE<sub>j</sub>~N(0,1). 
  - The probability of obtaining a z<sub>j</sub> > 1.96 is `pnorm(q=1.96,lower.tail=FALSE)`~0.025.
  - Likewise, the probability of obtaining a z<sub>j</sub> < -1.96 is `pnorm(q=-1.96,lower.tail=TRUE)`~0.025. 
  - Therefore, the probability of rejecting if H<sub>0</sub> > holds is ~0.05. 
  - This implies that if we use |z<sub>j</sub>|> 1.96 the expected Type-I error rate is 0.05.


**P-values**

Recall that p-values are estimates of the probability of rejecting the null given that the null holds; thus, p-values provide an estimate of the Type-I error rate. If we want to control this error at a low rate (e.g. 0.05) we should reject when p-values are smaller than the Type-I error rate we are willing to tolerate.


**Power**

What is the power to detect a non-null effect in the above-example? Power is the probability of rejecting the null when the H<sub>a</sub> holds. The main factors that affect power are the size of the effect, sample size (which affects the SE), and the statistical rule used for rejection.

Continouing with the example presented above, and assuming that the decision rule is: reject if |z<sub>j</sub>|>1.96, what is the probability to reject Hz<sub>0</sub> if b=0.1?

  - Under the H<sub>a</sub> bHat<sub>j</sub>~N(b<sub>j</sub>,V<sub>j</sub>). 
  - Thus, z<sub>j</sub>=bHat<sub>j</sub>/SE<sub>j</sub>~N(b<sub>j</sub>/SE<sub>j</sub>,1).
  - Therefore, the power to reject the null is 
  
  `pnorm(mean=b/SE,sd=1,q=1.96,lower.tail=FALSE) + +pnorm(mean=b/SE,q=-1.96)`
  
The following code uses the above results to estimate power for `b=[0.1,0.2,0.3]`, and `SE=[0.1,0.05]`.
  
  
```r
 b=c(0.1,0.2,0.3)
 SE=c(0.1,0.05)
 
 SCENARIOS=expand.grid(b=b,SE=SE)
 SCENARIOS$power=NA
 
 for(i in 1:nrow(SCENARIOS)){
  b=SCENARIOS$b[i]
  SE=SCENARIOS$SE[i]
  SCENARIOS$power[i]=pnorm(mean=b/SE,sd=1,q=1.96,lower.tail=FALSE) + +pnorm(mean=b/SE,q=-1.96)
 }
```

## 3) Monte Carlo Methods

In a MC study we replicate the sampling process (in this case the process that generates the test statistic) a very large number of times, each time applying  the decision rules. We count how many times we reject. If we are simulating under H0, the rejection rate estimates type-I error rate. If we are simulating under Ha, the empirical rejection rate is an estimate of hte power of the experiment. 

The example below illustrates how to estimate power using a simpe linear regression model as an example.

#### Example

Power and error rates depend on three main factors: (i) sample size, (ii) the size of the effect relative to the variance of the noise (i.e., signal-to-noise ratio), and (iii) the test statistics and the decision rule used to reject H0.


The following example evaluates rejection rate for a simple linear model. The R2 parameter controls the signal to noise ratio (R2/(1-R2)), R2=0 simulates from the null, R2>0 simulates from Ha.

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

If you run the above example with R2=0, the estimated rejection rate should be close to 0.05. Why? Because we are rejecting if p-value<0.05, if the p-values are correct (in the above case they are correct because we simulate data under the same normal assumptions that are used to derive the test-statistic) then we expect a rejection rate equal to the significance level used for rejection. But p-values are not always correct. The following example illustrates this.


## What if assumptions don't hold?

If the assumptions made to derive the p-values do not hold, p-values are not necesarily correct and we may have a type-I error rate smaller or higher than the significance level used. The first example uses exponential residuals, this type of violation of assumptions may ahve an effect on type-I error rate, but the effect dissapears with sample size because asymptotically, OLS estimates follows normal distrivbution regardless of the distribution of the errors.

```r
  
  N=10 # sample size
  nRep=100000 # number of Monte Carlo replicates

  pValues=rep(NA,nRep)
  N0=floor(N/2)
  x=c(rep(0,N0),rep(1,N-N0))
  
  for(i in 1:nRep){   
      error=rexp(rate=1,n=N)  # this violates the normality assumption
      y=error # i.e., simulating under H0
      fm=lsfit(y=y,x=x) # equivalent to lm (i.e., fits model via OLS) but faster
      pValues[i]=ls.print(fm,print.it = FALSE)$coef[[1]][2,4]
      if(i%%5000==0){ message(i) }
  }
  
  reject=pValues<.05 # decision rule
  mean(reject,na.rm=T) # Is the test is slightly conservative?, Change N=100
   
```  

**Model miss-specification**: Other violations of assumptions are more complicated, for instance, imagine `Y` is affected by `Z`, which is correlated with `X` and suppose we regress `Y` on `X`. `X` does not have an effect but if we miss-specified the model by ignoring `Z`, then we will get inflated type-I error.

```r 
  N=100
  nRep=10000 # number of Monte Carlo replicates

  pValues=rep(NA,nRep)
  N0=floor(N/2)
  bZ=.1
  
  for(i in 1:nRep){   
      error=rnorm(n=N)  # this violates the normality assumption
      z=rnorm(N)
      x=rnorm(N)+z
      signal=z*bZ
      y=signal + error 
      fm=lsfit(y=y,x=x) # equivalent to lm (i.e., fits model via OLS) but faster
      pValues[i]=ls.print(fm,print.it = FALSE)$coef[[1]][2,4]
      if(i%%1000==0){ message(i) }
  }
  
  reject=pValues<.05 # decision rule
  mean(reject,na.rm=T) 
  
```  


Including `Z` in the model fixes the problem.


```r
  
  N=50
  nRep=10000 # number of Monte Carlo replicates

  pValues=rep(NA,nRep)
  N0=floor(N/2)
  bZ=.1
  
  
  for(i in 1:nRep){   
      error=rnorm(n=N)  # this violates the normality assumption
      z=rnorm(N)
      x=rnorm(N)+z
      signal=z*b
      y=signal + error 
      fm=lsfit(y=y,x=cbind(x,z)) # equivalent to lm (i.e., fits model via OLS) but faster
      pValues[i]=ls.print(fm,print.it = FALSE)$coef[[1]][2,4]
      if(i%%1000==0){ message(i) }
  }
  
  reject=pValues<.05 # decision rule
  mean(reject,na.rm=T) 
  
```  
[Main]( https://github.com/gdlc/STAT_COMP/blob/master/README.md )
