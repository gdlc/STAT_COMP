
### 1-Data

We load the wheat data set in the BGLR package, extract one phenotype, scale and center genotypes and split the data into a training and a testing set.

```r
 library(BGLR)
 data(wheat); X=scale(wheat.X); Y=wheat.Y
 objects();dim(X);dim(Y)
 N<-nrow(X) ; p<-ncol(X)
 y<-Y[,2]
 set.seed(12345)
 tst<-sample(1:N,size=150,replace=FALSE)
 XTRN<-X[-tst,]
 yTRN<-y[-tst]
 XTST<-X[tst,]
 yTST<-y[tst]
 
```

## 2: Penalized regressions using glmnet


**2a) Fitting the models**

```r
 library(glmnet)

 # alpha 0 gives Ridge Regression
 fmRR=glmnet(y=yTRN,x=XTRN,alpha=0)
 
 # alpha 1 gives Lassso
 fmL=glmnet(y=yTRN,x=XTRN,alpha=1)
 
 # alpha between 0 and 1 gives elastic net
 fmEN=glmnet(y=yTRN,x=XTRN, alpha=0.5)

 
 COR.RR=rep(NA,100)
 COR.L=rep(NA,100)
 COR.ENet=rep(NA,100)
 
 # evaluating correlation in TST set
 for(i in 1:100){
   COR.RR[i]=cor(yTST,XTST%*%fmRR$beta[,i])
   COR.L[i]=cor(yTST,XTST%*%fmL$beta[,i])
   COR.ENet[i]=cor(yTST,XTST%*%fmEN$beta[,i])
 }
 
 plot(COR.RR,x=log(fmRR$lambda),type='o',col='blue',cex=.5)
 plot(COR.L,x=fmL$df,type='o',  col='blue',cex=.5,xlab='# of active markers')
 plot(COR.ENet,x=fmEN$df,type='o',col='blue',cex=.5,xlab='# of active markers')

 
```


## 3: Bayesian shrinkage/variable selection

```r
 library(BGLR)
 LP=list(list(X=XTRN,model='BayesA')) # scaled-t prior
 
 fmBA=BGLR(y=yTRN,ETA=LP,verbose=F,nIter=12000,burnIn=2000)
 yHatBA=XTST%*%fmBA$ETA[[1]]$b
 
 LP[[1]]$model='BayesB' # scaled-t-slab+point of mass at zero
 fmBB=BGLR(y=yTRN,ETA=LP,verbose=F,nIter=12000,burnIn=2000)
 yHatBB=XTST%*%fmBB$ETA[[1]]$b
 
 LP[[1]]$model='BL' # 'Bayesian Lasso'
 fmBL=BGLR(y=yTRN,ETA=LP,verbose=F,nIter=12000,burnIn=2000)
 yHatBL=XTST%*%fmBL$ETA[[1]]$b
 
 tmp=c(max(COR.RR),max(COR.L,na.rm=T),max(COR.ENet,na.rm=T),
       cor(yHatBA,yTST),cor(yHatBB,yTST),cor(yHatBL,yTST))
 names(tmp)=c('Ridge','Lasso','ENet','BayesA','BayesB','Bayesian Lasso')
 print(as.matrix(tmp))

```


