 

## Using the EM-algorithm to fit mixture models

The following [handout](https://github.com/gdlc/STAT_COMP/blob/master/FittingFiniteMixturesWithEM.pdf) describes the model and the algorithm implemented below.


**Simulating data from a mixutre with 2 components**

```r
## Simulation
 mu0=1:2
 sd0=c(.3,.5)
 prob0=c(.6,.4)

 n=1000
 group0=sample(1:length(mu0),size=n,replace=T,prob=prob0)
 y=rnorm(n=n,mean=mu0[group0],sd=sd0[group0])

# Empirical density
 fittedDensity=density(y)
 plot(fittedDensity)

```


**A function to fit a k-component mixture of Gaussians using the EM-algorithm**


```r

fitMixture=function(y,nComp,nIter=100){ 
 n=length(y)
 PROBS=matrix(nrow=n,ncol=nComp,0)
 
 # assigning observations to groups based on quantiles
 tmp=quantile(y,c(0,1:nComp/nComp))
 z=as.integer(cut(y,breaks=tmp))
 for(i in 1:n){
  PROBS[i,z[i]]=1
 }  
   
 mu=rep(NA,nComp)
 SD=rep(NA,nComp)
 alpha=rep(NA,nComp)
 
 ## Iterations
 for( i in 1:nIter){
	# M-step maximizes a weighted log-likelihood 
	K=sum(PROBS)
	for(j in 1:nComp){
		Nj=sum(PROBS[,j])		
		mu[j]=sum(y*PROBS[,j])/Nj		
		eHat=(y-mu[j])*sqrt(PROBS[,j])		
		vHat=sum(eHat^2)/Nj
		SD[j]=sqrt(vHat)
		alpha[j]=sum(PROBS[,j])/K
	}

	# E-step finds the probability that each observation belongs to each group	
	for(j in 1:nComp){
		PROBS[,j]=dnorm(y,mean=mu[j],sd=SD[j])*alpha[j]
	}
	# normalization 
	tmp=rowSums(PROBS)
	for(j in 1:nComp){
		PROBS[,j]=PROBS[,j]/tmp
	}		   
 }
 ANS=list(MEANS=mu,SD=SD,alpha=alpha,PROBS=PROBS)
 return(ANS)
}
 
```

**Parameter estimation usinng EM**

```
 fm=fitMixture(y,nComp=2)
```

**A function to evaluate the density **

```r
 mixtureDensity=function(x,mu,sd,prob){
   n=length(x)
   f=rep(0,n)
   nComp=length(mu)
   for(i in 1:nComp){
     f=f+prob[i]*dnorm(x,mean=mu[i],sd=sd[i]) 
    }
   return(f)
 }
```
**Displaying results**

```r
 # plots
 x=seq(from=min(y),to=max(y),length=1000)
 f_true=mixtureDensity(x,mu=mu0,sd=sd0,prob=prob0) # the true density
 f_ML=mixtureDensity(x,mu=fm$MEANS,sd=fm$SD,prob=fm$alpha) # the density evaluated at the ML estimates of the parameters
 plot(f_true~x,col=2,type='l')
 lines(x=x,y=f_ML,col=4,lty=2)
```
**Using EM for clustering?**

The EM algorithm also renders estimates of the probability of each observationg of belonging to each of the mixture's components. This information can be used for clustering.

```r
  apply(FUN=which.max,X=fm$PROBS,MARGIN=1)
  
```

[INCLASS_10]()

[Back](https://github.com/gdlc/STAT_COMP/)
