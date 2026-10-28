## Inclass 15

**Tasks**: Create two functions `rCS(P,n)` and `rGibbs(P,n)` that generate `n` random draws from a bi-variate distribution. Here **P** is a 2x2 matrix with the joint probabilities of X (rows) and Y.


**Templates**

```r
 rCS=function(P,n){
  X=rep(NA,n)
  Y=rep(NA,n)

  for(i in 1:n){
     X[i]=# sample X[i] from p(X)
     Y[i]=# sample Y[i] from p(Y|X=X[i])
  } 

  return(cbind(X,Y))
 }
```

```r
 rGibbs=function(P,n){
  X=rep(NA,n)
  Y=rep(NA,n)
  # Initialize X[1] and Y[1] to any 0/1 values

  for(i in 2:n){
     X[i]=# sample X[i] from p(X|Y=Y[i-1])
     Y[i]=# sample Y[i] from p(Y|X=X[i])
  } 

  return(cbind(X,Y))
 }
```
To test it you can use use following

```r
 P=matrix(nrow=2,ncol=2,0)
 P[1,1]=.1
 P[1,2]=0.3
 P[2,1]=0.15
 P[2,2]=1-sum(P)

 XY=rCS(P,100000)
 table(XY[,1],XY[,2])/nrow(XY)

```

 
## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) with the definitions of `rCS()` and `rGibbs()`.
