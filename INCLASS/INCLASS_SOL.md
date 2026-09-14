
 <div id="MENUE" />
 

<div id="INCLASS_1" />

### INCLASS 1

```r
x <- c(1L,2L,3L)
y <- c(1,2,3)

Q1.1 <- typeof(x)
Q1.2 <- typeof(y)
z <- x*y

Q2 <- length(z)

names(x) <- c('x1','x2','x3')
x[2] <- 1.1
Q3 <- typeof(x)

W <- cbind(x,y)
Q4 <- typeof(W)
```

[back to list](#MENUE)

<div id="INCLASS_2" />

### INCLASS 2

```r
 DATA <- read.table('https://hastie.su.domains/ElemStatLearn/datasets/prostate.data')

 tmp<-c("lcavol",      "lweight",      "age",  "lbph", "svi",  "lcp",  "gleason", "pgg45", "lpsa")

 Q3.mean <- apply(DATA ,2,mean)[tmp]
 Q3.median <- apply(DATA ,2,median)[tmp]

 COR <- apply(X=DATA[,tmp[-length(tmp)]],y=DATA[,'lpsa'],FUN=cor,MARGIN=2)

 top_predictor <- names(COR)[which.max(COR)]

```
[back to list](#MENUE)


<div id="INCLASS_3" />

### INCLASS 3

[back to list](#MENUE)
 
Q1=character()
for(i in 1:5){
 for(j in c('a','b')){
  Q1=c(Q1,paste0(i,'-',j))
 }
}


i=0
while(i<=5){
    i=i+1
}
Q2=i


recode2=recode0=function(x,old_levels,new_levels){
   x=as.character(x)
   b=length(x)
   y=rep(NA_character_,length(x))
   for(i in 1:length(old_levels)){
    tmp=x==old_levels[i]
    y[tmp]=new_levels[i]
   }
   return(y)
}


<div id="INCLASS_4" />

### INCLASS 4

[back to list](#MENUE)

