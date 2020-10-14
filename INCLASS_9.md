### Maximum Likelihood: Estimation and Inference

The [gout data set](https://raw.githubusercontent.com/gdlc/STAT_COMP/master/goutData.txt) contain information on gout (a common form of inflammatory arthritis) sex, race, age and other covariates.

**1)** Use `optim()` to fit a logistic regression of the form `gout~race+sex+age`. Compare your estimates with those reported by `glm()` for the same regression.

Suggestions: 
 - Convert the gout variable (Y/N) into (1 if Yes, 0 if No gout). 
 - Center all the columns of the incidence matrix (X), except the first one. This makes all predictors orthogonal to the vector of 1s (incidence vector for the intercept)
and thus, it facilitates convergence (not centering predictors do not affect regression coefficients).
 - Initialize the intercetp to `mu=log(mean(y)/(1-mean(y))` and all the other regression coefficients to zero.

**2)** Use optim to obtain estimates and SEs, t-statistics and p-values. Compare your results with those of `summary(glm(gout~race+sex+age,family='binomial',...))`.

Suggestion: see [inference](https://github.com/gdlc/STAT_COMP/blob/master/LogisticRegression.md/#inference) section.

**3**) What are the log-odds for sex and race?

#### Possible Solution


**1)** Estimation

```r
 DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/goutData.txt',header=TRUE)
 DATA$y=ifelse(DATA$gout=="Y",1,0)
 
 # Negative-log(Likelihood)
 negLogLik=function(y,X,b){
   ETA=X%*%b
   PROB=exp(ETA)/(1+exp(ETA))

   # be careful with details, 
   #    - Use log=TRUE (i.e., compute the log-likelihood), 
   #    - LogLik is the sum() of the log-likelihood of each of the data points
   #    - Return -logLik not logLik (by default optim performs minimization)
   
    logLik=sum(dbinom(prob=PROB,size=1,x=y,log=TRUE))
    return(-logLik) 
 }

 X=model.matrix(~race+sex+age,data=DATA)
 
 # Centering facilitates convergence
  for(i in 2:ncol(X)){ X[,i]=X[,i]-mean(X[,i]) }
 yBar=mean(DATA$y)
 Int=log(yBar/(1-yBar)) 
 bIni=c(Int,rep(0,ncol(X)-1))
 fm=optim(fn=negLogLik,X=X,y=DATA$y,par=bIni)
 
 fmGLM=glm(y~X-1,data=DATA,family='binomial')
 
```

**2)** Inference

```r
 # Re-fitting, this times requesting the Hessian matrix
  fm=optim(fn=negLogLik,X=X,y=DATA$y,par=bIni,hessian=TRUE)
  
  bHat=fm$par
  COV=solve(fm$hessian)
  SE=sqrt(diag(COV))
  tStat=bHat/SE
  pVal=pt(q=abs(tStat),lower.tail=FALSE,df=nrow(X)-ncol(X))*2 # two-sided test
  
  EST=cbind('Estimate'=bHat,'SE'=SE,'z-stat'=tStat,'p-value'=pVal)
  rownames(EST)=colnames(X)
  
  round(EST,5)
  
  round(summary(fmGLM)$coef,5)

```

**3)**

In the case of dummy variables, the coefficients can be interpreted as log(OR) where OR are the ratio of the odds of gout
for the group coded by the dummy variable over the odds of the reference group. Therfore; `exp(bHat)` gives an estimate of the odds-ratio. And OR>1 indicates that disease is more likely in the group coded by the dummy variable, relative to the reference category, OR<1 means the opposity. ORs<0.8 or >1.2 are often considered to be an indication of a sizable effect. Although one needs to be careful because when prevalence is very low or very high a huge or very small OR may not imply much in terms of increased/decreased risk.

```r
  exp(bHat[2:3])
```
