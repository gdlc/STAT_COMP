

### Model Comparison using AIC/BIC/Adjusted R-2 and out-of-sample prediction R-sq.



Consider these two competing hypotheses:   H1: `Wage~Sex+Education+Experience`, H2: `Wage~.`


  - Fit the two models to the full data set, obtain R-sq., adjusted R-sq., AIC, BIC and a p-value from an F-test.
  - Conduct 1000 training-testing evaluations (nTesting=150) to estimate prediciton R-sq. for H1 and H2.
  - Report a table with AIC,BIC,Training R-sq., Training adj-Rsq. and prediction r-sq. for each of the models.
  - Which model do you choose? Why?


### Proposed solution


```r

DATA=read.table('~/Dropbox/STATCOMP/2018/wage.txt',header=T)

H0='Wage~Sex+Education+Experience'
HA='Wage~.'

fm0=lm(H0,data=DATA)
fmA=lm(HA,data=DATA)

## F-test, we reject H0 in favor of HA
print(anova(fm0,fmA))


TMP=data.frame(model=c('H0','HA'),
				R2=c(summary(fm0)$r.squared,summary(fmA)$r.squared),
				adjR2=c(summary(fm0)$adj.r.squared,summary(fmA)$adj.r.squared),
				AIC=c(AIC(fm0),AIC(fmA)),
				BIC=c(BIC(fm0),BIC(fmA)))
				
				
				
R2.CV=matrix(nrow=1000,ncol=2,NA)
colnames(R2.CV)=c('R2-H0','R2-HA')
N=nrow(DATA)

for(i in 1:nrow(R2.CV)){

	trn=sample(1:N,size=100,replace=F)
	
	fm0=lm(H0,data=DATA[trn,])
	fmA=lm(HA,data=DATA[trn,])
	
	yHatTST_H0=predict(fm0,newdata=DATA[-trn,])
	yHatTST_HA=predict(fmA,newdata=DATA[-trn,])
	
	mu=mean(DATA[trn,]$Wage)
	y=DATA$Wage[-trn]
	R2.CV[i,'R2-H0']=1-sum((y-yHatTST_H0)^2)/sum((y-mu)^2)
	R2.CV[i,'R2-HA']=1-sum((y-yHatTST_HA)^2)/sum((y-mu)^2)	

}

TMP$R2.CV=colMeans(R2.CV)
print(TMP)



```


The answer of what model is preferred would depend on the research goals.

The F-test and AIC favors HA; however, BIC (which favors simpler models) and the R1-CV favors the null model.

If the objective is to infer the effects of Sex, Education and Experience on wages I would use HA to avoid bias due to omitted variables..

If the purpose is to predict wages, I would use H0 since it gave slightly higher accuracy.
