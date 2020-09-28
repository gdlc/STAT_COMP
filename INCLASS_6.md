## IN-CLASS 5: Implementing the [Gauss-Seidel](https://github.com/gdlc/STAT_COMP/blob/master/LinearAlgebra.md#gauss-seidel) algorithm.

**Task:** Create a funciton `solveSys(C,r,to1e-5)` that would produce and return a solution to the system **Cb=r** using the Gauss-Seidel algorithm. You can find an outline [here](https://github.com/gdlc/STAT_COMP/blob/master/LinearAlgebra.md#gauss-seidel).

You can test your code using the following example

```r
 n=500
 p=5
 X=matrix(nrow=n,ncol=p,data=rnorm(n*p))
 y=X[,3]-X[,5]+rnorm(n)
 
 C=crossprod(X)
 r=crossprod(X,y)
 # compare your results with solve(C,r)
```


#### Template of a solution
```r
 solveSYS=function(C,r,tol=1e-5){
  p=ncol(C)
  b=rnorm(p) # can initialize with whatever you want!
  ready=FALSE
  while(!ready){
  
   bOLD=b # copy the current solution
   
   #update the solution one uknown at a time
   for(i in 1:p){
    b[i]=(r[i]-sum(C[i,-i]*b[-i]))/C[i,i]
   }
   
   # compare with previous soultion
   ready=max(abs(b-bOLD))<tol
  }
  return(b)
 }
```

**Test**

```r
 X=cbind(1,matrix(nrow=100,ncol=4,rnorm(400)))
 b=c(10,1,-1,2,0)
 y=X%*%b # no error in this case...
 C=crossprod(X)
 r=crossprod(X,y)
 sol1=solve(C,r)
 sol2=solveSYS(C,r)
 round(cbind(b,sol1,sol2),5)

```

**Note**: The algorithm is guaranteed to converge if **C** is diagonal dominant, to avoid an infinite while loop, you can include an additional argument (e.g., `maxIter`), counte the number of iterations (e.g., niter),  and then make `ready=(max(abs(b-bOLD))<tol) | (niter>=maxIter)`. 
