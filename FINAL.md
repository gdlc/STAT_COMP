#### Code question 1


```r
 # Joint distribution of X and Y
 P=rbind(c(.14,.2),c(.23,.43))
 colnames(P)=c('Y=0','Y=1')
 rownames(P)=c('X=0','X=1')
 print(P)

```


#### Code question 2

```r
 data(cars)
 f=function(speed,a){
    out=(speed^2)/2/a
    return(out)
}

fmNLS=nls(dist~f(speed,a),data=cars,start=list(a=2))

```
