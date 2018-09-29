# setting directory
setwd("~/Desktop/projects/r-projects")

#import data
sample <- read.csv("sample.csv", header = FALSE)

#if it was a table in txt..
#sample <- read.table("sample.txt", sep=",", header = FALSE)

#assess data
summary(sample)
nrow(sample)

#counting
max(sample$V4)
min(sample$V5)
unique(sample$V2)
sort(unique(sample$V2))
length(unique(sample$V2))

#queries
which(sample$V3 == "Eugene Barchas")
length(which(sample$V3 == "Eugene Barchas"))

