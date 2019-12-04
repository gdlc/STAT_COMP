

Goals:

  - To fit a mixture model to hourly wages
  - To cluster subjects using a mixture model according to their wages
  - And to examine the association between the clusters and education, sex and race.
 
 (1) Use the [wages](https://github.com/gdlc/STAT_COMP/blob/master/wages.txt) data set to fit a mixture models with 2, 3 and 5 components.
     Plot in one graph the three fitted mixtures. Add one more line with a non-parameteric dessity fit (`tmp<-density(z)` fits a density to variable `z`,  `tmp$x` and `tmp$y` will give you the x-y coordinates for a density plot, try `lines(x=tmp$x,y=tmp$y` to add lines to an exisiting plot).
     
  (2) Report proportion of male, average years of education and proportions of whites in each of the clusters, for each of the mixtures.
  
  **Proposed soultion**
  Note: after looking at results I decided to add a gaussian approximation (i.e., 1 component), fitting also a 4-components mixture, and using a histogram instead of `density`. We will discuss the results in class.
  
  
  The functions `fitMixture` and `mixtureDensity` used below can be obtained from [here](https://github.com/gdlc/STAT_COMP/blob/master/EM_MIXTURES.md).
  
  ```r
  
   Y=read.table('~/Dropbox/STATCOMP/2018/wage.txt',header=T)
   fm2=fitMixture(Y$Wage,nComp=2,nIter=300)
   fm3=fitMixture(Y$Wage,nComp=3,nIter=300)
   fm4=fitMixture(Y$Wage,nComp=4,nIter=300)
   fm5=fitMixture(Y$Wage,nComp=5,nIter=300)

   x=seq(from=1,to=45,by=.1)
   y2=mixtureDensity(x=x,mu=fm2$MEANS,sd=fm2$SD,prob=fm2$alpha)
   y3=mixtureDensity(x=x,mu=fm3$MEANS,sd=fm3$SD,prob=fm3$alpha)
   y4=mixtureDensity(x=x,mu=fm4$MEANS,sd=fm4$SD,prob=fm4$alpha)
  
   par(mfrow=c(3,2))
   hist(Y$Wage,50)
   plot(x=x,y=dnorm(x,mean=mean(Y$Wage),sd=sd(Y$Wage)),col=1,type='l')
   plot(x=x,y=y2,col=2,type='l',main=2)
   plot(x=x,y=y3,col=3,type='l',main=3)
   plot(x=x,y=y4,col=4,type='l',main=4)
   plot(x=x,y=y5,col=5,type='l',main=5)


  ```
  
  Descriptive statistics per group
  
  ```r
    clust2=apply(FUN=which.max,X=fm2$PROBS,MARGIN=1)
    clust3=apply(FUN=which.max,X=fm3$PROBS,MARGIN=1)
    clust4=apply(FUN=which.max,X=fm4$PROBS,MARGIN=1)
    clust5=apply(FUN=which.max,X=fm5$PROBS,MARGIN=1)
   
   # 2 groups
   tmp2=rbind(tapply(FUN=mean,X=Y$Wage,INDEX=clust2),
      tapply(FUN=mean,X=Y$Sex,INDEX=clust2),
      tapply(FUN=mean,X=Y$Black,INDEX=clust2)
      )
    rownames(tmp2)=c('Wage','Sex','Black')
    tmp2
    
     # 3groups
     tmp3=rbind(tapply(FUN=mean,X=Y$Wage,INDEX=clust3),
      tapply(FUN=mean,X=Y$Sex,INDEX=clust3),
      tapply(FUN=mean,X=Y$Black,INDEX=clust3)
      )
    rownames(tmp3)=c('Wage','Sex','Black')
    tmp3 

  
  ```
