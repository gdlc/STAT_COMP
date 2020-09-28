## Operations with matrices (definitions and computational methods)

<div id="outline" />

##### Outline

  * [Internal structure](#internal-structure) 
  * [Dimnames](#dimnames) 
  * [Transponse](#transpose) 
  * [Addition](#addition) 
  * [Cell-by-cell operations](#cell)
  * [Inverse](#inverse)
  * [Matrix product](#product)
  * [Diagonal](#diagonal)
  * [Determinant](#determinant)
  * [Inverse](#inverse)
  * [Generalized Inverse](#ginverse)
  * [Apply](#apply)
  * [Matrix Factorizations](#matrix-factorization)
  * [Gauss-Seidel algorithm](#gauss-seidel)

**Definition**: A matrix is a 2-dimensional array of values of the same type. Here we focus on numeric matrices.

<div id="internal-structure" />

### Internal structure

By default R stores matrices by column.

```r
  X=matrix(nrow=3,ncol=2,data=1:6)
  X
  # you can use the `byrow` argument to tell R that you are providing the data to fill the matrix sorted by rows.
  X=matrix(nrow=3,ncol=2,data=1:6,byrow=TRUE)
  X
```
[Back to outline](#outline)



<div id="dimnames" />


### Column-names and row-names 

We can append names to rows and columns.

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
[Back to outline](#outline)


### Basic matrix operations

If you need to review basic matrix operations (sum of two matrices, the transpose, matrix multiplication, the inverse of a matrix) here are a two handouts that you may consult (thousands more available upon search on the web):

  - [Cherney, Denton, Thomas, and Waldron](  https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwi1m4GOsPrrAhVC7qwKHbk_AxsQFjABegQIAxAB&url=http%3A%2F%2Fcs229.stanford.edu%2Fsection%2Fcs229-linalg.pdf&usg=AOvVaw0hW8mS96Vpvsz0xFhC8W3O )
  - [Kolter & Do](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwi1m4GOsPrrAhVC7qwKHbk_AxsQFjABegQIAxAB&url=http%3A%2F%2Fcs229.stanford.edu%2Fsection%2Fcs229-linalg.pdf&usg=AOvVaw0hW8mS96Vpvsz0xFhC8W3O )


<div id="transpose" />

##### [Transpose](https://en.wikipedia.org/wiki/Transpose)

```r
  X=matrix(nrow=3,ncol=2,data=1:6)
  t(X)
```
[Back to outline](#outline)


<div id="addition" />

##### Matrix [addition](https://en.wikipedia.org/wiki/Matrix_addition#:~:text=The%20direct%20sum%20of%20matrices%20is%20a%20special%20type%20of%20block%20matrix.&text=Any%20element%20in%20the%20direct,(i.e.%2C%20zero%20matrices).),
```r
  X=matrix(nrow=3,ncol=2,data=1:6)
  show(X)
```
[Back to outline](#outline)


<div id="cell" />

##### Cell-by-cell operations
  
```r  Y=X
  X+Y # matrix addition, cell-by-cell
  X-Y # substraction, same type (cell-by-cell)
  log(X) # any function when called on a matrix it is applied to each of its cells
  X^2
  X*X # Note, this is the Haddamard (i.e. cell by cell product) not the standard matrix product (see below)
```
[Back to outline](#outline)


<div id="product" />

##### [Matrix product](https://en.wikipedia.org/wiki/Matrix_multiplication)


```r
  # Matrix product: to obtain the matrix product use `%*%` instead of `*`
  A=X
  B=matrix(nrow=ncol(X),ncol=10,data=runif(ncol(X)*10)
  
  C=A%*%B
  
  # to verify that the result is correct
  sum(A[3,]*B[,2])==C[3,2]
```
[Back to outline](#outline)


<div id="diagonal" />

##### The diagonal of a matrix

```r
  X=matrix(data=rnorm(9),ncol=3,nrow=3)
  
  # extracting the diagonal entries
   diag(X)
  
  # modifying the diagonal
   show(X)
   diag(X)=1:3
   show(X)
```
[Back to outline](#outline)


##### Creating a [diagonal](https://en.wikipedia.org/wiki/Diagonal_matrix#:~:text=A%20square%20matrix%20is%20diagonal,it%20is%20triangular%20and%20normal.&text=A%20symmetric%20diagonal%20matrix%20can,dimensional%20matrix%20is%20always%20diagonal.) matrix


We can also use `diag()` to creat a diagonal matrix

```r
  diag(3) # creates a 3x3 identity matrix 
  
  diag(ncol=3,nrow=3,x=5)
  
  diag(c(1,2,3))
  
```
[Back to outline](#outline)


<div id="determinant" />

##### Matrix [determinant](https://en.wikipedia.org/wiki/Determinant) 

```r
 A=matrix(nrow=2,ncol=2,0.5)
 show(A)
 
 # A sigunlar matrix has a determinant equal to zero
 det(A) 
 
 # Now a non-singular matrix
 diag(A)=1
 det(A)
 
```
[Back to outline](#outline)


<div id="inverse" />

##### [Matrix Inverse](https://mathworld.wolfram.com/MatrixInverse.html)


```r
 A=matrix(nrow=2,ncol=2,0.5)
 diag(A)=1
 
 AInv=solve(A)
 
 show(A)
 show(AInv)
 
 show(round(AInv%*%A,8))
 show(round(A%*%AInv,8))
 
```
[Back to outline](#outline)


<div id="generalized inverse" />

##### [Generalized inverse](https://en.wikipedia.org/wiki/Generalized_inverse)

For singular matrices, in some applications we will use a Generalized inverse. 

```
 # A signular matrix
 X=cbind(1:3,runif(3), 1:3)
 det(X)
 solve(X)
 
 # now a generalized inverse
 library(MASS)
 GInv=ginv(X)
 
 round(X%*%GInv,8)
 
 show(round(X%*%GInv%*%X,8))
 show(X)
 
 # Try help(ginv) for details...
 
```
[Back to outline](#outline)


<div id="apply" />

##### Apply function

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
[Back to outline](#outline)


If we have a vector and an index set (e.g., male/female) we can apply a function to the vector for every level of the index using `tapply`.

```r
 x=rnorm(100)
 id=sample(c("M","F"),size=100,replace=T)
 tapply(X=x,INDEX=id,FUN=sum)
 sum(x[id=='M'])
 sum(x[id=='F'])
 
```
[Back to outline](#outline)


<div id="matrix-factorization" />

### Matrix factorizations

Matrix factorizations are used often for (i) obtaining OLS estimates, (ii) inverting matrices, (iii) determining the rank of a matrix, 
(iii) describing features of the data and (iv) in simulations. 


The following table described often used matrix factorisations. 

|  Name   | Description  | R-function |
|-----------|-----------|----------|
| Singular Value Decomposition           |  X=UDV' applies to any matrix        |  `svd`        |
| Eigen Decomposition | X=UDU' applies to symmetric matrices  |  `eigen` |
| QR | X=QR applies to any marrix  |  `qr` |
| Cholesky| X=U'U applies to symmetric positive definite matrices  |  `chol` |

#### Cholesky decompoisition

Symmetric (i.e., **A**=**A'**), positive definite (i.e., matrices satisfying **a'Aa**>0 for all non-zero **a** vector) can be factorized using the Cholesky decomposition. The Cholesky factor is a triangular matrix, depending on the software it can bue an upper-triangular (**U**) or lower-triangular (**L=U'**) matrix. Using the Cholesky factor of **A**, the input matrix can be represented as either **A=U'U** or, equivalently, **A=LL'**. The `chol()` function in R produces the upper-triangular Cholesky factor (**U**)

```r
 X=matrix(nrow=100,ncol=2,data=runif(300))
 XtX=crossprod(X) # produces X'X which is symmetric and positive definite because X has rank=ncol(X)
 U=chol(XtX)
 show(round(U,8))
 
 round(crossprod(U),8)
 round(XtX,8)
 all.equal(crossprod(U),XtX) # note: you may get false due to rounding errors, if so, try round(, 8) on each of the objects
```

**Obtaining an inverse from a cholesky factor**

For positive definite matrices, the inverse can be obtained from the Cholesky factor using `chol2inv()`, this approach exploits the triangular nature of the factor.

```r
 n=1000
 p=5
 X=matrix(nrow=n,ncol=p,data=runif(n*p))
 XtX=crossprod(X) # produces X'X which is symmetric and positive definite because X has rank=ncol(X)
 U=chol(XtX)
 INV=chol2inv(U)
 INV2=solve(XtX)
 all.equal(round(INV,8),round(INV2,8))
```

For large matrices, if the matrix is symmetric and guarenteed to be positive-definite, using `chl2inv()` is much faster than `solve()`.

```r
 set.seed(195021)
 n=20000
 p=1000
 X=matrix(nrow=n,ncol=p,data=runif(n*p))
 XtX=crossprod(X) # produces X'X which is symmetric and positive definite because X has rank=ncol(X)
 system.time( INV<-chol2inv(chol(XtX)) )
 system.time( INV2<-solve(XtX) )

```

#### Singular-value decomposition

Finds orthonormal-basis for the row (**U**) and column (**V**) linear spaces spanned by **X**.


**Computation**

```r 
  X=matrix(nrow=20,ncol=4,data=runif(80))
  SVD=svd(X)
  str(X) 
  dim(SVD$u)    # left-singular vectors
  length(SVD$d) # the singular values
  dim(SVD$v)    # righ-singular vectors
```
[Back to outline](#outline)

**Using the SVD to identify substructures (e.g., clusters)**

The following example shows the loadings on the 1st two eigenvectors for each species in the `iris` data set, colors represent the different species

```r
 data(iris)
 X=as.matrix(iris[,1:4])
 SVD=svd(X)
 plot(SVD$u[,1:2],col=sp,xlab='1st Eigenvector',ylab='2nd Eigenvector')
 legend(x=-.11,y=.13,legend=unique(sp),text.col=1:3)

```


We can also use the right-singular vectors examine structure among columns

```r
 plot(SVD$v[,1:2],col=as.ineger(colnames(X)))
 plot(SVD$v[,1:2],col=as.integer(factor(colnames(iris)[1:4])))
 heatmap(X)
```


**Veriffying properties**


```r
  # Recovering X from the factorization
   Xnew=SVD$u%*%diag(SVD$d)%*%t(SVD$v) 
   all(round(Xnew,8)==round(X,8))
  
  # Rank of the matrix is equal to the number of positive singular values
   sum(SVD$>1e-8)
   
  # U and V have orthonormal columns
  round(crossprod(SVD$u),8)
  round(crossprod(SVD$v),8)
  
  # For full-column rank matrices (as in this example) the rows or V are also orthonormal 
  # (for full-row rank matrices UU'=I, but this does not happen in this case because rank(X)<nrow(X)
  round(tcrossprod(SVD$v),8)
```
[Back to outline](#outline)

The left-singular vectors (U) can be used to describe features of the rows (subjects) and the right-singular vectors (V)
can be used to describe patterns of the columns of X. Thus, the first two left-singular vectors are often used to describe
data structure, you can use `plot(SVD$u[,1:2])` to display this. Likewise `plot(SVD$v[,1:2])` can be used to uncover
relationships among columns. Biplots mixes these two features in a single plot.


**Solving systems of equations and obtaining OLS estimates**

Consider `y=Xb+e`, replace `X` with it's SVD decomposition, that is, write: `y=UDV'b+e`. Let `d=DV'b`, then `y=Ud+e`. 
This is a regression of `y` on an orthonormal basis for X. Because `U'U=I` the OLS estimate of `d` is `dHat=U'y`. This orthogonal projection can always be pefrormed, even if `X` is rank-deficient. In the full-column-rank case, we have `bHat=VD^-1dHat`. The following example verifies this.

```r
  # OLS estimates
   y=rnorm(nrow(X))
   XX=crossprod(X)
   rhs=crossprod(X,y)
   bHat=solve(XX,rhs)

  # Now the same using SVD
   dHat=crossprod(SVD$u,y)
   bHat2=SVD$v%*%diag(1/SVD$d)%*%dHat
   cbind(bHat,bHat2)
```
[Back to outline](#outline)


#### QR-decomposition

This factorization is commonly used to obtain OLS estimates.  The following example shows how to obtain the QR decomposition.

```r
  QR=qr(X)
  Q=qr.Q(QR) # gives you the Q matrix
  R=qr.R(QR) # gives you the R matrix
  
  ## Verifying orthogonality
  round(crossprod(Q), 8)
  
  ## Recovering X
  XNew=Q%*%R
  
  all(round(XNew,8)==round(X,8))
  
```
[Back to outline](#outline)


Following the same ideas we discussed before, substitute in the linear model `y=Xb+e` `X` with the QR-decomposition, `y=QRb+e`, let `d=Rb`, to get `y=Qd+e`. Since `Q` has orthogonal columns, the OLS estimate of d is `dHat=Q'y`. And, in the full-colmun rank case, `bHat=RInv*dHat`. Because `R` is triangular, the inverse can be computed easily using a recursive algorithm (discussed in class).

```r
 dHat=crossprod(Q,y)
 bHat3= backsolve(R,dHat) # solves a system of equations Rb=dHat, for the case where the coefficient matrix, R is triangular.
 cbind(bHat,bHat2, bHat3)

```
[Back to outline](#outline)

<div id="gauss-seidel" />

### Gauss-Seidel algorithm

Consider a system of linear equations of the form

**Cb**=**r**

In the context of least squares estimation of effects for the linear model **y=Xb+e**, **C=X'X** and **r=X'y**.

The system involves `p=ncol(C)=length(r)` equations of the form **C[i,]'b**=r[i] (*i=1,...,p*) or, in scalar form 

`C[i,1]b[1]+C[i,2]b[2]+...+C[i,i]b[i]+...+C[i,p]b[p]=r[i]`

Now, pretend we have a good guess for the solution to all but the ith coefficient, using this we can find an update for the ith coefficient by re-arranging the above equation

`b[i]=(r[i] -(C[i,1]b[1]+C[i,2]b[2]+...+C[i,i-1]b[i-1]+C[i,i+1]b[i+1]+...+C[i,p]b[p])/C[i,i]`

Once we updated `b[i]`, we can move an update `b[i+1]`, and so on.

The Gauss-Seidel algorithm uses the idea described above, the outline of the algorithm is as follows

  - Initialize b (e.g., b=0 for all entries of b)
  - Iterate from *i=1,...p*, each time updating a coefficient using the equation for `b[i]` described above.
  - Repeat the above loop until the solution converges.
 
 Here an R-outline of the algorithm...
 ```r
  # Determine the dimension of the system
  p=ncol(C)
  
  # Initialize b
  b=rep(0,p)
  
  # Define criteria to determine convergence
  tol=1e-4
  
  ready=FALSE
  
  while(!ready){ # this loop will stop when convergence is achieved
  
   bOLD=b # copy the current solution before updating
   for(i in 1:p){
    # update each coefficient using the formula discussed above
   }
   ready<-(max(abs(b-bOLD))<tol)
  }
  
  # comparing with an exact solution
  plot(b,solve(C,r));abline(a=0,b=1)
 ```
  
 <div id="gauss-seidel-example" />
  
 **Example for a 3x3 system**
 
 ```r
  X=cbind(1,rnorm(100),rnorm(100))
  y=10+X[,2]-2*X[,3] # no error, so we know the solution is b=(10,1,-2)
 
  C=crossprod(X)
  r=crossprod(X,y)
  
  solve(C,r)
  
  # Now Gauss seidel
  b=rep(0,3)
  
  # First iteration
    b[1]=(r[1]-C[1,2]*b[2]-C[1,3]*b[3])/C[1,1]
    b[2]=(r[2]-C[2,1]*b[1]-C[2,3]*b[3])/C[2,2]
    b[3]=(r[3]-C[3,1]*b[1]-C[3,2]*b[2])/C[3,3]
    b
    
  # Second iteration
    b[1]=(r[1]-C[1,2]*b[2]-C[1,3]*b[3])/C[1,1]
    b[2]=(r[2]-C[2,1]*b[1]-C[2,3]*b[3])/C[2,2]
    b[3]=(r[3]-C[3,1]*b[1]-C[3,2]*b[2])/C[3,3]
    b
    
   ## 3rd iteration

    b[1]=(r[1]-C[1,2]*b[2]-C[1,3]*b[3])/C[1,1]
    b[2]=(r[2]-C[2,1]*b[1]-C[2,3]*b[3])/C[2,2]
    b[3]=(r[3]-C[3,1]*b[1]-C[3,2]*b[2])/C[3,3]
    b
 ```
  
[Back to outline](#outline)
  
