
Family wise error rate with correlated tests:

Modify the three-predictor [example discussed in class today](https://github.com/gdlc/STAT_COMP/blob/master/LARGE_SCALE_TESTING.md) by making the three predictors correlated accoridng to 
the following correlation matrix (do not use `mvrnorm()`):

| | | |
|----|----|----|
| 1.0  | 0.5 | 0.5 |
| 0.5  | 1.0 | 0.5 |
|0.5.  | 0.5 | 1.0 |


Hint: 

   - Compute the lower-triangular cholesky of the above matrix (`L=t(chol(S))`)
   - Check that `S==L%*%t(L)`
   - Initialize a matrix X (n rows, q columns)
   - In a loop from 1 to n:
        - Generate `q` iid iid N(0,1) `z=rnorm(3)`
        - set `X[i,]=L%*%z`
   - Use this incidence matrix in the example discussed in class today.

Estimate and report the type-I error rate when you reject using `alpha=0.05`, `alpha=0.05/3`.


## Suggested solution



Code marked between `#*#`was added to the example discussed in class

```r
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
