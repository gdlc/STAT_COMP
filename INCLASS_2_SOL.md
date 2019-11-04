


```r


# Code marked between #*# was added to the example discussed in class

#*#
 RHO=0.999
 S=matrix(nrow=q,ncol=q,RHO) 
 diag(S)=1
 U=chol(S) # this is the upper-triangular Cholesky factor
#*#

q=3
nRep=10000
n=100
PVALUES=matrix(nrow=nRep,ncol=q,NA)

for(i in 1:nRep){
  X=matrix(nrow=n,ncol=q,data=rnorm(n*q))
  
  #*#
    X=X%*%U
  #*#
  
  y=rnorm(n)
  fm=lsfit(y=y,x=X)
  PVALUES[i,]=ls.print(fm,print.it=F)[[2]][[1]][,4][-1]
  if(i%%1000==0){ message(i) }
}

mean(PVALUES[,1]<.05)
mean(PVALUES[,2]<.05)

mean(PVALUES[,1]<.05 | PVALUES[,2]<0.05 | PVALUES[,3]< 0.05)
mean(PVALUES[,1]<.05/3 | PVALUES[,2]<0.05/3 | PVALUES[,3]< 0.05/3)

```
