### Logistic Regression

In a logistic regression we model the logarithm of the odds log(p/(1-p))  as a linear regression on covariates. Specifically, let *yi* be a 0/1 bernoulli random variable and **xi** a vector of covariates for the ith individual, then we model log(pi/(1-pi))=**xi'b**, where here **b** is a vector of regression coefficients. Solving for the success probability, this yields pi=exp(**xi'b**)/(1+exp(**xi'b**)). 

**The log-likelihood**

```r
  negLogLik=function(y,X,b){
  	eta=X%*%b  # linear predictor
	theta=exp(eta)/(1+exp(eta)) # success probability
	logLik=sum(ifelse(y==1,log(theta),log(1-theta))) 
        return(-logLik)
  }
```

Alternatively, we can compute the log-likelihood using `dbinom`.

```r
  negLogLik2=function(y,X,b){
  	eta=X%*%b  # linear predictor
	theta=exp(eta)/(1+exp(eta)) # success probability
	logLik=sum( dbinom(size=1,prob=theta,x=y,log=TRUE)  ) 
        return(-logLik)
  }
```

Consider now a simple intercept model, (X is a matrix with one column, all filled with ones, beta is just a scalar), obtain ML estimates of beta using your function via grid-search and using optimize. To test your function use the following data

**Small test data set**
```r
 set.seed(195021)
 n=1000
 X=cbind(1,runif(n))
 b=c(.2,.25)
 eta=X%*%b
 p=exp(eta)/(1+exp(eta))
 y=rbinom(n=n,size=1,prob=p)
```
**Estimation Using GLM**

The `glm()` function can be used to fit generalized linear (fixed effects) models via maximum likelihood.

Discuss options for family and link.

```r
  fm=glm(y~X-1,family=binomial(link=logit))
  summary(fm)
```

**Estimation using optim()**

Finding reasonalbe intial values is important here. One possible strategy is assume all regression coefficient equal to zero and then gues the intercept based on the observed proportion of 1s. Note that log(p/(1-p))=x'b; therefore, if all regression coefficient are equal to zero, we have  log(p/(1-p))=b0, where b0 is the intercept. This suggest that we can use as initial value for the intercept b0=log(mean(y)/(1-mean(y)). To ease convergence we can also center covariates (all columns of X except the intercept). This make them orthogonal to the intercept and usually helps convergence.

```r
  pHat=mean(y)
  b0Hat=log(mean(y)/(1-mean(y)))
  b.ini=c(b0Hat,0)
  X[,2]=X[,2]-mean(X[,2])
  fm=optim(fn=negLogLik,X=X,y=y,par=b.ini)
  fm2=optim(fn=negLogLik2,X=X,y=y,par=b.ini) # this one uses dbinom() to evaluate the log-likelihood
  fm3=glm(y~X-1,family=binomial(link=logit))
  cbind(coef(fm3),fm$par,fm2$par)
```
**Inference**

Under regularity conditions, the large sample distribution of Maximum Likelihood (ML) estimates is Mulrivariate Normal, with mean equal to the true parameter value (i.e., ML estimates are asymptotically un-biased; however they are not necesarily unbiased in small samples) and a (co)variance matrix equal to Fisher's information matrix, which the expected value of the matrix of the 2nd derivatives of the log liklihood, that is: **I(theta)=E[d2l/d theta,d theta']**.


[Back to course page](https://github.com/gdlc/stat_comp)  


