### IN-CLASS Assigment 20: Comparing Single Marker-Regression and Bayesian models

In a Single Marker Regression (SMR), the association between the response and each of the markers is tested one marker at a time (i.e., using a marginal associaton test). The following code runs SMR using the same data you use in HW 4 (you can use this [link](https://www.dropbox.com/s/7yk8l3p6xn6rayd/Xy.RData?dl=0) to downlaod the data). The plot displays the -log10(pvalue) for the assocaition test for each marker by order of the marker in the genome. Red points are markers with effect significant at 5% FDR.

```r
load('~/Dropbox/STATCOMP/2020/Xy.RData')
X=scale(X,center=TRUE,scale=FALSE) # centering, not needed for SMR but recomendable for Penalized and Bayesian models
SMR=matrix(nrow=ncol(X),ncol=4,NA)
colnames(SMR)=c('Estimate','SE','z-stat','p-value')

for(i in 1:ncol(X)){
  SMR[i,]=summary(lm(y~X[,i]))$coef[2,]
}
FDR_SIG=p.adjust(SMR[,4],method='fdr')<0.05
plot(-log10(SMR[,4]),col=ifelse(FDR_SIG,2,4),
                     cex=ifelse(FDR_SIG,0.7,0.5), 
                     pch=ifelse(FDR_SIG,19,1)
      )
```
Task: 

  - Fit a Bayesian variable selection model (e.g., `fm=BGLR(y=y,ETA=list(list(X=X,model='BayesC')))`), and produce a plot of the probability of inclusion by marker. 
  - What are the p-values of the SNPs with probability of inclussion gerater than 0.8, 0.6, and 0.5?

