### Logistic Regression

The [handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/LogisticRegression.pdf) provides an overview of maximum likelihood in the logistic regression model. Here we present code related to the handout.


In a logistic regression we model the logarithm of the odds log(p/(1-p))  as a linear regression on covariates. Specifically, let *yi* be a 0/1 bernoulli random variable and **xi** a vector of covariates for the ith individual, then we model log(pi/(1-pi))=**xi'b**, where here **b** is a vector of regression coefficients. Solving for the success probability, this yields pi=exp(**xi'b**)/(1+exp(**xi'b**)). We use this to create a funcction to evaluate the negative of the log-liklihood.


<div id="log-likelihood" />

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

**Likelihood profiling**

Consider now a simple intercept model (X is a matrix with one column, all filled with ones, beta is just a scalar)
 

<div id="example-1" />

**Example 1**

```r
 set.seed(195021)
 n=1000
 X=matrix(nrow=n,ncol=1,1)
 b=c(.2)
 eta=X%*%b
 p=exp(eta)/(1+exp(eta))
 y=rbinom(n=n,size=1,prob=p)
```

**Evaluating the log-likelihood over a grid of values of the parameter**

```r
 b_grid=seq(from=.001,to=.999,length=100)
 logLik=rep(NA,length(b_grid))

 for(i in 1:length(b_grid)){
   logLik[i]= -1*negLogLik(X=X,  b=b_grid[i],  y=y)  
 }
 L=exp(logLik)
 plot(L~b_grid,type='l')
 bHat=log(mean(y)/(1-mean(y)))
 abline(v=bHat,col=4,lty=2)
 abline(v=b,col=1,lty=2)
```

Let's consider now an example with an intercept and one predictor. First we simulate data, then w estimate using `glm()` and then using optim.


<div id="example-2" />

**Example 2**

```r
 set.seed(195021)
 n=1000
 X=cbind(1,runif(n))
 b=c(.2,.25)
 eta=X%*%b
 p=exp(eta)/(1+exp(eta))
 y=rbinom(n=n,size=1,prob=p)
```


<div id="glm" />

**Estimation Using GLM**

The `glm()` function can be used to fit generalized linear (fixed effects) models via maximum likelihood.

Discuss options for family and link.

```r
  fm=glm(y~X-1,family=binomial(link=logit))
  summary(fm)
```


<div id="optim" />

**Estimation using optim() and opmtimize()**

The `optim()` and `optimize()` functions can be used to solve optimization problems numerically. `optimize()` is used when there is only one parameter, and `optimize()` is recommended for multiparameter problems.

Briefly, suppose that you wan to minimize a function `f(a,b,c)` that takes three arguments and return a scalar. Our goal is to minmiz `f()` with respect to `b`, with the other arguments fixed at values specified by the user. Assuiming that `b` is a vector, to minimize this function we would call

```r 
  result=optim(fn=f,a=a,c=c,par=initial_values_for_b)
```

In the above call, `optim()` recognizes that `f()` has three arguments and two are provided (`a`, `c`); therefore, `optim()` will minimize `f()` with respect to the argument that was not provided (`b` in the above example). The argument `par` takes initial values for `b`.

The object results will have the values of `b` that minimized `f` at `results$par`, the value of `f()` at `b=results$par`, and a flag for convergence. 

With small differences, the way we use `optimize()` for scalar optimization is very similar.

**Example 1: using optimize for scalar optimization**: The following example minimizes a parabola with respect to `x`, obviously the value of `x` that minimizes the function is `x=a`. Because `x` is scalar we use `optimize()`, this function requires an interval for `x`.


```r
 f=function(x,a){ return(100+(x-a)^2) }
 tmp=optimize(f=f,a=2,interval=c(-1000,1000))
 tmp
```

**Example 2: multi-parameter problems**

We consider now situations where there are multiple uknowns (i.e., `b` is a vector). For this we use `optimize()`, here, instead of an interval we need to provide initial values. In the example below we aim to fit a logistic regression with an intercept and one predictor via maximum likelihood. Therefore, the function to minimize will be the negative-log-likelihood (minimizing the negative log likelihood leads the same result than maximizing the likelhood function). 

Finding reasonalbe intial values is important here. In the context of regression, one possible strategy is assume all regression coefficient equal to zero and then guess the intercept. In linear models we can take `mean(y)` as initial value. In the case of logistic regression, we note that `log(p/(1-p))=mu+x1b1+...`; therefore, if all regression coefficient are equal to zero, we have  `log(p/(1-p))`=mu. This suggest that we can use as initial value for the intercept b0=log(mean(y)/(1-mean(y)). To ease convergence we can also center covariates (all columns of X except the intercept). This make them orthogonal to the intercept and usually helps convergence.

```r
  pHat=mean(y)
  b0Hat=log(mean(y)/(1-mean(y)))
  b.ini=c(b0Hat,0)
  X[,2]=X[,2]-mean(X[,2])
  fm=optim(fn=negLogLik,X=X,y=y,par=b.ini)
  fm2=glm(y~X-1,family=binomial(link=logit))
  cbind(coef(fm2),fm$par)
```


<div id="inference" />

**Inference**

The likelihood function `L(b|X,y)` depends on the data (`y`) and therefore is expected to vary (i.e., be random) over conceptual repeated sampling. Consequently, the ML estimate (i.e., the value of the parameter that maximizes the likelihood) is also expected to vary over conceptual repeated sampling. This is illustrated in the following simulation: 

  - We simulate 100 data sets, 
  - For each data set we evaluate the likelihood over a grid of values of the parametes and display it,
  - We also obtaine, for each data set the MLE (using the simple grid search).
  - Then we approximate the expected value of the ML estimator by averaging the 100 estimates.

```r
  nRep=100
  muHat=rep(NA,nRep) # a vector to store ML estimates
  #grid of values of the parameter
  b.grid=seq(from=-0.2,to=1, by=.01) # grid of values for b
  
  plot(0,col='white',ylab='Likelihood (scaled)',
  xlab='Parameter values',ylim=c(0,1),xlim=range(b.grid))
  
  for(i in 1:nRep){
    # Simulation 
     n=1000
     X=matrix(nrow=n,ncol=1,1)
     b=c(.4)
     eta=X%*%b
     p=exp(eta)/(1+exp(eta))
     y=rbinom(n=n,size=1,prob=p)
     
    # Evaluating the likelihodd
    
     L=rep(NA,length(b.grid))
     for(j in 1:length(b.grid)){
       L[j]= exp(-1*negLogLik(X=X,  b=b.grid[j],  y=y))  
     }
     
     # ML (over the grid)
     muHat[i]=b.grid[which.max(L)]
     
     # scaling (for display purpouse only)
     L=L/abs(max(L))
     lines(L~b.grid,type='l',col=8,lwd=.4)
  }
  abline(v=mean(muHat),col='navyblue',lwd=2,lty=2)
  abline(v=b,col='red',lty=2,lwd=2)
  
```

**Note**: The average ML was very close to the true value (this is related to the bias of the ML, more below). The SD of the estimator over repeated sampling is the SE.

**Sampling (co)variance matrix, SE and p-values**

Under regularity conditions, the large sample distribution of Maximum Likelihood (ML) estimates is Multivariate Normal, with mean equal to the true parameter value (i.e., ML estimates are asymptotically un-biased; however they are not necesarily unbiased in small samples) and a (co)variance matrix equal to the inverse of Fisher's information matrix, which the expected value of the negative of the matrix of the 2nd order derivatives of the log liklihood with respect to the parameters (see handout). For some models, this expectation may not have a closed form or the expectation may depend on the true value of the parameter, which are uknown. Thus, in practice, we use the observed information matrix (OI), which is the matrix of second-order derivatives of the negative log-likelihood evaluated at the observed data (aka the Hessian matrix). This is illustrated in the following example.

```r
  ## Simulation from Example 2
  set.seed(195021)
  n=1000
  X=cbind(1,runif(n))
  b=c(.2,.25)
  eta=X%*%b
  p=exp(eta)/(1+exp(eta))
  y=rbinom(n=n,size=1,prob=p)
  
  # Maximum likelihood estimation
   # negLogLik function
    negLogLik=function(y,X,b){
  	eta=X%*%b  # linear predictor
	theta=exp(eta)/(1+exp(eta)) # success probability
	logLik=sum(ifelse(y==1,log(theta),log(1-theta))) 
        return(-logLik)
   }
   
   # centering covariates to facilitate convergence
   for(j in 2:ncol(X)){ X[,j]=X[,j]-mean(X[,j]) }
  
   # initial values
   b.ini=rep(0,ncol(X))
   b.ini[1]=log(mean(y)/(1-mean(y)))
   
   # optim (use hessian=TRUE to obtain the hessian matrix)
   fm=optim(fn=negLogLik,X=X,y=y,par=b.ini,hessian=TRUE)
  
   # Observed information
   OI=fm$hessian

   # Covariance matrix
   COV=solve(OI)
  
   # compare with glm
   vcov(glm(y~X-1,family='binomial'))

```

**SE, t-statistic & p-values**: 
The SE are simply the square-root of the variances, using this, and using the fact that with large samples, the ML estimator follow normal distributions, we can caluclate p-value for each coefficients. This is illustrated in the following example.

```r
 EST=matrix(nrow=ncol(X),ncol=4,NA)
 colnames(EST)=c('Estimate','SE','Z-stat','p-value')
 EST[,'Estimate']=fm$par
 EST[,'SE']=sqrt(diag(COV))
 EST[,'Z-stat']=EST[,'Estimate']/EST[,'SE']
 EST[,'p-value']=pt(df=length(y)-ncol(X),q=EST[,'Z-stat'],lower.tail=F)*2
```

<div id="LRT" />

**Hipothsis testing when more than 1DF are involved**


If we just want to test one regression coefficient, we can use the t-test described above; however, for more than 1DF test we will typically use either a Likelihood Ratio or Wald test.

**Wald's test**

This test is the same as the one discussed in the context of OLS:
  - Express H0 in linear form Tb=0
  - Under the null, dHat=TbHat follows a multivariate normal distribution with mean 0 and variance covariance matrix TVT', where V=var(b), which can be obtained from the Hessian matrix (see COV, above). Here, bHat are the estimated coefficients from Ha.
  - Therfore, dHat'solve(TVT')dHat ~ dchisq(df=nrow(T))

**Likelihood ratio test**

Once we fitted the model with, say, the glm() function, the log-likelihood, evaluated at the maximum likelihood estiamtes can be obtained by applying the `logLik()` function to the fitted model. For instance,


```r
 fm=glm(y~x1+x2+...,data=....)
 logLik(fm)
```

To implement a likelihood ratio test you will:

 - Fit the null (say H0) and alternative (say HA) hypothesis.
 - Compute the likleihood ratio test statistic
    - LRT=-2[logLik(Ha) - logLik(H0)]
 - Under the null, LRT ~chisq(q) where q is the difference in the number of parameters in H0 and HA, therfore, the p-value is obtained using `d=pchisq(df=q,q=LRT,lower.tail=FALSE)`.
 

[Back to course page](https://github.com/gdlc/stat_comp)  


