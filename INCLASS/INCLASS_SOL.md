
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

**Hierarchical clustering**

```r
 D=dist(t(scale(DATA[,1:9]))) #Euclidean distance between columns, aftern centering and scaling
 HC=hclust(D)
 plot(HC)
```
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

**4)**  Recoding: 3-strategies

**Note**: The examples below are meant to illustrate how to create functions. For data recoding you can use built-in function such as `map()` or `cut()`. 


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
 recodeOne=function(x,breaks){
  ans="G<=6"
  if(x==7){
    ans="G=7"
  }
  
  if(x>7){
   ans="G>=8"
  }
  return(ans)
 }

```
Note: the above function recodes one entry of the vector, to recode anentire vector we can use either `sapply()` or ifelse. 

```r
 recode=function(x,breaks){
  sapply(FUN=recodeOne,X=x,breaks=breaks)
 }
 DATA$gleason_4=recode(DATA$gleason,c(6,7))
 table(DATA$gleason_1,DATA$gleason_4)
```
[back to list](#MENUE)

<div id="INCLASS_Rmarkdown_practice" />

 ## INCLASS Rmarkdown practice
 
 ### Using Rmarkdown for in class assignments and homework

From now and on we will be writing the solution to in class assignments and homework to Rmarkdown.

For a summary of the syntax rules go to this [cheatsheet 1](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf).

### Aim of assignment:

In the next, tasks we are going to:

- create a simulated data set of variables drawn either from discrete or continuous distributions,

- then we will use this data set to practice on ggplot2 visualizations.



### The simulated data set

The simulated data set will have variables that will express the *vitamin D concentration* in nmol/L of a simulated sample of *60 patients* that have normal and very low  levels of vitamin D.

According to [NIH](https://ods.od.nih.gov/factsheets/VitaminD-Consumer/#:~:text=Levels%20of%2050%20nmol%2FL,and%20might%20cause%20health%20problems.):

"Because you get vitamin D from food, sunshine, and dietary supplements, one way to know if you’re getting enough is a blood test that measures the amount of vitamin D in your blood. In the blood, a form of vitamin D known as 25-hydroxyvitamin D is measured in either nanomoles per liter (nmol/L) or nanograms per milliliter (ng/mL). One nmol/L is equal to 0.4 ng/mL. So, for example, 50 nmol/L is the same as 20 ng/mL.

- Levels of 50 nmol/L (20 ng/mL) or above are adequate for most people for bone and overall health.

- Levels below 30 nmol/L (12 ng/mL) are too low and might weaken your bones and affect your health.

### Question 1

Create the variable, *D_group*,  that will express in which category a patient belongs to: normal levels or low levels of vitamin D.
Hint draw from the binomial distribution and take into consideration that the prevalence of vitamin D deficiency in the US is about 42%.
#### Solution  1
I will draw randomly from a binomial of 60 trials. The probability of success will correspond to subjects with normal levels (so a probability of 1- 0.42 = 0.58)

```{r D_group}
set.seed(1)
D_group = rbinom(1,n=60,prob = 0.58)

```

### Question 2

Create the variable, *D_level*,  that will express the level of vitamin D based on the group a patient belongs to. Hint: for Normal levels draw from the normal distribution with mean 60 and sd = 3,for low levels draw from the normal distribution with mean= 20 and sd = 3.

#### Solution 2
```{r}
D_level = rep(0, times=60)

n_norm_levels = length(which(D_group == 1))
n_low_levels =  length(which(D_group == 0))

D_level[D_group == 1] = rnorm(n=n_norm_levels, mean = 60, sd = 3)
D_level[D_group == 0] = rnorm(n=n_low_levels, mean = 20, sd = 3)
```

### Question 3

Create the variable, *Sex*,  that will express if a patient is Male or Female. Hint draw from the binomial distribution and assume that the sample has equal number of participants from each of the categories.

#### Solution 3
```{r}
set.seed(4)
Sex = rbinom(1,n=60,p=0.5)
Sex = ifelse(Sex, 'f', 'm')
```

### Question 4
#### Solution 4
Create the variable, *Age*,  of the subject. Assume that we have sampled uniformly females of ages between 20 and 50 and male of ages between 20 and 50. 

```{r}
n_female = length(which(Sex == 'f'))
n_male = length(which(Sex == 'm'))

Age = rep(0,times=60)
Age[Sex == 'f']= runif(n=n_female, min = 20, max =50)
Age[Sex == 'm']=runif(n=n_male, min = 20, max =50)

```
### Question 5

Create the data frame, vitamin_D, with columns the variables created in question 1 through 4.
#### Solution 5
```{r}
vitamin_D = data.frame(D_group=D_group, D_level=D_level, Age = Age, Sex=Sex)
vitamin_D$D_group = as.factor(vitamin_D$D_group)
vitamin_D$Sex = as.factor(vitamin_D$Sex)

```

### Question 6
Use ggplot2 to create side-by-side boxplots of the *D_level* of the different *D_groups*

Use ggplot2 to create side-by-side boxplots of the *D_level* of the different *Sex*
#### Solution 6
```{r}
library(ggplot2)

ggplot(vitamin_D, aes(x=D_group, y=D_level)) + 
  geom_boxplot()

ggplot(vitamin_D, aes(x=Sex, y=D_level)) + 
  geom_boxplot()
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

**A function to fit models via OLS**

```r
 fitXy=function(y,X){
   C=crossprod(X) #X'X, the 'Coefficients Matrix '
   rhs=crossprod(X,y) # X'y the 'right-hand-side'
   bHat=solve(C,rhs)
   return(bHat)
 }

```
**Testing the function**

```r
n=300
 x1=rbinom(size=1,n=n,prob=.5)
 x2=rnorm(n)
 mu=100
 b1=2
 b2=-3
 
 signal=mu + x1*b1 + x2*b2
 error=rnorm(n)
 y=signal+error
 
 coef(lm(y~x1+x2))
 
 fitXy(y,X=cbind(1,x1,x2))
 
```

**Using a formula interface**

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

## Now a function that takes a formula as an input
fitOLS=function(formula,...){
	tmp=getXy(formula,...)
	X=tmp$X
	y=tmp$y
	fm=fitXy(X=X,y=y)
	return(fm)
}

```

**Testing**

```r
 fitOLS(y~x1+x2)
 
 ## passing variables trhough a data frame
 DATA=data.frame(y=y,z1=x1,z2=x2)
 fitOLS(y~z1+z2,DATA)
 
 ## Interested to learn about R-environments? See http://adv-r.had.co.nz/Environments.html
```
**Estimates, SE, t-stat, and p-values**

```r
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


fitXy(y,X=cbind(1,x1,x2))
summary(lm(y~x1+x2))

```
[back to list](#MENUE)

<div id="INCLASS_5_Supplemental" />

### INCLASS 5 Supplemental
We will attempt to predict Sales (child car seat sales) in 400 locations based on a number of predictors.The Carseats data includes qualitative predictors such as Shelveloc, an indicator of the quality of the shelving location—that is, the space within a store in which the car seat is displayed—at each location. The predictor Shelveloc takes on three possible values: Bad, Medium, and Good.

More on Carseats dataset [here](https://rdrr.io/cran/ISLR2/man/Carseats.html)


## Question 1: Explore the data set Carseats, create boxplots for each variable and a scatterplot of sales vs each of the other variable. Which of the variables do you expect to have a linear relationship with sales?
```{r}
library(ISLR2)
head(Carseats)

```

## Question 2: Predict Carseat sales using all other variables

```{r}
fm <- lm(data = Carseats, Sales~.)
summary(fm)

```

## Question 3: Explore evaluation plots for the above model. What do you observe, are the assumption regarding the model errors satisfied?

```{r}
plot(fm)
```

Conclusion: We observe that the plot od residuals is symmetric accross the horizontal line that crosses 0 and the cloud of residuals fitted values doesn't have a pattern, instead dots are scattered on the plot. This indicates the errors of the models (which we estimate using the residuals) are independent.

Also the spread of the cloud is constant so we estimate that the errors of the model have constant variance.

Additionally, from the QQ plot we observe that the theoretical quantiles of the normal distribution are almost the same as the standardized residuals, hence we can coclude that the assumption about the normality of the residuals holds.



## Question 4: Assuming that assumptions about the error term hold. Use an Ftest to answer the following question.Is at least one of the predictors X1, X2,...,Xp useful in predicting the response? or are all coefficients  zero and there is only the intercept in the model?

```{r}
n=dim(Carseats)[1]
H0 = lm(Sales ~ 1, data = Carseats)
Ha = lm(Sales ~., data = Carseats)

RSS0 = sum(residuals(H0)^2)
RSSA = sum(residuals(Ha)^2)

MSS = RSS0 - RSSA

df1 = length(coef(Ha)) - length(coef(H0))
df1
df2 = n-length(coef(Ha))
df2

Fstat = (MSS/df1)/(RSSA/df2)
Fstat

pval= pf(Fstat, df1 =df1, df2=df2, lower.tail = F)

print(c('Ftest' = Fstat, 'df1'= df1, 'df2'=df2, 'pval' = pval ))

# OR

anova(H0,Ha)
```
H0: The coeeficients of all variables of the Carseats dataset are zero. None of the variables are useful in predicting Sales.

HA: There is at least one coefficient of the Carseats dataset that is non-zero and the corresponding variable is useful in predicting Sales

Conclusion: We observe that the p-value from the Ftest is very close to zero hence we has strong evidence that there is at least one variable which is useful in predicting Sales.


## Question 5: Use the Ftest to test if the variables Population, Education, Urban, US, Age are useful in predicting Sales.

```{r}
n=dim(Carseats)[1]
H0 = lm(Sales ~ CompPrice + Income + Advertising + Price + 
          ShelveLoc, data = Carseats)
Ha = lm(Sales ~.   , data = Carseats)

RSS0 = sum(residuals(H0)^2)
RSSA = sum(residuals(Ha)^2)

MSS = RSS0 - RSSA

df1 = length(coef(Ha)) - length(coef(H0))
df1
df2 = n-length(coef(Ha))
df2

Fstat = (MSS/df1)/(RSSA/df2)
Fstat

pval= pf(Fstat, df1 =df1, df2=df2, lower.tail = F)

print(c('Ftest' = Fstat, 'df1'= df1, 'df2'=df2, 'pval' = pval ))

# OR

anova(H0,Ha)
```

Since the p-value is very close to zero we have evidence that the mentioned variables are useful in predicting Sales.

##  Question 6: Fit the model Sales vs the remaining useful variables and adding some interatcions in the model. Write the regression equation with the estimated coefficients and interpret the coefficients of the intereaction terms.

```{r}
as.formula(Carseats)

fm_int = lm(Sales ~ CompPrice + Income + Advertising + Population + Price + 
    ShelveLoc + Age + Education + Urban + US + Price*ShelveLoc   , data = Carseats)
summary(fm_int)

# How is ShelveLoc coded?
model.matrix(fm_int)
```

Better quality seats will increase the price coefficient and make the customers less sensitive to high price for good quality products.

If the quality is low the coefficient of price doesn't change.

If the price increases the coefficients of the quality increases and hence the number of sales.

[back to list](#MENUE) 

### INCLASS 6

<div id="INCLASS_6" />

**The data**
```r
 n=500
 p=5
 X=matrix(nrow=n,ncol=p,data=rnorm(n*p))
 y=X[,3]-X[,5]+rnorm(n)
 
 C=crossprod(X)
 r=crossprod(X,y)
```

**A function to solve the system Cx=r using QR**

```r
 solveSysQR=function(C,r){
 	QR=qr(C)
	Q=qr.Q(QR)
	R=qr.R(QR)
	sol=backsolve(R,crossprod(Q,r))
	return(sol)
 }
 
 # testing
 solve(C,r)
 solveSysQR(C,r)

```

**A function to fit a linear model via QR**


```r
 fitLMQR=function(X,y){
  	QR=qr(X)
	Q=qr.Q(QR)
	R=qr.R(QR)
	Qy=crossprod(Q,y)
	sol=backsolve(R,Qy)
	return(sol)
 }
 
 fitLMQR(cbind(1,X),y)
 coef(lm(y~X))

```
**A function to fit a linear model via SVD**

```r
 fitLMSVD=function(X,y){
  SVD = svd(X)
  U= SVD$u
  V= SVD$v
  Dinv =diag(1/SVD$d)
  bhatSVD= V%*%Dinv%*%crossprod(U,y)
	sol=bhatSVD
	return(sol)
 }
 
 fitLMSVD(cbind(1,X),y)
 coef(lm(y~X))
```

**Gauss Seidel**


```r
  
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
	   message('Algorithm did not converge before ', i,' iterations.')
	}else{
	   message('Converged after ', i,' iterations.')
	}
	return(b)
  }
  
  solveSysGS(crossprod(X),crossprod(X,y))
  coef(lm(y~X-1))
```

[back to list](#MENUE)

### INCLASS 7 

<div id="INCLASS_7" />
	
**Q1:Cholesky decomposition.**

Use the code below to generate a system of 5 equations on 5 unknowns (**Cb=r**). 
Solve the system using the Cholesky decomposition and `lm(y~X-1)`.
Use the function system.time() to compare the time needed to solve this system of equations with lm, Cholesky and Gauss-Seidel.

```{r}
 n=500
 p=5
 X=matrix(nrow=n,ncol=p,data=rnorm(n*p))
 y=X[,3]-X[,5]+rnorm(n)
 
 C=crossprod(X)
 r=crossprod(X,y)
 
 b_chol_time <- system.time(chol2inv(C)%*%r)
 b_chol_time
 ## Gauss Seidel
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
	   message('Algorithm did not converge before ', i,' iterations.')
	}else{
	   message('Converged after ', i,' iterations.')
	}
	return(b)
  }
  
  b_GS_time <- system.time(solveSysGS(C,r))
  b_GS_time
  ## With lm
  b_lm_time <- system.time(coef(lm(y~X-1)))
  b_lm_time


```
Looking at the elapsed time we observed that it took a little longer for Gauss-Seidel to find the solution. The actual performance of such methods should in general be tested on higher dimensional problems.

**Q2:SVD**

Below you can find how to read a data set of the gene expression data (columns) of Europeans and African ancestry people(row). Use SVD of X after scaling X, to reduce the dimension of the data set to two. Using the new dimension make a plot that illustrates the separation of the subjects to two groups.

```{r}
X=read.csv('https://www.dropbox.com/scl/fi/x1ixoaps699baao6xi3ye/GENOS_TWO_GROUPS.csv?rlkey=oirqands5fisg148o9xuadh97&dl=1',header=TRUE,row.names=1)

X=as.matrix(X)
dim(X)
X[1:10,1:3]
X=scale(X)
SVD=svd(X)
plot(SVD$u[,1:2],xlab='1st Eigenvector',ylab='2nd Eigenvector')


```
We observe that the reduced dimensions of the above gene expression data set groups the subjects of the study in to two groups. Having the variable of ancestry we could color the above plot based on whether a subject (dot) is of European or of African ancestry and we would expect to reflect the grouping of the plot.

**Q3:Non linear regression for median value of houses in suburbs of Boston**

Using the Boston data of ISLR2 package, we want to answer the question, "Is there evidence of non-linear association between  the response (medv) any of the predictors (rest of variables)?" 

To answer this question, for each
predictor X, fit a model of the form Y = beta0 + beta1*X + beta2*X2 + beta3*X3 + e


```{r}
library(ISLR2)
head(Boston)

colnames(Boston)
Boston[1:2,]


```

We  apply the model medv = beta0 + beta1*X + beta2*X2 + beta3*X3 + e for X being each of the column variables but the categorical variables. Then, we can record for which of the models the coefficient of X^2 or X^3 is significant for the prediction of medv. We will record this to the logical variable __non_linear__.

If they second or third power terms are significant then there will be evidence that the corresponding variable and medv are related non-linearly.

```{r}
non_linear<-c()
R_adj <- c()
for(i in c(1:3,5:12)){
  Y = Boston$medv
  X =  Boston[,i]
  fmPoly=lm(Y~X+I(X^2)+I(X^3))
  non_linear = rbind(non_linear,summary(fmPoly)$coefficients[3,4]< 0.001 | summary(fmPoly)$coefficients[4,4]< 0.001)
  R_adj = rbind(R_adj, summary(fmPoly)$adj.r.squared)
}

Nonlinear_models_summary<- data.frame(variable = colnames(Boston)[c(1:3,5:12)],
                                     non_linear = non_linear,
                                     R_adj = R_adj)
Nonlinear_models_summary[Nonlinear_models_summary$non_linear == TRUE,]


```

We observe that there are strong evidence that the variables crim, zn,indus, rm, rad, lstat. From those the best fit was observed for lsta and rm, which have the largest adjusted R squared values.
[back to list](#MENUE)

### INCLASS 8
<div id="INCLASS_8" />

```{r}
set.seed(195021)
x<-seq(from=0, to=2*pi,by=0.05)
f0<-function(x){ 100+sin(2*x)+cos(x/2) }
R2<-0.5
y<-f0(x)+rnorm(n=length(x),sd=sqrt(var(f0(x))*(1-R2)/R2))
plot(y~x)
lines(x=x,y=f0(x),col='red',lwd=2)


library(splines)
RES=data.frame(DF=seq(from=4,to=20,by=2),RSS=NA,RSq=NA,AdjRSq=NA)

for(i in 1:nrow(RES)){
  Z=bs(degree=3,x=x,df=RES$DF[i],intercept=FALSE) # Note index [i] in DF
  fm=lm(y~Z)
  
  RES$RSS[i]=sum(residuals(fm)^2)
  RES$RSq[i]=summary(fm)$r.sq
  RES$AdjRSq[i]=summary(fm)$adj.r.sq
}


plot(AdjRSq~DF,col=2,type='o',data=RES);abline(v=RES$DF,col=8,lty=2)
plot(RSq~DF,col=2,type='o',data=RES);abline(v=RES$DF,col=8,lty=2)
```
We observe that the model with 6, 8 and 20 degrees of freedom achieve the best adjusted R square.
[back to list](#MENUE)

### INCLASS 9
<div id="INCLASS_9" />

### 9A: Logistic Regression

The [gout data set](https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/goutData.txt) contain information on gout (a common form of inflammatory arthritis) sex, race, age and other covariates.

**Use `glm()` to fit a logistic regression of the form `gout~race+sex+age`**:
  - Fit the model
  - Summarize your findings
  - Test each of the factors (race/sex/age) separately using likelihood ratio test. 

To do this, for each factor, fit the model without that factor (H0), extract the log-likelihood (logLik(H0)), determine the DF (difference in the number of paramters between H0 and HA (the full model that you fitted before) and compute a p-value using `pchisq()`, compare your results with: 
  (i) the pvalues from summary(HA), and with those of 
  (ii) anova(H0,HA) which implements likelhood ratio test (the pvalues from anova() should be identical, up to rounding errors, to the ones you obtained. 

Suggestions: 
 - Convert the gout variable (Y/N) into (1 if Yes, 0 if No gout).
 - Don't forget to specify family='binomial'! 

### Solution of 9A
```{r}
Gout <- read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/goutData.txt', header = TRUE)
Gout$gout <- ifelse(Gout$gout =='Y', 1,0)

logmod <- glm(gout~race+sex+age, data = Gout, family = binomial)
summary(logmod)

```
We observe that age and the intercept are the more helpful variables to predict the log of odds of the probability of someone having gout.

Parametric test using normal distribution which is the test conducted in glm summary

```{r}
#Parametric test using normal distribution - glm summary
p_glm <-as.vector(summary(logmod)$coefficients[-1,4])
variables <- c('race','sex','age')
```

ANOVA and LRT tests:
 
```{r}
p_lrt <- c()
p_anova <- c()

# Loglikelihood of the full model
lmle = logLik(logmod)[1]

# Ho: variable isn't helpful vs HA: variable is helpful

for(i in 1:3){
  #LRT
  form<- as.formula( paste0('gout~', paste(variables[-i], collapse=" + ")))
  logmod0 <- glm(form, data = Gout, family = binomial)

  l0 = logLik(logmod0)[1]
  lrt = -2*l0+2*lmle

  p_lrt[i] = pchisq(lrt, df = length(coef(logmod))-length(coef(logmod0)), 
       lower.tail = FALSE )

  #ANOVA you can use either test = LRT or Chisq - RECOMMENDED is LRT

  anova_table = anova(logmod0, logmod, test= 'LRT')
  p_anova[i] = anova_table$`Pr(>Chi)`[2]
}

```

Table of all results:

```{r}
HT_results <- data.frame(method =rep(c('glm_summary', 'LRT_test', 'anova_test'), each =3),
                              p_value = c(p_glm,p_lrt,p_anova),
                              variable = rep(variables, times=3))
HT_results$significant <- ifelse(HT_results$p_value<0.015, 'yes','no')

HT_results[order(HT_results$variable),]

```
The anova method and the LRT method with LogLik provide the same p-values. The parametric test of glm that uses the normal distribution will lead to the same conclusion but with a slightly different p-value.

#### 9B: Fit the logistic regression model using optim()

Your goal would be to produce a table similar to the one returned by summary(glm()) using optim()

Suggestions:

 - Center all the columns of the incidence matrix (X), except the first one. This makes all predictors orthogonal to the vector of 1s (incidence vector for the intercept)
and thus, it facilitates convergence (not centering predictors do not affect regression coefficients).
 - Initialize the intercept to mu=log(mean(y)/(1-mean(y)) and all the other regression coefficients to zero.
 
### Solution of 9B

```{r}
 neglog = function(beta, Data, y_indx, x_indx){
  Y <-  Data[, y_indx]
  X <- Data[, x_indx]
  n <- nrow(Data)
  #uncomment if your Data input doesn't have an intercept column of ones
  #X <- cbind(rep(1, n), X) 
  Z <- as.matrix(X)%*%beta
  p <- exp(Z)/(1+exp(Z))
  ngl = - sum(Y%*%log(p) + (1-Y)%*%log(1-p))
  return(ngl)
}
```

With centering
```{r}
X = model.matrix(~race+sex+age, data =Gout)
X[,2:4] = apply(X[,2:4], 2, function(x) x-mean(x))

Gout_scaled = cbind(Gout$gout, X)
ybar=mean(Gout_scaled[,1])

mle_logistic <- optim(par=c(log(ybar/(1-ybar)),0,0,0), Data =Gout_scaled, 
                      y_indx= 1, x_indx=2:5 ,fn = neglog, hessian = TRUE)

mle_logistic
```

Without centering
```{r}
X = model.matrix(~race+sex+age, data =Gout)
#X[,2:4] = apply(X[,2:4], 2, function(x) x-mean(x))

Gout_scaled = cbind(Gout$gout, X)
ybar = mean(Gout_scaled[,1])
mle_logistic <- optim(par=c(log(ybar/(1-ybar)),0,0,0), Data =Gout_scaled,
                      y_indx= 1, x_indx=2:5 ,fn = neglog, hessian = TRUE)

mle_logistic
```

Since we achieved convergence without centering, we will not center the data

Hypothesis testing for each coefficient

```{r}
VAR=solve(mle_logistic$hessian)
VAR
SEs = sqrt(diag(VAR))
SEs

Estimate = mle_logistic$par
Std.Error = SEs
z_value = Estimate/SEs
Pr = 2*pnorm(abs(z_value), 0,1, lower.tail = FALSE)

GLM_OUTPUT = data.frame(Estimate = Estimate,
                        Std.Error = Std.Error,
                        z_value = z_value,
                        Pr=Pr)
GLM_OUTPUT
```
[back to list](#MENUE)



### INCLASS 11
<div id="INCLASS_11" />

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


**4)** The Poisson Distribution is used for count variables (i.e., variables that can take values 0, 1, 2,...) and can be viewed as an 
approximation to the Binomial distribution when the success probability of each of the Bernoulli trials is small and the number of trials is large. 
The distribution has a signle parameter (labmda) which is both the expected value and the variance of the RV. 

Use R to generate 10,000 draws from Binomial and Poisson, for a RV X which is the sum of 50 Bernoulli trials, each with success probability 0.05. Hint: for the Poisson simulation set lambda to be the expected value of the Binomial RV.
Compare the results of both simulations using table(X).


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


**5)** The estimated regression coefficient for the effect of education in wages in a linear model (b) that included an intercept and 5 other predictors was 0.83 and the SE was 0.45. Compute the p-value for testing the following hypothes

   - H0: b=0 Vs Ha: b different than 0
   - H0: b=0.5 Vs Ha: b>0.5
   
Counduct the test assuming that b follows a normal distribution first, and then using a t-distribution for (b-b0)/SE using df=20.

```r
  bHat=0.83
  SE=0.45
  b0=0 # null value

  # Using pnorm(),i.e., ignoring that SE was estimated from the same data used to estimate bHat.
  pnorm(bHat,sd=SE,lower.tail=FALSE)

  # Using the t-distribution
  b0=0
  Z=(bHat-b0)/SE
  pt(Z,df=20,lower.tail=FALSE)
  # with df=20, the t-distribution has thicker tails than the N(0,1)

```



### IN-CLASS 12

<div id="INCLASS_12A" />
	
## A) Transformations of RVs

From the network of distributions included in Figure 1 of the [handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/SimulatingRandomVariables.pdf) we have that:
  - We can generate exponential random variables by transforming a uniform RV `Y=-log(X)/lambda`.
  - The sum of *r* IID exponential RVs with rate parameter *lambda* follows a Gamma distribution with shape equal to *r* and rate parameter equal to *lambda*.
 
Develop a function that will generate *n* IID gamma distributed RVs with the specified shape and rate parameters. Your function should generate the draws from gamma distribution starting from draws from a uniform distribution.


```r
  rgamma2=function(n,shape,rate){
     U=runif(n*shape)   # sampling uniform
     EXP= -log(U)/rate # transforming to make it exponential
     X=matrix(ncol=shape,nrow=n,data=EXP) # shaping it into a matrix
     Y=rowSums(X) # adding 
     return(Y)
  }
```


 - Use your function to generate 100,000 draws of a Gamma RV with shape=5,rate=2.
 - Present a histogram of your draws, print the mean and variance of the draws.
 - Generate another set of 100,000 draws using `rgamma(n=100000,rate=2,shape=5)`, produce a histogram for these draws, print the mean and variance of the draws. Compare with the mean and variance of the draws generated using your function.

```r
 x1=rgamma(n=100e3,shape=5, rate=2)
 x2=rgamma2(n=100e3,shape=5,rate=2)

 rbind('mean'=c(mean(x1),mean(x2)),
        'var'=c(var(x1),var(x2)))


 plot(density(x1),lty=2,col=4)
 tmp=density(sort(x2))
 lines(x=tmp$x,y=tmp$y,col=2)
```


<div id="INCLASS_12B" />
	
## B) Composition Sampling and Gibbs Sampling

Draw 100,000 samples from the bi-varaite Bernoulli in the Table in section 2.1 of the [handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/SimulatingRandomVariables.pdf) on sampling
random variables, using the algorithms described in Box 1 and Box 2 of the handout.


#### Compostion sampling

We find the marginal distribution of X and the conditional distribution of Y|X. Because both X and Y are {0,1} both distributions must be Bernoulli.

  - P(X=1)=P(X=1|Y=0)+P(X=1|Y=1)
  - P(Y=1|X=0)=p(Y=1 & X=0)/P(X=0) ;  P(Y=1|X=1)=p(Y=1 & X=1)/P(X=1)

 **Solution**:

Joint probability:

```r
PXY=rbind( 'X=0'=c('Y=0'=.1,'Y=1'=.1),'X=1'=c('Y=0'=.2,'Y=1'=.6))
```

We need to derive the marginal and conditional success probability of Y|X

```r
 pX=rowSums(PXY)
 pYgX=PXY[,2]/rowSums(PXY)
```

Now we sample

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

### IN-CLASS 13

<div id="INCLASS_13" />

i) Create a function that will generate samples from a MVN using the Cholesky decomposition (see example in the handout)

```r
 rMVN=function(mu,S,n){
     p=length(mu)
     Z=matrix(nrow=n,ncol=p,data=rnorm(n*p))
     B=chol(S) 
     
     X=Z%*%B # Note: with B=chol(S), B'B=S (verify...). 
     
     ## Adding the mean
     for(i in 1:p){ X[,i]=X[,i]+mu[i] }
     return(X)
  }
```
ii) Generate 10,000 samples with your function and check whether the empirical mean and empirical covariance matrix matches closely the true parameter values.

```r

 mu=c(2,10,3) # mean vector
 S=diag(c(1,2,1.2))  # variances
 S[1,2]=S[2,1]=.5    # covariance 1,2
 S[1,3]=S[3,1]=.2    # covariance 1,3
 S[3,2]=S[2,3]=.4    # covariance 2,3  


  library(MASS)
  
  system.time(X<-mvrnorm(Sigma=S,mu=mu,n=100000))
  system.time(X2<-rMVN(S=S,mu=mu,n=100000))
  round(cov(X),4)
  round(cov(X2),4)
  
  cbind(mu,round(colMeans(X),4), round(colMeans(X2),4))
```


### IN-CLASS 14

<div id="INCLASS_14_A" />

**A function to simulate the data**

```r
 simulateData=function(N,b,signal_to_noise_ratio){
  x=rnorm(N)
  signal=100+x*b 
  vE=var(signal)/signal_to_noise_ratio
  error=rnorm(sd=sqrt(vE),n=N) 
  y=signal+error
  DATA=data.frame(x=x,y=y)
  return(DATA)
}
```

**5,000 Monte Carlo Simulations**

```r
nRep=5000
pVals=rep(NA,nRep)

for(i in 1:nRep){
	DATA=simulateData(N=100,b=1,signal_to_noise_ratio=0.1)
	fm=lm(y~x,data=DATA)
	pVals[i]=summary(fm)$coef[2,4]

}
# estimated power
mean(pVals<0.05)

```

**Part II**

<div id="INCLASS_14_B" />
	
```r

 simulateData=function(N,signal_to_noise_ratio){
  x=rnorm(N)  
  error=rnorm(N) 

  if(signal_to_noise_ratio>0){
    vE=1/signal_to_noise_ratio
    y=x+error*sqrt(vE)
  }else{
    y=error
  }

  DATA=data.frame(x=x,y=y)
  return(DATA)
}

 SCEN=expand.grid(n=c(10,30,50,100,200),SNR=c(0,.05,.1,.15),rej_rate=NA) # SNR=signal_to_noise_ratio
 nRep=1000 # need to use more!
 for(i in 1:nrow(SCEN)){
   SNR=SCEN$SNR[i]
   N=SCEN$n[i]
   pVals=rep(NA,nRep)
   for(j in 1:nRep){
     DATA=simulateData(N,SNR)
     fm=lsfit(x=DATA$x,y=DATA$y) # similar to lm() but twice faster
     pVals[j]=ls.print(fm,print.it=FALSE)[[2]][[1]][2,4]
   }
   SCEN$rej_rate[i]= mean(pVals<.05)
 }

 library(ggplot2)
 SCEN$SNR=factor(SCEN$SNR)
 p=ggplot(SCEN,aes(x=n,y=rej_rate,group=SNR))+
     geom_point(aes(color=SNR))+
     geom_line(aes(color=SNR))+
     ylim(c(0,1))+
     geom_hline(yintercept=.05)

 plot(p)
```

### INCLASS 16

<div id="INCLASS_16" />

```r
 DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/goutData.txt',
                    header=TRUE)
 DATA$y=ifelse(DATA$gout=="Y",1,0)
 fm0=glm(y~su,data=DATA,family='binomial')
 summary(fm) 

 su.grid=seq(from=4,to=20,by=.1)
 phat0=predict(fm0,type='response',newdata=data.frame(su=su.grid))
 plot(phat0~su.grid,xlab='Serum urate',ylab='P(Gout)',type='l',ylim=c(0,1),col=2,lwd=2)

 nRep=3000
 PHAT=matrix(nrow=length(su.grid),ncol=nRep,NA)
 n=nrow(DATA)
 for(i in 1:nRep){

   tmp=sample(1:n,size=n,replace=TRUE)
   DATA.B=DATA[tmp,]
   fm=glm(y~su,data=DATA.B,family='binomial')
   phat=predict(fm,type='response',newdata=data.frame(su=su.grid))
   PHAT[,i]=phat
   lines(x=su.grid,y=phat,col=4,lwd=.05)
 }

 LB=apply(X=PHAT,FUN=quantile,MARGIN=1,prob=.05)
 UB=apply(X=PHAT,FUN=quantile,MARGIN=1,prob=.95)

 lines(x=su.grid,y=LB,col=2,lty=2,lwd=2)

 lines(x=su.grid,y=UB,col=2,lty=2,lwd=2)
 
 lines(x=su.grid,y=phat0,col=2,lty=1,lwd=2)
 
 
## Another way to get SE
 yHat=predict.glm(fm0,type='link',newdata=data.frame(su=su.grid),se.fit=TRUE)
 LB.link=yHat$fit-1.96*yHat$se.fit
 UB.link=yHat$fit+1.96*yHat$se.fit

 LB.prob=exp(LB.link)/(1+exp(LB.link))
 UB.prob=exp(UB.link)/(1+exp(UB.link))
 lines(x=su.grid,y=LB.prob,col='green')
 lines(x=su.grid,y=UB.prob,col='green')
```


### INCLASS 17

<div id="INCLASS_16" />
	
**Simulated data**

```r
 set.seed(1950)
 X=matrix(nrow=1000,ncol=3,rbinom(size=2,n=3000,prob=0.2))
 b=c(1,0,1)
 signal=scale(X%*%b)*sqrt(0.1)
 error=rnorm(nrow(X),sd=sqrt(0.8))
 y=signal+error
 fm=lm(y~X)
```
**Permutation analysis**

Because we want to control the probability (under the null b1=0, b2=0, b3=0) of making at least one mistake, in each permutation we extract the three p-values and store the smallest. If we use tha pvalue as our threshold we will be making one mistake (rejecting one of the nulls). Then we compute our threshold as the .05 quantile of the stored permutation pvalues.


```r
 permPval=rep(NA,10000)

 n=length(y)
 for(i in 1:10000){
  tmp=sample(1:n,size=n,replace=FALSE)
  permY=y[tmp]
  fm=lm(permY~X)

  pvalues=summary(fm)$coef[2:4,4]
  permPval[i]=min(pvalues)
 }
 threshold= quantile(permPval,prob=.05)

```

Note that the threshold is very similar to the Bonferroni corrected threshold (0.05/3), this happens because in this case the columns of X, and therefore the tests, are independent.

### INCLASS 19

<div id="INCLASS_19" />

```r

## Reading the data
 DATA=read.table('https://hastie.su.domains/ElemStatLearn/datasets/prostate.data',header=TRUE)
 train=DATA[,'train']
 DATA=DATA[,-ncol(DATA)]


## Partition into training and testing
 DATA.TRN=DATA[train,]
 DATA.TST=DATA[!train,]
 dim(DATA.TRN)


## OLS Regression
 fmOLS_FULL=lm(lpsa~.,data=DATA.TRN)


## Forward regression
 fm0=lm(lpsa~1,data=DATA.TRN)
 fullModel='lpsa ~ lcavol+lweight+age+lbph+svi+lcp+gleason+pgg45'
 fwd=step(fm0,scope=fullModel,direction='forward',data=DATA.TRN)
 
 
## Lasso
 library(glmnet)
 Z=as.matrix(DATA.TRN[,-ncol(DATA.TRN)]) # removing lpsa from the incidence matrix
 fmL=glmnet(y=DATA.TRN$lpsa,x=Z)


## Prediction accuracy in Testing data

 COR.OLS_FULL=cor(DATA.TST$lpsa,predict(fmOLS_FULL,newdata=DATA.TST))
 
 COR.FWD=cor(DATA.TST$lpsa,predict(fwd,newdata=DATA.TST))
 
 COR.LASSO=rep(NA,ncol(fmL$beta))
 Z.TST=as.matrix(DATA.TST[,-ncol(DATA.TST)])
 for(i in 1:ncol(fmL$beta)){
 	COR.LASSO[i]=cor(DATA.TST$lpsa,Z.TST%*%fmL$beta[,i])
 }
 
 plot(COR.LASSO,type='o',ylim=range(c(COR.LASSO,COR.OLS_FULL,COR.FWD),na.rm=TRUE)*c(.98,1.02))
 abline(h=COR.OLS_FULL,col='blue',lty=2,lwd=1.5);text(label='OLS-FULL',col='blue',x=20,y=COR.OLS_FULL+.002)
 abline(h=COR.FWD,col='red',lty=2,lwd=1.5);text(label='Forward',col='red',x=60,y=COR.FWD+.002)

 abline(v=which(diff(fmL$df)>0),col='grey',lty=2)## Reading the data
 DATA=read.table('https://hastie.su.domains/ElemStatLearn/datasets/prostate.data',header=TRUE)
 train=DATA[,'train']
 DATA=DATA[,-ncol(DATA)]


## Partition into training and testing
 DATA.TRN=DATA[train,]
 DATA.TST=DATA[!train,]
 dim(DATA.TRN)


## OLS Regression
 fmOLS_FULL=lm(lpsa~.,data=DATA.TRN)


## Forward regression
 fm0=lm(lpsa~1,data=DATA.TRN)
 fullModel='lpsa ~ lcavol+lweight+age+lbph+svi+lcp+gleason+pgg45'
 fwd=step(fm0,scope=fullModel,direction='forward',data=DATA.TRN)
 
 
## Lasso
 library(glmnet)
 Z=as.matrix(DATA.TRN[,-ncol(DATA.TRN)]) # removing lpsa from the incidence matrix
 fmL=glmnet(y=DATA.TRN$lpsa,x=Z)


## Prediction accuracy in Testing data

 COR.OLS_FULL=cor(DATA.TST$lpsa,predict(fmOLS_FULL,newdata=DATA.TST))
 
 COR.FWD=cor(DATA.TST$lpsa,predict(fwd,newdata=DATA.TST))
 
 COR.LASSO=rep(NA,ncol(fmL$beta))
 Z.TST=as.matrix(DATA.TST[,-ncol(DATA.TST)])
 for(i in 1:ncol(fmL$beta)){
 	COR.LASSO[i]=cor(DATA.TST$lpsa,Z.TST%*%fmL$beta[,i])
 }
 
 plot(COR.LASSO,type='o',ylim=range(c(COR.LASSO,COR.OLS_FULL,COR.FWD),na.rm=TRUE)*c(.98,1.02))
 abline(h=COR.OLS_FULL,col='blue',lty=2,lwd=1.5);text(label='OLS-FULL',col='blue',x=20,y=COR.OLS_FULL+.002)
 abline(h=COR.FWD,col='red',lty=2,lwd=1.5);text(label='Forward',col='red',x=60,y=COR.FWD+.002)

 abline(v=which(diff(fmL$df)>0),col='grey',lty=2)
 tmp=which.max(COR.LASSO)
 which(fm$beta[,tmp]!=0)
 
 coef(fwd)[-1]

```
