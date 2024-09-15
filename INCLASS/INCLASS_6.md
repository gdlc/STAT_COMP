## IN-CLASS 6

### Use lm function to run linear regression on Abalone dataset

Abalone dataset (https://archive.ics.uci.edu/dataset/1/abalone) studies how the age of abalones (Rings + 1.5) is related to the other features, e.g., length and diameter.

In the practice, we want to use the function `lm` to build a model to predict Rings.

We use the following command to load the data

```r
abalone = read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/abalone.data', header = TRUE, sep=',')
```

**1)** Use `lm` function and obtain the coefficents of the regression model. Use all features to do the prediction.

**2)** Calculate the residual for each sample: the residual equals to the difference between the actual response and the predicted value.

After figuring out the residual for all samples, record the maximum and minimum residuals.


## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. If you have multiple files to submit, at least one of them is named as `assignment.R`.  You may submit your answer to Gradescope as many times as needed.

  - `Q1`: the coefficients of the model. Note that intercept should be included, and by default, it is the first element of the coefficient vector.
  - `Q2.max_res`, `Q2.min_res`: the maximum and minimum residuals.
