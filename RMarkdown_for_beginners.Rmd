---
title: "Getting Started with R-Markdown"
author: "Gustavo"
date: "8/13/2020"
output: html_document # you can use pdf_document or word_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# This is a large title

## A smaller title...

### Even smaller...

This is plain text, **boldface**, and *italics*.


This is a link to [great R-Markdown lessons](https://rmarkdown.rstudio.com/lesson-1.html)


You can write equations using latex-style syntax $y=X\beta+\epsilon$


**You can run simple or complex R-code** 

```{r } 
 x=rnorm(200)
 plot(x)
```

**Tables** can be produced by either introducing it explicitly in the Markdown file


| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |


Or by generating them with R-code


```{r}
 library(knitr)
 x=rbinom(n=100,prob=.3,size=1)
 y=x+rbinom(n=100,prob=.3,size=1)
 TABLE1=table(x,y)
 kable(TABLE1)
```

Using `echo=FALSE` can be used to display outputs only 

```{r,echo=FALSE}
 y=x+rnorm(100)
 fm=lm(y~x)
 kable(summary(fm)$coef)
```

Using `eval=FALSE` can be used to display code without actually running it

```{r,eval=FALSE}
 y=x+rnorm(100)
 fm=lm(y~x)
 kable(summary(fm)$coef)
``` 

This is a useful R-markdown [cheatsheet](https://rmarkdown.rstudio.com/lesson-15.html)
