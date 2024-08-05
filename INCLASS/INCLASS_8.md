## In-Class assigment 8

Use a natural spline (with `DF=[3,4,6,8]`) to obtain non-parameteric fits to the relationship between offspring height and the average parental heigth. Evaluate whether the relationship between offsprings' height has a linear relationship with parental average. 

Create a 2x2 panel of plots, each plot with offspring height (`$Height`) on the y-axis, parental average (`PA=($Father+$Mother)/2`) on the horizontal axis, grey (col=8) small points (cex=.5), and a red line representing the fitted spline. 


You can read the data into the R-environment using the following code


```r
 DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/GALTON.csv',header=TRUE,sep=',')
 DATA$PA=(DATA$Father+DATA$Mother)/2
```

