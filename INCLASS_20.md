


```{r}

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
