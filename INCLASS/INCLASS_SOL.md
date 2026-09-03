
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


