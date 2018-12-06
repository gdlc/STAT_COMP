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

```r
 # parameters that define the mixture model
 mu0=1:3
 sd0=c(.1,.2,.2)
 prob0=c(.4,.4,.2)
 
 trueDensity=function(x,mu,sd,prob){
   f=prob[1]*dnorm(x,mean=mu[1],sd=sd[1]) +
     prob[2]*dnorm(x,mean=mu[2],sd=sd[2]) +
     prob[3]*dnorm(x,mean=mu[3],sd=sd[3])  
   return(f)
 }

## Simulation
n=1000
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
# Initial values
 PROBS=matrix(nrow=n,ncol=3)
 PROBS[,1]=ifelse(y<quantile(y,prob=1/3),.8,.1)
 PROBS[,2]=ifelse((quantile(y,prob=1/3)<y)&(y<quantile(y,prob=2/3)),.8,.1)
 PROBS[,3]=ifelse(y>quantile(y,prob=2/3),.8,.1)
 
 mu=rep(NA,3)
 SD=rep(NA,3)
 alpha=rep(NA,3)
 
 ## Iterations
 nIter=100

 for( i in 1:nIter){
	# M-step maximizes a weighted log-likelihood 
	K=sum(PROBS)
	for(j in 1:3){
		Nj=sum(PROBS[,j])		
		mu[j]=sum(y*PROBS[,j])/Nj		
		eHat=(y-mu[j])*sqrt(PROBS[,j])		
		vHat=sum(eHat^2)/Nj
		SD[j]=sqrt(vHat)
		alpha[j]=sum(PROBS[,j])/K
	}

	# E-step finds the probability that each observation belongs to each group	
	for(j in 1:3){
		PROBS[,j]=dnorm(y,mean=mu[j],sd=SD[j])*alpha[j]
	}
	# normalization (not strictly needed)
	tmp=rowSums(PROBS)
	for(j in 1:3){
		PROBS[,j]=PROBS[,j]/tmp
	}		   
 }
 
 # Maximum likelihood estimate of the density function
 fHat=trueDensity(x,mu=mu,sd=SD,prob=colSums(PROBS)/n)
 lines(x=x,y=fHat,col=4)
```

**Suggested Tasks**:

   * Change the mixture proportions, or increase the variances of the mixutre components and evaluate the behavior.
   
   * Using the parameter values used above desing a monte-carlo study to estimate the expected value of f(x=1.5) and its sampling variance. (Hint: repeat the above simulation 1000 times, each time will render a maximum likelihood estimate of the density (fHat above), evaluate the fitted density for x=1.5, sotre the result. The average of the estimated density values (across MC samples) and the variance of the estiimated values porvide estimates of the expected vlaue of the estimator and its sampling variance. Is the estimate unbiased?
   
   
[Back](https://github.com/gdlc/STAT_COMP/)
