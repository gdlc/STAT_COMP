# A Quick introduction to R

Contributors: Gustavo de los Campos, Grace Hong, Marco Lopez-Cruz and Andriana Manousidaki

<div id="Outline" />

## Outline
  * [Installation](#installation)
  * [Good syntax practices](#Good_syntax_practices)
  * [Types](#types) 
  * [Basic operations with numbers](#basic-operations) 
  * [Vectors](#vectors) 
  * [Matrices](#matrices)
  * [Lists](#lists)
  * [Data frames](#data.frames) 
  * [Reading/writing files](#read-write) 
  * [Descriptive statistics](#descriptives)
  * [Plots](#plots) 
  * [Conditional statements](#conditionals)
  * [Loops](#loops) 
  * [Functions](#functions) 
  * [Libraries](#libraries) 
  * [Distributions](#distributions)
    
-------------------------------------------------------------------------------------------


<div id="installation" />

### Installation

You can install R and R-libraries and also have access to many materials and manuals at the [R-website](https://www.r-project.org/). 

To install R, follow the instructions under **Getting Started**. Once R is installed, you should have the R-icon on your programs. Click on the icon to open the R-console.

[Back to Outline](#Outline)

-------------------------------------------------------------------------------------------


<div id="Good syntax practices" />

### Good syntax practices

The tidyverse package has provided a guide for R syntax that can be found [here](https://style.tidyverse.org/syntax.html#syntax).
In this course we will try to create code that is easy to ready and understand. The above guide can assist you to that.
Of course as with every skill, it takes time and practice to learn how to write easy-to-read scripts.

We recomend to start by taking a look at the [spacing](https://style.tidyverse.org/syntax.html#spacing) section and as we move forward we will make further suggestions.

![Rstudio](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/rstudio2.png)
It is also important to not write further than the vertical line found in the source code editor of Rstudio.

Use comments to record the project name, date and author and to provide key phrases that make your code easier to be understand. 
If you find your self having more comments than code, then you have actually written a report and it is recommended to use [Rmarkdown](https://rmarkdown.rstudio.com/lesson-1.html) for that.

In our third lecture we will dive into Rmarkdown and it will be our default way of submitting assignments.

But let's first start with variable types that can be use in R!

[Back to Outline](#Outline)

-------------------------------------------------------------------------------------------
<div id="types" />

### Types

R support several types of variables, the basic ones are: `logical` (`TRUE`/`FALSE`), `integer`, `numeric` (double-precision, this is use for real numbers), `character` (these are used to store text), and `factors` (these are reserved for variables that can take on a limited set of values, e.g., ethnicity). The following example illustrates the creation and basic operations with this types of variables.

```r
  # numeric
  x = 1.1
  str(x)
  class(x)
  
  # integer
  x = 1
  class(x) # by default a numeric type was created but we can coerce it to integer
  x = as.integer(x)
  class(x)
  
  # Alternatively, add "L" after the number and an integer will be created
  z = 1L
  class(z)
  
  # logical
  x = 1.1 >2 
  x
  class(x)
  !x  # exclamation sign returns the negative of the logical value
  isTRUE(x)
  isTRUE(!x)
  
  # character
  x = 'hello' # you can use either single or double quates to create a character
  class(x)
  print(x)
  show(x)
  x = "hello"
  
```

[Back to Outline](#Outline)

<div id="basic-operations" />

### Basic Operations with `numeric` and `integer`

```r
 x = 2
 x + 10
 x - 10
 x*4
 x^2
 sqrt(x)
 log(x) # natural log
 log(100, base=10)
```
[Back to Outline](#Outline)

<div id="vectors" />

### Vectors

The following code shows how to create vectors, subset (i.e., extract single or multiple elements) and modify (repleacement) them.

```r
  x = c(1, 10, 15, 100)
  x[3] # extracting one element
  x[3] = 99 # replacing one element
  x[-3] # `-` can be used to extract all but some entries
  
  # Sequence
  x = 1:10 # creates a sequence from 1:10
  x
  x[3] = 1000
  x
  
  # Indexing and replacement can also be done with TRUE/FALSE
  x = 1:4
  x[c(TRUE, FALSE, FALSE, FALSE)]
  
  # or with names
  names(x) # for now it has no names, but we can add names
  names(x) = c('a', 'b', 'c', 'd')
  x['a'] # subsetting
  x['b'] = -10 # replacement
  x[c('a', 'b')] # can also use vectors for indexing
 
  # Vectors can be of any type
  x = c("a", "b", "hello")
  x
  
  # Factors: a type that we can use for nominal variables that take on a finite number of levels
  x = c('treatment 1', 'control', 'treatment 2', 'treatment 1', 'control')
  class(x)
  x = as.factor(x)
  class(x)
  
  # you can also create it as a factor from the beginning
  
  x = factor(x = c('treatment 1', 'control', 'treatment 2', 'treatment 1', 'control'))
  class(x)
  str(x)
  
  # Internally, each level has an integer associated to it, indeed
  
  levels(x)
  as.integer(x)
  
  # levels can have a user-specified order
  z = factor(x = c('treatment 1', 'control', 'treatment 2', 'treatment 1', 'control'),
              levels = c('treatment 1', 'control', 'treatment 2'))
  x
  z
  as.integer(x)
  as.integer(z)
  
  
```

[Back to Outline](#Outline)


<div id="matrices" />

### Matrices

A matrix is a two dimensional array that holds values of the same type (e.g., numeric, logical). The following code illustrates how to create, subset and modify a matrix. Matrix operations will be covered in the course.


```r
  x1 = 1:10
  x2 = 11:20
  x3 = 21:30
  
  X = cbind(x1, x2, x3) # Binds columns
  dim(X)
  nrow(X)
  ncol(X)
  X
  
  ## Subseting 
  X[1, ] # returns the first row
  X[, 2] # returns the second column
  X[1:2, 2:3] # returns the block defined by rows 1 and 2 and columns 2 and 3
  
  ## Replacement
  X[2, 3] = 1000
  X
  
  ## Try: Z=rbind(x1,x2,x3); dim(Z)

 
```

[Back to Outline](#Outline)

<div id="lists" />

### Lists

Lists are arrays that can hold elements of different types. The following example creates a list

```r
 CARS = list()
 CARS[[1]] = list(brand = 'Toyota', model = 'Corolla', year = 2012, engineSize = 1500)
 CARS[[2]] = list(brand = 'Dodge', model = 'Ram', year = 2010, engineSize = 3600)

 # Subsetting/replacement can be done with integer indexing, booleans, or names, but for list we must use two square braces [[
 
 CARS[[1]]$brand
 CARS[[1]][[1]]
 
 names(CARS)=c('first','second')
 
 CARS[['first']]$model
 
```


[Back to Outline](#Outline)



<div id="data.frames" />

### Data Frames

Vectors and matrices can store data of a single type (e.g., `numeric`, `integer`, `character`). In statistics often we need to use data tables that store variables of different types. For instance, we may want to store in a single data table: sex ("M"/"F" will be `character`, age and weight (both `numeric`). We can do this using data frames. Strictily speaking `data.frames` are `lists`; however, unlike the general list, `data.frames` are two dimensional arrays, pretty much like matrices, with the flexibility that they can store different types in the columns.

[Back to Outline](#Outline)

```r
   N = 100
   x1 = sample(c("F","M"),size=N,replace=T)
   x2 = runif(min=25,max=60,n=N) # samples 10 values from a uniform distribution with support on [25,60]
   DATA = data.frame(sex=x1,age=x2)
   DATA$height = ifelse(DATA$sex=="F",170,175)+rnorm(n=N,sd=sqrt(40)) # adding a new variable can be done this way
   
   head(DATA)    # prints the first rows of the data to the screen
   tail(DATA)    # prints the last rows of the data to the screen
   str(DATA)     # tells you the strcture (class, dimensions) of the object
   fix(DATA)     # shows the data frame in a spread-sheet-like fashion
   summary(DATA) # most objects in R have a summary method, note summaries depend upon the type.
   
   ## Indexing  
   DATA[, 1]
   DATA$sex  # you can index by variable name, same for replacement.
   
   DATA[1, 1]
   DATA$sex[1]
   
```

<div id="read-write" />

### Changing the working directory, creating folders, listing files

```r
 getwd() # returns the working directory
 setwd('~/Desktop') # changes the working directory
 getwd()

 dir.create('tmp') # creating a new folder
 setwd('tmp')
 
 list.files() # listing files in the current folder
 
```

### Writing/reading [ASCII](https://en.wikipedia.org/wiki/ASCII#Bit_width) files

These examples demonstrate the basic functions available in R for reading and writing "table-like data" in ASCII format.

**read.table and write.table**
```R
  # Writing
   write.table(DATA, file = 'DATA.txt') # writes the data to an ASCII file
   list.files(pattern = '.txt') # list the files in the current folder having *.txt in the name.
  
  # Reading
   DATA2 = read.table('DATA.txt', header = T) # you can add sep="," or sep"\t" for comma and tab-spearated files, respectively
   head(DATA)
   head(DATA2)
   
   # Removing files
   unlink('DATA.txt')
   getwd()
   list.files()
   
```

The function `read.csv` is similar to `read.table(...,sep=',')`, but specialized in comma separated files.

**write, scan, readLines**

Thes three functions are more basic and can be used to read/write files or specific lines of a file.

```R
 x=sample(1:1000,size=2500,replace=TRUE) # generating some integers
 
 write(x,ncol=1,file='x.txt')
 z=scan('x.txt',what=integer()) # use character() for characters.. quiet=TRUE for suppressing messaging
 
 # Now we write in 5 columns
 write(x,ncol=5,file='x_5col.txt')
 readLines('x_5col.txt',n=1)
 readLines('x_5col.txt',n=2)
 

```

**Reading from the web**

Most of the functions can read from the web...
The data sets used in the book The Elements of Statistical Learning (Hastie, Tibshirani, and Friedman) are available at the following [web-adress](https://hastie.su.domains/ElemStatLearn/data.html).

Here we download or we read directly ozone data for Los Angeles.
```R
#Download from the web

url_ozone = 'https://hastie.su.domains/ElemStatLearn/datasets/LAozone.data'
download.file(url_ozone,'ozone.data')
ozone = read.csv('ozone.data')

# Read from the web
ozone = read.csv(url(url_ozone), header = TRUE)
```
**Compressed files**

These functions can also read compressed files. The function `gzfile()` can be used to handle these types of connections and the object returned by `gzfile()` can be passed as an argument to the functions discussed above.


**Reading very large ASCII files**

The functions discussed above are enough for reading/writing reasonably large files. However, to read huge files, it is better to use `fread` from the `data.table`. This package offers great funcitonality to read and work with very large files. We illustrate this with a very large file.

```r
 library(data.table)
 setwd('/mnt/research/quantgen/projects/UKB/PIPELINE500/output/BED/whites/imputed/chromosomes/')
 DATA<-fread('chrom02.bim') # a file with 1 million rows, 6 columsn (it took ~.25 seconds to be read)

```

### R-objects Files

We can also save and recover R-objects of any type using save/load

```R
 save(DATA,file='DATA.RData')
 rm(DATA)
 ls()
 
 load('DATA.RData',verbose=TRUE) #note, load loads objects with their original name in the environment, unlike read.table, no assigment is needed.
 
 list.files()

```
Note: for writing/reading flat binary files, look at `readBin()` and `writeBin()`.


[Back to Outline](#Outline)

<div id="descriptives" />

### Descriptive Statistics

```R
   summary(DATA$age)
   table(DATA$sex)
   quantile(DATA$age,p=.08)
   isTall<-ifelse(DATA$height>median(DATA$height),">median","<median")
   table(DATA$sex,isTall)
```

<div id="plots" />

### Plots
```r
   barplot(table(DATA$sex))
   hist(DATA$age)
   boxplot(height~sex,data=DATA)
   plot(height~age,data=DATA)
   plot(density(DATA$height))
```
[Back to Outline](#Outline)


<div id="conditionals" />

### Conditional Statments
In programing conditional statements can be used to execute one type of code or another depending on a conditon.

```R
 x=1
 y=2
 
 if(x>y){
   print("X is greater than Y!")
 }
 
 ## IF-ELSE
 if(x>y){
   print("X is greater than Y!")
 }else{
   print("Y is greater than X!")
 }

 ## IF-ELSE
 x=3
 if(x>y){
   print("X is greater than Y!")
 }else{
   print("Y is greater than X!")
 }
 
 
 ## We can evaluate multiple conditions at a time by nesting if statments or by evaluating them jointly
 
 x=TRUE
 y=FALSE
 
 if(x){
  if(y){
    print("Both X and Y are TRUE!")
  }else{
    print("X is TRUE and Y is FALSE")
  }
 }else{
   if(y){
    print("X is FALSE and Y is TRUE")
   }else{
    print("Both X and Y are FALSE")
   }
 }

 ## Alternatively
 
 if(x&y){ print("Both X and Y are TRUE") }
 if(x&!y){ print("X is TRUE and Y is FALSE") }
 if((!x)&y){ print("X is FALSE and Y is TRUE") }
 if((!x)&(!y)){ print("Both X and Y are FALSE") }
 
```
[Back to Outline](#Outline)


<div id="loops" />

### Loops
 In many applications we need to repeat a task a fixed numer of times or until somthing happen. For this you can use the `for` and `while` loops.

```r
 for(i in 1:10){
   print(i)
 }
 
 ## We can iterate over any vector
 for(i in c("a","b","zzz")){
    print(i)
 }

 ## While loop
 x=0
 while(x<=10){
  x=x+1
  print(x)
 }

## For loops can sometimes be replaced by lapply and apply
# read prostate data and create a data frame that 
DATA2=read.csv('DATA.csv')
Data3 = DATA2[,1:9]
for (i in 1:9) {
Data3[,i] = DATA2[,i]/sum(DATA2[,i])
}

Data4 = apply(  DATA2[,1:9], MARGIN=2, function(x)  x/sum(x))

data_list = as.list(DATA2)

new_data_list = lapply(data_list, function(x)  x/sum(x))

#

```
[Back to Outline](#Outline)


<div id="functions" />

### Functions
A function takes on a numbrer of arguments, carries out some computations and (often) returns an object. The `sin`, `cos` , `log` and `summary` are examples of functions that return a value.

```R
   x=100
   sin(x)
   cos(x)
```

You can easily create your own functions. Remember, that in the least-squares (OLS=Ordinary Least Squares) estimate of a regression coefficient of simple linear regerssion equals the covariance between `x` and `y` divided by the variance of `x`. The following example returns OLS estimates of the intercept and regression coefficient in a simple linear regression.

```R
  myOLS=function(x,y){
    b=cov(x,y)/var(x)
    a=mean(y)-mean(x)*b
    return(c(a,b))
  }
  
  # simulating a simple data set
  pred=rnorm(100)
  response=100+.5*pred + rnorm(100)
  
  myOLS(x=pred,y=response)
  
```
[Back to Outline](#Outline)


<div id="libraries" />

### Libraries
The basic installation of R comes with several functions for computation, basic statistical analyses, descriptive statistics, etc. Specialized code is contributed by develpers under the form of libraries. To use a library you first need to install it and then load it into the environment.

```R
   install.packages(pkg='BGLR', repos='https://cran.r-project.org/') # installs BGLR package from the CRAN repository.
```

Now that the package is installed you can load it into your environment.

```R
  library(BGLR)
  
```

Let's also install and load [ggplot 2](https://ggplot2.tidyverse.org/), a very useful graphics package. Here is a [cheatsheet for ggplot2](https://github.com/rstudio/cheatsheets/blob/main/data-visualization.pdf)

```{r}
install.packages("ggplot2")
library("ggplot2")
```
[Back to Outline](#Outline)


<div id="distributions" />

### Distributions

The package **stats** (included with the R-installation) contains functions to:
  - **d\*()**: Evaluate density functions (or probabilities in the case of discrete random variables),
  - **p\*()**: Evaluate the cumulative distribution function (CDF) of a random variable (`P(X<=q)`),
  - **q\*()**: Evaluate the quantile function of a random variable (i.e., the inverse of the CDF)
  - **r\*()**: Generate random draws from a given distribution.
  
 The distributions considered in the stats package can be found [here](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/Distributions.html) along with their documentation.

**Density Function**. Functions with prefix `d` evaluates= the density function (p.d.f) for continuos random variables, *f(x)*, and the probability mass function (p.m.f) for discrete random, variables, *f(x)=P(X=x)*.


*Example 1*: Binomial. 

Let X=Z1+Z2+Z3, where Zi are IID bernoulli RVs, each with success probability 0.2. It follows that X follows a Binomial distribution with size=3 (# of bernoulli trials), each with prob=0.2 

What is the probability that X=1?

```r
  dbinom(prob=0.2,size=3,x=1)
```

*Example 2*: Normal

Let X be a normally distributed random variable with mean 42.5 and variance 25. 

What is the value of the density function at x=13?


```r
  dnorm(q=13, mean=42.5,sd=sqrt(25))
```

**Cumulative distribution**. Functions with *p* evaluates the cumulative distribution function (c.d.f.) for the random variable `X`, that is: `F(x) = P(X <= x)`. 

*Example 3*. From the Binomial RV in Example 1, what is the probability that X<=1?

```r
  pbinom(q=2,size=3,prob=0.2) # 

```

Of course, we can obtain the sam result using

```r
 dbinom(size=3,x=0,prob=0.2)+dbinom(size=3,x=1,prob=0.2)+dbinom(size=3,x=1,prob=0.2)
```

Or using 1-P(X>2).

```r
 1-pbinom(q=3,lower.tail=FALSE) #
```

# For our Normal distribution example, what is P(BMI>=35)?
 pnorm(q=35,sd=5,mean=27.5,lower.tail=FALSE)

 # Standardizing
 z <- (35-27.5)/5
 pnorm(z,lower.tail=FALSE) # by default pnorm() uses mean=0,sd=1 
```

**Quantile**. Prefix *q*

For continuous distributions, it evaluates the inverse c.d.f. of the distribution, *x = F<sup>-1</sup>(p)* where *p = F(x)*.

```r
# Example 1: In testing Ho in certain experiment, we get a F-statistic=6.02 that has an F-distribution with 
# Numerator DF=3 and Denominator DF=20 
#  - Calculate the p-value (i.e., the probability of obtaining an F-statistic as large or larger than the one observed if the null holds)
 pf(q=6.02,df1=3,df2=20,lower.tail=FALSE) # p-value is smaller than 0.05, we would reject the null at alpha=0.05

# reject?
qf(p=0.05,lower.tail=FALSE,df1=3,df2=20)<6.02

# Example 2: Height was measured for n=50 randomly sampled students from a population with uknown mean and unknown variance. 
# The sample mean=165.4 and sample sd=8.3. 
# Test Null hyphotesis Ho: Mean=163. Ha: mean>163.
# Decision rule: reject Ho at a level 0.05 if tStat > qt(p=0.05,lower.tail=FALSE,df=49)
 tStat=(165.4-163)/(8.3/sqrt(50)) # t-statistics
 qt(p=0.05,lower.tail=FALSE,df=49) # 1.67 is smaller than tStat=2.04 thus Ho is rejected.
```

Note: for discrete distributions, which have a step c.d.f an thus are not invertible, the quantile funciton is defined as the smallest value *x* such that *F(x)>=p*, where *F* is the CDF.


```r
# The probabilities P(X=0), P(X=1),...
dbinom(x=0:3,size=3,prob=0.2)
 
# The CDF in the case of discrete RVs is just the cumulative sum of the probability funciton
 cumsum(dbinom(x=0:3,size=3,prob=0.2)) # the CDF!
 pbinom(q=0:3,size=3,prob=0.2)
# The quantile function
qbinom(p=0.7,size=3,prob=0.2)
```

**Generating random variables**. Prefix *r*

Simulates IID random draws from a particular distribution.

```r
x1 <- rnorm(n=10000,mean=10,sd=2.2)   # draw 10,000 samples from a normal distribution with mean=10 and sd=2.2
x2 <- rnorm(n=10000,mean=11.5,sd=3.5)   # draw 10,000 samples from a normal distribution with mean=11.5 and sd=3.5
plot(density(x1),ylab="Density",col="red",xlim=range(c(x1,x2)))
lines(density(x2),col="blue")
legend("topright",legend=c("mean=10, sd=2.2","mean=11.5, sd=3.5"),col=c("red","blue"),pch=20)
```

Random draws are not acutally *random*, the computer can only generate deterministic sequences that appear as random. 

The simulation can be controlled using the `set.seed()` function. Try this example

```r
 rnorm(3)
 rnorm(3)
 
 rnorm(3)
 rnorm(3)
 
 set.seed(195021)
 rnorm(3)
 rnorm(3)

 set.seed(195021)
 rnorm(3)
 rnorm(3)
 

```

[Back to Outline](#Outline)
