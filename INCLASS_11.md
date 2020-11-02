### IN-CLASS 11: Univariate distributions

Produce R-code to obtain the following probabilities

**1)** X follows a Normal distribution with mean 10 and variance 4. Evaluate the following probabilities:
   - P(X<8)
   - P(X>11)
   - P(8<X<11)
   
```r
 pnorm(mean=10,sd=2,q=8) # note: by default, lower.tail=TRUE (i.e., cdf)
 pnorm(mean=10,sd=2,q=11,lower.tail=FALSE)
 pnorm(mean=10,sd=2,q=11,lower.tail=FALSE)-pnorm(mean=10,sd=2,q=8)
```

**2)** For the same RV X, we produce a linear transformaton Z=(X-10)/2. Compute the following probabilities
   - P(Z< -1)
   - P(Z> 1/2)
   - P( -1 < X < 1/2)

```r
 pnorm(q= -1)
 pnorm(q= 1/2,lower.tail=FALSE)
 pnorm(q= 1/2,lower.tail=FALSE)-pnorm(q= -1)
```

**3)** Let Z1, Z2,...,Zp be IID Bernoulli random variables with success probability 0.07. Now let X=Z1+Z2+...+Zn. Compute and report the following probabilities for `n=[10,20,30]`

  - P(X=3)
  - P(X>3)
  - P(X<3)
  - P(X<=3)
  - Verify that P(X<=3)+P(X>3)=1

```r
 prob=0.07
 n=c(10,20,30)
 
 # P(X=3)
  dbinom(x=3,p=prob,size=n[1])
  dbinom(x=3,p=prob,size=n[2])
  dbinom(x=3,p=prob,size=n[3])

  # P(X>3)   
  # Note: pbinom() evauates P(X<= q) if lower.tail=TRUE, else P(X>q) if lower.tail=TRUE
  pbinom(q=3,p=prob,lower.tail=FALSE,size=n) # if you use 3, 3.5,...,3.99 you should get the same value
  
  # P(X<=3)
  pbinom(q=3,p=prob,lower.tail=TRUE,size=n) 
  
  # P(X<3)
  pbinom(q=2,p=prob,lower.tail=TRUE,size=n) (any number in [2,3) )
  
  # P(X<3)+P(X>=3)=1
  pbinom(q=3,p=prob,lower.tail=TRUE,size=n) + pbinom(q=3,p=prob,lower.tail=FALSE,size=n)
```

**4)** The Poisson Distribution is used for count variables (i.e., variables that can take values 0, 1, 2,...) and can be viewed as an 
approximation to the Binomial distribution when the success probability of each of the Bernoulli trials is small and the number of trials is large. 
The distribution has a signle parameter (labmda) which is both the expected value and the variance of the RV. 

Use R to generate 10,000 draws from Binomial and Poisson, for a RV X which is the sum of 50 Bernoulli trials, each with success probability 0.05. Hint: for the Poisson simulation set lambda to be the expected value of the Binomial RV.
Compare the results of both simulations using table(X).

```r
 nTrials=50
 nSamples=10000
 prob=0.05
 
 # A matrix with iid Bernoulli
 Z=matrix(nrow=nSamples, ncol=nTrials,data=rbinom(size=1,n=nTrials*nSamples,prob=prob))
 X=rowSums(Z) # these are then binomial.
 
 #Note: the two previous steps should yield results equivalent to rbinom(size=50,...), let's verify
 X2=rbinom(size=50,n=nSamples,prob=prob)
 
 # Now Poisson
 X3=rpois(n=nSamples, lambda=prob*nTrials)
 
 par(mfrow=c(3,1))
 hist(X,50)
 hist(X2,50)
 hist(X3,50)
 
 round(cbind(table(factor(X,levels=1:12)),table(factor(X2,levels=1:12)),table(factor(X3,levels=1:12)))/nSamples,3)

```

**5)** The estimated regression coefficient for the effect of education in wages in a linear model (b) that included an intercept and 5 other predictors was 0.83 and the SE was 0.45. Compute the p-value for testing the following hypothes

   - H0: b=0 Vs Ha: b different than 0
   - H0: b=0.5 Vs Ha: b>0.5
   
Counduct the test assuming that b follows a normal distribution first, and then using a t-distribution for (b-b0)/SE using df=20.

```r
  tStat=0.83/0.45
  
  # two-sided p-value 
  2*pt(df=20,q=abs(tStat),lower.tail=FALSE)
  
  # One-sided
  pt(df=20,q=tStat,lower.tail=FALSE)
```


**6)** In a likelihood ratio test the likleihood ratio test statistic is equal to `-2*{ logLik(H0)- logLik(HA)}` where 
`logLik(H0)` and
`logLik(HA)` are the log-likelihoods of the null and alternative hypothesis, respectively.

Compute the p-value for the likelihood ratio test between H0 and Ha in the example below. Compare your result with `anova(H0,HA)`.

```r
 DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/wages.txt',header=TRUE)
 str(DATA) # inspect the types of each variable! Do variables have the correct type?

 HA=lm(Wage~Education+Sex+Union+Region+Ethnicity,data=DATA)
 H0=lm(Wage~Education+Sex+Union+Region,data=DATA)
 # Use logLik() to obtain the log-likelihood for each model
```

```r
 CHISQ=as.numeric(-2*(logLik(H0)-logLik(HA)))
 pchisq(q=CHISQ,lower.tail=FALSE,df=length(coef(HA))-length(coef(H0)))
 
```

**7)** Use `pf()` To obtain the p-value for the above test using an F-test (recall our discussion about ANOVA, compute RSS(HA), RSS(H0), the SS of the model is RSS(H0)-RSS(HA), the residual sum of squares is RSS(HA), the residual DF is..., compute the MS of the model and of the residuals, then compute the ratio of the two, and use `pf()` to get the p-value..

```r
 RSS=sum(residuals(HA)^2)
 MSS=sum(residuals(H0)^2)-RSS
 rss.df=nrow(DATA)-length(coef(HA))
 model.df=length(coef(HA))-length(coef(H0))
 
 MSRes=RSS/rss.df
 MSReg=MSS/model.df
 FStat=MSReg/MSRes
 pf(q=FStat,df1=model.df,df2=rss.df,lower.tail=FALSE)
 
 # compare with
  anova(HA,H0)

```
**8)** In a meeting involving 100 people there are three people infected with COVID-19. You are suceptible, you participate in the meeting, and have close contacts with 4 individuals. What is the probability that you contract  COVID-19 assuming that the probability of contracting the disease from a close contact between an infected and a suceptible individual is 1?

**First approach**: Assume an infinite large population, and consider 4 Bernoulli trials with 'success' probability equal to prevalence (3/100). Compute the probability that X>=1.

```r
 prev=3/99 # 3 of 99 people are infected
 
 # Probability of no close contact
 pNotInf=(1-prev)^4 # (1-prev) is the probability 
 
 # Probability of at least 1 contact with an infected person (~11.6%)
 1-pNotInf
```


**A better approach**: Use the [hypergeometric](https://en.wikipedia.org/wiki/Hypergeometric_distribution) distribution. The distribution is implemented in R by the [\*hyper()](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/Hypergeometric.html) family.

Our 'urn' has 3 infected and and 97 (100-3) healty people, you have contact with 4 of them, the probability that at least one of 
the four was infected is 
```r
 
 1-dhyper(x=0,k=4,m=3,n=96) #dhyper(x=0, ...) gives here the probability of zero contact with an infected person

```
 
