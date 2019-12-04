
## HW 5 
**Due** Dec. 4th in D2L + printed copy in class the same day.

## Question 1 (Bootstrap)

**Objective**: to estimate a risk curve (and confidence bands) for gout as a function of serum urate.

Althoug gout risk may also depend on sex, race and age, for simplicity we will just consider a logistic regression of gout (Y/N)
on serum urate levels. The following code shows how to fit a logistic regression to the gout outcome using serum urate as predictor. 

To download the data use the following [link](https://github.com/gdlc/STAT_COMP/blob/master/goutData.txt). 

```r

DATA=read.table('~/Dropbox/STATCOMP/2018/goutData.txt',header=T)
DATA$gout=ifelse(DATA$gout=='Y',1,0)

fm=glm(gout~su,family='binomial',data=DATA)

summary(fm)
```



**1.1** Present a plot with the estimated probability of developing gout in the y-axis and serum urate in the x-axis. 

In the plot display predicted risk for the serum urate levels: `SU=seq(from=3,to=12,by=.1)`.  

**1.2** Use bootsrap to estimate a 95% confidence band for the mean curve presented in 1.1. Present a plot with the mean curve in a solid line and the estimate 95% confidence band in dashed lines.
- Use at least 1,000 bootstrap data sets to estimate the confidence bands,
- Since there are only 30 gout cases, discard bootstrap data sets with less than 5 cases of gout.



## Question 2: Permutation

Joe wants to test weather a the population correlation of y and x is different than zero.

Data consist of a pair of vectors, x and y. 

The proposed test statistic is: reject H0 if the absolute value of the sample correlation (i.e., `abs(cor(x,y))`) is greater than 0.1.

The data available is give below.

```r
 x<-c(0.634,-0.2119,0.5573,-0.1496,0.9057,-1.1871,0.6196,1.0978,1.2734,3.6887,0.7271,1.0695,0.0092,2.7288,2.2511,
       -0.4604,2.2568,0.6934,1.4057,0.6835,0.022,0.779,3.6794,0.0549,0.4713,-0.1583,1.7813,
       1.021,2.2305,2.3341,0.2757,0.1429,0.945,-0.5404,0.8633,1.5886,1.1324,-0.0488,1.0846,
       -0.0329,0.0914,1.7145,1.0102,0.212,0.2591,0.163,2.9892,0.1436,1.4092,2.5441,1.9485,
       1.7708,-0.1758,-0.4029,0.7764,0.6944,2.384,0.8131,0.8842,-0.0683,0.2312,1.0394,
       2.8581,0.5689,0.4849,2.0361,3.5297,0.5002,0.8305,1.4896,0.0651,-0.4312,0.5889,0.5881,-0.08,
       1.9153,1.6418,0.375,-0.3963,1.2148,0.9178,0.5538,0.742,-0.298,0.8876,
       0.267,0.3064,1.0215,0.2846,0.8067,0.1886,0.674,0.0438,0.6449,0.7669,
       0.5705,0.1712,0.291,1.0395,-0.3946)
  
 y<-c(0.99,-1.414,-0.175,-1.2016,-0.5451,-2.4346,0.8572,2.1505,1.0321,-0.5873,1.0554,-1.472,-0.4566,-0.3953,-0.5922,
      -1.2084,-0.6361,0.6896,-0.6128,-0.4068,-0.6627,-1.379,2.2171,-0.2956,0.7176,-0.5751,-0.2126,1.0235,
      0.1804,0.8917,0.2317,-0.9527,-0.4074,-1.5784,1.5088,1.9565,0.624,-1.1149,0.3273,-0.6217,-1.2779,-0.3181,0.373,0.1012,
      0.1076,-0.2733,2.3347,0.0482,-1.8307,0.8342,-0.5809,0.8359,-0.4145,-1.3119,-0.3743,0.5917,0.6753,1.5999,0.4179,
      -0.8108,0.0278,0.576,1.8718,-0.5622,0.5405,-0.3566,0.7039,0.9494,-0.9232,0.8041,-0.3757,-1.1262,-0.0313,0.8664,
      -0.7742,0.181,-0.6513,-0.6487,-1.0154,-0.9262,-0.1505,-0.1987,0.4892,-2.3308,0.5141,-0.2912,-0.0993,1.7827,
      -0.6219,1.5431,0.2213,0.8707,-1.2091,-0.0553,-0.9392,1.037,-0.5226,0.014,-0.5306,-1.6497)
      
```

Use a 10,000 permulations of the data presented above to estimate the type-I error rate of the proposed rule.

**Report**: the estimated type-I error rate.

## Question 3: EM-algorithm

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

```

**3.1** Report a table with the true mean and true variance, 
the sample mean and sample variance of the uncensored data (`y`) and the mean and variance of the censored data (`yCen`).

**3.2** Is the sample mean of the censored data an unbiased estimate of the true mean? Why?

**3.3** Devlop an EM-algorithm to estimate the mean and variance of the data accounting for censoring. 

**Outline of the steps needed**:
 - Derive the maximum likelihood (ML) estimates of the mean and variance for the complete data (assuming data is IID normal). You will use these functions in the M-step to update your ML estimates.
 - Since the data follows a distribution from the exponential family, the E-step reduces to impute the censored data with the conditional expectation, you can use the function below to perform the E-step.
 
Hint: The outline of the algorithm is similar to the one we discuss in class for the censored exponential data. The only difference is on what are the ML estimates from the complete data and what is the conditional expectation of the censored data. For the conditional expectatio you can use the function given below.

**Report**: a trace plot (i.e., a plot of the parameter values over the iteration path) for the mean and one for the variance (this can be used to assessed convergence).

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
 
 **3.4**
 Report a table with the true mean and variance, the estimated mean and variance of the uncensored data and the estiamted mean and variance you obtained with the EM-algorithm.
 
 
 
 ## Proposed solutions
 
 ### Question 1

```r
DATA=read.table('~/Dropbox/STATCOMP/2018/goutData.txt',header=T)
DATA$gout=ifelse(DATA$gout=='Y',1,0)
fm=glm(gout~su,family='binomial',data=DATA)
x=seq(from=3,to=12,by=.1)
y=predict(fm,newdata=data.frame(su=x),type='response') 
LP=coef(fm)[1]+x*coef(fm)[2]
risk=exp(LP)/(1+exp(LP))
plot(risk~x,type='l',lwd=2,col=2,ylab='Riks',xlab='Serum Urate',ylim=c(0,.7))
```

```r
nRep=2000
RISK=matrix(nrow=length(x),ncol=nRep,NA)
N=nrow(DATA)
counter=0
for(i in 1:nRep){

 TMP=DATA[sample(1:N,size=N,replace=T),]
 if(sum(TMP$gout)>=5){
   counter=counter+1
   fmB=glm(gout~su,family='binomial',data=TMP) #fit the model using the bootstrap data
   riskB=predict(fmB,newdata=data.frame(su=x),type='response')
   lines(x=x,y=riskB,lwd=.5,col='skyblue')
   RISK[,counter]=riskB
 }
 
}

# Computing Quantiles
RISK=RISK[,1:counter]
counter
LB=apply(FUN=quantile,prob=.025,X=RISK,MARGIN=1)
UB=apply(FUN=quantile,prob=.975,X=RISK,MARGIN=1)
lines(x=x,col=2,lwd=2,lty=2,y=LB)
lines(x=x,y=predict(fm,newdata=data.frame(su=x),type='response'),lwd=2,col=4)
lines(x=x,lwd=2,lty=2,y=UB,col=2)
abline(h=mean(DATA$gout))

```

### Question 2

```r
 ABS_COR=rep(NA,10000)
 for(i in 1:10000){
  ABS_COR[i]=abs(cor(y,sample(x,size=length(x),replace=F)))
 }
 mean(ABS_COR>0.1) #More than 0.3!
```


### Question 3

 ## 3.1
 
 ```r
 TMP=rbind(c(mu,v),c(mean(y),var(y)),c(mean(yCen),var(yCen)))
 colnames(TMP)=c('Mean','Variance')
 rownames(TMP)=c('True','Est(y)','Est(yCen)')
```

## 3.2

 The sample mean of the censored data comptued without accounting for censoring is biased.
 
## 3.3


TBD in class.
