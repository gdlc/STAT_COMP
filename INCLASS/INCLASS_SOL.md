
 <div id="MENUE" />
  
  - [INCLASS 1](#INCLASS_1) ; [INCLASS 2](#INCLASS_2); [INCLASS 3](#INCLASS_3); [INCLASS 4](#INCLASS_4); [INCLASS 5](#INCLASS_5)
  - [INCLASS 6](#INCLASS_6) ; [INCLASS 7](#INCLASS_7); [INCLASS 8](#INCLASS_8); [INCLASS 9](#INCLASS_9); [INCLASS 10](#INCLASS_10)
  - [INCLASS 11](#INCLASS_11) ; [INCLASS 12](#INCLASS_12); [INCLASS 13](#INCLASS_13); [INCLASS 14](#INCLASS_14); [INCLASS 15](#INCLASS_15);
  - [INCLASS 16](#INCLASS_16);


<div id="INCLASS_1" />

### INCLASS 1

**1)** Create within the R-environment these two vectors: `x=[1L,2L,3L]` and `y=[1,2,3]`. What are the types of x and y?

```r
 x=c(1L,2L,3L)
 y=c(1,2,3)
 class(x) # integer
 class(y) # numeric
```
 
 **2)** Multiply x and y, what are the dimensions and type of the resulting vector?
 
 
```r
 z=x*y
 class(z) # numeric
```
The product of integer and numeric yields a numeric object. The length of z is the same as that of x and y.

 **3)** Add names to x `['x1','x2','x3']`, and, using indexing by name, replace the second entry of x with the value 1.1. What is the type of x after the replacement?
 
 ```r
  names(x)=c('x1','x2','x3')
  x['x2']=1.1
  class(x)
 ```
 When a numeric value is inserted the whole itneger vector is promoted to numeric.
 
 **4)** Create a matrix (W) using `cbind(x,y)`. What is the class of W?
  
  ```r
   x=c(1L,2L,3L)
   y=c(1,2,3)  
   W=cbind(x,y)
  ```
  When a matrix is created by binding a numeric and a integer vector the whole matrix is promoted to numeric.
  
 **5)** Apply the log() function to the W matrix created in (4)
 
 ```r
  log(W)
 ```

What do yo conclude about the behavior of functions that take scalar arguments when we apply them to arrays?

When functions that take scalar inputs are called on arrasy, the function is applied to each entry of the array, the return value has the same dimensions as the input.

 **6)** Pick your two favorite cars and for each define the brand, model, year, and engine size. 
   - Create a list (length 2, one entry by car), each element of the list will contain the brand, model and year. Access to the information of the 1st and 2nd entry of the list using integer-indexing, and using `$`. Hint: see this [example](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/RIntro.md#lists).
   - Replace 2nd entry of the list CARS with your first car and add a third entry to the list with your 2nd car.

```r
 CARS=list()
 CARS[[1]]=list(brand='Toyota',model='Corolla',year=2012,engineSize=1500)
 CARS[[2]]=list(brand='Dodge',model='Ram',year=2010,engineSize=3600)

 CARS[[1]]
 CARS[[2]]
 
 tmp=CARS[[2]]
 
 CARS[[2]]=CARS[[1]]
 CARS[[3]]=tmp
 
```
[back to list](#MENUE)


<div id="INCLASS_2" />

### INCLASS 2

**Reading the data**

```r
 DATA=read.table('https://web.stanford.edu/~hastie/ElemStatLearn/datasets/prostate.data',header=T)
 head(DATA)
 dim(DATA)
 str(DATA)
 tail(DATA)
```

**Writing/reading comma-separated file**

```r
write.table(DATA,file='DATA.csv',sep=',') # consider also write.csv()
DATA2=read.csv('DATA.csv')
all.equal(DATA,DATA2)

DATA3=read.table('DATA.csv',sep=',')
all.equal(DATA,DATA3)

```

**Summary statistics**

```r
 for(i in c(1,2,3,4,6,7,8,9)){
   print(summary(DATA[,i]))
 }
 
 table(DATA[,5])

```

**Histograms**

```r
  par(mfrow=c(3,3))
   for(i in 1:9){
     hist(DATA[,i],main=colnames(DATA)[i])
   }
```

**Scatterplots and boxplots**

```r
  par(mfrow=c(2,4))
   for(i in 1:8){
     if(i!=5){
      plot(lpsa~DATA[,i],main=colnames(DATA)[i],xlab=colnames(DATA)[i],data=DATA)
     }else{
      boxplot(lpsa~DATA[,i],main=colnames(DATA)[i],xlab=colnames(DATA)[i],data=DATA)
     }
   }
```
**Heatmap**

```r
heatmap(cor(as.matrix(DATA[,1:9])),symm=TRUE)
```

**Hierarchical clustering**

```r
 D=dist(t(scale(DATA[,1:9]))) #Euclidean distance between columns, aftern centering and scaling
 HC=hclust(D)
 plot(HC)
```

**Heatmap based on absolute-value correlation**

```r
 heatmap(abs(cor(as.matrix(DATA[,1:9]))),symm=TRUE)
```
[back to list](#MENUE)



<div id="INCLASS_3" />

### INCLASS 3


**1)** For loop

```r
  for(x in 1:5){
    print(x)
  }
  
  for(i in c('a','b','d','c')){
    print(i)
  }
  
  for(z in c(TRUE,FALSE,TRUE,TRUE)){ print(z) }
``` 

**2)** Nested loops

Write code with a loop nested within another loop. For the first iterator use `(i in 1:5)`, for the inner loop use `(j in c('a','b'))`, inside the inner loop, print `i` and `j`, e.g., `print(paste(i,j))`.

for(i in 1:5){
  for(j in c('a','b')){
     message(i,j)
  }
}


**3)** While loop
```r
i=0
 while(i<=5){
  message(i)
  i=i+1
 }
 
 print(i)
```
 
 **4)**  Recoding: 3-strategies
 
 The goal is to recode the `lgleason` score variable into three levels, `<=6`, `7`, and `>=8`. We will consider three strategies: 
   - `for` loop with `if(){}` statment inside
   - `ifelse` this function takes three arguments, a boolean, a vector for the TRUE entries and a vector for the FALSE entries, e.g., `ifelse(c(1,2,3)<=2, "A","B")`) 
      Hint: consider nesting an `ifelse` statmente within another `ifelse`.
   - `cut`, try `help(cut)`.
 
 ```r
  DATA$gleason_1=NA
  for(i in 1:nrow(DATA)){
    if( DATA$gleason[i]<=6){
      DATA$gleason_1[i]="G<=6"
    }else{
      if(DATA$gleason[i]==7){
        DATA$gleason_1[i]="G=7"
      }else{
        DATA$gleason_1[i]="G>=8"
     }
   }
  }
  boxplot(gleason~gleason_1,data=DATA)
```  

```r
  DATA$gleason_2=ifelse(DATA$gleason<=6,"G<=6",ifelse(DATA$gleason<8,"G=7","G>=8"))
  table(DATA$gleason_1,DATA$gleason_2)

```

```r
  DATA$gleason_3=cut(DATA$gleason,breaks=c(0,6,7,12))
 table(DATA$gleason_1,DATA$gleason_3)
```
 
**5)** Functions 

```r
 recodeOne=function(x,breaks=c(6,7)){
  ans="G<=6"
  if(x==7){
    ans="G=7"
  }
  
  if(x>7){
   ans="G>=8"
  }
  return(ans)
 }
 DATA$gleason_4=recodeOne(DATA$gleason)
```
Note: the function does not work as intended. Instead use:

```r
 DATA$gleason_4<-sapply(FUN=recodeOne,X=DATA$gleason)
 table(DATA$gleason_1,DATA$gleason_4)
```
[back to list](#MENUE)



<div id="INCLASS_4" />

### INCLASS 4

**A function to produce the transpose of a matrix**

```r
  myT=function(X){
   nRows=nrow(X)
   nCols=ncol(X)
   W=matrix(nrow=nCols,ncol=nRows,NA)
   rownames(W)=colnames(X)
   colnames(W)=rownames(X)
   
   for(i in 1:nCols){
     for(j in 1:nRows){
       W[i,j]=X[j,i]
     }
   }
  
  return(W)
}


## Test
 X=matrix(nrow=5,ncol=4,rnorm(20))
 Xt=myT(X)
 all.equal(Xt,t(X))
```
**A function to produce matrix producs using scalar operations**

```r
 matProd=function(A,B){
   conform=ncol(A)==nrow(B)
   if(conform){
     W=matrix(nrow=nrow(A),ncol=ncol(B),NA)
     for(i in 1:nrow(A)){
      for(j in 1:ncol(B)){
       W[i,j]=sum(A[i,]*B[,j])
      }
     }
     return(W)
   }else{
    stop('Matrix do not conform')
   }
 }
 
 A=matrix(nrow=5,ncol=3,rnorm(15))
 B=matrix(nrow=3,ncol=4,runif(12))
 TMP=matProd(A,B)
```
[back to list](#MENUE)



<div id="INCLASS_5" />

### INCLASS 5

```r
# First a function that takes the response and an incidence matrix as inputs
OLS_Xy=function(X,y){
	n=nrow(X)
	p=ncol(X)
	
	XX=crossprod(X)
	Xy=crossprod(X,y)
	
	INV=solve(XX)
	
	bHat=INV%*%Xy
	
	res=y-X%*%bHat

	varE=sum(res^2)/(n-p)
	COV=INV*varE
	
	ANS=data.frame(Estimate=bHat,SE=sqrt(diag(COV)))
	ANS$tStat=ANS[,1]/ANS[,2]
	ANS$pvalue=pt(abs(ANS$tStat),df=n-p,lower.tail=FALSE)*2
	
	return(ANS)
}

# Wrapper that takes a formula as input
# note: the use of '...' allows us to pass any arguments to other formulas inside 
OLS=function(model,...){

	model=as.formula(model)
	
	DF=model.frame(model,...)
	X=model.matrix(as.formula(paste('~',paste(colnames(DF[,-1]),collapse='+'))),...)
	y=DF[,1]
	ANS=OLS_Xy(X,y)
	return(ANS)
}

```

**Test**

```r
  DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/goutData.txt',header=TRUE)
  fm=lm(su~race+sex+age,data=DATA)
 
  fm2=OLS(su~race+sex+age,data=DATA)
  
  summary(fm)$coef
  fm2

```
[back to list](#MENUE)



<div id="INCLASS_6" />

### INCLASS 6


```r
 n=500
 p=5
 X=matrix(nrow=n,ncol=p,data=rnorm(n*p))
 y=X[,3]-X[,5]+rnorm(n)
 
 C=crossprod(X)
 r=crossprod(X,y)
```

**1)** Obtaining OLS esitmates from the QR decomposition

Note that `X=QR` where `Q'Q=I` and `R` triangular.

Using this we have that `X'X=(QR)'QR=R'Q'QR=R'R`; therefore, `Inv(X'X)`=`Inv(R'R)=Inv(R)Inv(R')`.

Above we used the following: 
  - Q'Q=I
  - Inv(AB)=Inv(B)Inv(A)
  
Checking this:

```r
 CInv=solve(C)
 all.equal(CInv,tcrossprod(solve(R)))
```

Now, `X'y=R'Q'y`; therefore, the OLS estimate is: `Inv(X'X)X'y=Inv(R)Inv(R')R'Q'y=Inv(R)Q'y`. Then, we can obtain OLS estimates using

```r
  QR=qr(X)
  R=qr.R(QR)
  Q=qr.Q(QR)
  
  bHat=backsolve(R,crossprod(Q,y))
  solve(C,r)
```

**2)** Gauss Seidel

First, I'll do a function for just one iteration of the Gauss-Seidel.

```r
 GSiter=function(C,r,b){
   for(i in 1:nrow(C)){
     offset=sum(C[-i,i]*b[-i])
     b[i]=(r[i]-offset)/C[i,i]
   }
   return(b)
 }
```

Now a function that will call it and solve the system

```r
  GS=function(C,r,nIter,tol=1e-6){
    b=r/diag(C) # initial value
    ready<-FALSE
    iter=1
    while(!ready){
    	b0=b
	b=GSiter(C,r,b)
	ready=(max(abs(b-b0))<=tol)|(iter>=nIter)
	iter=iter+1
    }
    return(b)
 }
 GS(C,r,10)
 solve(C,r)
 
```
[back to list](#MENUE)


<div id="INCLASS_7" />

### INCLASS 7

```r
 set.seed(195021)
 x<-seq(from=0, to=2*pi,by=0.1)
 f0<-function(x){ 100+sin(2*x)+cos(x/2) }
 R2<-2/3
 y<-f0(x)+rnorm(n=length(x),sd=sqrt(var(f0(x))*(1-R2)/R2))
 plot(y~x)
 lines(x=x,y=f0(x),col='red',lwd=2)
```

```r
  DF=round(seq(from=4,to=40,length=9))
  par(mfrow=c(3,3))
  
  RESULTS=cbind(DF=rep(NA,length(DF)),R2=NA,adjR2=NA,AIC=NA,BIC=NA)
  
  for(i in 1:length(DF)){

	
	z=cut(x,breaks=seq(from=min(x),to=max(x+.01),length=DF[i]),right=F)
        fm=lm(y~z)
	  
	
	
         plot(y~x,col='grey',main=paste('AIC=',round(AIC(fm),2),'; BIC=',round(BIC(fm),2)))
	 lines(x=x,y=f0(x),col='red',lwd=2)
	 lines(x=x,y=predict(fm),col='blue',lwd=2)
	 
	RESULTS[i,'DF']=length(coef(fm))
	RESULTS[i,'R2']=summary(fm)$r.sq
	RESULTS[i,'adjR2']=summary(fm)$adj.r.sq
	RESULTS[i,'AIC']=AIC(fm)
	RESULTS[i,'BIC']=BIC(fm)
  }
  
  RESULTS
```
[back to list](#MENUE)


<div id="INCLASS_8" />

### INCLASS 8


```r
DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/GALTON.csv',header=TRUE,sep=',')
DATA$PA=(DATA$Father+DATA$Mother)/2
DATA=DATA[order(DATA$PA),]
library(splines)

DF=seq(from=3,to=11)
par(mfrow=c(3,3))

fm0=lm(Height~PA,data=DATA)

STATS=data.frame(DF=DF,AIC=NA,FTest=NA)

for(i in 1:length(DF)){
   plot(Height~PA,data=DATA,cex=.5,col=8)
   fm=lm(Height~ns(PA,df=DF[i]),data=DATA)
   lines(x=DATA$PA,y=predict(fm),col=2,lwd=1.5)
   lines(x=DATA$PA,y=predict(fm0),col=4,lwd=1.5)
   STATS$AIC[i]=AIC(fm)
   STATS$FTest[i]=anova(fm0,fm)$P[2]
}
STATS=rbind(data.frame(DF=1,AIC=AIC(fm0),FTest=NA),STATS)
STATS
```
[back to list](#MENUE)


<div id="INCLASS_9" />

### INCLASS 9


```r

DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/goutData.txt',header=TRUE)

DATA$y=ifelse(is.na(DATA$gout),NA,ifelse(DATA$gout=='Y',1,0))

table(DATA$y,DATA$gout)


fm0=glm(y~race+sex+age,data=DATA,family=binomial)

X=as.matrix(model.matrix(~race+sex+age,data=DATA))[,-1]
X=scale(X,center=TRUE,scale=FALSE)

 negLogLik=function(y,X,b){
  	eta=X%*%b  # linear predictor
	theta=exp(eta)/(1+exp(eta)) # success probability
	logLik=sum(ifelse(y==1,log(theta),log(1-theta))) 
        return(-logLik)
  }
fm1=glm(y~X,data=DATA,family=binomial) # same model as fm0, but note that, because X has columns centered, the intercept changes

fm2=optim(fn=negLogLik,X=cbind(1,X),y=DATA$y,par=c(log(mean(DATA$y)/mean(1-DATA$y)),rep(0,ncol(X))))

cbind(coef(fm0),coef(fm1),fm2$par)

```
[back to list](#MENUE)


<div id="INCLASS_10" />


### INCLASS 10

```r
DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/goutData.txt',header=TRUE)

DATA$y=ifelse(is.na(DATA$gout),NA,ifelse(DATA$gout=='Y',1,0))

X=as.matrix(model.matrix(~race+sex+age,data=DATA))[,-1]
X=scale(X,center=TRUE,scale=FALSE)

 negLogLik=function(y,X,b){
  	eta=X%*%b  # linear predictor
	theta=exp(eta)/(1+exp(eta)) # success probability
	logLik=sum(ifelse(y==1,log(theta),log(1-theta))) 
        return(-logLik)
 }

yBar=mean(DATA$y)
logOdds=log(yBar)/(1-yBar)
init=c(logOdds,rep(0,ncol(X)))

# Using glm to check our results
 GLM=glm(y~X,family='binomial',data=DATA) 

# Obtaining results using optim()
 fm=optim(fn=negLogLik,X=cbind(1,X),y=DATA$y,par=init,hessian=TRUE)
 b=fm$par
 COV=solve(fm$hessian)

# Once we get the estimates and the covariance matrix, caluclations go exactly as with OLS

 SE=sqrt(diag(COV))
 zStat=b/SE
 pVal=pnorm(abs(zStat),lower.tail=FALSE)*2
 EST=data.frame('Estimate'=b,'SE'=SE,'z-stat'=zStat,'pVal'=round(pVal,6))
 round(EST,5)
 round(summary(GLM)$coef,5)
 
```


##### Likelihodd ratio test

```r
  Z=X[,-1]
  H0=optim(fn=negLogLik,X=cbind(1,Z),y=DATA$y,par=init[-2],hessian=TRUE)
  LRT=2*(H0$value-fm$value)
  c(DF=1,LRT=LRT,pval=pchisq(LRT,df=1,lower.tail=FALSE))
  H0.GLM=glm(y~Z,family='binomial',data=DATA) 
  anova(H0.GLM,GLM)
  summary(GLM)$coef[2,]
```

##### Wald's test

```r
 T=matrix(c(0,1,0,0),nrow=1)
 VInv=solve(T%*%COV%*%t(T))
 Tb=T%*%fm$par
 W=t(Tb)%*%VInv%*%t(Tb)
 pchisq(W,df=nrow(T),lower.tail=FALSE)
 summary(GLM)$coef[2,]
```

[back to list](#MENUE)


<div id="INCLASS_11" />

### INCLASS 11

There are at least three ways to obtain a CI for a prediction from logistic regression:

**First approach**:

  - We obtain the point estimates for the coefficients and the covariance matrix of effects.
  - Using that we compute a 95% CI for the value of the linear prdictor,
  - Then we eavluate the inverse logit link at the bounds of the CI for the linear predictor.
  - 
*Example*:

```r
   DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/goutData.txt',header=TRUE)
   DATA$y=ifelse(DATA$gout=="Y",1,0)
   fm=glm(y~su,data=DATA,family='binomial')
   summary(fm) 
   
   V=vcov(fm)
   bHat=coef(fm)
   
   ## Evaluating the linear predictor
    x=matrix(c(1,7.5),nrow=1) # predicting for SU=7.5
    LP=x%*%bHat
    V.LP=x%*%V%*%t(x)
    SE.LP=sqrt(V.LP)
    CI.LP=c(LP-1.96*SE.LP,LP+1.96*SE.LP)
    
    pHat=exp(LP)/(1+exp(LP))
    CI.PHat=exp(CI.LP)/(1+exp(CI.LP))
   
```

**Second approach**: Use the Delta method to approximate the SE(pHat) from the SE for the linear predictor (this is what I believe predict.glm() does)

```r
    predict.glm(fm,type='response',newdata=data.frame(su=x[2]),se.fit=TRUE)
    SE.LP*pHat*(1-pHat) # this is the (Delta method) approximate SE
```

And then compute a 95% CI

```r
  pred=predict.glm(fm,type='response',newdata=data.frame(su=x[2]),se.fit=TRUE)
  CI.DeltaMethod=pred$fit+c(-1,1)*1.96*pred$se.fit
```

**Third approach**: use Bootstrap

```r
 nSamples=10000
 predProb=rep(NA,nSamples)
 n=nrow(DATA)
 for(i in 1:nSamples){
 	tmp=sample(1:n,size=n,replace=TRUE)
	fm=glm(y~su,data=DATA[tmp,],family='binomial')
	LP=x%*%coef(fm)
	predProb[i]=exp(LP)/(1+exp(LP))	
 }
 CI.Bootstrap=quantile(predProb, prob=c(.025,.975))
```

**How do they compare**?

```r
  round(rbind(CI.PHat,CI.DeltaMethod,CI.Bootstrap),3)
```

[back to list](#MENUE)


<div id="INCLASS_12" />

### INCLASS 12


##### 1)

```r
 pnorm(q=8,mean=10,sd=2)
 pnorm(q=11,mean=10,sd=2,lower.tail=FALSE)
 pnorm(q=11,mean=10,sd=2)-pnorm(q=8,mean=10,sd=2)
```


##### 2)

If X~N(10,VAR=4), then Z=(X-10)/2  ~N(0,1)

[Note you get the same results as in 1, think about why]

```r 
 pnorm(q= -1)
 pnorm(q=1/2,lower.tail=FALSE)
 pnorm(q=0.5)-pnorm(q= -1)
```


##### 3)

```r
 n=c(10,20,30)
 
 dbinom(x=3,size=n,prob=0.07)
 
 pbinom(q=3,size=n,prob=0.07,lower.tail=FALSE)
 
 pbinom(q=3,size=n,prob=0.07)
 
 
 pbinom(q=3,size=n,prob=0.07)+(1- pbinom(q=3,size=n,prob=0.07))
  
```

##### 4)

```r
 n=10000
 lambda=0.05*50
 X=rpois(lambda=lambda,n=n)
 Y=rbinom(prob=0.05,size=50,n=n)
 
 mean(X)
 mean(Y)
 var(X)
 var(Y)
 
 par(mfrow=c(1,2))
 hist(X,xlim=c(0,12))
 hist(Y,xlim=c(0,12)) 
```

##### 5)

```r
 zStat=0.83/0.045
 pnorm(-abs(zStat))*2
 
 pt(-abs(zStat),df=20)*2
 
```


##### 6)

```r
  DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/wages.txt',header=TRUE)
  str(DATA) # inspect the types of each variable! Do variables have the correct type?

  HA=lm(wage~education+sex+union+region+ethnicity,data=DATA)
  H0=lm(wage~education+sex+union+region,data=DATA)
```

**Likelihood ratio test**

```r
 LRT=-2*(logLik(H0)-logLik(HA))
 pchisq(LRT, df=length(coef(HA)-length(coef(H0))))
 pchisq(LRT, df=length(coef(HA))-length(coef(H0)),lower.tail=FALSE)
 
 anova(H0,HA)
 
```

##### 7)

P(Infection)=1-P(Not infected)

P(Not infected)= (1-3/100)*(1-3/99)*(1-3/98)*(1-3/97)


We can also obtain this probability from the hypergeometric distribution


```r
 P1=1-(1-3/100)*(1-3/99)*(1-3/98)*(1-3/97)
 P2=1-dhyper(m=3,n=97,k=4,x=0)
 P3=phyper(m=3,n=97,k=4,q=0,lower.tail=FALSE)
 c(P1,P2,P3)
 
```

[back to list](#MENUE)


<div id="INCLASS_13" />

### INCLASS 13

**Composition sampling**

```r
XY=rbind(c(0.1,0.1),c(0.2,0.6))
colnames(XY)=c('Y=0','Y=1')
rownames(XY)=c('X=0','X=1')

# marginal distribution of X
 pX=sum(XY['X=1',])

# conditional success probability of Y given X
 pYgX= XY[,'Y=1']/rowSums(XY)


N=100000
X=rep(NA,N)
Y=rep(NA,N)

# Collecting samples
for(i in 1:N){
   # sampling X from its marginal distribution
   X[i]=rbinom(size=1,n=1,prob=pX)

   # Sampling Y from the conditional distribution of Y given X
   if(X[i]==0){
       Y[i]=rbinom(size=1,n=1,prob=pYgX['X=0'])
   }else{
      Y[i]=rbinom(size=1,n=1,prob=pYgX['X=1'])
   }
   
   # or simply use 
   #Y[i]=rbinom(size=1,n=1,prob=pYgX[X[i]+1])
}
table(X,Y)/N
```

**Gibbs sampler

```r

N=100000
X2=rep(NA,N)
Y2=rep(NA,N)

# Initialization
 X2[1]=1  # any values with non-zero probability are fine
 Y2[1]=0 
 
 
# Collecting samples
for(i in 2:N){
   
  
   # Sampling X from its fully conditional
     y=Y2[i-1]
     X2[i]=rbinom(size=1,n=1,prob=pXgY[ y +1 ])

      
    # Sampling Y from its fully conditional
     x=X2[i]
     Y2[i]=rbinom(size=1,n=1,prob=pYgX[ x + 1 ])

}
table(X2,Y2)/N


```

## Effective number of independent samples

Composition sampling generates IID samples: (X[i],Y[i]) are independent (and identically distributed) of (X[i'],Y[i']).

This is not the case of the Gibbs sampler, in this case, conditioning on the most recent realized values generates auto-correlations between samples.


```r
plot(Y2[1:200],type='o')
plot(Y[1:200],type='o')

 acf(Y,lag.max=10,plot=FALSE)
 acf(Y2,lag.max=10,plot=FALSE)
 
 #install.packages(pkg='coda',repos='https://cran.r-project.org/')
 library(coda)
 effectiveSize(cbind(X,Y))
 effectiveSize(cbind(X2,Y2))
```



[back to list](#MENUE)


<div id="INCLASS_14" />

### INCLASS 14

See handout on Sampling RVs (section on the Multivariate normal distribution).


<div id="INCLASS_15" />

### INCLASS 15


**I) Power estimation**


```{r}
 nReps=5000
 reject=rep(NA,nReps)
 
 for(i in 1:nReps){
   # Simulate data
    N=100
    R2=0.1
 
    x=rnorm(N)
    b=sqrt(R2)
    signal=x*b # var(xb)=var(x)*var(b)=var(x)b^2=R2
    error=rnorm(sd=sqrt(1-R2),n=N) 
    y=signal+error
    
    # Fit the model
     fm=lm(y~x)
    
    # Evaluate the test statistic and the decision rule
     pVal=summary(fm)$coef[2,4]
     
     reject[i]=pVal<0.05
  }
 
  # estimated power
  mean(reject)

```


**I) Estimating power**

To estimate power se simulate data from HA, which in this case correspond to b!=0.

```{r}
 nReps=5000
 reject=rep(NA,nReps)
 
 for(i in 1:nReps){
   # Simulate data
    N=100
    R2=0.1
 
    x=rnorm(N)
    b=sqrt(R2)
    signal=x*b # var(xb)=var(x)*var(b)=var(x)b^2=R2
    error=rnorm(sd=sqrt(1-R2),n=N) 
    y=signal+error
    
    # Fit the model
     fm=lm(y~x)
    
    # Evaluate the test statistic and the decision rule
     pVal=summary(fm)$coef[2,4]
     
     reject[i]=pVal<0.05
  }
 
  # estimated power
  mean(reject)
  # Estimated SE
  sqrt(var(reject)/nReps)
```

**II) Type-I error estimation**

To estimate type-I error rate we simulate from H0 (b=0 in this case)

```{r}
 nReps=5000
 reject=rep(NA,nReps)
 
 for(i in 1:nReps){
   # Simulate data
    N=100
    R2=0.1
 
    x=rnorm(N)
    b=0#sqrt(R2)
    signal=x*b # var(xb)=var(x)*var(b)=var(x)b^2=R2
    error=rnorm(sd=sqrt(1-R2),n=N) 
    y=signal+error
    
    # Fit the model
     fm=lm(y~x)
    
    # Evaluate the test statistic and the decision rule
     pVal=summary(fm)$coef[2,4]
     
     reject[i]=pVal<0.05
  }
 
  # estimated type-I error rate
   mean(reject)
  # Estimated SE
   sqrt(var(reject)/nReps)
```



<div id="INCLASS_16" />


### INCLASS 16

```r
 set.seed(1950)
 X=matrix(nrow=1000,ncol=50,rbinom(size=2,n=50000,prob=0.2))
 causal=runif(50)>0.9 # determining ~ 10% of predictors with non zero effect
 b=rnorm(50)
 b[!causal]=0
 signal=scale(X%*%b)*sqrt(0.2)
 error=rnorm(nrow(X),sd=sqrt(0.8))
 y=signal+error
 fm=lm(y~X)
 pval0=summary(fm)$coef[-1,4]
```


**Permutation analysis**

For the inclass assigment we permute and store the smallest pvalue. 

Note1: We don't re-simulate data, we just permute the data wehave

```r

 nPerm=5000 
 
 first_pval=rep(NA,nPerm)
 
 for(i in 1:nPerm){
   tmpY=sample(y,size=length(y),replace=FALSE)
   fm=lm(tmpY~X)
   pval=summary(fm)$coef[-1,4]

   
   pval=sort(pval)
   first_pval[i]=pval[1]
    
   print(i) 
 }
```

Obtaining the thresholds that will control the probability of making at most one type-I errorat 0.05.

```r
  threshold=quantile(first_pval,0.05)
```

Decision rule: we find the pvalues (from the original analysis) that were smaller than the permutation-threshold.

```r
 reject=(pval0<threshold)
```

*Power*

```r
 table(reject,causal)
```

### INCLASS 18

### INCLASS 19

### INCLASS 20

