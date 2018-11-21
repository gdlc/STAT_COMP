## Examples Using Transformations


#### Example 1: from uniform to exponential

```r
n=1e6
lambda=3
U=runif(n)
Y1=-log(U)/lambda
Y2=rexp(n=n,rate=lambda)

par(mfrow=c(1,2))
hist(Y1,main='Using Uniforms',30)
hist(Y2,main="Using rexp()",30)
mean(Y1)
mean(Y2)
cbind(quantile(Y1,p=seq(from=.1,to=.9,by=.1)),quantile(Y2,p=seq(from=.1,to=.9,by=.1)))

```

#### Example 2: from exponentials to gamma

```r
r=4
lambda=6
X=matrix(nrow=n,ncol=r,NA)
for(i in 1:r){ X[,i]=rexp(n=n,rate=lambda) }
Y1=rowSums(X)
Y2=rgamma(n=n,rate=lambda,shape=r)
cbind(quantile(Y1,p=seq(from=.1,to=.9,by=.1)),quantile(Y2,p=seq(from=.1,to=.9,by=.1)))
```


#### Inverse Probability Method


**Normal Distribution**

```r
  n=1e5
  u=runif(n)
  x=qnorm(n,sd=2,mean=8)
  y=rnorm(n,sd=2,mean=8)
  
  # comparing quantiles
  cbind(quantile(x,p=seq(from=.05,to=.95,length=10)),
        quantile(y,p=seq(from=.05,to=.95,length=10)))

```

**Gamma?**
**Beta?**
