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

#### Example 3: from Gamma to Beta

```r
X1=rgamma(n=n,shape=4,rate=2)
X2=rgamma(n=n,shape=3,rate=3)

Y1=X1/(X1+X2)
Y2=rbeta(n=n,shape1=2,shape2=1.5)
```
