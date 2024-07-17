
**1)** For loop

Ran these three loops

`for(x in 1:4){ print(x)  }`
`for(x in c('a','b','d','c')){  print(x) }`
`for(x in    c(TRUE,FALSE,TRUE,TRUE)){ print(x)}`


**2)** Nested loops

Write code with a loop nested within another loop. For the first iterator use `(i in 1:5)`, for the inner loop use `(j in c('a','b'))`, inside the inner loop, print `i` and `j`, e.g., `print(paste(i,j))`. 


**3)** While loop

   - Initialize a counter (e.g., `i=0` )
   - Write a while loop, for condition use `i<=5`,
   - Inside the loop write `i=i+1`

 What is the value of i after the while loop finishes? 
 
 
**4)** Functions 
  
Create a function to recode a character variable from some levels to other levels. For example, suppose we have a variable `x` that take values `a`, `b`, or `c` and we want to recode according to the following keys
| Level      | Recode value       | 
| ------------- |-------------| 
|A     | AAA | 
| B     | BB    | 
| C | CCC    | 



  - Use it to recode one value `recode(DATA$gleason[1],thresholds=c(6,7,8)`
  - Apply it now to the entire vector of gleason scores (`DATA$gleason`). What do you infer as to the behavior of functions when applied to vectors?


 ## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answeromg the questions shown below If you have multiple files to submit, at least one of them is named as `assignment.R`. You may submit your answer to Gradescope as many times as needed.

  - Store in vectors named `Q3.mean` and `Q3.median` the mean and median of each of the variables listed above. Name the vector with the variable name.
  - Store in  a vector named `COR` the correlation of each variable with `lpsa`, name the vector with the variable name. Your vector should have a length of 8, each entry corresponding to the correlation between one predictor and `lpsa`.
  - Store in a variable named `top_predictor` the variable name of the top predictor of lpsa.

