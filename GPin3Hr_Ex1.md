
```r
knitr::opts_chunk$set(echo = TRUE, message = FALSE,eval=TRUE,warnings = FALSE)
```
### 1-Data

We load the wheat data set in the BGLR package, extract one phenotype, scale and center genotypes and split the data into a training and a testing set.

```r
 library(BGLR)
 data(wheat); X=scale(wheat.X); Y=wheat.Y
 objects();
 dim(X);
 dim(Y);
 head(Y)
 N<-nrow(X) ; p<-ncol(X)

```

### 2-Creating a training-testing partition.

We will use the training data to build our models (bariable selection and effect estimation) and will use the testing data to evaluate prediction accuracy.

```r
 
 y<-Y[,2]
 set.seed(12345)
 tst<-sample(1:N,size=150,replace=FALSE)
 XTRN<-X[-tst,]
 yTRN<-y[-tst]
 XTST<-X[tst,]
 yTST<-y[tst]

```


## 3-Single marker regression

```r
 pValues<-numeric()
 for(i in 1:p){
	fm<-lsfit(y=yTRN,x=XTRN[,i])
	pValues[i]<-ls.print(fm,print.it=F)$coef[[1]][2,4] # extracts p-value, similar to lm() but a bit faster
 }
 
 plot(-log10(pValues),cex=.5,col=2)
```

## 4-Prediction models using the q-top SNPs

```r
####### VARIABLE SELECTION ##############################
 mrk_rank<-order(pValues); corTRN<-numeric(); corTST<-numeric()
 for(i in 1:300){	
	tmpIndex<- mrk_rank[1:i]
	ZTRN=XTRN[,tmpIndex,drop=F]
	ZTST=XTST[,tmpIndex,drop=F]
	
	fm<-lm(yTRN~ZTRN)
	bHat=coef(fm)[-1]
	bHat<-ifelse(is.na(bHat),0,bHat)
	
	yHatTRN=ZTRN%*%bHat
  corTRN[i]<-cor(yTRN,yHatTRN)
  
	yHatTST=ZTST%*%bHat
	corTST[i]<-cor(yTST,yHatTST)
	
 }
 
 plot(c(0,corTRN),x=0:length(corTRN),type='o',col=2,ylab='Correlation-Training',
       xlab='Number of markers',ylim=c(0,.9))
 
 lines(x=0:length(corTST),y=c(0,corTST),col=4)
 points(x=0:length(corTST),y=c(0,corTST),col=4)
 abline(v=which.max(corTST),lty=2)
 abline(h=corTST[which.max(corTST)],lty=2)
 
```

## 5-Prediction in testing sets using random 


```r
 library(BGLR)
 data(wheat); X=scale(wheat.X); Y=wheat.Y;N=nrow(X);p=ncol(X)
 nRep=100 # number of training-testing partitions
 pMax=250 # maximum number of SNPs
 
# An object to store correlations
 COR.TST=matrix(nrow=nRep,ncol=pMax,NA)
 
# Random partititions
 y<-Y[,2]
 
plot(0,xlab='# of SNPs in the model',ylab='Corrleation-testing',col='white',ylim=c(0,.6),xlim=c(0,pMax))
for(h in 1:nRep){
 tst<-sample(1:N,size=150,replace=FALSE)
 XTRN<-X[-tst,]
 yTRN<-y[-tst]
 XTST<-X[tst,]
 yTST<-y[tst]

# Single marker regression
 pValues<-numeric()
 for(i in 1:p){
	fm<-lsfit(y=yTRN,x=XTRN[,i])
	pValues[i]<-ls.print(fm,print.it=F)$coef[[1]][2,4] # extracts p-value, similar to lm() but a bit faster
 }
 
 mrk_rank<-order(pValues); corTRN<-numeric(); corTST<-numeric()
 for(i in 1:pMax){	
	tmpIndex<- mrk_rank[1:i]
	ZTRN=XTRN[,tmpIndex,drop=F]
	ZTST=XTST[,tmpIndex,drop=F]
	
	fm<-lm(yTRN~ZTRN)
	bHat=coef(fm)[-1]
	bHat<-ifelse(is.na(bHat),0,bHat)
	
	yHatTRN=ZTRN%*%bHat
  corTRN[i]<-cor(yTRN,yHatTRN)
  
	yHatTST=ZTST%*%bHat
	COR.TST[h,i]<-cor(yTST,yHatTST)
 }
 lines(COR.TST[h,],col='skyblue',lwd=.5)
}
avgCurve=colMeans(COR.TST)
lines(avgCurve,lwd=2,col=2)
abline(v=which.max(avgCurve),lty=2)
abline(h=avgCurve[which.max(avgCurve)])
 
```
