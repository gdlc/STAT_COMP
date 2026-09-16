## INCLASS 5: Matrix determinant, inverse and generalized inverse


To complete the assignment you will use the Matrix and MASS packate

```{r}
 library(Matrix)
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


 - Store in a variable named `Q2.2` a generalized inverse of `B` derived using the `ginv()` function of the MASS R-package.
 
 
 - Store in a variable named `Q2.3` the product `B%*%Q2.2%*%B`
 
**Note**: for a generalized inverse `B%*%Q2.2%*%B` must be equal to B up to double precision.

### 3) Computing determinants using the LU-factorization

Create a function (name `myDet()`) that takes as input a square matrix and returns its determinant. Do not use `det()`, instead, use the following code to factorize the matrix unto a lower- and upper-triangular factors (LU), use results regarding the determinant of lower- and upper-triangular matrices to compute and return the determinant. 

Here is some toy code that may be useful

```r
 library(Matrix)
 A=diag(c(1,2)); A[2,1]=A[1,2]=0.45

 LU=expand(lu(A))
 L=LU$L
 U=LU$U

```


