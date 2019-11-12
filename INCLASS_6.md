
Using the [Gout data set](https://github.com/gdlc/STAT_COMP/blob/master/goutData.txt) estimate the p-value for `race` using 10000 permutations.

Consider a model that also accounts for `sex`, `age`, and `serum urate (su)`.


**Fitting the model to the matched data**

```r
 DATA=read.table("~/Desktop/gout.txt",header=T)

 DATA$gout=ifelse(DATA$gout=='Y',1,0)

# fitting the model without doing any permutation
 fm0=glm(gout~su+race+sex+age,data=DATA,family='binomial')
 summary(fm0)
 str(summary(fm0))
```

**Outline of the algorithm**:

   - Preparation: find out how to extract the p-value for race from `fm0` (see code above)
   - Create a vector that will stor the permutation *t-statistic*
   - You will need to use a lopp for `i in 1:10000`
   - Inside the loop, create a temporary data set (e.g., TMP) where you permute only the column corresponding to `race`
   - Fit the model using the temporary data set instead of `DATA`
   - Extract and store the required t-statistic
   - Compute the proportion of times the permuatiion t-statistic was, in absolute, value greater or equal than the one in `fm0` (also in absolute value).
	
**Suggested response**

```r

 
DATA=read.table("~/Desktop/gout.txt",header=T)
DATA$gout=ifelse(DATA$gout=='Y',1,0)

# fitting the model without doing any permutation
 fm0=glm(gout~su+race+sex+age,data=DATA,family='binomial')
 
 nRep=10000
 t_stat=rep(NA,nRep)
 n=nrow(DATA)
 
 
 for(i in 1:nRep){
   TMP=DATA
   
   tmp=sample(1:n,size=n,replace=F)
   
   TMP$race=DATA$race[tmp]
   TMP$age=DATA$age[tmp]
   fm=glm(gout~su+race+sex+age,data=TMP,family='binomial')
   t_stat[i]=summary(fm)$coef[3,3]
 }
 
 hist(t_stat,50)
 cutoff=abs(summary(fm0)$coef[3,3])
 abline(v=c(-1,1)*cutoff,col=2,lwd=1.5)
 
 # permutation p-vlaue
 mean(abs(t_stat)>cutoff)
 
 # likelihood-theory p-value
  summary(fm0)$coef[3,]
 

```

