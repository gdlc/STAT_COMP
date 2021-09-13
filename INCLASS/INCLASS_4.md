
Use R-studio to implement and report resutls from (in either pdf, word, or html format) the following tasks.



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

**Task**: Create a function (`myT()`) that will take a matrix and will return it's transpose. Inside the function you cannot use the `t()` funciton, instead, use loops to produce the transpose. 

Print an R-Markdown block with the function code, then use it to print the following matrix and its transpose.

```r
 z=c('a','b','c','d','e','f','g','h','i')
 X=matrix(nrow=3,ncol=3,data=z)
 print(X)
 print(t(X)) 
 print(myT(X))

```

Repeat using: `X=matrix(nrow=3,ncol=3,data=z,by.row=TRUE)`

What do you learned about the way data is stored inside a matrix?
