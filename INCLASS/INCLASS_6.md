## IN-CLASS 6

### Use lm function to run linear regression on Abalone dataset

Abalone is a seashell that lives in oceans costlines around the world. The age of an abalone is approximately the number of rings + 1.5.

For this assignment you will use the following abalone dataset (https://archive.ics.uci.edu/dataset/1/abalone).

We use the following command to load the data

```r
 DATA= read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/abalone.data', header = TRUE, sep=',')
```

**1)** Use `lm` function to regress the number of rings on all other predictors. (Hint: using `lm(y~. data=DATA)` fits a regression of `y` on all the other variables that appear in `DATA`).


**2)** Calculate the residual for each sample, use these residuals to compute the residual sum of squares. 

**3)** When we call `lm()` with a formula interface, this function first creates the incidence matrix (`X`) for the linear model `y=Xb+e`, by default this matrix contains a column of 1's (for the intercept), one column per quantitative covaraite, and as many columns of q-1 per factor (or character) variable in the model (here q is the number of levels of the factor).

Task: Create an incidence matrix for the linear model fitted in 1) using `X=model.matrix(...)`, then fit a second model 

```r
 fm2=lm(Rings~X-1,data=DATA)
```

Compare the results in fm2 with those of the first linear model you obtained.

## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. If you have multiple files to submit, at least one of them is named as `assignment.R`.  You may submit your answer to Gradescope as many times as needed.

  - `Q1`: store the the coefficients of the model. Note that intercept should be included, and by default, it is the first element of the coefficient vector.
  - `Q2`: store here the residual sum of squares (RSS)
  - `Q3 `: store here the average difference in the number of rings for Sex=I and Sex=M (I minus M), holding everything else constant.
  - `Q4`: store here the matrix `X` created using `model.matrix()`.

