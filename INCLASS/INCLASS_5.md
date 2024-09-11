In this assignments we will work on inverting full-rank and rank-deficient matrices and checking the properties of such inverses.


To complete the assignment you must install the MASS package. In many R-installations it may come installed. To check it try:

```{r}
 library(MASS)
```

If you don't have it, you can install it using this script

```{r,eval=FALSE}
 install.packages(pkg='MASS',repos='https://cran.r-project.org/')
```
### 1) Full rank matrix


Symmetric positive definite matrices (SPD) play a central role in statistical models. SPD matrices have a positive determinant.

The following script generate a SPD 3x3 matrix.


```{r}
  A=diag(c(1,1.2,1))
  A[1,2]= A[2,1]=0.5
  A[2,3]= A[3,2]=.2
  A[1,3]= A[3,1]=-0.2
```

The following script test for the symmetry

```{r}
 all(A==t(A))
```


 - Store in a variable named `Q1.1` the determinant of A.
 - Store in a variable named `Q1.2` the inverse of A.
 
 

**Note**: Since A is positive definite, the determinant must be positive.

If `Z` is the inverse of `A`, then we have that `ZA=AZ=I`. In the following two questions you will verify it.

 - Store in a variable named `Q1.3` the result of post-multiplying `A` by `Q1.2`.
 - Store in a variable named `Q1.4` the result of pre-multiplying `A` by `Q1.2`.


**Note**: to check you are getting an identity matrix in both Q1.3 and Q1.4, you can round the result to double precision (`round(X,.Machine$double.eps)` rounds X to double precision).


### 2) Rank-deficient matrices

The following script generates a rank-deficient symmetric (positive semi-definite) matrix.

```{r}
  set.seed(195021)
  X=matrix(nrow=3,ncol=5,rnorm(15))
  B=crossprod(X)
```

 -  Store in a variable named `Q2.1` the determinant of `B`.
 
 **Note:** since the matrix is rank-deficient, the determinant you get must be zero after rounding to double precision.

What happens if you try to invert it (try: `solve(B)`)?


 - Store in a variable named `Q2.2` a generalized invers of `B` derived using the `ginv()` function of the MASS R-package.
 
 
 - Store in a variable named `Q2.3` the product `B%*%Q2.2%*%B`
 
**Note**: for a generalized inverse `B%*%Q2.2%*%B` must be equal to B up to double precision.


