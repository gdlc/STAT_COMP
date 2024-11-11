

The following example illustrates how to use the `boot` R package. For te example we focus on inferences on the correlation coefficient between Serum Urage and Age.

The functions we will discuss include:

    - boot: used to generate bootstrap sample,
    - boot.ci: used to obtain boostrap CI's

For more details abou the pacakge and other functions included on it, please view teh reference manual [here](https://cran.r-project.org/web/packages/boot/index.html).

The following description is taken form the reference manual for the `boot` function.

"Generate R bootstrap replicates of a statistic applied to data. Both parametric and nonparametric resampling are possible. For the nonparametric bootstrap, possible resampling methods are the or- dinary bootstrap, the balanced bootstrap, antithetic resampling, and permutation. For nonparametric multi-sample problems stratified resampling is used: this is specified by including a vector of strata in the call to boot. Importance resampling weights may be specified.


**Example**

For the example we will use the Gout data set and focus on inferences on the correlation between serum urate and age.

```r
 fname='https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/goutData.txt' 
 DATA=read.table(fname,header=TRUE) 

  # Point estimate
 COR=cor(DATA$su,DATA$age)
```
Here is a simple example of how to generate 10000 bootstrap samples using non-parameteric bootstrap.

```r
 R=10000 # numbrer of bootstrap samples 

 correlations=rep(NA,R) 
 n=nrow(DATA)
 for(i in 1:R){
    tmp=sample(1:n,size=n,replace=TRUE) 
    correlations[i]=cor(DATA$su[tmp],DATA$age[tmp]) 
 }

```

Here is the same task using the boots package. First we need to re-write the function that computes the statistics

```r
 myStat=function(DATA,x){
  cor(DATA$su[x],DATA$age[x])
 }
```
Above, `x` is an index that will be re-sampled by the boot function.

```r
 library(boot)
 tmp=boot(DATA,myStat,R=1000)

```


