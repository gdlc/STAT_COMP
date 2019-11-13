

Using the [wages](https://github.com/gdlc/STAT_COMP/blob/master/wages.txt) datatset generate a plot of wages versus income, by sex, and att 95% confidence bands to each of the regressions,.

**Reading the data**

```r

## Reading the data set
 DATA=read.table('~/Desktop/wages.txt',header=T,stringsAsFactors=F)

## model

  model='Wage~Education+South+Black+Hispanic+Sex+Married+Experience+Union'  
  fm0=lm(model,data=DATA)
  summary(fm0)
  # Pediction equation
   ED=6:18
  Z=cbind(1,ED,0,0,0,0,0,4,0) # male, north, not married, non-union, white, 4 yr of experience
  head(Z)
  yHat=Z%*%coef(fm0)
  plot(yHat~ED,type='o',col=4)

```


**TASK**
   - Generate 5000 bootstrap samples of yHat (store them in a matrix)
   - For each value of ED, estimate a 95% CI for yHat
   - Plot the predicted equation (using fm0, see code above)
   - Add, to each of the predicted point a vertical line with the estimated 95% CI 
