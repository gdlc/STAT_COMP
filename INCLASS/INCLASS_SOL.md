
 <div id="MENUE" />
  
  - [INCLASS 1](#INCLASS_1>) ; [INCLASS 2](#INCLASS_2)

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
[back to list](<div id="MENUE" />)


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



### INCLASS 10

### INCLASS 11

### INCLASS 12

### INCLASS 13

### INCLASS 14

### INCLASS 15

### INCLASS 16

### INCLASS 17

### INCLASS 18

### INCLASS 19

### INCLASS 20

