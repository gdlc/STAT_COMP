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
