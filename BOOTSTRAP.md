
## Bootstrap

For a reference on the topic I suggest [Efron & Gong, AmStat, 1983](http://www.tandfonline.com/doi/pdf/10.1080/00031305.1983.10483087?needAccess=true).


## Example: the sampling distribution of OLS estimates using Bootstrap

```r
## Reading the data set
 DATA=read.table('~/Desktop/wage.txt',header=T,stringsAsFactors=F)
 N=nrow(DATA)
 
## Parameters
 sampleSize=300
 nRep=10000

## model
  model='Wage~Education+South+Black+Hispanic+Sex+Married+Expirience+Union'
  

## Fitting the model to the entire data set

fm=lm(model,data=DATA)

## Bootstrap analyses
  

  B=matrix(nrow=nRep,ncol=length(coef(fm)))
  colnames(B)=names(coef(fm))
  
  for(i in 1:nRep){
  	myRows=sample(1:N,size=sampleSize,replace=T)
  	tmpData=DATA[myRows,]
  	fm=lm(model,data=tmpData)
  	B[i,]=coef(fm)  	
  	if(i%%1000==0){ print(i) }
  }
  
  cov(B)
  colMeans(B)
  fm$coef
```


## In class

1) Provide estimates of the variance-covariance matrix of estimates of the effects for sample size=100,200 and nrow(DATA)

2) Provide histograms with the (estimated) sampling distribution of the sex, south and education effects for sample size 100, 200 and nrow(DATA).

### Estimating risk curves (and confidence bands) in a logistic regression using Bootstrap


For a quick review of Logistic Regression, Odds Ratios and Relative Risks follow this [link](https://github.com/gdlc/STAT_COMP/blob/master/LogisticRegression.pdf).

```r


SU=seq(from=3,to=18,length=100)

predictRisk=function(b,SU){
    ETA=b[1]+b[2]*SU
    RISK=exp(ETA)/(1+exp(ETA))
   return(RISK)
}


#####
DATA$gout2=ifelse(DATA$gout=="Y",1,0)

fm0=glm(gout2~su,data=DATA,family='binomial')
y=predictRisk(b=coef(fm0),SU=SU)

plot(y~SU,ylim=c(0,1),xlim=range(SU),col="red",type='l',lwd=2)


nRep=5000
n=nrow(DATA)

CURVE=matrix(nrow=nRep,ncol=length(SU),NA)

for(i in 1:nRep){
   tmp=sample(1:n,size=n,replace=TRUE)
   tmpDATA=DATA[tmp,]
   fm=glm(gout2~su,family='binomial',data=tmpDATA)
   b=coef(fm)
   CURVE[i,]=predictRisk(b=b,SU=SU)

   lines(x=SU,y=CURVE[i,],lwd=.3,col=8)

}

```

### In-class assigment

Using the [Alcohol Data set](https://github.com/gdlc/STAT_COMP/blob/master/DATA_ALCOHOL.RData)

  1) Fit a logistic regression by regressing Alcohol use on sex and year of birth. 
  
  2) Summarize your findings.
  
  
  3) Estimate using bootstrap the sampling distribution of the female:male OR and the
  female:male relative risk, the latest for people born in 1940, 1950, and 1960. Report a historgram
  for each of these quantities and 95% confidence regions.


[Back](https://github.com/gdlc/STAT_COMP/)
