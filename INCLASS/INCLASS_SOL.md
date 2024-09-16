
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

<div id="INCLASS_4" />


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

<div id="INCLASS_5" />

### INCLASS 6

[back to list](#MENUE)

<div id="INCLASS_6" />

### INCLASS 7

[back to list](#MENUE)

<div id="INCLASS_7" />

### INCLASS 8

[back to list](#MENUE)

<div id="INCLASS_8" />

### INCLASS 9

[back to list](#MENUE)

<div id="INCLASS_9" />

### INCLASS 10

[back to list](#MENUE)

<div id="INCLASS_10" />

### INCLASS 11

[back to list](#MENUE)

<div id="INCLASS_11" />

### INCLASS 12

[back to list](#MENUE)

<div id="INCLASS_12" />

### INCLASS 13

[back to list](#MENUE)

<div id="INCLASS_13" />

### INCLASS 14

[back to list](#MENUE)

<div id="INCLASS_14" />

### INCLASS 15

[back to list](#MENUE)

<div id="INCLASS_15" />

### INCLASS 16

[back to list](#MENUE)

<div id="INCLASS_16" />

### INCLASS 17

[back to list](#MENUE)

<div id="INCLASS_17" />

### INCLASS 18

[back to list](#MENUE)

<div id="INCLASS_18" />

### INCLASS 19

[back to list](#MENUE)

<div id="INCLASS_19" />

### INCLASS 20

[back to list](#MENUE)

<div id="INCLASS_20" />


