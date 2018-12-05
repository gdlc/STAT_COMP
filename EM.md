# Expectation-Maximization (EM) Algorithm examples


## (1) Estimating the rate parameter of an exponential distribution using right-censored data


**Simulating right-censored exponential data**

```r
set.seed(195021)
 n=100
 y=rexp(n=n,rate=4)
 # let's consider fixed censoring time
 d=y<0.3 # TRUE here indicate event and FALSE right-censored
 
 yCen=y; yCen[!d]=0.3 # this is the data we observe 
```

**EM-algorithm**

```r
lambda=rep(NA,10) # a vector to store estimates iterations
 lambda[1]=1/mean(y[d]) # initial value (estimate ignoring censoring)
 completeData=y  # this vector stores the 'complete' data
 for(i in 2:length(lambda)){
    # E-step
    completeData[!d]=y[!d]+1/lambda[i-1]
    # M-step
    lambda[i]=1/mean(completeData)
 }
 round(1/lambda,3)

```

## (2) Finite Mixture Model

**Simulating data from a finite mixutre with 3 components**

```
 # parameters that define the mixture model
 mu0=1:3
 sd0=c(.3,.3,.5)
 prob0=c(.5,.4,.1)
 
 trueDensity=function(x,mu,sd,prob){
   f=prob[1]*dnorm(x,mean=mu[1],sd=sd[1]) +
     prob[1]*dnorm(x,mean=mu[2],sd=sd[2]) +
     prob[1]*dnorm(x,mean=mu[3],sd=sd[3])  
   return(f)
 }

## Simulation
nb=1000
group0=sample(1:length(mu0),size=n,replace=T,prob=prob0)
y=rnorm(n=n,mean=mu0[group0],sd=sd0[group0])

# Empirical density
fitDen=density(y)
plot(fitDen,lwd=2,col=4,ylim=c(0,.6))
lines(x=fitDen$x,y=trueDensity(fitDen$x,mu=mu0,sd=sd0,prob=prob0),col=2)

x=seq(from=0,to=4,length=1000)
f=trueDensity(x,mu=mu0,sd=sd0,prob=prob0)
plot(f~x,col=2,type='l')

```


**EM-algorithm**


```r


```


[Back](https://github.com/gdlc/STAT_COMP/)
