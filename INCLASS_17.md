### Model Comparison using AIC/BIC/Adjusted R-2 and out-of-sample prediction proportion of variance explaineds.



Recall the wages data set

```r
 DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/wages.txt',header=TRUE)
 
```

Consider these two competing hypotheses:   H1: `Wage~Sex+Education+Experience`, H2: `Wage~.`

We want to compare these models using:

  1. F-test `anova(fm1,fm2)`
  2. Within-sample R-squared `summary(fm)$r.squared`
  3. Adjusted R-sq ` summary(fm)$adj.r.squared`
  4. AIC and BIC `AIC(fm)`, smaller is better
  5. Out-of-sample proportion of variance explained (PVE) estimated in 100 training testing partitions.


  - Fit the two models to the full data set, (1)-(4)
  - Conduct 100 training-testing evaluations (nTesting=100) to estimate PVE for H1 and H2 (5).
  - Report a table with AIC,BIC,Training R-sq., Training adj-Rsq. and PVE for each of the models.
  - Which model do you choose? Why?

##### Possible solution

```r
DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/wages.txt',header=TRUE)

H0="Wage~Sex+Education+Experience"
HA="Wage~."

fm0=lm(H0,data=DATA)
fm1=lm(HA,data=DATA)

## 100 Training-testing partitions
 PVE0.TST=rep(NA,100)
 PVE1.TST=rep(NA,100)
 PVE0.TRN=rep(NA,100)
 PVE1.TRN=rep(NA,100)
 nRep=100
 N=nrow(DATA)

 for(i in 1:nRep){
	tst=sample(1:N,size=100,replace=FALSE)
	tmp=rep(TRUE,N)
	tmp[tst]=FALSE
	tmp0=lm(H0,data=DATA,subset=tmp)
    tmp1=lm(HA,data=DATA,subset=tmp)
    
    
    ## Goodness of fit in the training set
     y=DATA$Wage[-tst]
	 yHat0=predict(tmp0,newdata=DATA[-tst,])
	 yHat1=predict(tmp1,newdata=DATA[-tst,])
     
	 SSy=sum((y-mean(y))^2)
     PVE0.TRN[i]=1-sum((y-yHat0)^2)/SSy
     PVE1.TRN[i]=1-sum((y-yHat1)^2)/SSy    
     rm(y,yHat0,yHat1)
    
    ##  Prediction accuracy in the testing set
     y=DATA$Wage[tst]
	 yHat0=predict(tmp0,newdata=DATA[tst,])
	 yHat1=predict(tmp1,newdata=DATA[tst,])    
    
	 SSy=sum((y-mean(y))^2)
     PVE0.TST[i]=1-sum((y-yHat0)^2)/SSy
     PVE1.TST[i]=1-sum((y-yHat1)^2)/SSy  
 }

## Comparisons

  ANS=matrix(nrow=5,ncol=2,NA)
  colnames(ANS)=c('H0','HA')
  rownames(ANS)=c('RSq','Adj-RSq','AIC','BIC','PVE')
  
  ANS['RSq',1]=round(summary(fm0)$r.sq,3)
  ANS['RSq',2]=round(summary(fm1)$r.sq,3)

  ANS['Adj-RSq',1]=round(summary(fm0)$adj.r.sq ,3)
  ANS['Adj-RSq',2]=round(summary(fm1)$adj.r.sq ,3)
  

  ANS['AIC',1]=AIC(fm0)
  ANS['AIC',2]=AIC(fm1)
  
  ANS['BIC',1]=BIC(fm0)
  ANS['BIC',2]=BIC(fm1)
  

  
  ANS['PVE',1]=mean(PVE0.TST)
  ANS['PVE',2]=mean(PVE1.TST)
  
  round(ANS,3)
  
```


##### Remarks: 

  - The 'long-regression' (HA) has higher adjusted R-sq., smaller AIC, and higher PVE in CV. These criteria suggest choosing HA over H0.
  - The F-test is significant
  - However, BIC, a model comparison criteria that heavily favors parsimonious models favors H0.
  - I would recommend using HA.
  - Compare PVE-TRN versus PVE-TST. As expected the prop. of variance explained (PVE) is higher in the training set, the model with more predictors fits the data better in the TRN data always (we cannot compar models based on R-sq. or PVE in the training data); however, it may not be the best at predicting data out-of sample. In this case it also happens tha HA is better at predicting out-of-sample data as well.
  
  
  

  
