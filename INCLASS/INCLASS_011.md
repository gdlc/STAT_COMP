## INCLASS 10: Gauss-Seidel


Write a function `fitLogisticReg=function(formula,data)` that estimates coefficients for a logistic regression model.

Here is an outline of the function


```r

 fitLogisticReg(formula,data){
  # 1) create y (response) and X from the formula and data
  # 2) center the columns of X (except the one for the intercept) this won't change estimates and will facilitate convergence
  # 3) check that the response has only two levels length(unique(y))==2, is 0/1 (trhough an error with a message if not), force it to be 0/1 (e.g., as.integer(as.factor(y)))
  # 4) Create a function to evaluate the negative log-likelihood function of the logistic regression negLogLik=function(y,X,b){}, see  https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/LogisticRegression.md
  #    This function can be defined within this function.
  # 4) Initialize parameters, suggestion: initialize the intercept to log(mY/(1-mY)) where mY=mean(y) and all the other coefficients equal to zero
  # 5) Call optim()
  # 6) Extract estimates and return 
 }

```


## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below.

Include in your script the definition of the functions `fitLogisticReg()` and any other functions that you developed and are used by `fitLogisticReg()`.

