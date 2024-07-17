**In-class assignment 2**

For this assgiment you will use a prostate cancer data set available in the  following [web-adress](https://web.stanford.edu/~hastie/ElemStatLearn/data.html).

**1)** Read: use `read.table()` to read into the R-environment the prostate data set. Store your table in: `DATA`.

**2)** Write: use `write.csv` to write the data set into a comma-separated file `prostate.csv`, read it back into the R-environment using `read.csv()` and store the data into `DATA2`. Hint: you can use row.names=1 to let `read.csv` know that the first column are ronwames.

**3)** Summary statistics. Compute summary statistics for the variables `[lcavol,	lweight,	age,	lbph,	svi,	lcp,	gleason, pgg45, lpsa]`. For quantiative variables provide mean, median, and adequate quantiles (hint: try `summary()`), for categorical variables, frequency tables (try `table()`). 

**4)** Provide a histogram of ag

**5)** Bi-variate analysis. Using lpsa as a dependent variable, provide a plot of lpsa versus each of the other variables. Note: for quantitative predictors use scatterplot (`plot()` for categorical predictors use a boxplot of the response versus the predictor. 

**6)** Multivariate: try `heatmap(cor(as.matrix(DATA[,1:9])),symm=TRUE)`. 

**7)** Which variable appears to be most predictive of `lpsa`? 


## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. If you have multiple files to submit, at least one of them is named as `assignment.R`.  You may submit your answer to Gradescope as many times as needed.


  - Store in vectors named `Q3.mean` and `Q3.median` the mean and median of each of the variables listed above. Name the vector with the variable name.
  - Store in  a vector named `COR` the correlation of each variable with `lpsa`, name the vector with the variable name. Your vector should have a length of 8, each entry corresponding to the correlation between one predictor and `lpsa`.
  - Store in a variable named `top_predictor` the variable name of the top predictor of lpsa.
