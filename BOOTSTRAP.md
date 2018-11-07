
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



[Back](https://github.com/gdlc/STAT_COMP/)
