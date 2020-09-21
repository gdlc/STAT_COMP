### Due Sept. 18th, 1:00pm in D2L


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

**Hint 1**: Consider structuring the task into the following sub-tasks: 
  1) create a small matrix (e.g., 3, rows 2 columns) to use as an example,  
  2) determine dimensions of the input matrix using `nrow()` and `ncol()`, 
  3) create another object (e.g., `Xt`) with the expected dimensions of the transpose, 
  4) consider using a loop nested within another loop to fill the entries of the transpose from the entries of the input matrix,  
  5) test your code, 
  6) only when your code is running and tested, wrap it up into a function (don't forget to return), 
  7) test again!


#### Proposed solution


```r
 myT=function(x){
  nRow=nrow(x)
  nCol=ncol(x)
  xt=matrix(nrow=nCol,ncol=nRow,NA)
  for(i in 1:nCol){
   for(j in 1:nRow){
     xt[i,j]=x[j,i]
   }
  }
  return(xt)
 }

```
