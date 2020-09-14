### Due Sept. 12th, 4:20pm in D2L


The data sets used in the book "The Elements of Statistical Learning (Hastie, Tibshirani, and Friedman) are available at the following [web-adress](https://web.stanford.edu/~hastie/ElemStatLearn/data.html).

For each data set, you will find a description and a link to the data.


**1)** Read: use `read.table` to read into the R-environment the prostate data set.

**2)** Write: use `write.table` to write the data set into a comma-separated file (e.g., `prostate.csv`) 

**3)** Read back the data into the R environment (use a different object name, e.g., `DATA2`)

**4)** Compare the dimensions and the content (hint: could try `all.equal(DATA,DATA2)`) of the two objects

**5)** For columns 1-9 provide univariate summaries: adequate summary statistics for each variable. Note: for quantiative variables provide mean, median, sd, and adequate quantiles (hint: try `summary()`), for 
categorical variables, frequency tables (try `table()`).

**6)** For columns 1-9 provide a histogram of each variable

**7)** Bi-variate analysis. Using lpsa as a dependent variable, provide a plot of lpsa versus each of the other variables. Note: for quantitative predictors use scatterplot (`plot()` for categorical predictors use a boxplot of the response versus the predictor.

**8)** Multivariate: try `heatmap(cor(as.matrix(DATA[,1:9])),symm=TRUE)`

**9)** What variables appear to be most predictive of `lpsa`?


### Sample Answer

```r
 ## 1)
  DATA=read.table('https://web.stanford.edu/~hastie/ElemStatLearn/datasets/prostate.data') 
  dim(DATA)
  head(DATA)
  str(DATA)

 ## 2)
  write.table(DATA,file='~/Desktop/prostate_data.txt',sep='\t')
 
 ## 3)
  DATA2=read.table('~/Desktop/prostate_data.txt',header=TRUE)

 ## 4)
  all.equal(DATA,DATA2)

 ## 5)
  summary(DATA[,-c(5,9)]) 
  table(DATA[,5])
 
 ## 6) 
 for( i in 1:8){ # will discuss loops in today's class
  hist(DATA[,i])
 }
 
 ## If you want to put them in a single plot
 par(mfrow=c(4,2))
  
 for( i in 1:8){ # will discuss loops in today's class
  hist(DATA[,i],xlab=colnames(DATA)[i])
 }
 
 ## 7)
  # For the binary predictor
  dev.off() # closing the 4x2 panel
  boxplot(lpsa~svi,data=DATA)
  
  par(mfrow=c(4,2))
  for( i in c(1:4,6:8)){
    plot(lpsa~DATA[,i],data=DATA,xlab=colnames(DATA)[i])
  }
  
  ## 8) Heatmap
  round(cor(DATA[,1:9]),2)
  
  heatmap(cor(as.matrix(DATA[,1:9])))
 
```

From the above analysis: all variables are positvely correlated with log-psa, lcavol and svi appear thto be the ones with strongests association.
