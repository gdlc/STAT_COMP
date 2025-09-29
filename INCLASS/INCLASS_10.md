## In-class assigment 10

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


Fit cubic splines (degree=3 in bs function) with 4,6,...,20 degrees of freedom (df in bs function)(number of `knots` + 4) and, for each model evaluate:

   - Model R-squared `summary(fm)$r.squared`
   - Model adjusted R-sq. `summary(fm)$adj.r.squared`
   - [AIC](https://en.wikipedia.org/wiki/Akaike_information_criterion)  `AIC(fm)`
   - [BIC](https://en.wikipedia.org/wiki/Bayesian_information_criterion)  `BIC(fm)`
 
Report a table with models in rows, model DF, and each of the above criteria in columns. Please use `intercept=FALSE` when using `bs`.

What model do you choose? Why?


## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. If you have multiple files to submit, at least one of them is named as `assignment.R`.  You may submit your answer to Gradescope as many times as needed.

  - Include in your script a `data.frame` named answers, with your results:

    `  ANS=data.frame(df=seq(from=4,to=20,by=2), AdjRSq=NA,AIC=NA,BIC=NA,select=FALSE) `
    
  - Fill the table with your results and set to `TRUE` the row corresponding to the model you choose, in the column names `select`.
