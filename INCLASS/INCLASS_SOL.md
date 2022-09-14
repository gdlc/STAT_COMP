
 <div id="MENUE" />
  
  - [INCLASS 1](#INCLASS_1) ; [INCLASS 2](#INCLASS_2); [INCLASS 3](#INCLASS_3); [INCLASS 4](#INCLASS_4); [INCLASS 5](#INCLASS_5)
  - [INCLASS 6](#INCLASS_6) ; [INCLASS 7](#INCLASS_7); [INCLASS 8](#INCLASS_8); [INCLASS 9](#INCLASS_9); [INCLASS 10](#INCLASS_10)
  - [INCLASS 11](#INCLASS_11) ; [INCLASS 12](#INCLASS_12); [INCLASS 13](#INCLASS_13); [INCLASS 14](#INCLASS_14); [INCLASS 15](#INCLASS_15);
  - [INCLASS 16](#INCLASS_16); [INCLASS 17](#INCLASS_17); [INCLASS 18](#INCLASS_18); [INCLASS 19](#INCLASS_19); [INCLASS 20](#INCLASS_20)



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
 for(i in (1:9)[-5]){
   print(summary(DATA[,i]))
 }
 
 table(DATA[,5])

```

**Using apply**

```r
  apply(FUN=summary,X=DATA,MARGIN=2)
```

**Histograms**

```r
  par(mfrow=c(3,3)) # creates a 3x3 gri
  
  # fills the grid with plots
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
dev.off()
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



