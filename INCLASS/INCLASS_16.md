
## Permutation analysis in multiple testing problems

Many problems involve testing multiple hypothesis. For example, in a linear model of the form `Y=a+X1b1+X2b2+X3b3+E` we may want to test: H01: b1=0 vs HA1: b1!=0, H02: b2=0 vs HA2: b2!=0, and H03: b3=0 vs HA2: b3!=0 (note that here we are testing three hypothesis, this is different than testing  H0: b1=b2=b3=0 vs HA: at least one of the b's different than zero).

A Type-I error rate occurs when we reject a null that holds. In multiple testing, a standard approach is to control the probability of making at least one mistake (i.e., wrongly rejecting one ore more null that holds). Although not commonly used, we could try to control the probability of making k msitakes (e.g., k=2).

How do we use permutations to control the probability of making at least k mistakes? 

The procedure is as follows:

  1) Generate a permutation data set,
  2) Evaluate the test statistics associated with each of the hypothesis being tested
  3) Sort the test statistic from strongest to weakest evidence (e.g., sort pvalus from smallest to largest).
  4) Copy and sorte the value of the kth statistic. In the permuted data set all the nulls hold; therefore, if you reject using the value of the keth statistic you will be making k mistakes.
  5) Repeat 1-4 a large number of times, always saving the value of the kth ordered test statistic.

After completing the above steps you will have a vector holding values of the kth ordered statistic, you can regard that vector as a sample from the sampling distribution of the kth statistic. If you want to control the probability of making k mistakes at the 0.05 level, then choose the 0.05 empirical percentile as your threshold for rejection.

## Task

Use the following symulated data set to estimate using permutations the threshold that you should use to control the probability of making at least 1 mistake smaller or equal than 0.1.

**Simulation**

```r 
 set.seed(1950)
 X=matrix(nrow=1000,ncol=50,rbinom(size=2,n=50000,prob=0.2))
 tmp=runif(50)>0.9 # determining ~ 10% of predictors with non zero effect
 b=rnorm(50)
 b[!tmp]=0
 signal=scale(X%*%b)*sqrt(0.2)
 error=rnorm(nrow(X),sd=sqrt(0.8))
 y=signal+error
 fm=lm(y~X)
 pval=summary(fm)$coef[-1,4]
 plot(-log10(pval),col=ifelse(tmp,2,8))
```

- Use the above simulation and  5000 permuations to estimate the threshold that you should use to control the probability of making at least   one mistake smaller or equal than 0.1.

- How many hypothesis would you reject if you apply that threhold to the original data set (without permuting it)?

