
## HW 5 
(**Due** Dec. 3rd in D2L)

## Question 1 (Bootstrap)

The goal of this analysis is to produce an estiamted curve (and confidence bands) relating risk to develop gout by serum urate levels.

Althoug the risk to develop gout may also depend on sex, race and age, for simplicity we will just consider a logistic regression of gout (Y/N)
on serum urate levels.

The following code shows how to fit a logistic regression to the gout outcome using serum urate as predictor. 

To download the data use the following [link](https://github.com/gdlc/STAT_COMP/blob/master/goutData.txt). 

```r

DATA=read.table('~/Dropbox/STATCOMP/2018/goutData.txt',header=T)
DATA$gout=ifelse(DATA$gout=='Y',1,0)

fm=glm(gout~su,family='binomial',data=DATA)

summary(fm)
```

**1.1** Present a plot with the estimated probability of developing gout in the y-axis and serum urate in the x-axis. 

For the serum urate use `SU=seq(from=3,to=12,by=.1)`.  


**1.2** Use bootsrap to estimate a 95% confidence band for the mean curve presented in 1.1. Present a plot with the mean curve in a solid line
and the estimate 95% confidence band in dashed lines.
- Use at least 1,000 bootstrap data sets to estimate the confidence bands,
- Since there are only 30 gout cases, discard bootstrap data sets with less than 5 cases of gout.


## Question 2: estimatin the mean and variance of right-censored gaussian data

The following code simulates right-censored gaussian data.

```r
### Simulation
set.seed(195021)
  n=10000
  mu=2
  v=1
  y=rnorm(n,mean=mu,sd=sqrt(v))
  
  threshold=2.2 # fixed point used for censoring
  isCensored=y>threshold
  
  yCen=y
  yCen[isCensored]=threshold
 
  head(data.frame(isCensored,y,yCen),20)
  plot(yCen~y,col=ifelse(isCensored,'pink','skyblue'));abline(a=0,b=1,col=2,lwd=2)
  abline(v=mean(y),col=4,lwd=2)
  abline(h=mean(yCen),col=4,lwd=2)
 
  # Computing just the mean and the variance of the censored data
  # which contains both time to events and time to censoring
  # leads to biased estimates
```

**2.1** Report a table with the true mean and true variance, 
the sample mean and sample variance of the uncensored data (`y`) and the mean and variance of the censored data (`yCen`).

**2.2** Is the sample mean of the censored data an unbiased estimate of the true mean? Why?

**2.3** Devlop an EM-algorithm to estimate the mean and variance of the data accounting for censoring. 

 - Check the iterations to be sure your algorithm converged.
 - You may use the function below which returns the conditional mean of a censored data-point
 
```r
 # A function to compute the mean of a truncated normal distribution
  meanTN=function(mu,SD,a,b){
  	alpha=(a-mu)/SD
  	beta=(b-mu)/SD
  	K=pnorm(beta)-pnorm(alpha)
  	mean=mu-SD*( dnorm(beta)-dnorm(alpha))/K
  	return(mean)
  }	
 ###
 ```
 
 **2.4**
 Report a table with the true mean and variance, the estimated mean and variance of the uncensored data and the estiamted mean and variance you obtained with the EM-algorithm.
 
 
