# STATISTICAL COMPUTING


This GitHub serves as a repository for STT 802 and EPI 853B

**Instructor**: Gustavo de los Campos (gustavoc@msu.edu)

**[Syllabus](https://www.dropbox.com/s/g8obzjdv6g4c5ws/STAT_COMP_SYLLABUS_2021.pdf?dl=0)**

**Time & Place** M/W 3:00-4:20PM (Hybrid). 

## Topics & Tentative Schedule

|Class | Topics | Assigments | Materials |
|----|----|----|---|
|  | **Module 1: Introduction to R** | |
|1|Types, basic operations, arrays|[IN-CLASS 1](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_1.md)|[R Intro](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/RIntro.md)|
|2|Reading/Writing data, Descriptive analysis|[IN-CLASS 2](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_2.md)|[Read/Write](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/RIntro.md#read-write), [Descriptive statistics & basic plots](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/RIntro.md#descriptives) |
|3|Loops and conditional statements, functions|[IN-CLASS 3](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_3.md)|[Conditionals](https://github.com/QuantGen/RIntro#conditionals) / [Loops](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/RIntro.md#loops) / [functions](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/RIntro.md#functions)|
|4|Reporting using RStudio/RMarkdown|| [For begninners](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/RMarkdown_for_beginners.Rmd)/[RMarkdown Lesson 1](https://rmarkdown.rstudio.com/lesson-1.html)/ [cheatsheets](https://rmarkdown.rstudio.com/lesson-15.html)|
| | **Module 2: Linear Algebra** | | |
|5|Linear Algebra in R| [INCLASS 4](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_4.md) |[Matrix operations](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/LinearAlgebra.md)|
| | **Module 3: Least Squares problems** ||
|6|Linear Regression|[INCLASS 5](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_5.md) ;  [Homework 1](https://github.com/gdlc/STAT_COMP/blob/master/HW/HW1.pdf) |[OLS-Handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/OLS.pdf) / [OLS Using lm and Matrix operations](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/OLS.md)|
|7| Matrix Factorizations & Iterative algorithms to solve systems of equations | [IN-CLASS 6](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_6.md) | [Matrix Factorixation in R](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/LinearAlgebra.md#matrix-factorization) / [Gauss-Seidel](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/GaussSeidel.md) |
|8| Non-Linear regression via OLS |[IN-CLASS 7](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_7.md) |[scatter-plot smoothing](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/scatter_plot_smoothing.md)|
|8| Non-Linear regression via OLS |[IN-CLASS 8](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_8.md) |[scatter-plot smoothing](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/scatter_plot_smoothing.md)|
| | **Module 4: Maximum Likelihood** | | |
|9 |Estimation and inference using the `optim` function |[IN-CLASS 9](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_9.md)|[Logistic Regression](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/LogisticRegression.pdf) / [ML using optim](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/LogisticRegression.md)|
| | **Module 5: Bootstrap** | | |
|10|Bootstrap |[IN-CLASS 10](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_10.md) / [HW2](https://github.com/gdlc/STAT_COMP/blob/master/HW/HW2.pdf)  / [Efron & Hastie (2017)](https://web.stanford.edu/~hastie/CASI/) / [Efron's video](https://www.youtube.com/watch?v=H2tOhMaXWvI)|
|11| Midterm ||||
| | **Module 6: Sampling random variables** | | |
|13| Univariate distributions (the 'd', 'p', 'q' and 'r' functions)|[IN-CLASS 11](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_11.md)|[Distributions](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/RIntro.md#distributions)|
|14| Composition Sampling and Gibbs Sampler | [INCLASS 12](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_12.md) | [Sampling RVs handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/SimulatingRandomVariables.pdf) | |
|15 | Metropolis Hastings | | |
|16| Multivariate normal distribution ||[Sampling RVs handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/SimulatingRandomVariables.pdf) / [Examples](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/MVNORM.md) |
| 17 | **Module 5: Power Analysis** | [HW3](https://github.com/gdlc/STAT_COMP/blob/master/HW/HW3.md) / [INCLASS-14](https://github.com/gdlc/STAT_COMP//blob/master/INCLASS/INCLASS_14.md)| [Slides](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/ErrorRateAndPower.pdf) / [Examples](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/POWER_AND_TYPE-I_ERROR.md)  |
| | **Module 6: Permutation** |||
|18| Permutation tests ||[Permutation](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/PERMUTATION.md) |
| | **Module 7: Cross-validation** |||
|19| Cross-validation |[INCLASS 16](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_16.md) |[CV Examples](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/CROSSVALIDATION.md) |
| | [Overview of the three resampling methods discussed](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/RESAMPLING_METHDOS.pdf) | | |
| | **Module 8: Large scale hypothesis testing** |||
|20|Controlling error rate in multiple testing problems| [HW4](https://github.com/gdlc/STAT_COMP/blob/master/HW/HW4.md) /  |[Handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/MultipleTesting.pdf) / [Ch. 15, Efron & Hastie (2017)](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwiBwITgjZntAhUMHqwKHYi1C5oQFjABegQIBBAC&url=https%3A%2F%2Fweb.stanford.edu%2F~hastie%2FCASI_files%2FPDF%2Fcasi.pdf&usg=AOvVaw35RkePmQDVbV9mFQfiCn73) |
|21 | **Module 8: High-Dimensional Regression** | [INCLASS 17](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_17.md) / [INCLASS 18](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_18.md) / [INCLASS 19](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_19.md) |[Handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/HIGH_DIMENSIONAL_REGRESSION.Rmd) |
|22|Final Exam: | ||

