## Homework 4: Large-scale hypothesis testing.

Due December 4th in D2L.

The data set available in this [link](https://www.dropbox.com/s/7yk8l3p6xn6rayd/Xy.RData?dl=0)  provides SNP genotypes for 10,000 individuals (rows of X) at 19,996 SNPs (columns of X) and a phenotype (y, 10,000x1). To load this data set into an R-environment, you need to dwonload it to your computer and then use `load()` to load it into R. Once you load it, you should see objects `X` and `y` in the environment (try `ls()`).

Using this data set, test the association between each SNP (i.e., each column of X) and the phenotype, one SNP at a time, using a linear model of the form

```r
   fm=lm(y~X[,i])
```

Use the resulting 19,996 p-values for the following

**1** Identify all the SNPs with 'significant' associations using Bonferroni, Holm, and the Benjamini-Hochberg (BH) methods to adjust for multiple testing. Conduct inferences at 0.05 significance level (for Bonferroni's and Holm's method) and 0.05 false discovery rate for the BH method.

Hint: check the function `help(p.adjust)`

Report the SNPs (column numbers) that were 'significant' according to each method.


**2** Produce the following plot (using un-adjusted p-values)
  - Manhattan plot (-log10(pvalue) in the y-axis versus position of the SNP (1:ncol(X)) in the horizontal axis)
  - A a histogram of p-values with 500 bins hist(pvalues,500)
  - A qqplot(), i.e., a scatterplot with the empirical quantiles of your p-values in the vertical axis versus the quantiles of the uniform distribution (i.e., the expected distribution under the null) in the x-axis. Display both axis in the -log10 scale. Add a 45-degree line.
  - At what value of -log10(pvalue) do you see clear departure from the null distribution?

Hints:
  - To get the empirical quantiles of your p-values you can use `quantile(pvalues,prob=seq(from=0,to=1,by=1/length(pvalues))`
  - The quantiles of the uniform distribution are `seq(from=0,to=1,by=1/length(pvalues))`
  - Plot both in the -log10 scale
  - If you have truouble producing this plot, check the package `qqman`
    
    
 ## [Solution](https://github.com/gdlc/STAT_COMP/blob/master/HW4_SOLUTION.pdf)
