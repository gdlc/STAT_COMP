
## Bootstrap

For a reference on the topic I suggest [Efron & Gong, AmStat, 1983](http://www.tandfonline.com/doi/pdf/10.1080/00031305.1983.10483087?needAccess=true).


## Example: the sampling distribution of OLS estimates using Bootstrap

```r
## Reading the data set
 DATA=read.table('~/Desktop/wages.txt',header=T,stringsAsFactors=F)
 
## Parameters
 sampleSize=300
 nRep=10000
DATA$Wage=log(DATA$Wage)

## model
  model='Wage~Education+South+Black+Hispanic+Sex+Married+Experience+Union'
  

## Fitting the model to the entire data set
 fm0=lm(model,data=DATA)
 V1=vcov(fm0)
 
 X=model.matrix(~Education+Black+Hispanic+Sex+Married+Experience+Union,data=DATA)
 vE=sum(residuals(fm0)^2)/(nrow(DATA)-ncol(X))
 
 V2=solve(crossprod(X))*vE
 max(abs(V1-V2))
 
## Bootstrap analyses
  B=matrix(nrow=nRep,ncol=length(coef(fm0)))
  colnames(B)=names(coef(fm0))
  N=nrow(DATA)
  
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
