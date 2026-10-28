## Inclass 15

Tasks: Create two functions `rCS(P,n)` and `rGibbs(P,n)` that generate `n` random draws from a bi-variate distribution. Here **P** is a 2x2 matrix with the joint probabilities of X (rows) and Y.


**Template**

```{r}
 rCS=function(P,n){
  X=rep(NA,n)
  Y=rep(NA,n)
  # sample here

  return(cbind(X,Y))
 }
```
To test it you can use use following

```{r}
 P=matrix(nrow=2,ncol=2,0)
 P[1,1]=.1
 P[1,2]=0.3
 P[2,1]=0.15
 P[2,2]=1-sum(P)

 XY=rCS(P,10000)
 table(XY[,1],XY[,2])/nrow(XY)

```
