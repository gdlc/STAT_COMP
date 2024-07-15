
**1)** For loop

Create three vectors (`Q1.1`, `Q1.2`, and `Q1.3` each of length 4).

Then, write these three loops

`for(x in 1:4){ print(x)  }`
`for(x in c('a','b','d','c')){  print(x) }`
`for(x in    c(TRUE,FALSE,TRUE,TRUE)){ print(x)}`


**2)** Nested loops

Write code with a loop nested within another loop. For the first iterator use `(i in 1:5)`, for the inner loop use `(j in c('a','b'))`, inside the inner loop, print `i` and `j`, e.g., `print(paste(i,j))`. 


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

In addition, Write three functions for the above named **Q4.1_fun**, **Q4.2_fun**, and **Q4.3_fun**. The arguments are the three cutoff values (e.g., 6, 7, 8 in the above).  In each function
   - Follow the above requirement to recode the `lgleason` score variable into three levels using the three strategies respectively.
   - If may always assume that each category contains at least one sample.
 
 
  **5)** Functions 
  
  - Create a function to  recode **one value** of the gleason score according to the thresholds described above:
  - Use it to recode `DATA$gleason[1]`
  - Apply it now to the entire vector of gleason scores (`DATA$gleason`). What do you infer as to the behavior of functions when applied to vectors?

Store the recoeded vbariable in a **vector named Q5**.


 
