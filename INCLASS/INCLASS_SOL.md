
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
