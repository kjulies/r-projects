#Obtaining all except NA
age[c(-5, -11)] ==  age[c(1, 2, 3, 4, 6, 7, 8, 9, 10, 12)] == age[!is.na(age)]

#import
library(tidyverse)
papers <- as_tibble(read_csv(???filepath???))
papers_select <- select(papers, journal, year, cites, title, au1)

summary(filter(papers, cites >= 100))
summarize(group_by(papers, journal), sum_ci = sum(cites))
n_distinct(papers$au1)  == length(unique(papers_select$au1))

select(papers, contains("female")) 

aggregate(papers_select$cites, by=list(journal=papers_select$journal), FUN=sum)

filter(group_by(papers, journal), journal == "Econometrica")

nrow(filter(papers, cites >= 100))
