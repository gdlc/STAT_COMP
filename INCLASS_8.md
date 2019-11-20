Using the [gout](https://github.com/gdlc/STAT_COMP/blob/master/goutData.txt) produce 95% bootstrap CI for the following:

    - Male/Female OR
    - B/W OR
    - Probability of developing gout for each of the following cases
          - W/F/55
          - B/F/55
          - W/M/55
          - B/M/55
       
**Outline of the algorithm**:

    1. Create a bootstrap sample of the data (e.g., `tmpData`).
    2. Fit a logistic regression model to the bootstrap sample (fm=glm(gout2~sex+race+age,data=tmpData,family='binomial'))
    3. From the fitted model calculate the ORs and risk probabilities listed above. 
    4. Repeat 1-3 5,000 times, each time with a different bootstrap sampe. Store the odds and risk probabilities in a matrix or data frame.
    5. Compute 95% CI by applying the quantile function to the bootstrap estimates of odds and risk probabilities. 
    6. Compare the average of the bootstrap estimates with the estimates you obtined with the original data.


#### Proposed Solution


```r


  Y=read.table('~/Dropbox/STATCOMP/2018/goutData.txt',header=T,stringsAsFactors=F)
  Y$gout2=ifelse(Y$gout=='Y',1,0) 
  n=nrow(Y)
  
  
   fm0=glm(gout2~sex+race+age,data=Y,family='binomial')

   Z=cbind(1,c(1,1,0,0),c(1,0,1,0),rep(55,4))
   colnames(Z)=c('Int','M','W','age')
   rownames(Z)=c('M/W/55','M/B/55','F/W/55','F/B/55')
   
   LP=Z%*%coef(fm0) # these are the log-odds
   PROBS=exp(LP)/(1+exp(LP))
   
   
   nRep=10000
  
 
  
  B=matrix(nrow=nRep,ncol=ncol(Z)+2) 
  colnames(B)=c('M/F-OR','W/B-OR',rownames(Z))
  

  
  for(i in 1:nRep){
   tmp=sample(1:n,size=n,replace=T)
   tmpData=Y[tmp,]
   
   fm=glm(gout2~sex+race+age,data=tmpData,family='binomial')
   bHat=coef(fm)
   
   B[i,1]=exp(bHat[2])
   B[i,2]=exp(bHat[3])
   
   eta=Z%*%bHat
   probs=exp(eta)/(1+exp(eta))
   B[i,3:6]=probs
   message(i)	
 }
 
CI= apply(FUN=quantile,X=B,MARGIN=2,prob=c(.025,.975))

bHat=coef(fm0)

EST=c(exp(bHat[2]),exp(bHat[3]),PROBS)
names(EST)=colnames(B)
BootEst=colMeans(B)
round(rbind(EST,BootEst,CI),3)
```
