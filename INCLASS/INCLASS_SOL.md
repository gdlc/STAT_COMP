
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


