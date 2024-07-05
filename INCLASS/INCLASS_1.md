**In-class assignment 1 - due on Tuesday 29th at 11:59pm on D2L**

Provide an script and the output for the following problems.

Please name your script as "assignment.R" (match case) when submitting to Gradescope. If you have multiple files to submit, at least one of them is named as "assignment.R". You may submit your answer to Gradescope for multiple times. 

**1)** Create within the R-environment these two vectors

       x=[1L,2L,3L]

and

        y=[1,2,3]
   
Evaluate the type of y and x and store your answers in:
  - `Q1_type_x`
  - `Q1_type_y`
 
 **2)** Multiply x and y, what are the dimensions and type of the resulting vector? Evaluate and store your answers in:
  - `Q2_dim`: a single value if we obtain a one-dimensional vector after multiplying x and y, otherwise a vector containing the dimensions.
  - `Q2_type`
 
 **3)** Add names to x ['x1','x2','x3'], and, using indexing by name, replace the second entry of x with the value 1.1. What is the type of x after the replacement? Evaluate and store your answers in:
  - `Q3_type_x`
 
 **4)** Create a matrix (W) using `cbind(x,y)`. What is the class of W? Evaluate and store your answers in:
  - `Q4_type_W`
       
 **5)** Apply the log() function to the W matrix created in (4). Store the obtained result in:
  - `Q5`
       
 **6)** Pick your two favorite cars and for each define the brand, model, year, and engine size. 
   - Create a list (length 2, one entry per car), each element of the list will contain the brand, model and year. Access to the information of the 1st and 2nd entry of the list using integer-indexing, and using `$`. Hint: see this [example](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/RIntro.md#lists).
   - Replace the 2nd entry of the list CARS with your first pick, and add a third entry to the list with your 2nd pick.

Store the list in `Q6_CARS`.


