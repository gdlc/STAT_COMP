### IN-CLASS Assigment 20: Comparing Single Marker-Regression and Bayesian models

In a Single Marker Regression (SMR), the association between the response and each of the markers is tested one marker at a time (i.e., using a marginal associaton test). The following code runs SMR using the same data you use in HW 4 (you can use this [link](https://www.dropbox.com/s/7yk8l3p6xn6rayd/Xy.RData?dl=0) to downlaod the data). The plot displays the -log10(pvalue) for the assocaition test for each marker by order of the marker in the genome. Red points are markers with effect significant at 5% FDR.

```r
load('~/Dropbox/STATCOMP/2020/Xy.RData')

## Note: if you have difficulty running this code in your computer (too slow, memory issues)
##       you could add this line to reduce the number of predictors
##  X=X[,c(10000:12000)]
SMR=matrix(nrow=ncol(X),ncol=4,NA)
colnames(SMR)=c('Estimate','SE','z-stat','p-value')

for(i in 1:ncol(X)){
  SMR[i,]=ls.print(lsfit(y=y,x=X[,i]),print.it=F)[[2]][[1]][2,]
}
FDR=p.adjust(SMR[,4],method='fdr')
FDR_SIG=FDR<0.05
plot(-log10(SMR[,4]),col=ifelse(FDR_SIG,2,4),
                     cex=ifelse(FDR_SIG,0.7,0.5), 
                     pch=ifelse(FDR_SIG,19,1)
      )
```

**Note**: For very large problems, consider using the GWAS() function of the [BGData R-package](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6505159/). Here is an example

```r
 library(BGData)
 SMR2=GWAS(y~1,data=BGData(pheno=data.frame(y=y),geno=X),method='rayOLS')
```


**Task**: 

  - Fit a Bayesian variable selection model (e.g., `fm=BGLR(y=y,ETA=list(list(X=X,model='BayesC')))`), and produce a plot of the probability of inclusion by marker. 
  - What are the p-values of the SNPs with probability of inclussion gerater than 0.8, 0.6, and 0.5?

**Solution**
(runs after the code presented above)

Examples using [BGLR](https://github.com/gdlc/bglr-r).

```r
  # Centering, not needed for SMR but recomendable for Penalized and Bayesian models
  # Could use X=scale(X,center=TRUE,scale=FALSE); however, if your RAM is small, it may be better doing it SNP-by-SNP
  for(i in 1:ncol(X)){ X[,i]=X[,i]-mean(X[,i]) }
  
  library(BGLR)
  
  # A two-level list
  MODEL=list(list(X=X,model='BayesC')) 
  fm=BGLR(y=y,ETA=MODEL) # use verbose=FALSE to supress messages, for real analysis, increase nIter and burnIn
  postProb=fm$ETA[[1]]$d # posterior probability of non-zero effect
  
  par(mfrow=c(2,1))

  # posterior probability of inclussion from the Bayesian model
  tmp=postProb>0.8
  plot(postProb, cex=ifelse(tmp,.5,.8),col=ifelse(tmp,2,4),pch=ifelse(tmp,19,1),ylab=expression(paste('P(',beta[j],' !=0|data)')))
 
  # colloring the single-marker regression p-values based on postrior probabilities
 
  plot(-log10(SMR[,4]),col=4,cex=.5)
  points(x=which(tmp),y= -log10(SMR[tmp,4]),cex=.8,col=2,pch=19)
  abline(h=-log10(max( p.adjust(SMR[,4],method='fdr')[FDR_SIG])),lty=2)  
```
