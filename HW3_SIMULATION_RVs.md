## HW3: Simulation of Random Variables (RVs)

**(Due Sat Nov. 2nd in D2L)**

Please upload a single file containing the code, outputs and comments (preferable a pdf or html created using R Markdown).

#### 1. Inverste probability method

Generate 50,000 samples from a gamma distributed RV with rate=2 and shape=2. Display a histogram with veritcal lines indicating: (1) 
empirical quantiles (in read for prob 0.1,0.2,...,0.9) and the true quantiles for the distribution (in blue can use `qgamma`) for the same probabilities.


#### 2. Composition Sampling (mixture of scaled-normals)

Let (xi,yi) follow a bi-variate distribution such that p(xi)=dchisq(df=4) and p(yi|xi)=dnorm(mean=0,sd=sqrt(1/xi)). 

2.1. Use composition sampling to generate 50,000 samples for the pair.

2.2. Present a density plot of y, overlap over it a density plot of a normally distributed RV with mean equal to 0 and variance equalt to var(y). What differences do you see?

2.3. Repat 2.1 and 2.2 with df=100. Compare your results with those obtained with df=4.

#### 3. Composition Sampling in the Multivariate Normal (MVN) distribution.

Let `x=(x1,x2,x3)` be a MVN random vector with mean E[x1]=1, E[x2]=2, E[x3]=0 and (co)variance matrix

|   |   |   |
| ------------- |-------------| -----|
| 1.0 | 0.2 | 0.3|
| 0.2| 1.2 | 0.1 |
| 0.3 | 0.1 | 2.0 |


3.1. Compute and report E[X2|X1=x1] and Var[X2|X1=x1], and E[X3|X1=x1,X2=x2] and Var[X3|X1=x1,X2=x1].

3.2. Use the above results to generate a composition sampling algorithm to generate 30,000 samples of `x=(x1,x2,x3)`. Report the empirical mean and empirical (co)variance matrix and compare it with the tarteg mean and (co)variance matrix.



[Main](https://github.com/gdlc/STAT_COMP/blob/master/README.md)


## Suggested Solution

### Problem 1

Generate 50,000 samples from a gamma distributed RV with rate=2 and shape=2. Display a histogram with veritcal lines indicating: (1) empirical quantiles (in read for prob 0.1,0.2,...,0.9) and the true quantiles for the distribution (in blue can use qgamma) for the same probabilities.

```r 
  n=50000 # use 1/2million to get more accurate results
  u=runif(n)
  x=qgamma(p=u,rate=2,shape=2)
  FD=density(x)
  plot(FD,col='red',main='',xlab='Simulated values')
  
  lines(x=sort(x),y=dgamma(x=sort(x),shape=2,rate=2),col='blue')
  legend(x=2.5,y=.6,text.col=c('red','blue'),legend=c('Empirical dennsity of simulated values', 'Gamma(2,2) density'))
  
  tmp=seq(from=.05,to=.95,by=.05)
  TMP=round(cbind(quantile(x,prob=tmp),qgamma(p=tmp,shape=2,rate=2)),3)
  print(TMP)
  
```

## Problem 2


Let (xi,yi) follow a bi-variate distribution such that p(xi)=dchisq(df=4) and p(yi|xi)=dnorm(mean=0,sd=sqrt(1/xi)).

#### 2.1 Use composition sampling to generate 50,000 samples for the pair.


```r
  DF=4
  n=50000
  x=rchisq(n,df=DF)
  y=rnorm(n=n,sd=1/sqrt(x))

```


#### 2.2 Present a density plot of y, overlap over it a density plot of a normally distributed RV with mean equal to 0 and variance equalt to var(y). What differences do you see?

```r
 FD=density(y) ## fitted density
 ND=dnorm(x=sort(y),mean=mean(y),sd=sd(y)) # fitted, nomrmal density
 plot(FD,col='red')
 lines(x=sort(y),y=ND,col='blue')
```

The simulated density (which is a t with 4 df) has more mass at zero and thicker tails than the normal 

#### 2.3 Repat 2.1 and 2.2 with df=100. Compare your results with those obtained with df=4.

```r
 DF=100
 x=rchisq(n,df=DF)
 y=rnorm(n=n,sd=1/sqrt(x))
 DF=100
 FD=density(y) ## fitted density
 ND=dnorm(x=sort(y),mean=mean(y),sd=sd(y)) # fitted, nomrmal density
 plot(FD,col='red')
 lines(x=sort(y),y=ND,col='blue')
```

### 3. Composition Sampling in the Multivariate Normal (MVN) distribution.

#### 3.1 Compute and report E[X2|X1=x1] and Var[X2|X1=x1], and E[X3|X1=x1,X2=x2] and Var[X3|X1=x1,X2=x1].

```r
 S=diag(c(1,1.2,2.0))
 S[1,2]=S[2,1]=0.2
 S[1,3]=S[3,1]=0.3
 S[2,3]=S[3,2]=0.1
 mu=c(1,2,0)
 
 getCondPar=function(S,mu,index1,index2){
    COV21=S[index2,index1,drop=F]
    V1=S[index1,index1,drop=F]
    V2=S[index2,index2,drop=F]
    B=COV21%*%solve(V1) # matrix of regression coeff
    condVar=V2-B%*%t(COV21)
    ans=list(B=B,V=condVar)
    return(ans)
 }
 ```
 
The `E[X2|x1=X1]=B(x1-mu1)` where B is the matrix reported below
   
```r
  getCondPar(S,mu,1,2)$B
  
```

And the conditional variance, `V[X2|X1]` is

```r
 getCondPar(S,mu,1,2)$V
```

Now `E[X3|X1,X2]=B%*%(c(x1,x2)-mu[c(1,2)])`, where `B` is:

```r
 getCondPar(S,mu,c(1,2),3)$B
```

And the conditional variance is:

```r
 getCondPar(S,mu,c(1,2),3)$V
```
### 3.2 Use the above results to generate a composition sampling algorithm to generate 30,000 samples of `x=(x1,x2,x3)`. Report the empirical mean and empirical (co)variance matrix and compare it with the tarteg mean and (co)variance matrix.

```r
 n=50000
 X=matrix(nrow=n,ncol=3,NA)
 B1=getCondPar(S,mu,index1=1,index2=2)$B
 V1=getCondPar(S,mu,index1=1,index2=2)$V
 
 B2=getCondPar(S,mu,index1=1:2,index2=3)$B
 V2=getCondPar(S,mu,index1=1:2,index2=3)$V 
 
 for(i in 1:n){
   X[i,1]=rnorm(n=1,sd=sqrt(S[1,1]),mean=mu[1])
   X[i,2]=rnorm(n=1,sd=sqrt(V1),mean=I(mu[2]+B1%*%(X[i,1]-mu[1])))
   X[i,3]=rnorm(n=1,sd=sqrt(V2),mean=I(mu[3]+B2%*%(X[i,1:2]-mu[1:2])))
   
 }
 
 
 print(round(colMeans(X),3))
 print(round(var(X),3))
   
```


