
**1)** Create a function that computes the transpose of a matrix without using `t()`.



The transpose of matrix **X** (denoted as **X**') is defined as a matrix that satisfy: ncol(**X**')=nrow(**X**), nrow(**X**')=ncol(**X**), **X**'[i,j]=**X**[j,i].

The function `t()` in R produces the matrix transpose:

```r
 X=matrix(nrow=4,ncol=3,data=rnorm(12))
 Xt=t(X)
 dim(X)
 dim(Xt)
 X
 Xt
```

**Task**: Create a function (`myT()`) that will take a matrix and will return it's transpose. Inside the function you cannot use the `t()` funciton, instead, use loops to produce the transpose. You can use the following matrix to test it.

```r
 z=c('a','b','c','d','e','f','g','h','i')
 X=matrix(nrow=3,ncol=3,data=z)
 print(X)
 print(t(X)) 
 print(myT(X))

```

Repeat using: `X=matrix(nrow=3,ncol=3,data=z,by.row=TRUE)`

What do you learned about the way data is stored inside a matrix?

**2)** Create an R-function to compute the matrix product (`myproduct()`) that only uses loops and scalar operations, test it with two (confrormable) matrices, and compare your result with that of `%*%`. The function `myproduct()` should receive two input arguments as the two matrices.

## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. If you have multiple files to submit, at least one of them is named as `assignment.R`.  You may submit your answer to Gradescope as many times as needed.

  - Include in your script the definition of the functions `myT()` and `myproduct()`, we will test both functions with an arbitrary example. 
