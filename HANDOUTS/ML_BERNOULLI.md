
## Example of Maximum Likelihood Estimation in the Bernoulli Model Using Numerical Methods

These scripts illustrate how to estimate the success probability of the Bernoulli distribution using numerical optimization.

In this example, we don't need to use numerical optimization because the ML estimate has a closed form. However, we use this model as an example in a case where we can compare the results obtained through numerical optimization with the analytical solution. For a step-by-step derivation of the log-likelihood and the ML estimate in this model read the first section of this [handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/LogisticRegression.pdf).



#### A sample of Bernoulli IID RVs

To illustrate we will use this data.

```r
  set.seed(195021)
  x=rbinom(size=1,prob=0.2,n=100)

```

#### First, we need to write a function to evaluate the negative-log-likelihood

```r
 negLogLik=function(theta, y){
 	n=length(y)
 	meanY=mean(y)
 	logLik=n*meanY*log(theta)+n*(1-meanY)*log(1-theta)
 	return(-logLik)
 }
```

#### Maximum likelihood estimation using optimize

Then, we use `optimize()` to minimize the negative log-likelihood. This yields the same estimates we would obtain if we maximized the likelihood.

In `optimize()`, `f` is the function to be minimized, `interval` is the interval for the parameter space. Additional arguments to the function are passed with the name given in the function (in this case `y`).

```r
 fm=optimize(f=negLogLik,y=x,interval=c(0,1))

```

#### Using density functions implemented in R


For most problems we can use density-functions implemented in R to evaluate the log-likelihood. The following code returns the Bernoulli log-likelihood for each observation.

```r
 dbinom(x=x,prob=.2,size=1,log=TRUE)
```

Recall that the log-likelihood for the sample is the sum of the log-likelihoods of each of the observations.



```r
negLogLik2=function(y,theta){
	logLik=sum(dbinom(x=y,prob=theta,size=1,log=TRUE))
	return(-logLik)
}

fm2=optimize(f=negLogLik2,y=x,interval=c(0,1))

fm

fm2
```

### Inference

The (large sample) sampling variance of the ML can be approximated using the inverse of the 2nd derivative of the negative log-likelihood (aka the Hessian) evaluated at the ML (i.e., the inverse of Fisher's Observed Information)

The following script illustrates how to obtain the Hessian and, from it, the sampling variance of the ML.

```r

H=hessian(func=negLogLik,y=x,x=fm$minimum)
VAR=1/H
SE=sqrt(VAR)
MLEst=fm$minimum
CI=MLEst+c(-1,1)*1.96*SE[,]

``` 

Note: in this particular problem, the ML has a closed form (`mean(x)`), and the variance of the sample mean is: `VAR=theta*(1-theta)/n`. Let's verify how accurate our variance estimate is.

```r
 VAR
 MLEst*(1-MLEst)/length(x)

```


