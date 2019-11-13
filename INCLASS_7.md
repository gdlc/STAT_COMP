

Using the [wages](https://github.com/gdlc/STAT_COMP/blob/master/wages.txt) datatset generate a plot of wages versus income, by sex, and att 95% confidence bands to each of the regressions,.

**Reading the data**

```r

## Reading the data set
 DATA=read.table('~/Desktop/wages.txt',header=T,stringsAsFactors=F)

## model

  model='Wage~Education+South+Black+Hispanic+Sex+Married+Experience+Union'  
  fm=lm(model,data=DATA)
  


```
