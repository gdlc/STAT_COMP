### A) Logistic Regression

Using this data set [gout data set](https://github.com/gdlc/STAT_COMP/tree/master/DATA) fit a logistic regression model with gout ( recoded as 0/1, 1=Yes, 0=No) as the response and race, sex, and age as predictors.

Download the data and read it via

```r
  GOUT=read.table('goutData.txt',header=TRUE)
```

Test each of the factors (race/sex/age) separately using likelihood ratio test. To do this, for each factor, fit the model without that factor (H0), extract the log-likelihood (logLik(H0)), determine the DF (difference in the number of paramters between H0 and HA (the full model including sex, age, and race) and compute a p-value using `pchisq()`.

Store your results into the following `data.frame`.

```r
 ANS=data.frame(factor=c('Race','Sex','Age'),DF=NA,logLik=NA,chisq=NA,pValue=NA)
```

The `DF`, `logLik`, `chisq`, and `pValue`, should report the results of the Likelhood Ratio Tests for each of the factors. 



#### B) Develop a function to fit a logistic regression using optim()

To do this, you should develop two functions:

- `negLogLik = function(y,X,b)`: a function that evaluates (and returns) the negative logLikelihood of a logistic regression model of the form `y=Xb+e`, where `y` is the response (0/1) and `X=model.matrix(~ your model, data= your data..)` is the incidence matrix for your model.
- `fitLogisticReg=function(y,X)`

```r
  fitLogisticReg=function(y,X){
     # center all columns of X, except the (first) one that corresponds to the intercept
     # Initialized coefficients (see Hint below)
     # call optim (hessian=TRUE)
     # extract estimates
     # extract the hessian and compute the (co)variance matrix of estimates
     # create a table with the following
     OUT=data.frame(predictor=colnames(X),Estimate=NA,SE=NA,tStat=NA,pValue=NA)
     # fill the table
     return(OUT)
  } 
```

**Hint**: In your `fitLogisticReg()`, to facilitat convergence, center all columns of X (except the one corresponding to the intercept), and use as initial values the folloiwng `b=c(log(mean(y)/mean(1-y)),rep(0,ncol(X)-1))`.

To test your functions:

  - Evaluate the log-likelihood of the model you fitted in (A) by passing to your `negLogLik()` function `y`, `X`, and the esitmated coefficient you got in (A). Your result should be the same as `-logLik(fm)` where `fm` is the model you fitted in part (A).
  - Test `fitLogisticReg()` by fitting the model you fit in part (A) using your function. Compare the results obtained with your function with those of `summary(fm)`.


## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. If you have multiple files to submit, at least one of them is named as `assignment.R`.  You may submit your answer to Gradescope as many times as needed.

Include in your script the table `ANS` generated in Part A as well as the two functions that you were asked to develop for part B.
