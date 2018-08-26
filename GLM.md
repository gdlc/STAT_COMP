# Generalized linear models (GLM)

### Logistic Regression

 In a logistic model, the outcome is commonly on one of three scales:

- Log odds (also called logits), which is the linearized scale

- Odds ratios (exponentiated log odds), which are not on a linear scale

- Probabilities, which are also not on a linear scale

Specifically, let *yi* be a 0/1 bernoulli random variable and **xi** a vector of covariates for the ith individual, then we model log(pi/(1-pi))=**xi'b**, where here **b** is a vector of regression coefficients. Solving for the success probability, this yields pi=exp(**xi'b**)/(1+exp(**xi'b**)). 

**Suggested Excercise**. Develop an R-function to evaluate the log-likelihood of a logistic regression. As a template for the function you can use the following

```r
  negLogLik=function(y,X,b){
  	eta=X%*%b
	theta=exp(eta)/(1+exp(eta))
	logLik=sum(ifelse(y==1,log(theta),log(1-theta)))
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

The `glm()` function can be used to fit generalized linear (fixed effects) models via maximum liklihood.

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
  glm(y~X-1,family=binomial(link=logit))$coef
```








[Back](https://github.com/gdlc/STAT_COMP/)
