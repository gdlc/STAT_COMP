### IN-CLASS 16: Bootstrap

In this assignment we will use Bootstrap to produce confidence bands for logistic regression and compare those with confidence bands produced by inverting a CI for the linear predictor.

The objective is to predict the risk of develping gout by serum urate levels. Using the [GOUT](https://github.com/gdlc/STAT_COMP/blob/master/DATA/goutData.txt) data set, we fit a logistic regression model for gout as a function of serum urate.

Download the data set and in your `assignment.R` file read the data using exactly this code

**Script 1**

```R
 DATA=read.table('goutData.txt',header=TRUE)
 DATA$y=ifelse(DATA$gout=="Y",1,0)
```

Display

```
 fm=glm(y~su,data=DATA,family='binomial')
 summary(fm) 
```

Recall that in logistic regression,the predicted probability is `theta=exp(x'b)/(1+exp(x'b))`, see [handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/LogisticRegression.pdf) for details. We use this to predict the probability of developing gout as a function of `su`. 

```r
 su.grid=seq(from=3,to=12,by=1)
 phat=predict(fm,type='response',newdata=data.frame(su=su.grid))
 plot(phat~su.grid,col=2,xlab='Serum urate',ylab='P(Gout)',type='l',ylim=c(0,.5))
```

The predictions displayed in the plot are estimates that are subject to sampling variability. To quantify uncertainty about predictions we can create confidence intervals for each value of SU in the grid.  One way to do that is by first obtaining a CI for the linear predictor (mu+x'b) and then map this into an interval for the predicted probability of gout. This is illustrated in the example provided below.

```r
 LP=predict(fm,newdata=data.frame(su=su.grid),se.fit=TRUE,type='link')

 # CI for the linear predictor
  CI.LP=cbind('LB'=LP$fit-1.96*LP$se.fit ,'UB'=LP$fit +1.96*LP$se.fit)

 # CI for the predictd probability
  CI.PROB=exp(CI.LP)/(1+exp(CI.LP))
```

To visualize your results you can use the following code
(do not include this script in the `assignment.R` file.

```r
 plot(phat~su.grid,col=2,xlab='Serum urate',ylab='P(Gout)',type='l',ylim=c(0,.5))
 lines(CI.PROB[,1],x=su.grid,col='blue',lty=2)
 lines(CI.PROB[,2],x=su.grid,col='blue',lty=2)
```

  
   
**2) Task: use Bootstrap to generate confidence bands for predicted probabilities from Logistic Regression**

Use `nB=100` Bootstrap samples to create a 95% confidence band for predicted risk for `su.grid=c(4,7,10)`.

```r
 su.grid=c(4,7,10)
 nB=100
```

 1. Create a matrix PHAT, with `ncol=length(su.grid)`, and `nropw=nB`
 2. In a loop from 1:nB
     - Generate a Bootstrap sample `TMP=DATA[sample(1:nrow(DATA),replace=TRUE),]`
     - Fit the glm model using the bootstrap data (`TMP`)
     - Use the fited model and the `su.grid` (4,7,10) as newdata `predict(fm,type='response',newData=data.frame(su=su.grid))` to predict probability of gout by level of serum urate.
     - Save those predictions in the ith column of the PHAT matrix

 3. Estimate the 0.025 and 0.975 quantiles by applying, the `quantile` function to the rows (`MARGIN=`1) of `PHAT`)
 
**Script 2**

```R
 CI.Bootstrap=apply(FUN=quantile, prob=c(.025,.975),X=PHAT,MARGIN=2)
 colnames(CI.Bootstrap)=c("LB","UB")
```
(end of script 2)

## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case). 

Your script must read the data using **Script 1** (above) and then it should generate the bootstrap samples and estimate the confidence bounds in an object named `CI.Bootstrap` (see Script 2, above).

