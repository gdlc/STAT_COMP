### IN-CLASS 16: Bootstrap

In this assignment we will use Bootstrap to produce confidence bands for logistic regression and compare those with confidence bands produced by inverting a CI for the linear predictor.

The objective is to predict the risk of develping gout by serum urate levels. Using the [GOUT](https://github.com/gdlc/STAT_COMP/blob/master/DATA/goutData.txt) data set, we fit a logistic regression model for gout as a function of serum urate.

Download the data and in your `assignment.R` file read the data using exactly this code

**Script 1**
```R
 DATA=read.table('goutData.txt',header=TRUE)
 DATA$y=ifelse(DATA$gout=="Y",1,0)
 fm=glm(y~su,data=DATA,family='binomial')
 summary(fm) 
```


Recall that in logistic regression,the predicted probability is `theta=exp(x'b)/(1+exp(x'b))`, see [handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/LogisticRegression.pdf) for details. We use this to predict the probability of developing gout as a function of `su`. 

```r
 su.grid=c(4,7,10)
 phat=predict(fm,type='response',newdata=data.frame(su=su.grid))
 plot(phat~su.grid,col=2,xlab='Serum urate',ylab='P(Gout)',type='l',ylim=c(0,.5))
```

 **1) Confidence bands using methods previoulsy discussed in class**

We discussed how to produce confidence bands for predictions by:
   - Producing a CI for the linear predictor
   - Mapping that CI into a probability scale using the inverse-logit (`theta=exp(x'b)/(1+exp(x'b))`).

The following code produces confidence bands using that approach

**Script 2**
```r
 LP=predict(fm,newdata=data.frame(su=su.grid),se.fit=TRUE,type = 'response')
 CI.LP=cbind('LB'=LP$fit-1.96*LP$se.fit ,'UB'=LP$fit +1.96*LP$se.fit) 
 CI.PROB=exp(CI.LP)/(1+exp(CI.LP))
```

To visualize your results you can use the following code
(do not include this script in the `assignment.R` file.

```r
 plot(phat~su.grid,col=2,xlab='Serum urate',ylab='P(Gout)',type='l',ylim=c(0,.5))
 lines(CI.PROB[,1],x=su.grid,col='blue',lty=2)
 lines(CI.PROB[,2],x=su.grid,col='blue',lty=2)
```

  
   
**2) Confidence bands using Bootstrap**

Use n=5000 Bootstrap samples to create a 95% confidence band for predicted risk for `su.grid=c(4,7,10)`.

 1. Create a matrix PHAT, with `nrow=length(su.grid)`, and `ncol=n`
 2. In a loop from 1:n:
     - Generate a bootstrap sample `TMP=DATA[sample(1:nrow(DATA),replace=TRUE),]`
     - Fit the model using the bootstrap data (`TMP`)
     - Use the fited model and `su.grid` as newdata to predict probability of gout by level of serum urate.
     - Save those predictions in the ith column of the PHAT matrix

 3. Estimate the 0.025 and 0.975 quantiles by applying, the `quantile` function to the rows (`MARGIN=`1) of `PHAT`)
 4. Store the estimated Confidence intervals in the following object and compare it with `CI.LP`

```R
 CI.BS=matrix(nrow=length(su.grid),ncol=2)
 colnames(CI.BS)=c("LB","UB")
```

## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case). 

Your script must read the data using **Script 1** (above) and then it should generate the bootstrap samples and estimate the confidence bounds.

Your script should include 2 matrices named `CI.LP` and `CI.BS`, each assigned to the confidence bands obtained using Linear predictor and Boostrap methods respectively.

