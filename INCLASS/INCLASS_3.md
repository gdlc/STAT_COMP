
**1)** For loop

Run these three loops

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
| C | CCCC    | 

Your function should be named `recode(x,old_levels,new_levels)`, take as inputs the variable (`x`) as well as the old and new levels, and should return the recoded values.

To test it, use the following example

```r
 x=sample(c('A','B','C'),size=100,replace=TRUE)
 z=recode(x,c('A','B','C'),c('AAA','BB','CCCC'))
 table(x,z)

```


 ## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. If you have multiple files to submit, at least one of them is named as `assignment.R`.  You may submit your answer to Gradescope as many times as needed.

  - Store in vectors named Q1.1, Q1.2, and Q1.3, the values of the `print` statments of each of the loops. 
  - Store in a variable named Q3 the value of `i` after the while loop finished
  - Include in your script the `recode()` function, we will test it with an arbitrary example.
