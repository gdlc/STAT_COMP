### Ordnary Least Squares (OLS)

Consider a linear regression of the form **y**=**Xb**+**e**. The OLS estimates of the vector of regression coefficients is given by
<br />
<br />
      **bHat**=argmin{  RSS(**y**,**X**,**b**) }
<br />
<br />

Where:   RSS(**y**,**X**,**b**)=(**y**-**Xb**)'(**y**-**Xb**) is the residual sum of squares.
<br />
<br />

The solution of the above problem can be obtained from the following systems of equatrions
<br />
<br />
(**X**'**X**)**b**=**X**'**y**
<br />
<br />

#### (1) Estimation (full-rank case)

**Computation of OLS estimates using `lm`, `lsfit` and with matrix operations.**

```r
   fm=lm(y~X) ;coef(fm) ; summary(fm)
   
   fm=lsfit(y=y,x=X); coef(fm)    # a bit faster than lm
   
   XtX=crossprod(X)     # matrix of coefficients, X'X
   Xty=crossprod(X,y)   # right-hand side X'y
   bHat=solve(XtX,Xty)  # solution

```

#### (2) OLS regression with categorical predictors.

Above we assumed that our predictors were all numeric (or at least quantitative). We can introduce categorical predictors using dummy variables. 

**Discuss in class**:
  * Introducing categorical predictors using dummy variables
  * Parameteri interpretation
     

**Examples**

For this class we will use the following [dataset](https://www.dropbox.com/s/iwkmmytsulmkwjf/gout.txt?dl=0)

Tasks:
  * Read the data set and produce univariate descriptive statistics (frecuencies for categorical variables, means, SD, etc. for quantitative variables).
  * Bivariate descriptive statistics: scatter plot serum urate versus age, boxplot of serum urate by sex and race.
  * Estimate effects uisng lm with dummy coding.
  * Fill the following table.
     
     
| Sex, Race, Age              | Dummy coding|
| ------------- |:-------:|
| M  W  50     |  |
| F  W  50      |        |
| M  B  50  |           |
| M  B  50  |           |
| M  W  60     |    |
| F  W  60            |    |
| M  B  60        |     |
| M  B  60        |     |


