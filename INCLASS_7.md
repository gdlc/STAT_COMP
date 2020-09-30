##### In-class assigment 7

Using the following simulation

```r
set.seed(195021)
x<-seq(from=0, to=2*pi,by=0.2)
f0<-function(x){ 100+sin(2*x)+cos(x/2) }
R2<-2/3
y<-f0(x)+rnorm(n=length(x),sd=sqrt(var(f0(x))*(1-R2)/R2))
plot(y~x)
lines(x=x,y=f0(x),col='red',lwd=2)

```


Fit step-functions with 2, 4, 6,...,20 bins (DF) and, for each model evaluate:

   - Model R-squared `summary(fm)$r.squared`
   - Model adjusted R-sq. `summary(fm)$adj.r.squared`
   - AIC  `AIC(fm)`
   - BIC  `BIC(fm)`
 
Report a table with models in rows, model DF, and each of the above criteria in columns.
