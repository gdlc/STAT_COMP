### Due Sept. 22nd, 1:00pm in D2L


1) Create an R-function to compute the matrix product that only uses loops and scalar operations

2) Create an R-function that will fit a linear model via least-squares, use the example below to compare your results with `lm()`. In your function you can use all the matrix operations that we discuss today.

Recall that in a linear model **y=Xb+e**, the least-squares estimate of **b** is the solution to the following system **X'Xb=X'y**.


```r
 n=300
 x1=rbinom(size=1,n=n,prob=.5)
 x2=rnorm(n)
 mu=100
 b1=2
 b2=-3
 
 signal=mu + x1*b1 + x2*b2
 error=rnorm(n)
 y=signal+error
 
 summary(lm(y~x1+x2))
 
```

**Suggested outline for problem 2**
   - Create the incidence matrix X for the model y=Xb+e, recall that for an 'intercept' the 1st column of X must be a vector of 1's, thus, `X=cbind(1,x1,x2)`
   - Compute the cross-products involved in the normal equations `C=X'X` and `rhs=X'y`,
   - Use solve to obtain bHat,
   - Return


### Solution templates


**Problem 1**:

```r
  matProd=function(x,y){
   # thorws a message if the operation does not conform
   if(ncol(x)!=nrow(y)){ stop("Number of colums of x must be equal to number of rows of y")}
   
   n=nrow(x)
   p=ncol(y)
   ans=matrix(nrow=n,ncol=p,NA)
   for(i in 1:n){
     for(j in 1:p){
      ans[i,j]=0
      for(k in 1:ncol(x)){  
       ans[i,j]=ans[i,j]+x[i,k]*y[k,j]
      }
     }
   }
   return(ans)
  }
  
  # Test
  x=matrix(nrow=3,ncol=2,rnorm(6))
  y=matrix(nrow=2,ncol=4,rnorm(8))
  matProd(x,y)
  matProd(x,y)==(x%*%y)
  
  matProd(y,x)
  
```

**Problem 2**:


```r
 myOLS=function(X,y){ 
  XtX=crossprod(X)   # equivalent to t(X)%*%X
  Xty=crossprod(X,y) # equivalent to t(X)%*%y
  sol=solve( XtX,Xty)
  return(sol )
 }
 
 
 
 n=300
 x1=rbinom(size=1,n=n,prob=.5)
 x2=rnorm(n)
 mu=100
 b1=2
 b2=-3
 
 signal=mu + x1*b1 + x2*b2
 error=rnorm(n)
 y=signal+error
 
 
 
 X=cbind(1,x1,x2)
 
 cbind(myOLS(X,y) , coef(lm(y~x1+x2)))

```
