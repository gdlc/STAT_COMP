## In-Class assigment 8

Use a natural spline (with `DF=[3,4,6,8]`) to obtain non-parameteric fits to the relationship between offspring height and the average parental height. Evaluate whether the relationship between offsprings' height has a linear relationship with parental average. 

Please download GALTON.csv from https://github.com/gdlc/STAT_COMP/tree/master/DATA and save it in the same directory as your submission. You can read the data into the R-environment using the following code


```r
 DATA=read.table('GALTON.csv',header=TRUE,sep=',')
 DATA$PA=(DATA$Father+DATA$Mother)/2
```

In GradeScope, we provide GALTON.csv in the same direction.

Create a 2x2 panel of plots, each plot with offspring height (`$Height`) on the y-axis, parental average (`PA=($Father+$Mother)/2`) on the horizontal axis, grey (col=8) small points (cex=.5), and a red line representing the fitted spline. 


**Sequential testing**

Perform the following sequence of tests using `anova(fmj, fmk)`

  - Linear model versus Natural Spline with 3df
  - Natural Spline with 3df versus Natural Spline with 4 DF.
  - Natural Spline with 3df versus Natural Spline with 6 DF. 
  - Natural Spline with 3df versus Natural Spline with 8 DF.

Which model do you choose?

## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. If you have multiple files to submit, at least one of them is named as `assignment.R`.  You may submit your answer to Gradescope as many times as needed.

Include in your anser the following data frame

 `  ANS=data.frame(H0=c('Linear', 'NS3DF','NS3DF','NS3DF'), HA=c('NS3DF','NS4DF','NS6DF','NS8DF'),FStat=NA,pValue=NA) `

Include in your script a variable named `chosenModel` and set it equal to the label of the model you select (refer to the model using one of the labels used in `unique(c(ANS$H0,ANS$HA))`.
