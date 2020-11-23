# STATISTICAL COMPUTING


This GitHub serves as a repository for STT 803 and EPI 853B

**Instructor**: Gustavo de los Campos (gustavoc@msu.edu)

**[Syllabus](https://www.dropbox.com/s/qdatt31mn4it9ev/STAT_COMP_SYLLABUS.docx?dl=0)**

**Time & Place** M/W 3:00-4:20PM (Online synchronous). Short videos will be made available after the class. If you are not in the US and cannot attend the class via zoom in a synchronous mode, please contact me to discuss possible accommodations.

## Topics & Tentative Schedule

|Class | Topics | Assigments | Materials |
|----|----|----|---|
|  | **Module 1: Introduction to R** | |
|1|Types, basic operations, arrays|[IN-CLASS 1](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS_1.md)|[R Intro](https://github.com/gdlc/STAT_COMP/blob/master/RIntro.md)|
|2|Reading/Writing data, Descriptive analysis|[IN-CLASS 2](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS_2.md)|[Read/Write](https://github.com/gdlc/STAT_COMP/blob/master/RIntro.md#read-write), [Descriptive statistics & basic plots](https://github.com/gdlc/STAT_COMP/blob/master/RIntro.md#descriptives) |
|3|Loops and conditional statements, functions|[IN-CLASS 3](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS_3.md)|[Conditionals](https://github.com/QuantGen/RIntro#conditionals) / [Loops](https://github.com/gdlc/STAT_COMP/blob/master/RIntro.md#loops) / [functions](https://github.com/gdlc/STAT_COMP/blob/master/RIntro.md#functions)|
|4|Reporting using RStudio/RMarkdown|[INCLASS 4](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS_4.md)| [For begninners](https://github.com/gdlc/STAT_COMP/blob/master/RMarkdown_for_beginners.Rmd)/[RMarkdown Lesson 1](https://rmarkdown.rstudio.com/lesson-1.html)/ [cheatsheets](https://rmarkdown.rstudio.com/lesson-15.html)|
| | **Module 2: Linear Algebra** | | |
|5|Linear Algebra in R|[INCLASS 5](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS_5.md)|[Matrix operations](https://github.com/gdlc/STAT_COMP/blob/master/LinearAlgebra.md)|
| | **Module 3: Least Squares problems** ||
|6|Linear Regression|[Homework 1](https://github.com/gdlc/STAT_COMP/blob/master/HW1.md) |[OLS-Handout](https://github.com/gdlc/STAT_COMP/blob/master/OLS.pdf) / [OLS Using lm and Matrix operations](https://github.com/gdlc/STAT_COMP/blob/master/OLS.md)|
|7| Matrix Factorizations & Iterative algorithms to solve systems of equations | [IN-CLASS 6](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS_6.md) | [Matrix Factorixation in R](https://github.com/gdlc/STAT_COMP/blob/master/LinearAlgebra.md#matrix-factorization) / [Gauss-Seidel](https://github.com/gdlc/STAT_COMP/blob/master/GaussSeidel.md) |
|8| Non-Linear regression via OLS |[IN-CLASS 7](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS_7.md) |[scatter-plot smoothing](https://github.com/gdlc/STAT_COMP/blob/master/scatter_plot_smoothing.md)|
|8| Non-Linear regression via OLS |[IN-CLASS 8](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS_8.md) |[scatter-plot smoothing](https://github.com/gdlc/STAT_COMP/blob/master/scatter_plot_smoothing.md)|
| | **Module 4: Maximum Likelihood** | | |
|9 |Estimation and inference using the `optim` function |[IN-CLASS 9](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS_9.md)|[Logistic Regression](https://github.com/gdlc/STAT_COMP/blob/master/LogisticRegression.pdf) / [ML using optim](https://github.com/gdlc/STAT_COMP/blob/master/LogisticRegression.md)|
| | **Module 5: Bootstrap** | | |
|10|Bootstrap |[IN-CLASS 10](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS_10.md) / [HW2](https://github.com/gdlc/STAT_COMP/blob/master/HW2.pdf) /  [HW2-Sol](https://github.com/gdlc/STAT_COMP/blob/master/HW2_SOLUTION.pdf) / [Efron & Hastie (2017)](https://web.stanford.edu/~hastie/CASI/) / [Efron's video](https://www.youtube.com/watch?v=H2tOhMaXWvI)|
|11| Midterm |Monday Oct. 26 (class-time)|[Solution](https://github.com/gdlc/STAT_COMP/blob/master/MIDTERM_2020.pdf)||
| | **Module 6: Sampling random variables** | | |
|13| Univariate distributions (the 'd', 'p', 'q' and 'r' functions)|[IN-CLASS 11](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS_11.md)|[Distributions](https://github.com/gdlc/STAT_COMP/blob/master/RIntro.md#distributions)|
|14| Composition Sampling and Gibbs Sampler | [INCLASS 12](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS_12.md) | [Sampling RVs handout](https://github.com/gdlc/STAT_COMP/blob/master/SimulatingRandomVariables.pdf) | |
|15 | Metropolis Hastings | | |
|16| Multivariate normal distribution ||[Sampling RVs handout](https://github.com/gdlc/STAT_COMP/blob/master/SimulatingRandomVariables.pdf) / [Examples](https://github.com/gdlc/STAT_COMP/blob/master/MVNORM.md) |
| 17 | **Module 5: Power Analysis** | [HW3](https://github.com/gdlc/STAT_COMP/blob/master/HW3.md) / [INCLASS-14](https://github.com/gdlc/STAT_COMP/tree/master)| [Slides](https://github.com/gdlc/STAT_COMP/blob/master/ErrorRateAndPower.pdf) / [Examples](https://github.com/gdlc/STAT_COMP/blob/master/POWER_AND_TYPE-I_ERROR.md)  |
| | **Module 6: Resampling methods** |||
|18| Permutation tests ||[Permutation](https://github.com/gdlc/STAT_COMP/blob/master/PERMUTATION.md) |
|19| Cross-validation ||[CV Examples](https://github.com/gdlc/STAT_COMP/blob/master/CROSSVALIDATION.md) |
| | **Module 7: Large scale hypothesis testing** |||
|29|Controlling type-I error rate in multiple testing problems| [HW4](https://github.com/gdlc/STAT_COMP/blob/master/MultipleTesting.pdfd) |[Multiple Testing](https://github.com/gdlc/STAT_COMP/blob/master/MultipleTesting.pdfd) |
|21| False Discovery Rate |||
| | **Module 8: Variable screening and variable selection** |||
|22|Lasso and Elastic Net |||
|23|Bayesian sparse regressions|||
|24|Assesment of Prediction Accuracy through Cross-Validation|||
|25|Final Exam: Monday, Dec 14 2020 3:00pm - 5:00pm |||

