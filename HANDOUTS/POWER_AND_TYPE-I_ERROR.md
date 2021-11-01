### Power & Type-I Error Rate

Hypothesis testing is a central problem in statistical inference. In hypothesis testing we use a decision rule (e.g., reject if  |t-statistic|>1.96) to reject/do-not reject one or more hypothesis.  In the simplest case we have two possible states of nature (H<sub>0</sub>/H<sub>a</sub>) and  two possible decisions (reject/do not reject); the table below classifies each of these cases


|           | Do not reject H<sub>0</sub>  | Reject H<sub>0</sub>          |
|-----------|-------------------|---------------------|
| H<sub>0</sub> holds  | True Negative  | False Positive |
| H<sub>a</sub> holds  | False Negative | True positive  |

**Types of error**: In the table above there are two decisions that are incorrect: the False Positives (also called Type-I errors) the False Negatvies (called the Type-II errors).

**Distribution of the Decision Rule over conceptual repeated sampling**

Suppose we repeat the experiment a large number of times, each time collecting data, evaluating the test-statistic, and rejecting or not. Imagine we know whether H<sub>0</sub> or H<sub>a</sub> holds and we count how many TN (N1), FP (N2), FN (N3) and TP (N4) we get, 


|           | Do not reject H0  | Reject H0          |
|-----------|-------------------|---------------------|
|  H<sub>0</sub> holds  | N1 | N2 |
| H<sub>a</sub> holds  | N3 | N4  |


If H<sub>0</sub> holds (first row in the above-table), the false discovery proportion is: N2/(N1+N2)

The **type-I error rate** is the probability of rejecting the null given that the null is true, that is p(rejecting|H<sub>0</sub> holds)= E[N2/(N1+N2)].

The **power** of an experiment is the probability of rejecting the null given that the alternative hypothesis holds, that is power=p(rejecting|H<sub>a</sub>)=E[N4/(N3+N4)].

In cases where we know the sampling distribution of the test statistic, power and Type-I error rate can be computed anlythically. However, in many cases we don't know the sampling distribution of the test statistic; in these cases we can estimate power and type-I error rate using Monte Carlo simulations.

## 1) Analythical approach


#### Example 1: Comparing two means

Suppose we want to test whether the mean of two groups are different. Data consists of measurment of an outcome  in each of the groups: 

  - **y**<sub>1</sub>={y<sub>1<sub>(1)</sub></sub>,y<sub>1<sub>(2)</sub></sub>,...,y<sub>1<sub>(n1)</sub></sub>}  and 
  -  **y**<sub>1</sub>={y<sub>2<sub>(1)</sub></sub>,y<sub>2<sub>(2)</sub></sub>,...,y<sub>2<sub>(n2)</sub></sub>} .

The Null and alternative hypothesis are: H<sub>0</sub>:  E[y<sub>1</sub>]=E[y<sub>2</sub>]  Vs H<sub>a</sub>:  E[y<sub>1</sub>]&#8800;E[y<sub>2</sub>] 

To test these hypotheses we estimate both means using the sample mean of the data (`yBar1=mean(y1)`, `yBar2=mean(y2)`).  The t-statistic for the test is


`tStat= (yBar1-yBar2)/SE`

where `SE=sqrt(V1+V2)`; here `V1` and `V2` are the variances of each of the means, which are equal to 

`V1=Var[y1]/n1`, `V2=Var[y2]/n2`.

**Type-I error rate**: Recall that the type-I error rate is the probability of rejecting the null given that the null holds (in this case given that the two means are equal).

  - If data is normal, each of the means follow a normal distribution `yBar1~N(mu1, V1)` and `yBar2~N(mu2,V2)`.
  - Thus `(yBar1-yBar2)~N(mu1-mu2, V1+V2)`, which under the null becomes `(yBar1-yBar2)~N(0, V1+V2)`.
  - Furthermore, under the null, the standarized difference (or t-statistic) `(yBar1-yBar2)/SE  ~ t(n1+n2-2)`  or `(yBar1-yBar2)/SE  ~ N(0,1)` if DF is large enough, say>50.
  
  
 What is the type-I error rate if our decision rule is reject if |t-stat|>2?
 
 The probability of having t-stat>2 under the null is `pt(df=DF,q=2,lower.tail=FALSE)`, and the probability of t-stat< -2 is `pt(df=DF,q=-2)`; therefore, considering that the t-distribution is symmetric, the expected type-I error rate is:  `pt(-abs(tStat))*2`.

**Power** Suppose that the true mean-difference is 1. What is the probability that we will reject the Null hypothesis if we use a samples of size n1=30, n2=10, and the variances are Var(y1)=2, Var(y2)=1? 

   
  - Under H<sub>0</sub>, `(yBar1-yBar2)~N(0, 2/30+1/10)`
  - Or`(yBar1-yBar2)/SE~N(0,1)`, where `SE=sqrt(2/30+1/10)`
  - Thus, for a significance of 0.05, the decision rule is to reject if the standarized difference |(yBar1-yBar2)/SE| is greater than 1.96
  - Under H<sub>a</sub> (mean-difference =1) `(yBar1-yBar2)~N(1, 2/30+1/10)`
  - Thus, `(yBar1-yBar2)/SE~N(1/SE, 1)`
  - Therefore, the probability of rejecting under H<sub>a</sub> is `pnorm(mean=1/sqrt(2/30+1/10),sd=1,q=1.96,lower.tail=FALSE)`~0.688. Thus, we have a power (probability) to detect a difference between the two means of 0.688.

## 2) Monte Carlo Methods

Let's verify the power result obtained for the previous problem using simulations. 

```r
 mu1=10; mu2=9
 V1=2; V2=1
 n1=30; n2=10

 nReps=20000 
 reject=rep(NA,nReps)
  
 for(i in 1:nReps){
   y1=rnorm(mean=mu1,sd=sqrt(V1),n=n1)
   y2=rnorm(mean=mu2,sd=sqrt(V2),n=n2)
   SE=sqrt(var(y1)/30+var(y2)/10)
   std_dif=(mean(y1)-mean(y2))/SE
   reject[i]=abs(std_dif)>1.96
 }
 
 mean(reject)
```

#### Type-I error control using p-values

In gypothesis testing, decision rules (e.g., reject if p-value<0.05), are designed to keep the type-I erorr rate below some level. 

Recall that a p-value is the probability of observing a test statistic as extreme or more extreme than  the one we observed given that H0 holds. Intuitevly, a very small p-value tells us that it is very unlikely to observed a test statistic as extreme or more extreme than the one we observe if H0 holds. This can be use as evidence that H0 does not hold. 


**Error control**: If p-values are correct (this depends on whether the assumptions made hold) rejecting in *p-value< a* leads to a type-I error rate equal to *a*. But this is only the case if the assumptions made to derive pvalues hold (at least approximately).


**Type-I error rate and violations of assumptions**:

  - Example 2 simualtes data under Gaussian assumptions, here type-I error rate matches the significance level used for rejection because the p-values we use for rejection are correct.
  - Example 3 uses exponential error terms, here assumptions are violated, thus, with small smaple size, p-values are incorrect and therefore, we do not have adequate type-I error control
  - Finally, Example 4 repeates Example 3 with larger sample size, here, because of the Central Limit Theorem (CLT) the p-values are approximately correct and therefore we have adequate type-I error control.
  

**Example 2**: Type-I error control in the linear model with data simulated under Gaussian assumptions


```r
 
  N=20 # sample size
  nRep=10000 # number of Monte Carlo replicates
   
  pValues=rep(NA,nRep)
  
  for(i in 1:nRep){
      x=rnorm(N)
      y=rnorm(N)  # simulating under the null...
      fm=lm(y~x)
      pValues[i]=summary(fm)$coef[2,4]
  }
  
  reject=pValues<.05 # decision rule
  mean(reject) # since we are simulating under H0 this estimates Type-I error rate
  
```

**Example 3**: Type-I error control in the linear model with non-Gaussian errors and small sample size

```r
 
  N=10 # sample size
  nRep=20000 # number of Monte Carlo replicates
   
  pValues=rep(NA,nRep)
  x=c(rep(0,floor(N/2)),rep(1,N-floor(N/2))) # a dummy variable
  for(i in 1:nRep){
      
      Z=rbinom(N,prob=.5,size=1)
      E=rgamma(n=N,shape=10,rate=4)
      y= ifelse(Z==1,E,-E) # simulating under the null...
      fm=lm(y~x)
      pValues[i]=summary(fm)$coef[2,4]
  }
  
  reject=pValues<.05 # decision rule
  mean(reject) # since we are simulating under Ha this estimates power
  
```

**Example 4**: Type-I error control in the linear model with non-Gaussian errors and larger sample size


```r
 
  N=300 # sample size
  nRep=20000 # number of Monte Carlo replicates
   
  pValues=rep(NA,nRep)
  x=c(rep(0,floor(N/2)),rep(1,N-floor(N/2))) # a dummy variable
  for(i in 1:nRep){
      
      Z=rbinom(N,prob=.1,size=1)
      E=rgamma(n=N,shape=10,rate=4)
      y= ifelse(Z==1,E,-E) # simulating under the null...
      fm=lm(y~x)
      pValues[i]=summary(fm)$coef[2,4]
  }
  
  reject=pValues<.05 # decision rule
  mean(reject) # since we are simulating under Ha this estimates power
  
```


**Type-I error rate and model miss-specifications**:

Model miss-specification is a much more serious problem. For instance, imagine `Y` is affected by `Z`, which is correlated with `X` and suppose we regress `Y` on `X`. `X` does not have an effect but if we miss-specified the model by ignoring `Z`, then we will get inflated type-I error.

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
