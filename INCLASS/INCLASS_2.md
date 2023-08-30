**In-class assignment 2. Due date: Thursday 31st of August 2023**

The data sets used in the book *The Elements of Statistical Learning* (Hastie, Tibshirani, and Friedman) are available at the following [web-adress](https://web.stanford.edu/~hastie/ElemStatLearn/data.html).

For each data set, you will find a description and a link to the data.


**1)** Read: use `read.table` to read into the R-environment the prostate data set.

**2)** Write: use `write.table` to write the data set into a comma-separated file (e.g., `prostate.csv`) 

**3)** Read back the data into the R environment (use a different object name, e.g., `DATA2`)

**4)** Compare the dimensions and the content (hint: could try `all.equal(DATA,DATA2)`) of the two objects

**5)** For columns 1-9 provide univariate summaries: adequate summary statistics for each variable. Note: for quantiative variables provide mean, median, and adequate quantiles (hint: try `summary()`), for categorical variables, frequency tables (try `table()`).

**6)** For columns 1-9 provide a histogram of each variable

**7)** Bi-variate analysis. Using lpsa as a dependent variable, provide a plot of lpsa versus each of the other variables. Note: for quantitative predictors use scatterplot (`plot()` for categorical predictors use a boxplot of the response versus the predictor. Add a vertical red line on a plot and a horizontal blue line on a plot.

**8)** Multivariate: try `heatmap(cor(as.matrix(DATA[,1:9])),symm=TRUE)`

**9)** What variables appear to be most predictive of `lpsa`?

