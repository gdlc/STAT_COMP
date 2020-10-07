## In-Class assigment 8

Using a natural spline (with `DF=[3,4,6,8]`), applied to Galton's data set,  evaluate whether the relationship between offsprings' height has a linear relationship with parental average. 

Present a 2x2 panel of plots, each plot with offspring height (`$Height`) on the y-axis, parental average (`PA=($Father+$Mother)/2`) on the horizontal axis, grey (col=8) small points (cex=.5), and a red line representing the fitted spline. 


You can read the data into the R-environment using the following code


```r
 DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/GALTON.csv',header=TRUE,sep=',')
```
### Possible solution

```r
DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/GALTON.csv',header=TRUE,sep=',')
DATA$PA=(DATA$Father+DATA$Mother)/2

# Sort the data by parental average, otherwise the lines in the plot would not look good.
tmp=order(DATA$PA,decreasing=FALSE)
DATA=DATA[tmp,]

library(splines)
par(mfrow=c(2,2))
DF=c(3,4,6,8)

for(i in 1:4){
 X=ns(DATA$PA,df=DF[i],intercept=TRUE)
 fm=lm(Height~X-1,data=DATA)
 plot(Height~PA,cex=.5,col=8,data=DATA,
      xlab='Average parental height (inches)',ylab='Offspring Height (inches)',xlim=range(DATA$Height),ylim=range(DATA$Height))
 abline(a=0,b=1,lty=2) # adding a 45 degree line
 abline(h=mean(DATA$Height),lty=2);abline(v=mean(DATA$PA),lty=2) # adding the mean for y and x
 lines(x=DATA$PA,y=predict(fm),col=2)
}
```

### How to chose the optimal number of knots (DF)?

We can do this in multiple ways, including: (i) Comparing models based on a model-comparison criteria (e.g., Adjusted-R-squared, AIC, BIC, for AIC and BIC 'smaller is better'), or by (ii) comparing models based on their predictive ability in cross-validation (we will discuss the topic later on on this course). The exmaple below suggest that, according to AIC and BIC 3DF is the best model (not a surprise, the pattern is quite linear).


```r
COMP=data.frame(DF=DF, ADJ.R2=NA,AIC=NA, BIC=NA)

for(i in 1:4){
 X=ns(DATA$PA,df=DF[i],intercept=TRUE)
 fm=lm(Height~X[,-1],data=DATA) # note a difference with the above, code, I remove the intercept form X and let lm() add it back, 
                                # otherwise the report on R-square would be wrong.
 COMP$ADJ.R2[i]=summary(fm)$adj.r.squared
 COMP$AIC[i]=AIC(fm)
 COMP$BIC[i]=BIC(fm)
}
```



