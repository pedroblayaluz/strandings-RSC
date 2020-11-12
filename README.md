Are green and loggerhead strandings increasing due to population growth
in the southwestern Atlantic Ocean?
================
Pedro Blaya Luz

-   [Description](#description)
-   [Code sections](#code-sections)
    -   [Setting up the environment](#setting-up-the-environment)
    -   [Data importing and processing](#data-importing-and-processing)
    -   [Statistical modeling](#statistical-modeling)
    -   [Plots](#plots)
    -   [Supplementary material](#supplementary-material)

## Description

This repository contains analysis scripts from the article “*Are green
and loggerhead strandings increasing due to population growth in the
southwestern Atlantic Ocean?*” to be submitted to [Biological
Conservation](www.journals.elsevier.com/biological-conservation). The
analysis code is divided into several separate scripts, which are called
from
[main\_code.r](https://github.com/pedroblayaluz/strandings-RSC/blob/master/main_code.R).

The following is a description of the **analysis code structure**,
executed in
[main\_code.r](https://github.com/pedroblayaluz/strandings-RSC/blob/master/main_code.R).
To see the results and get more detailed information please read the
article at [link](www.google.com)

## Code sections

### Setting up the environment

``` r
#PREPARING WORKSPACE
rm(list=ls())
#Root directory
directory <- "~/Dropbox/Science/Turtles/Masters/strandings-RSC/"
#Sub-directories
dir.data <- paste0(directory,'data/') 
dir.sup <- paste0(directory,"plots and tables/supplementary material/")
dir.code <-  paste0(directory,"code/")
#Loading/installing missing packages
source(paste0(dir.code,'0_packages.r'))
```

### Data importing and processing

In
[1\_data\_processing.R](https://github.com/pedroblayaluz/strandings-RSC/blob/master/code/1_data_processing.R)
all .csv files inside the
[data](https://github.com/pedroblayaluz/strandings-RSC/tree/master/data)
folder are imported and processed into appropriate data.frames for
subsequent analysis:

-   `chelonia.strandings` and `caretta.strandings` are used to model
    strandings in response to reproductive and environmental predictors.
-   `chelonia.plot.data` and `caretta.plot.data` are used to plot
    strandings and reproductive data.
-   `chelonia.sizes` and `caretta.sizes` are used to model and plot sea
    turtles body sizes (CCLs).

``` r
#DATA IMPORT AND PROCCESSING
source(paste0(dir.code,'1_data_processing.r'))
```

### Statistical modeling

In
[2\_statistical\_modelling.R](https://github.com/pedroblayaluz/strandings-RSC/blob/master/code/2_statistical_modelling.R)
four statistical models are adjusted:

-   One model for each species’ strandings

``` r
#Green
cm.strandings.model <- glm.nb(n~offset(log(km))+sst+w10+Ascension,
                              data=chelonia.strandings)
#Loggerhead
cc.strandings.model <- glm.nb(n~offset(log(km))+sst+w10+Brazil,
                              data=caretta.strandings)
```

-   One model for each species’ body sizes

``` r
#Green
cm.sizes.model <- lm(ccl~as.factor(year)+as.factor(month),
                     data=chelonia.sizes)
#Loggerhead
cc.sizes.model <- lm(ccl~as.factor(year)+as.factor(month), data=caretta.sizes)
```

``` r
#STATISTICAL MODELINGggpredict()
source(paste0(dir.code,'2_statistics.r'))
```

### Plots

In
[3\_plots.R](https://github.com/pedroblayaluz/strandings-RSC/blob/master/code/3_plots.R)
several plots are created. They are combined into two figures:

-   `strandings.plot` including strandings and reproductive data over
    time, along with the effects of each predictor over the number of
    strandings.

-   `sizes.plot` including temporal variations of turtles’ body sizes.

``` r
#PLOTS
source(paste0(dir.code,'3_plots.r'))
```

### Supplementary material

The last script
[4\_supplementary\_material.R](https://github.com/pedroblayaluz/strandings-RSC/blob/master/code/3_supplementary_material.R)
creates Tables and Figures annexed as Supplementary material.

``` r
#SUPPLEMENTARY MATERIAL
source(paste0(dir.code,'4_supplementary_material.r'))
```
