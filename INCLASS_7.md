

Using the [wages](https://github.com/gdlc/STAT_COMP/blob/master/wages.txt) datatset generate a plot of wages versus income for a male, white, single person from the north, that works in a non-union sector and has 4 years of esperience.

Use Bootstrap to generate 95% confidence bands for the prediction equation. 


**Reading the data**

```r

## Reading the data set
 DATA=read.table('~/Desktop/wages.txt',header=T,stringsAsFactors=F)

## model

  model='Wage~Education+South+Black+Hispanic+Sex+Married+Experience+Union'  
  fm0=lm(model,data=DATA)
  summary(fm0)
  # Pediction equation
   ED=6:18
  Z=cbind(1,ED,0,0,0,0,0,4,0) # male, north, not married, non-union, white, 4 yr of experience
  head(Z)
  yHat=Z%*%coef(fm0)
  plot(yHat~ED,type='o',col=4)

```


## Suggested Solution

```r
## Reading the data set
 DATA=read.table('~/Desktop/wages.txt',header=T,stringsAsFactors=F)
 n=nrow(DATA)
 
## Parameters
 sampleSize=300
 nRep=5000

## model
  model='Wage~Education+South+Black+Hispanic+Sex+Married+Experience+Union'
  

## Fitting the model to the entire data set
 fm0=lm(model,data=DATA)
 
 # Pediction equation
  EDU=6:18
  Z=cbind(1,EDU,0,0,0,0,0,4,0) # male, north, not married, non-union, white, 4 yr of experience
  yHat0=Z%*%coef(fm0)

# Plot
 plot(0,col='white',ylim=c(0,18),xlim=range(EDU),xlab='Years of Education',ylab='Wage ($/hour)')
 
 YHAT=matrix(nrow=nRep,ncol=length(yHat0))
  
 for(i in 1:nRep){
  	index=sample(1:n,size=n,replace=T)
  	TMP=DATA[index,] # a bootstrap sample
  	
  	fm=lm(model,data=TMP)
  	
  	YHAT[i,]=Z%*%coef(fm)
  	
  	lines(x=EDU,y=YHAT[i,],col=8,lwd=.3)

  }
  
  LB=apply(FUN=quantile,p=.025,X=YHAT,MARGIN=2) # lower-bound
  UB=apply(FUN=quantile,p=.975,X=YHAT,MARGIN=2) # upper-bound
  lines(x=EDU,y=LB,col='blue',lwd=2,lty=2)
  lines(x=EDU,y=UB,col='blue',lwd=2,lty=2)
  lines(x=EDU,y=yHat0,lwd=2,col='red')
  abline(v=mean(DATA$Education),lty=2)
  
  
```  
