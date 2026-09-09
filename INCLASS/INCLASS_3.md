

## 1) For (not graded in Gradescope)

Run these three loops and observe the behavior (do not include this code in `assigment.R`)

```r
for(x in 1:4){
  print(x)
}
```

```r
 for(x in c('a','b','d','c')){
     print(x)
}
```

```r
 for(x in c(TRUE,FALSE,TRUE,TRUE)){
    print(x)
 }
```

## 2) Nested loops

Write code with a loop nested within another loop. For the first iterator use `(i in 1:5)`, for the inner loop use `(j in c('a','b'))`, inside the inner loop print `paste0(i,'-',j)`. 

***Gradescope**:

   - Initialize a variable named `Q2=character()`
   - Inside the loop write `Q2=c(Q2, paste0(i,'-',j))`, this code will append in each cyle the values `i-j` to the vector Q2.

## 3) While loop

   - Initialize a counter (e.g., `i=0` )
   - Write a while loop, for condition use `i<=5`,
   - Inside the loop write `i=i+1`

 What is the value of `i` after the while loop finishes? 

***Gradescope***: Include after your while loop this line `Q3=i`.
 
## 4) Functions 
  
Create a function to re-code a character variable from some levels to other levels. For example, suppose we have a variable `x` that take values `a`, `b`, or `c` and we want to r-ecode according to the following keys
| Level      | Re-code value       | 
| ------------- |-------------| 
|A     | AAA | 
| B     | BB    | 
| C | CCCC    | 

Your function should be named `recode2(x,old_levels,new_levels)`, take as inputs the variable (`x`) as well as the old and new levels, and should return the re-coded values. 

To test it, use the following example

```r
 x=sample(c('A','B','C'),size=100,replace=TRUE)
 z=recode2(x,c('A','B','C'),c('AAA','BB','CCCC'))
 table(x,z)

```
***Gradescope***: Include in your script the `recode2()` function, we will test it with an arbitrary example.

 ## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. If you have multiple files to submit, at least one of them is named as `assignment.R`.  You may submit your answer to Gradescope as many times as needed.

Your script should produce the variables `Q2`,`Q3`, and the function `recode2()` as described above.
