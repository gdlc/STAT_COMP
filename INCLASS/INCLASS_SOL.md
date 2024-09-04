
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


[back to list](#MENUE)

<div id="INCLASS_Rmarkdown_practice" />

### INCLASS 4

[back to list](#MENUE)

<div id="INCLASS_4" />


### INCLASS 5

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


