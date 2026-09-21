## IN-CLASS 6

### Use lm function to run linear regression on Abalone dataset

Abalone is a seashell that lives in oceans costlines around the world. The age of an abalone is approximately the number of rings + 1.5.

For this assignment you will use the following abalone dataset (https://archive.ics.uci.edu/dataset/1/abalone).

We use the following command to load the data

```r
 abalone = read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/abalone.data', header = TRUE, sep=',')
```

**1)** Use `lm` function to regress the number of rings on all other predictors. 


**2)** Calculate the residual for each sample, use these residuals to compute the residual sum of squares. 

## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. If you have multiple files to submit, at least one of them is named as `assignment.R`.  You may submit your answer to Gradescope as many times as needed.

  - `Q1`: store the the coefficients of the model. Note that intercept should be included, and by default, it is the first element of the coefficient vector.
  - `Q2`: store here the residual sum of squares (RSS)

