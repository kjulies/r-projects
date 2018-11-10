# clean
rm(list = ls())

#setwd("Desktop/projects/r-projects/")

# load csv file
fastfood <- read.csv("fastfood.csv", header = TRUE, row.names = NULL)
fastfood

