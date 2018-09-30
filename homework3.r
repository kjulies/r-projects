#Get data from https://datacatalog.worldbank.org/dataset/gender-statistics
#Find the Gender Stats data and download the file in csv format
#Unzip and use Gender_StatsData.csv

getwd()
#setwd("~/Desktop/projects/r-projects")

rm(list = ls()) #cleaning up
library(utils)
library(tidyverse)

gender_data <- as.tibble(read.csv("Gender_StatsData.csv"))

str(gender_data) #show structure of R object
dim(gender_data) #dimensions
head(gender_data)

#equivalent commands: filter() dplyr == subset() base-R
#equivalent commands: select() dplyr == match() or which()
teenager_fr <- filter(gender_data, Indicator.Code == "SP.ADO.TFRT")

#we don't need anymore 'gender_date'
rm(gender_data)
