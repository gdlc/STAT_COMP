### Due Sept. 3rd, 4:20pm in D2L

Provide an script and the output for the following problems

**1)** Create within the R-environment these two vectors

       x=[1L,2L,3L]

and

        y=[1,2,3]
   
 What are the types of x and y?
 
 
 **2)** Multiply x and y, what are the dimensions and type of the resulting vector?
 
 **3)** Add names to x ['x1','x2','x3'], and, using indexing by name, replace the second entry of x with the value 1.1. What is the type of x after the replacement?
 
 
 **4)** Create a matrix (W) using `cbind(x,y)`. What is the class of W?
       
 **5)** Apply the log() function to the W matrix created in (4)
 
 What do yo conclude about the behavior of functions that take scalar arguments when we apply them to arrays?
       
 **5)** Pick your two favorite cars and for each define the brand, model, year, and engine size. Replace the 2nd entry of the list CARS with your first pick, and add a third entry to the list with your 2nd pick.


## A possible answer to the assigment

**1)**
```r
  x<-c(1L,2L,3L)
  y<-c(1,2,3)
  str(x)
  str(y)
  class(x)
  class(y)
```

**2)**

```r
  length(x*y)
  class(x*y)
```


**3)**

```r
  names(x)=c('c','a','b')
  class(x)
  x['a']=1.1
  class(x)
```

**4)**
Before I complet #4, I'll go back to x being a vector of integers
```r
  x=1:3
  class(x)
  class(y)
  
  W=cbind(x,y)
  str(W) # everything was promoted to numeric
```


**5)**

```r
  LOGW<-log(W)  # the function is applied cell-by-cell, the resulting objects has the same dimensions as W
  dim(W)
  dim(LOGW)
  
```


**6)**

This is the original example discussed in class

```R
 CARS=list()
 CARS[[1]]=list(brand='Toyota',model='Corolla',year=2012,engineSize=1500)
 CARS[[2]]=list(brand='Dodge',model='Ram',year=2010,engineSize=3600)

```

Now, I pick Maserati MC20 and add it to the list

```R
 length(CARS)
 CARS[[3]]=list(brand='Maserati',model='MC20', year=2020,engineSize=3.0)
 length(CARS)
 
 ## let's remove it and addit now with a name
 
 CARS=CARS[-3]
 length(CARS)
 CARS[['maseratimc20']]=list(brand='Maserati',model='MC20', year=2020,engineSize=3.0)
 
 length(CARS)
 names(CARS)
```
