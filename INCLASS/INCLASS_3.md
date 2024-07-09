
**1)** For loop

For this question, **store your answers in 4-dimensional vector named Q1.1, Q1.2, and Q1.3**.

Write three loops using the iterators described below. 

For each loop, inside the loop, print the variable used for iteration and store the output of `print()` function in the corresponding  entry of the vector.

  - **Q1.1**: `(x in 1:4)`
  - **Q1.2**: `(i in c('a','b','d','c'))`
  - **Q1.3**: `(z in c(TRUE,FALSE,TRUE,TRUE))`
  

**2)** Nested loops

Write code with a loop nested within another loop. For the first iterator use `(i in 1:5)`, for the inner loop use `(j in c('a','b'))`, inside the inner loop, print `i` and `j`, e.g., `print(paste(i,j))`. 

Store the outputs of in a two-level **list named Q2**, the first level of the list correspond to the otuer loop, and the inner level is used for the inner loops. Store in each entry the output of `print(paste(i,j))`.


**3)** While loop

   - Initialize a counter (e.g., `i=0` )
   - Write a while loop, for condition use `i<=5`,
   - Inside the loop write `i=i+1`

 What is the value of i after the while loop finishes? Store this value in a variable named **Q3**.
 
 **4)**  Recoding: 3-strategies
 
 The goal is to recode the `lgleason` score variable into three levels, `<=6`, `7`, and `>=8`. We will consider three strategies: 
   - `for` loop with `if(){}` statment inside
   - `ifelse` this function takes three arguments, a boolean, a vector for the TRUE entries and a vector for the FALSE entries, e.g., `ifelse(c(1,2,3)<=2, "A","B")`) 
      Hint: consider nesting an `ifelse` statmente within another `ifelse`.
   - `cut`, try `help(cut)`.

Store the recoded variables in vectors named **Q4.1**, **Q4.2**, and **Q4.3.** 
 
 
  **5)** Functions 
  
  - Create a function to  recode **one value** of the gleason score according to the thresholds described above:
  - Use it to recode `DATA$gleason[1]`
  - Apply it now to the entire vector of gleason scores (`DATA$gleason`). What do you infer as to the behavior of functions when applied to vectors?

Store the recoeded vbariable in a **vector named Q5**.


 
