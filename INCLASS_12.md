
Draw 100,000 samples from the bi-varaite Bernoulli in the Table in section 2.1 of the [handout](https://github.com/gdlc/STAT_COMP/blob/master/SimulatingRandomVariables.pdf) on sampling
random variables, using the algorithms described in Box 1 and Box 2 of the handout.


### Compostion sampling

We find the marginal distribution of X and the conditional distribution of Y|X. Because both X and Y are {0,1} both distributions must be Bernoulli.

  - P(X=1)=P(X=1|Y=0)+P(X=1|Y=1)
  - P(Y=1|X=0)=p(Y=1 & X=0)/P(X=0) ;  P(Y=1|X=1)=p(Y=1 & X=1)/P(X=1)
  
```r
XY=rbind(c(0.1,0.1),c(0.2,0.6))
colnames(XY)=c('Y=0','Y=1')
rownames(XY)=c('X=0','X=1')

# marginal distribution of X
pX=sum(XY['X=1',])
pYgX= XY[,'Y=1']/rowSums(XY)

N=100000
X=rep(NA,N)
Y=rep(NA,N)

for(i in 1:N){
  X[i]=rbinom(size=1,n=1,prob=pX)
  if(X[i]==0){
    Y[i]=rbinom(size=1,n=1,prob=pYgX[1])
  }else{
    Y[i]=rbinom(size=1,n=1,prob=pYgX[2])  
  }
}
table(X,Y)/N

```
**A little more compressed/faster code**

```r
  N=100000
  X=rbinom(n=N,size=1,prob=pX)
  Y=rbinom(n=N,size=1,prob=pYgX[X+1])
  table(X,Y)/N
```

### Gibbs sampler

We first find the fully-conditionals P(Y|X) and P(X|Y)

 - P(X=1|Y=0)=p(Y=1 & Y=0)/P(Y=0) ;  P(X=1|Y=1)=p(X=1 & Y=1)/P(Y=1)
 - P(Y=1|X=0)=p(Y=1 & X=0)/P(X=0) ;  P(Y=1|X=1)=p(Y=1 & X=1)/P(X=1)
 
Then we sample recursively usinge these distributions.

```r
 N=1000000
 X=rep(NA,N)
 Y=rep(NA,N)
 
 pYgX= XY[,'Y=1']/rowSums(XY)
 pXgY= XY['X=1',]/colSums(XY)
 
 X[1]=0 # (pick zero or one... it should not matter)
 Y[1]=rbinom(prob=pYgX[ X[1]+1],size=1,n=1)
 for(i in 2:N){
   X[i]=rbinom(prob=pXgY[ Y[i-1]+1],size=1,n=1)
   Y[i]=rbinom(prob=pYgX[ X[i-1]+1],size=1,n=1)   
 }
 table(X,Y)/N
```

