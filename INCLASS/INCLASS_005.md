## INCLASS 5: Matrix determinant, inverse and generalized inverse


To complete the assignment you will use the Matrix and MASS packate

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
 - Store in a variable named `Q1.2` the determinant of the inverse of A.
 
 

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



## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below.

Include in your script the variables `Q1.1`, `Q1.2`, `Q2.1`, `Q2.3`, and `Q2.3`


