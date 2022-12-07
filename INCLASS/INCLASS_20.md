## GWAS using sigle-marker regression, FWD regression and LASSO

The following [link](https://www.dropbox.com/s/yoo3cj8q3g846aa/GeneticData.RData?dl=0) contains a gneomic data set involving 1,576 
genetic markers (SNPs) evaluated in 10,000 individuals. Using this real genomic data, I simulated a phenotype (y) with 5 causal loci. Therefore, we have 1,571 SNPs without effect and 5 with effects.

In total the 5 SNPs explain ~1.5% of the variance of y.

Our task is to identify the possitions in X that have non-zero effect.

**A quick look at the data**

```r
  load("/Users/gustavodeloscampos/Dropbox/STAT_COMP/2022/GeneticData.RData")
  dim(X)
  length(y)
  causalLoci
  summary(lm(y~X[,causalLoci]))
```

**Independent screening**

The following code shows how to test the association of the phenotype with each SNP, one SNP at a time.

```r
 SMR=data.frame(snp=colnames(X),pvalue=NA)
 
 for(i in 1:ncol(X)){
  SMR$pvalue[i]=summary(lm(y~X[,i]))$coef[2,4]
 }
 
 ## Manhattan plot
 plot(-log10(SMR$pvalue),cex=.5,col=4)
 
 # Now coloring using fdr-significance as a criteria
 fdr=p.adjust(SMR$pvalue,method='fdr')
 plot(-log10(SMR$pvalue),cex=.5,col=ifelse(fdr<.05,2,4))
 
```

**Forward**

Here we use the FWD() function of the BGDataExt package to perform forward regression, stopping at 100 df.
```r
 # The package is not available in CRAN, it is maitnained at GitHub, here is what you need to use to install it.
 # library(devtools)
 # install_github('https://github.com/QuantGen/BGDataExt/')
 library(BGDataExt)
 FM=FWD(y=y,X=X,df=100,verbose=TRUE)
 FM$path
 colnames(X)[causalLoci]
```


**Lasso**

```r
 library(glmnet)
 fmL=glmnet(y=y,x=X,alpha=1)
```

## Task

 - Compute "power" and false-discovery proportion (FDP) for a decision rule that selects SNPs with FDR-significant single-marker regression pvalue.
 - Comptue power and FDP for the first 10 steps of FWD and the first 10 steps of Lasso.

