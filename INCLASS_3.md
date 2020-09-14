### Due Sept. 14th, 4:20pm in D2L


**1)** For loop

Write three loops, using the iterators described below. For each loop, inside the loop, print the variable used for iteration.

  - `(x in 1:5)`
  - `(i in c('a','b','d','c'))`
  - `(z in c(TRUE,FALSE,TRUE,TRUE))`
  
  
**2)** Nested loops

Write code with a loop nested within another loop. For the first iterator use `(i in 1:5)`, for the inner loop use `(j in c('a','b'))`, inside the inner loop, print `i` and `j`, e.g., `print(paste(i,j))`.

**4)** While loop

   - Initialize a counter (e.g., `i=0` )
   - Write a while loop, for condition use `i<=5`,
   - Inside the loop write `i=i+1`
   
 What is the value of i after the while loop finishes?
 
 **4)**  Recoding: 3-strategies
 
 The goal is to recode the `lgleason` score variable into three levels, `<=6`, `7`, and `>=8`. We will consider three strategies: 
   - `for` loop with `if(){}` statment inside
   - `ifelse` this function takes three arguments, a boolean, a vector for the TRUE entries and a vector for the FALSE entries, e.g., `ifelse(c(1,2,3)<=2, "A","B")`) 
      Hint: consider nesting an `ifelse` statmente within another `ifelse`.
    - `cut`, try `help(cut)`.
  
  **5)** Functions 
  
  - Create a function that will recode **one value** of the gleason score according to the thresholds described above:
  - Use it to recode `DATA$gleason[1]`
  - Apply it now to the entire vector of gleason scores (`DATA$gleason`). What do you infer as to the behavior of functions when applied to vectors?
  
  
