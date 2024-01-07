# gesca

<!-- badges start here: Will update later on once gesca published on CRAN -->
<!--
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/bayesplot?color=blue)](https://cran.r-project.org/web/packages/bayesplot)
[![Downloads](https://cranlogs.r-pkg.org/badges/bayesplot?color=blue)](https://cran.rstudio.com/package=bayesplot)
[![R-CMD-check](https://github.com/stan-dev/bayesplot/workflows/R-CMD-check/badge.svg)](https://github.com/stan-dev/bayesplot/actions)
[![codecov](https://codecov.io/gh/stan-dev/bayesplot/branch/master/graph/badge.svg)](https://codecov.io/gh/stan-dev/bayesplot)
-->
<!-- badges: end -->

### Overview

The R package **gesca** implements Generalized Structured Component Analysis (GSCA) and its basic extensions, including constrained single and multiple group analysis, and second order latent variable modeling. 
It enables users to obtain overall and local model fit measures, parameter estimates with bootstrapped standard errors and confidence intervals, and the total and indirect effects of latent variables and indicators.
The package allows users to easily specify their hypothesized relationships among latent variables and/or indicators using an intuitive, text-based syntax. 
This user-friendly syntax involves the use of indicator names and simple numerical operators, making it straightforward and accessible for users.

Currently, **gesca** offers basic GSCA methods, i.e., component-based structural equation modeling, wherein all constructs are represented by components or weighted sums of observed variable.
For those interested in more recently developed GSCA methods, such as GSCA with measurement errors (GSCA_M) and integrated GSCA (IGSCA),
we highly recommend [**GSCA Pro**](https://www.gscapro.com/).
This free software provides a graphical user interface, making it simpler to model through path diagrams and visualize results effectively.

We are committed to the continuous development of the gesca R package and plan to soon incorporate the latest GSCA methods, including features similar to those found in GSCA Pro. Stay tuned for these exciting updates!

### Resources

* [https://www.gscapro.com/two-sem-domains]: Quick overview of 

### Getting started 

If you are just getting started with **gesca**, we recommend starting with [the tutorial paper](https://doi.org/10.1007/s41237-016-0002-8) and the examples throughout the package.

### Installation

* Install from CRAN:

```r
install.packages("gesca")
```

### Examples

Some quick examples using the main function and the built-in dataset

```r
library(gesca)
```
