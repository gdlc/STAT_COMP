**In-class assignment 2. Due date: Thursday 31st of August 2023**

Please name your script as "assignment.R" (match case) when submitting to Gradescope. If you have multiple files to submit, at least one of them is named as "assignment.R". You may submit your answer to Gradescope for multiple times. 

The data sets used in the book *The Elements of Statistical Learning* (Hastie, Tibshirani, and Friedman) are available at the following [web-adress](https://web.stanford.edu/~hastie/ElemStatLearn/data.html).

For each data set, you will find a description and a link to the data.

**1)** Read: use `read.table` to read into the R-environment the prostate data set. Store your table in:
  - `prostate_data`

**2)** Write: use `write.table` to write the data set into a comma-separated file `prostate.csv`. No need to store anything for this question.

**3)** For columns 1-9 provide univariate summaries: adequate summary statistics for each variable. Note: for quantiative variables provide mean, median, and adequate quantiles (hint: try `summary()`), for categorical variables, frequency tables (try `table()`). Store your answers in:
  - `Q3_summaries`: The output item of the `summary` function for all the 9 columns.

**4)** For columns 1-9 provide a histogram of each variable. Store your answers in:
  - `Q4_histograms`: a list with 9 elements. The first element is the histogram object of column 1, the second element is the histogram object of column 2, etc. (hint: store `hist(your_variable)` in the list, and use the default value of bin numbers in the function) 

**5)** Bi-variate analysis. Using lpsa as a dependent variable, provide a plot of lpsa versus each of the other variables. Note: for quantitative predictors use scatterplot (`plot()` for categorical predictors use a boxplot of the response versus the predictor. Add a vertical red line on a plot and a horizontal blue line on a plot. Store the following as your answer:
  - `Q5_name`: the name of the function used to draw the lines. 

**6)** Multivariate: try `heatmap(cor(as.matrix(DATA[,1:9])),symm=TRUE)`. Store your answer in:
  - `Q6_heatmap`: the heatmap object.

**7)** Which variable appears to be most predictive of `lpsa`? Store your answer in:
  - `Q7_variable`: the name of the variable.

