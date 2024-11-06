
 <div id="MENUE" />
 

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
 length(z)
 dim(z)
```
The product of integer and numeric yields a numeric object. The length of z is the same as that of x and y.

 **3)** Add names to x `['x1','x2','x3']`, and, using indexing by name, replace the second entry of x with the value 1.1. What is the type of x after the replacement?
 
 ```r
  names(x)=c('x1','x2','x3')
  x['x2']=1.1
  class(x)
 ```
 When a numeric value is inserted the whole integer vector is promoted to numeric.
 
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

When functions that take scalar inputs are called on array, the function is applied to each entry of the array, the return value has the same dimensions as the input.


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
write.csv(DATA,file='DATA.csv') # consider also write.csv()
DATA2=read.csv('DATA.csv',row.names=1)
all(DATA==DATA2)

```
**Summary statistics**
```r
# method 1
for(i in (1:9)[-5]){
  print(summary(DATA[,i]))
}

# method 2
summary(DATA)

# method 3
descriptive_stats = apply(FUN = summary, X = DATA, MARGIN = 2)

table(DATA[,5])
```
**Histogram**

```r
hist(DATA[,1],main='lcavol')

hist(DATA[,1],main=colnames(DATA)[1])

# Make all plots with one line
for (i in 1:9) {
  hist(DATA[,i],main=colnames(DATA)[i])
}

# Visualize all plots at once
par(mfrow=c(3,3)) # creates a 3x3 gri

for (i in 1:9) {
  hist(DATA[,i],main=colnames(DATA)[i])
}

#Save each plot as a separate pdf page
plot_list = list()

for (i in 1:9) {
  plot_list[[i]] = hist(DATA[,i],main=colnames(DATA)[i])
}

pdf('Historams_of_prostate_cancer_variables2.pdf') 
for (i in 1:9) {
plot(plot_list[[i]], main = colnames(DATA)[i], xlab = colnames(DATA)[i])
}
dev.off()

# Add lines on a hist plot

# This is a very useful reference 
#http://www.sthda.com/english/wiki/abline-r-function-an-easy-way-to-add-straight-lines-to-a-plot-using-r-software

hist(DATA2[,1],main=colnames(DATA2)[1])
abline(v = 1.5, col = 'red')
abline(h = 20, col = 'blue')
```

# Scatterplots and boxplots 
```r
par(mfrow=c(2,4))
for (i in 1:8) {
  if (i!=5) {
    plot(lpsa~DATA[,i],main=colnames(DATA)[i],xlab=colnames(DATA)[i],data=DATA)
  }
}

boxplot(lpsa~DATA[,5],main=colnames(DATA)[5],xlab=colnames(DATA)[5],data=DATA)
```

**Heatmap based on absolute-value correlation**

```r
dev.off()
heatmap(cor(as.matrix(DATA[,1:9])),symm=TRUE)
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


```r
for(i in 1:5){
  for(j in c('a','b')){
     message(i,j)
  }
}
```


**3)** While loop
```r
i=0
 while(i<=5){
  message(i)
  i=i+1
 }
 
 print(i)
```
**4)** Recode function

```
recode=function(x,old_levels,new_levels){
    for(i in 1:length(old_levels)){
        idx = which(x==old_levels[i])
        x[idx] = new_levels[i]
    }
    return(x)
}

```

**Bonus on recoding**

There are several function in R for recoding (e.g., see functions `recode()` and `recode_factor()` of the `dplyr` package. 


Another approach, which will avoid using a loop, is to use the fact that factors can be converted to integers and then use this to index the new levels. Here is an example

```r

 old_levels=as.character(1:4)
 new_levels=c('a','b','c','d')

 # X has the old levels
 x=as.character(sample(1:4,size=10,replace=TRUE),levels=old_levels)
 
 # we now covert x to integers, and use the integers to index the new levels
 y=new_levels[as.integer(x)]



 # check
 levels(x)
 data.frame(value=x,index=as.integer(x))

 z=factor(x,levels=c(2,4,3,1))
 levels(z)
 data.frame(value=z,index=as.integer(z))

```

[back to list](#MENUE)

<div id="INCLASS_Rmarkdown_practice" />

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
 myproduct=function(A,B){
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
 TMP=myproduct(A,B)
```

[back to list](#MENUE)

<div id="INCLASS_5" />

### INCLASS 5


```{r}
 # Question 1
 Q1.1=det(A)
 show(Q1.1)
 
 Q1.2=solve(A)
 Q1.3=Q1.2%*%A

 
 print(round(Q1.3,.Machine$double.eps))
 
 Q1.4=A%*%Q1.2
  
 print(round(Q1.4,.Machine$double.eps))
 
 
 ## Question 2
 library(MASS)
 Q2.1=det(B)
 
 print(Q2.1)
 abs(Q2.1)>.Machine$double.eps
 
 Q2.2=ginv(B)
 Q2.3=B%*%Q2.2%*%B
 
 
  print(round(abs(Q2.3-B),.Machine$double.eps))

```


[back to list](#MENUE)

<div id="INCLASS_6" />

### INCLASS 6

```{r}
abalone = read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/abalone.data', header = TRUE, sep=',')

fm = lm(Rings ~. , data = abalone)

Q1 = coef(fm)

pred = predict(fm)

res = abalone$Rings - pred

Q2.min_res = min(res)

Q2.max_res = max(res)

```

[back to list](#MENUE)

<div id="INCLASS_7" />

### INCLASS 7

```r
 ## First a formula to generate the incidence matrix from a fomrula
 
 
 getXy=function(formula, ...){

	formula=as.character(formula)[-1]
	response=formula[1]
	predictors=formula[-1]
	X=model.matrix(formula(paste0('~',predictors)),...)
	
	y=get(response,...)
	
	return(list(y=y,X=X))	
}

fitXy=function(y,X){
   C=crossprod(X) #X'X, the 'Coefficients Matrix '
   rhs=crossprod(X,y) # X'y the 'right-hand-side'
   CInv=solve(C)
   bHat=CInv%*%rhs
   
   return(bHat)
 }

```

[back to list](#MENUE)

<div id="INCLASS_8" />

### INCLASS 8

```{r}
 fitXy=function(y,X){
   C=crossprod(X) #X'X, the 'Coefficients Matrix '
   rhs=crossprod(X,y) # X'y the 'right-hand-side'
   CInv=solve(C)
   bHat=CInv%*%rhs
   eHat=y-X%*%bHat
   RSS=sum(eHat^2)
   DF=ncol(X)
   n=nrow(X)
   vE=RSS/(n-DF)
   
   VCOV=CInv*vE
   SE=sqrt(diag(VCOV))
   t_stat=bHat/SE
   p_value=pt(abs(t_stat),lower.tail=FALSE,df=DF)*2
   
   RES=cbind('Estimate'=bHat,'SE'=SE,'t_stat'=t_stat,'pVal'=p_value)
   rownames(RES)=colnames(X)
   return(RES)
 }

getXy=function(formula, ...){
  formula=as.character(formula)[-1]
  response=formula[1]
  predictors=formula[-1]
  X=model.matrix(formula(paste0('~',predictors)),...)

  y=get(response,...)

  return(list(y=y,X=X))	
}

fitOLS=function(formula,...){
  tmp=getXy(formula,...)
  X=tmp$X
  y=tmp$y
  fm=fitXy(X=X,y=y)
  return(fm)
}

```

[back to list](#MENUE)

<div id="INCLASS_9" />

### INCLASS 9

```{r}

solveSysQR=function(C,r){
  QR=qr(C)
  Q=qr.Q(QR)
  R=qr.R(QR)
  sol=backsolve(R,crossprod(Q,r))
  return(sol)
}

fitLMQR=function(X,y){
  QR=qr(X)
  Q=qr.Q(QR)
  R=qr.R(QR)
  Qy=crossprod(Q,y)
  sol=backsolve(R,Qy)
  return(sol)
}

fitLMSVD=function(X,y){
  SVD = svd(X)
  U= SVD$u
  V= SVD$v
  Dinv =diag(1/SVD$d)
  bhatSVD= V%*%Dinv%*%crossprod(U,y)
  sol=bhatSVD
  return(sol)
}

solveSysGS=function(C,rhs,tol=1e-5,maxIter=1000){
 	p=nrow(C)
	b=rhs/diag(C) # initial values

	for(i in 1:maxIter){
	  b0=b
	  
	  # Gauss Seidel iterations
	  for(j in 1:p){
	     b[j]=(rhs[j]-sum(C[j,-j]*b[-j]))/C[j,j]
	  }

	  if(max(abs(b0-b))<tol){
	  	break()
	  }
	}
	if(i==maxIter){ 
    return(NA)
	   message('Algorithm did not converge before ', i,' iterations.')
	}else{
	   message('Converged after ', i,' iterations.')
	}
	return(b)
}
```
[back to list](#MENUE)

<div id="INCLASS_10" />

### INCLASS 10

```r
set.seed(195021)
x<-seq(from=0, to=2*pi,by=0.2)
f0<-function(x){ 100+sin(2*x)+cos(x/2) }
R2<-2/3
y<-f0(x)+rnorm(n=length(x),sd=sqrt(var(f0(x))*(1-R2)/R2))
plot(y~x)
lines(x=x,y=f0(x),col='red',lwd=2)


library(splines)
RES=data.frame(df=seq(from=4,to=20,by=2), AdjRSq=NA,AIC=NA,BIC=NA,select=FALSE)

for(i in 1:nrow(RES)){
  Z=bs(degree=3,x=x,df=RES$df[i],intercept=FALSE) # Note index [i] in DF
  fm=lm(y~Z)
  
  RES$AdjRSq[i]=summary(fm)$adj.r.sq
  RES$AIC[i]=AIC(fm)
  RES$BIC[i]=BIC(fm)
}

RES$select[4]<-TRUE

ANS <- RES
```

[back to list](#MENUE)

<div id="INCLASS_11" />

### INCLASS 11

```r

DATA=read.table('GALTON.csv',header=TRUE,sep=',')
DATA$PA=(DATA$Father+DATA$Mother)/2

library(splines)
RES=data.frame(H0=c('Linear', 'NS3DF','NS4DF','NS6DF'), HA=c('NS3DF','NS4DF','NS6DF','NS8DF'),FStat=NA,pValue=NA)

Z0=DATA$PA
Z3=ns(x=DATA$PA,df=3,intercept=FALSE) # Note index [i] in DF
Z4=ns(x=DATA$PA,df=4,intercept=FALSE) # Note index [i] in DF
Z6=ns(x=DATA$PA,df=6,intercept=FALSE) # Note index [i] in DF
Z8=ns(x=DATA$PA,df=8,intercept=FALSE) # Note index [i] in DF
y=DATA$Height
fm0=lm(y~Z0)
fm3=lm(y~Z3)
fm4=lm(y~Z4)
fm6=lm(y~Z6)
fm8=lm(y~Z8)

a<-anova(fm0,fm3)

RES$FStat[1]<-a$F[2]
RES$pValue[1]<-a$"Pr(>F)"[2]

a<-anova(fm3,fm4)
RES$FStat[2]<-a$F[2]
RES$pValue[2]<-a$"Pr(>F)"[2]

a<-anova(fm3,fm6)
RES$FStat[3]<-a$F[2]
RES$pValue[3]<-a$"Pr(>F)"[2]

a<-anova(fm3,fm8)
RES$FStat[4]<-a$F[2]
RES$pValue[4]<-a$"Pr(>F)"[2]

RES_chosenModel<-'Linear'

```

[back to list](#MENUE)

<div id="INCLASS_12" />

### INCLASS 12

```r
GOUT=read.table('goutData.txt',header=TRUE)


GOUT$gout <- ifelse(GOUT$gout=="Y",1,0)
GOUT$sex <- as.factor(GOUT$sex)
GOUT$race <- as.factor(GOUT$race)

H0 <- glm(gout~race+sex+age, data = GOUT, family=binomial(link=logit))
H1 <- glm(gout~sex+age, data = GOUT, family=binomial(link=logit))
H2 <- glm(gout~race+age, data = GOUT, family=binomial(link=logit))
H3 <- glm(gout~race+sex, data = GOUT, family=binomial(link=logit))


ANS = data.frame(factor=c('Race','Sex','Age'),DF=NA,logLik=NA,chisq=NA,pValue=NA)

ANS$DF <- c(H1$df.residual - H0$df.residual,H2$df.residual - H0$df.residual,H3$df.residual - H0$df.residual)
ANS$logLik <- c(as.numeric(logLik(H1)),as.numeric(logLik(H2)),as.numeric(logLik(H3)))
ANS$chisq <- c(-2*(as.numeric(logLik(H1)) - as.numeric(logLik(H0))),
               -2*(as.numeric(logLik(H2)) - as.numeric(logLik(H0))),
               -2*(as.numeric(logLik(H3)) - as.numeric(logLik(H0))))
ANS$pValue <- pchisq(q = ANS$chisq, df = ANS$DF, lower.tail = FALSE)
ANS



negLogLik <- function(y,X,b) {
  p <- exp(X %*% b) / (1 + exp(X %*% b))
  log_lik <- sum(ifelse(y==1,log(p),log(1-p))) 
  return(-log_lik)
}

fitLogisticReg=function(y,X){
  #for(j in 2:ncol(X)){ X[,j] = X[,j]-mean(X[,j]) }
  
  initial_beta <- c(log(mean(y)/(1-mean(y))),rep(0,ncol(X)-1))
  opt <- optim( par = initial_beta, fn = negLogLik, X=X,y=y, hessian = TRUE)
  
  COV=solve(opt$hessian)
  Estimates=opt$par
  SEs=sqrt(diag(COV))
  tstats=Estimates/SEs
  pvalues=pt(df=length(y)-ncol(X),q=abs(tstats),lower.tail=F)*2
  
  OUT=data.frame(predictor=colnames(X),Estimate=Estimates,SE=SEs,tStat=tstats,pValue=pvalues)
  return(OUT)
} 

```

[back to list](#MENUE)

<div id="INCLASS_13" />

### INCLASS 13



**1)** X follows a Normal distribution with mean 10 and variance 4. Evaluate the following probabilities:
   - P(X<8)
   - P(X>11)
   - P(8<X<11)


```r
 pnorm(q=8,mean=10,sd=2)
 pnorm(q=11,mean=10,sd=2,lower.tail=FALSE)
 pnorm(q=11,mean=10,sd=2)-pnorm(q=8,mean=10,sd=2)
```


**2)** For the same RV X, we produce a linear transformaton Z=(X-10)/2. Compute the following probabilities
   - P(Z< -1)
   - P(Z> 1/2)
   - P( -1 < Z < 1/2)


If X~N(10,VAR=4), then Z=(X-10)/2  ~N(0,1)

```r 
 pnorm(q= -1)
 pnorm(q=1/2,lower.tail=FALSE)
 pnorm(q=0.5)-pnorm(q= -1)
```


**3)** Let Z1, Z2,...,Zp be IID Bernoulli random variables with success probability 0.07. Now let X=Z1+Z2+...+ZP. Compute and report the following probabilities for `p=[10,20,30]`

  - P(X=3)
  - P(X>3)
  - P(X<3)
  - P(X<=3)
  - Verify that P(X<=3)+P(X>3)=1

```r
 p=c(10,20,30)
 # P(X=3)
  dbinom(size=p,prob=.07,x=3)

 # P(X>3)
 1-pbinom(size=p,prob=.07,q=3)
 # alternatively use lower.tail=FALSE
 pbinom(size=p,prob=.07,q=3,lower.tail=FALSE) # P(X>3)

 pbinom(size=p,prob=.07,q=3,lower.tail=FALSE)+pbinom(size=p,prob=.07,q=3,lower.tail=TRUE)
```
[back to list](#MENUE)


<div id="INCLASS_14" />

### INCLASS 14

**Sampling: From Uniform to Gamma**

```r
 rgamma2=function(n,shape,rate){
     
     # IID uniform draws, arranged in an n by shape matrix
     U=matrix(nrow=n,ncol=shape,data=runif(n*shape))
     
     # Transforming from uniform to exponential
     X=-log(U)/rate
     
     # Adding exponentials to get gamma
     y=rowSums(X)
     
     return(y)
  }
```


*Testing*

```r
  x=rgamma(n=100000,rate=1.25,shape=3)
  y=rgamma2(n=100000,rate=1.25,shape=3)
  p=seq(from=.01,to=.99,by=.01)
  plot(quantile(x,p=p),quantile(y,p=p));abline(a=0,b=1)
```

**Sampling Bi-variate Bernuilli using Composition Sampling**



Joint probability:

```r
PXY=rbind( 'X=0'=c('Y=0'=.1,'Y=1'=.1),'X=1'=c('Y=0'=.2,'Y=1'=.6))
```

We need to derive the marginal and conditional success probability of Y|X

```r
 pX=rowSums(PXY) # marginal distribution of X
 pYgX=PXY[,2]/rowSums(PXY) # conditional distribution of Y given X
```

Sampler

```r
n=100000
X=rbinom(size=1,n=n,p=pX[2])
Y=rbinom(size=1,n=n,p=pYgX[ X+1])
table(X,Y)/n
```


#### Gibbs sampler

We first find the fully-conditionals P(Y|X) and P(X|Y)

 - P(X=1|Y=0)=p(Y=1 & Y=0)/P(Y=0) ;  P(X=1|Y=1)=p(X=1 & Y=1)/P(Y=1)
 - P(Y=1|X=0)=p(Y=1 & X=0)/P(X=0) ;  P(Y=1|X=1)=p(Y=1 & X=1)/P(X=1)

```r
 pXgY=PXY[2,]/colSums(PXY)
```
Then we sample recursively usinge these distributions.

```r
 X=rep(NA,n)
 Y=rep(NA,n)
 X[1]=1;Y[1]=0 #initialization

 for(i in 2:n){
   X[i]=rbinom(size=1,n=1,p=pXgY[Y[i-1]+1])
   Y[i]=rbinom(size=1,n=1,p=pYgX[X[i]+1])
 }
 table(X,Y)/n
 PXY

```

[back to list](#MENUE)

<div id="INCLASS_15" />

### INCLASS 15

```r
 rMVNorm=function(mu,COV,n){
	p=length(mu)
	X=matrix(nrow=n,ncol=p,NA)
 	B=t(chol(COV))

	for(i in 1:n){
		z=rnorm(p)
		x=mu+B%*%z
		X[i,]=x
	}
	return(X)
 }
```

[back to list](#MENUE)

<div id="INCLASS_15_POWER" />

### INCLASS 15-POWER

```r

```
[back to list](#MENUE)


<div id="INCLASS_16" />

### INCLASS 16

[back to list](#MENUE)

<div id="INCLASS_17" />

### INCLASS 17

[back to list](#MENUE)

<div id="INCLASS_18" />

### INCLASS 18

[back to list](#MENUE)

<div id="INCLASS_19" />

### INCLASS 19

[back to list](#MENUE)

<div id="INCLASS_20" />

### INCLASS 20

[back to list](#MENUE)

<div id="INCLASS_20" />


