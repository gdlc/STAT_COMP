
#### Using Bootstrap to produce confidence bands for logistic regression

**Objective:** To predict risk of develping gout by serum urate levels.

The example below fits a logistic regression for gout as a function of serum urate.

```R
   DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/goutData.txt',
                    header=TRUE)
   DATA$y=ifelse(DATA$gout=="Y",1,0)
   fm=glm(y~su,data=DATA,family='binomial')
   summary(fm) 
```

**Prediction**

Recall that in logistic regression,the predicted probability is `theta=exp(x'b)/(1+exp(x'b)), see [handout](https://github.com/gdlc/STAT_COMP/blob/master/LogisticRegression.pdf) for details. We use this
to predict the probability of developing gout as a function of SU. 

```r
 su.grid=seq(from=4,to=10,by=.1)
 
 bHat=coef(fm)
 
 X=cbind(1,su.grid)
 ETA=X%*%bHat
 phat=exp(ETA)/(1+exp(ETA))
  
 # alternatively, you can use the function predict()
 phat_2=predict(fm,newdata=data.frame(su=su.grid),type='response')
  
 head(cbind(phat,phat_2))
 # Plot
  plot(phat~su.grid,col=2,xlab='Serum urate',ylab='P(Gout)',type='l',ylim=c(0,.35))
 ```

**Task**

Use 500 Bootstrap samples to create a 95% confidence band for predicted risk by level of SU

Suggestions:
 - i) Create a matrix PHAT, with `nrow=length(su.grid)`, and `ncol=500`
 - ii) Generate a bootstrap sample `TMP=DATA[sample(1:nrow(DATA),replace=TRUE),]`
 - iii) Fit the model using the bootstrap sample
 - iv) Use the fited model and `su.grid` to predict probability of gout by level of serum urate.
 - v) Fill the 1st column of PHAT with predictions from the fitted model
 - vi) Did it work? Do predictions makes sense? If yes, embed steps ii-iv into a for loop (from i in 1:500) and fill the 
     columns of PHAT with the predictions that you generate for each bootstrap sample
 - vii) Compute quantiles using `apply(FUN=quantile,MARGIN=1,prob=c(.025,.975))`
 viii) Add confidence bands to the plot using the results of `apply`.
