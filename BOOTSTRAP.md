
## Bootstrap

For a reference on the topic I suggest [Efron & Gong, AmStat, 1983](http://www.tandfonline.com/doi/pdf/10.1080/00031305.1983.10483087?needAccess=true).


## Example: the sampling distribution of OLS estimates using Bootstrap

```r
## Reading the data set
 DATA=read.table('~/Desktop/gout.txt',header=T,stringsAsFactors=F)
 N=nrow(DATA)
 
## Parameters
 nS=100
 nB=5000

## model
  model='serum_urate~sex+age+race'
  B=matrix(nrow=nB,ncol=4)
  fm=lm(model,data=DATA)
  colnames(B)=names(coef(fm))
  
## Bootstrap analyses
  for(i in 1:nB){
  	myRows=sample(1:N,size=nS,replace=T)
  	tmpData=DATA[myRows,]
  	fm=lm(model,data=tmpData)
  	B[i,]=coef(fm)  	
  	print(i)
  }
```


[Back](https://github.com/gdlc/STAT_COMP/)
