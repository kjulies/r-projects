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

#check data type
is.matrix(sample)
is.data.frame(sample)

#manipulate data
sample_mtx <- as.matrix(sample)
is.matrix(sample_mtx)

a <- matrix(1,2,3)
a
is.matrix(a)
as.data.frame(a)

#transpose
t(a)
a

#delete/add a row/columns
a <- a[-1,]
a
a <- rbind(a, c(2,2,2)) #add row
a
a <- cbind(a, c(2,3)) #add col
a
