
### (1) Power & Type-I error rate

Consider a single test for which there are two possible states of nature (H0 or Ha) and two possible decisions (reject/do not reject, **Table 1**). Suppose we repeat our experiment a large number of times. The proportion of false discoveries is N2/(N1+N2) and the proportion of true discoveries is N4/(N3+N4). Using these proportions we can define the following probabilities 

   - Type-I error rate: P(reject|H0 holds)=E[N2/(N1+N2)]
   - Power: P(Reject|Ha)=E[N4/(N3+N4)]
   
In hypothesis testing we tune our decision rule to control Type-I error rate at a low level (say <0.05)l. Recall that p-values are estimates of the probabilities of rejecting given that the nul is true; if p-values are correct and we conduct a signle test rejecting if the p-value is smaller than 0.05 we expect a 5% Type-I error rate. 

**Table 1**: Classification of decisions in hypothesis testing.

|           | Do not reject H0  | Reject H0          |
|-----------|-------------------|---------------------|
| H0 holds  | True Negative (N1) | False Positive (N2)|
| Ha holds  | False Negative (N3)| True positive (N4) |

### (2) Family-wise error rate

Consider now a problem involving testing two independent hypothesis (H01 and H02). If we reject each of them at \alpha=0.05.

#### Bonferroni adjustment


#### Holm's method


### (3) False Discovery rate


#### Distribution of p-values under H0 and under Ha


**A toy-simulation**

```r
  N=100 
  p=50000
  X=matrix(nrow=N,ncol=p,data=rbinom(size=2,p=.3,N*p))
  hasEffect=rep(F,p) 
  hasEffect[sample(1:p,size=500)]=T
  pValues=rep(NA,p)
  
  for(i in 1:p){ 
 	x=X[,i]
 	if(hasEffect[i]){ 
 	  b=rnorm(n=1,mean=.05,sd=1)
  	  signal=x*b
      error=rnorm(n=N,sd=1)
      y=signal+error
    }else{
      y=rnorm(N)
    }
    fm=lsfit(y=y,x=x)     
    pValues[i]=ls.print(fm,print.it = F)$coef[[1]][2,4]
    if(i%%10000==0){print(i)}
  }
```

**Distribution plots**

```r
  par(mfrow=c(2,2))

  # p-values under the null follow a uniform distribution
  hist(pValues[!hasEffect],100,main='H0')

  # under Ha the distribution is not uniform
  hist(pValues[hasEffect],100,main='Ha')
  
  # overall the distrubtion is a mixture
  hist(pValues,100,main='Overall')


```  


### Example: using Bonferroni Vs FDR in GWAS

For the following example we will use this [dataset](https://www.dropbox.com/s/1ccoy1hy3yddc09/X_10k_10k.RData?dl=0).

```r
 rm(list=ls())
 load('~/Dropbox/X_10k_10k.RData')
 # Pruning (almost perfectly colinear SNPs)
  p=ncol(X)
  n=nrow(X)
  for(i in 1:4){
	keep=rep(T,p)
 	for(i in 2:p){
 		keep[i]<- (cor(X[,i-1],X[,i])^2 < 0.9)
 	}
 	X=X[,keep]
 	p=ncol(X)
 	print(p)
  }
 
 #
 n=nrow(X); p=ncol(X)
 nQTL=10  # number of loci with effects
 QTL=round(seq(from=50,to=p-50,length=nQTL) )


 h2=.01 # R-sq of the simulated model
 
 b=rep(1,nQTL)
 
 signal=X[,QTL]%*%b
 signal=scale(signal)*sqrt(h2)
 error=rnorm(sd=sqrt(1-h2),n=n)
 y=signal+error
 
 # A function for single marker regression
 SMR=function(y,x){
 	fm=lsfit(y=y,x=x)
 	out=ls.print(lsfit(x=x,y=y),print.it=F)[[2]][[1]][2,]
 	return(out)
 }
 
# Single marker-test
 system.time(TMP<-t(apply(FUN=SMR,X=X,MARGIN=2,y=y)))
 pValues<-TMP[,4]
 
 plot(-log10(pValues),cex=.5,col=2)

 abline(h=-log10(.05/p),col=4) # Bonferroni's threshold for FWER=0.05

 sortedPValues=sort(pValues)
 isSmaller=sortedPValues<= (1:p)/p*0.1
 FDR.cutoff<-sortedPValues[max(which(isSmaller))]

 abline(h= -log10(FDR.cutoff),colk=4,lty=2)
 
```

### The `p.adjust` function in R

```r
  pValue_bonf=p.adjust(pValues,method='bonferroni')
  pValue_holm=p.adjust(pValues,method='holm')
  pValue_fdr=p.adjust(pValues,method='fdr')

```
