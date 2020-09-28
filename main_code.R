# Are green and loggerhead strandings increasing
# due to population growth in the southwestern Atlantic Ocean?
#-------------------------------------------------------------#
#PREPARING WORKSPACE
rm(list=ls())
#Root directory
directory <- "~/Dropbox/Science/Turtles/Masters/strandings-RSC/"
#Sub-directories
dir.data <- paste0(directory,'data/') 
dir.sup <- paste0(directory,"plots and tables/supplementary material/")
dir.code <-  paste0(directory,"code/")
setwd(dir.data)
#Installing/loading packages
source(paste0(dir.code,'0_packages.r'))
#------------#

#DATA IMPORTING AND PROCCESSING
source(paste0(dir.code,'1_data_processing.r'))

#------------#

#STATISTICAL MODELLING
source(paste0(dir.code,'2_statistics.r'))

#Strandings
summary(cm.strandings.model)
summary(cc.strandings.model)

#Body sizes
summary(cm.sizes.model)
summary(cc.sizes.model)

#------------#

#PLOTS
source(paste0(dir.code,'3_plots.r'))

#Green turtle strandings
chelonia.strandings.plot
#Loggerhead turtle strandings
caretta.strandings.plot
#Strandings plus GLM effects
strandings.plot

#Body sizes
sizes.plot

#------------#

#SUPPLEMENTARY MATERIAL

source(paste0(dir.code,'4_supplementary_material.r'))

#Summary tables
cc.table
cm.table
#Monthly strandings distribution
monthly.strandings
#Monthly covariates distribution
covariates
