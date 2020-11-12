#Install missing packages
packages <- c('dplyr','crayon','MASS','ggplot2','ggridges',
              'ggpubr','ggeffects','ggforce','fitdistrplus')
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}
#Loading all packages
require(dplyr)
require(crayon)
require(fitdistrplus)
require(MASS)
require(ggplot2)
require(ggridges)
require(ggpubr)
require(ggeffects)
require(ggforce)