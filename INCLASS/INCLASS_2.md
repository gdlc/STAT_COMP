**In-class assignment 2**

For this assgiment you will use a prostate cancer data set available in the  following [web-adress](https://web.stanford.edu/~hastie/ElemStatLearn/data.html).

**1)** Read: use `read.table()` to read into the R-environment the prostate data set. Store your table in: `prostate_data`.

**2)** Write: use `write.csv` to write the data set into a comma-separated file `prostate.csv`, read it back into the R-environment using `read.csv()` and store the data into `prostate_data2`.

**3)** Summary statistics. Compute summary statistics for the variables `[lcavol,	lweight,	age,	lbph,	svi,	lcp,	gleasonv, pgg45, lpsa]`For columns 1-9 provide univariate summary statistics. For quantiative variables provide mean, median, and adequate quantiles (hint: try `summary()`), for categorical variables, frequency tables (try `table()`). 

**4)** Provide a histogram of ag

**5)** Bi-variate analysis. Using lpsa as a dependent variable, provide a plot of lpsa versus each of the other variables. Note: for quantitative predictors use scatterplot (`plot()` for categorical predictors use a boxplot of the response versus the predictor. Add a vertical red line on a plot and a horizontal blue line on a plot. Store the following as your answer:
  - `Q5_name`: the name of the function used to draw the lines. 

**6)** Multivariate: try `heatmap(cor(as.matrix(DATA[,1:9])),symm=TRUE)`. Store your answer in:
  - `Q6_heatmap`: the heatmap object.

**7)** Which variable appears to be most predictive of `lpsa`? 




## Submission to Gradescope

For your submission to grade scope provide an R-script named "assignment.R" (match case) answeromg the questions shown below If you have multiple files to submit, at least one of them is named as "assignment.R". You may submit your answer to Gradescope for multiple times. 

  - Question 1: 
  - Question 2: 
  - Question 3: 
  - Question 4: 
