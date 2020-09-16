### Due Sept. 16th, 1:00pm in D2L


**1)** For loop

Write three loops, using the iterators described below. For each loop, inside the loop, print the variable used for iteration.

  - `(x in 1:5)`
  - `(i in c('a','b','d','c'))`
  - `(z in c(TRUE,FALSE,TRUE,TRUE))`
  
 ```r
  for(x in 1:5){
    print(x)
  }
  
  for((i in c('a','b','d','c')){
    print(i)
  }
  
  for(z in c(TRUE,FALSE,TRUE,TRUE)){ 
     print(z)
  }
 ```
**2)** Nested loops

Write code with a loop nested within another loop. For the first iterator use `(i in 1:5)`, for the inner loop use `(j in c('a','b'))`, inside the inner loop, print `i` and `j`, e.g., `print(paste(i,j))`.

```r
 for(i in 1:5){
   for(j in c('a','b')){
      message(i,j) # or use print(paste(i,j))
   }
 }

```

**4)** While loop

   - Initialize a counter (e.g., `i=0` )
   - Write a while loop, for condition use `i<=5`,
   - Inside the loop write `i=i+1`

```r
 i=0
 while(i <=5){
  i=i+1
  message(i)
 }
 print(i)
```
 What is the value of i after the while loop finishes?
 
 **5)**  Recoding: 3-strategies
 
 The goal is to recode the `lgleason` score variable into three levels, `<=6`, `7`, and `>=8`. We will consider three strategies: 
   - `for` loop with `if(){}` statment inside
   - `ifelse` this function takes three arguments, a boolean, a vector for the TRUE entries and a vector for the FALSE entries, e.g., `ifelse(c(1,2,3)<=2, "A","B")`) 
      Hint: consider nesting an `ifelse` statmente within another `ifelse`.
   - `cut`, try `help(cut)`.
 
 ```r
   DATA=read.table('https://web.stanford.edu/~hastie/ElemStatLearn/datasets/prostate.data') 
   dim(DATA)
   head(DATA)
   str(DATA)
 
   # 1) loop with if(){}else{} statments
   x=rep(NA,nrow(DATA))
   for(i in 1:nrow(DATA)){
    tmp<-DATA$gleason[i]
    if(tmp<=6){ 
      x[i]<-"<=6"
    }else{
      if(tmp==7){
        x[i]='7'
      }else{
        x[i]='>=8'
      }
    }
   }
   
   # 2) Using ifelse(,,) # note vectorized behavior of this function
   z=ifelse(DATA$gleason<=6,"<=6",ifelse(DATA$gleason==7,"7",">=8"))
   table(x,z)
   
   ## cut(), is not a good choice in this, case,....
   w=cut(DATA$gleason,breaks=c(-1,6.9,7.9,100))
   table(w,z)
   
 ```
  **6)** Functions 
  
  - Create a function to  recode **one value** of the gleason score according to the thresholds described above:
  - Use it to recode `DATA$gleason[1]`
  - Apply it now to the entire vector of gleason scores (`DATA$gleason`). What do you infer as to the behavior of functions when applied to vectors?
  
  
  ```{r}
    recode=function(x){
       if(x<=6){ ans<-'<=6'}
       if(x==7){  ans<-'=7'}
       if(x>=8){  ans<-'>=8' } 
       return(ans)
    }
    
    recode(4)
    
    recode(7)
    
    recode(8)
    
    recode(c(7,8))
    
    # some functions (e.g., rnorm(), ifelse() can be vectorized (i.e., when arguments are arrays, the function is applied to each element)
    # in other cases (such as the example above) we do not get the desired behavior, for this we can use the functions of the `apply` family
    
    sapply(FUN=recode,X=c(7,8)) # this funciton applies the function passed through FUN, to each element of the argument passed through X

    ## Discuss briefly: sapply(X=,FUN=), lapply(X=,FUN=), tapply(FUN=,X=,INDEX=), apply(MARGIN=)
    
  ```
  
