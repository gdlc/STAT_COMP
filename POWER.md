### Power, Type-I error rate and Flase Discovery Rate


Consider testing a hypothesis (e.g, in a linear model `y=mu+b*x+e`, H0: b=0 Vs Ha: b!=0). 

This hypothesis may or may not hold  (rows in the table below), and our decision may be to reject it or not to reject it (columns). The table below classifies each of the four possible cases we can encounter regarding the state of nature and our decision:


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

The expected value of these proportions gives the Type-I error rate, false discovery rate and power of our experiment/test, resepectively:
 
   - Type-I error rate: P(reject|H0 holds)=E[N2/(N1+N2)]
   - Power:  P(Reject|Ha)=E[N4/(N3+N4)]
   - False discovery rate (FDR): E[N2/(N2+N4)]

In simple cases (e.g., comparison of two means) power and Type-I error rate can be computed anlythically. However, for more involved tests, anlythical derivations are not always available. In these cases we can estimate the above quantities using Monte Carlo simulations. The underlying idea is to replicate the process of (conceptual) repeated sampling from the population for a verylarge number of times so that the empirical proportions provide a good approximation to the underlying probabilities (or expected rates). The example below illustrates how to estimate power, FDR and type-I error rate for a simpe linear regression model.



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

**Example of anwser**

  
 ```r
  
  R2=c(0,.01,.03,.05,.1) # Model R-sq.
  N=c(10,20,30,50,100) # sample size
  
 countRejections=matrix(nrow=length(R2),ncol=length(N),0) # We count rejections for every scenario
 rownames(countRejections)=paste0("R-sq=",R2)
 colnames(countRejections)=paste0("N=",N)
 
  
  nRep=10000 # number of Monte Carlo replicates
  significance=0.05 # significance for rejection
   
  for(h in 1:length(N)){ # loop for sample size
    n=N[h]

  	for(i in 1:length(R2)){ # loop over values of R-squared
      r2=R2[i]
      b=sqrt(r2)
      for(j in 1:nRep){ # Monte Carlo replicates
        x=rnorm(n)
        signal=x*b
        error=rnorm(sd=sqrt(1-r2),n=n) 
        y=signal+error
        fm=lsfit(y=y,x=x) # equivalent to lm (i.e., fits model via OLS) but faster
        reject=(ls.print(fm,print.it = F)$coef[[1]][2,4]<significance) 
        countRejections[i,h]=countRejections[i,h]+reject # TRUE is interpreted as 1 and FALSE as 0
      }  
    }
}


RR=countRejections/nRep

## displaying results in a power plot
plot(RR[,1],x=R2,type="o",ylim=c(0,1))
for(i in 2:length(N)){
     lines(x=R2,y=RR[,i],col=i)
     points(x=R2,y=RR[,i],col=i)
}


```     
   
    
**In-class 2**:
  
Let `x=mu+z` where `z~N(0,1)`. 

Our objective is to test H0: mu=0 Vs Ha: mu!=0.  

The proposed test-statistic is the sample mean and the decision rule is **reject H0 if |mean(x)|> 0.3**.

(1) Develop code to esitmate rejection rate for the above model and N=10, under alternative hypothesis mu=c(0,.3,0.5,0.7,1,2).


(2) Report the Type-I error rate and power of the test.


We collect data `x1,...,xn`, compute the sample mean `mX=mean(x)` and 


## Are p-values always correct?


In the previous examples we simulated data under normal assumptions and when rejecting at `p-value=0.05` the empirical type-I error rate was also 0.05. This happens because the assumptions used by `lm` when computing p-values hold; therefore, the reported `p-values` are correct and thus, if you reject at `0.05` type-I error rate will be 0.05. However, this only happens when the assumption hold. When the assuimptions do not hold the `p-values` may be incorrect, meaning that rejecting at alpha=0.05 or alpha=0.01, may yield higher (or smaller, depending on the problem) type-I error than the one specified by alpha. We illustrate this in the following examples.


**Uniformly distributed error terms**

The following examples uses uniformly distributed error terms.  Eventhough the errors are not normal, even with very small sample size, the type-I error rate is close to the desired significance level (alpha). This happens because eventhough data is not normal, the estimator (the sample mean in this case)  follows approximately a normal distribution (the assumption made by lm). This is an applicaiton of the Central Limit theroem and we see that for this simple problem even with very small sample size the required assumptions hold  (approximately).
```r
  #MODEL: y=mu+e; instead of using normal residuals we will try uniform and other distributions.... 
  mu=0 # to estimate type-I error rate we sumulate under the null
  n=10 
  countRejections=0
  nRep=50000
  alpha=0.05
  
  for(i in 1:nRep){
   y=mu+runif(min=-1,max=1,n=n)
   fm=lm(y~1)
   pValue=summary(fm)$coef[1,4]
   reject=pValue<alpha
   countRejections=countRejections+as.integer(reject)
  }
  countRejections/nRep
```

**Non-symmetric errors**

Non-symetric errors are a bit more problematic.... In the following example we sample errors from an exponential distribution. The empirical type-I error rate is almost twice the desired error rate...


```r
  #MODEL: y=mu+e; instead of using normal residuals we will try uniform and other distributions.... 
  mu=0 # to estimate type-I error rate we sumulate under the null
  n=10 
  countRejections=0
  nRep=50000
  alpha=0.05
  
  for(i in 1:nRep){
   error=rexp(rate=1,n=n)-1
   y=mu+error # the expected value of an exponential RV is the rate, we need zero-mean residuals...
   fm=lm(y~1)
   pValue=summary(fm)$coef[1,4]
   reject=pValue<alpha
   countRejections=countRejections+as.integer(reject)
  }
  countRejections/nRep
```

