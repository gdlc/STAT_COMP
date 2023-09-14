
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
