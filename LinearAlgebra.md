## (2) Matrix Algebra (definitions and computational methods)

**Definition**. A matrix is a 2-dimensional array of values of the same type.

**Internal structure**. By default R sorts matrices by column.
```r
  X=matrix(nrow=3,ncol=2,data=1:6)
  X
  # you can use the `byrow` argument to tell R that you are providing the data to fill the matrix sorted by rows.
  X=matrix(nrow=3,ncol=2,data=1:6,byrow=TRUE)
  X
```

**Column and rownames**. We can append names to rows and columns.

```r
  rownames(X)=c('a','b','c')
  colnames(X)=c('c1,'c2')
  colnames(X)
  rownames(X)
  dimnames(X)
  
  X=X[3:1,]
  rownames(X)
  
  X=X[,2:1]
  colnames(X)
```

**Basic matrix operators**

```r
  X=matrix(nrow=3,ncol=2,data=1:6)
  Y=X
  
  X+Y # matrix addition, cell-by-cell
  X-Y # substraction
  log(X) # any function when called on a matrix it is applied to each of its cells
  X^2
  
  X*X # Note, this is the Haddamard (i.e. cell by cell product)
  
  # To obtain the matrix product use `%*%` instead of `*`
  A=X
  B=matrix(nrow=ncol(X),ncol=10,data=runif(ncol(X)*10)
  
  C=A%*%B
  
  # to verify that the result is correct
  sum(A[3,]*B[,2])==C[3,2]
```

**Apply function**

There is a family of functions `lapply`, `tapply`, `applay`, etc. that can be used to apply operations to dimensions of an array (of different kinds). For matrices we use `apply`, this function can be used to apply functions to rows or comumns of a matrix.

```r
n=1000;p=500
X=matrix(nrow=n,ncol=p,runif(n*p))

cSums<-apply(X=X,FUN=sum,MARGIN=2)
rSums<-apply(X=X,FUN=sum,MARGIN=1)

## passing your own function
  sumsOfLogs=function(x){ sum(log(x)) }
  tmp=apply(X=X,FUN=sumsOfLogs,MARGIN=2)

## column and row suma are already build in
  cSums2=colSums(X)
  rSums2=rowSums(X)

```

If we have a vector and an index set (e.g., male/female) we can apply a function to the vector for every level of the index using `tapply`.

```r
 x=rnorm(100)
 id=sample(c("M","F"),size=100,replace=T)
 tapply(X=x,INDEX=id,FUN=sum)
 sum(x[id=='M'])
 sum(x[id=='F'])
 

```
