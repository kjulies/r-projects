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

#basic summary functions: mean(), sd(), min(), max(), sum()
mean(teenager_fr$X1975, na.rm = TRUE)

#reminder: n_distinct(), mutate(), summarise()
mean(teenager_fr$X1960, na.rm = TRUE)
sd(teenager_fr$X1960, na.rm = TRUE)

#extract the "low income", "middle income" and "high income". They are as Countries.
byincomelevel <- filter(teenager_fr, Country.Code %in% c("LIC","MIC","HIC"))

#just in case if fails, we set the name of the column (sometimes the following gather returns error)
colnames(byincomelevel)[1] <- "Country.Name"

#gather(): create 'Year' and 'FertilityRate' from columns X1960:X2015. 
#        Using column name as 'Year' (key) and content of this field as 'FertilityRate' (value).
plotdata_bygroupyear <- gather(byincomelevel, Year, FertilityRate, X1960:X2015) %>%
                        select(Year, Country.Name, Country.Code, FertilityRate)

#saving a backup
plotdata_byyear <- plotdata_bygroupyear

#spread(): inverse of gather()
plotdata_byyear <- select(plotdata_byyear, Country.Code, Year, FertilityRate) %>%
                   spread(Country.Code, FertilityRate)

#plotting
ggplot(plotdata_bygroupyear, aes(x=Year, y=FertilityRate, group=Country.Code, color=Country.Code)) +
      geom_line() +
      labs(title='Fertility Rate by Country-Income-Level over Time')

#removing 'X' from years as 'X1960'
#   str_sub("X1960",-4)
#   str_sub("X1960",2,5)
#   str_replace("X1960","X","")

plotdata_bygroupyear <- mutate(plotdata_bygroupyear, Year=as.numeric( str_sub(Year,-4) ))

##########
# Part 2 #
##########

colnames(teenager_fr)[1] <- "Country.Name"
histdata_twoyears <- gather(teenager_fr, Year, FertilityRate, X1960,X2000) %>%
                     select(Year, Country.Name, Country.Code, FertilityRate)

#plotting histogram
ggplot(histdata_twoyears, aes(x=FertilityRate)) +
  geom_histogram(data=subset(histdata_twoyears, Year=="X1960"), color="darkred", fill="red", alpha=0.2) +
  geom_histogram(data=subset(histdata_twoyears, Year=="X2000"), color="darkblue", fill="blue", alpha=0.2)

ggsave("hist.png")

#plotting densities
ggplot(histdata_twoyears, aes(x=FertilityRate, group=Year, color=Year, alpha=0.2)) +
  geom_histogram(aes(y=..density..)) +
  geom_density(data=subset(histdata_twoyears, Year=="X1960"), color="darkred", fill="red", alpha=0.2, bw=5) +
  geom_density(data=subset(histdata_twoyears, Year=="X2000"), color="darkblue", fill="blue", alpha=0.2, bw=5)


##########
# Part 3 #
##########

rm(list = ls())
library(utils)

install.packages('plot3D')
library(plot3D)

M <- mesh(seq(0, 1, length=100), seq(0, 1, length=100))
x <- M$x
y <- M$y
z <- (6/5)*(M$x + M$y^2)

persp3D(x, y, z, xlab='X', ylab='Y', xlim=c(0,1), main='Plotting Joint PDF')


#Computing and Plotting CDF's
x <- seq(0, 1, length=1000)
y <- seq(0, 1, length=1000)
cdfx <- (6/5)*((1/3)*x + x^2/2)
cdfy <- (6/5)*((1/2)*y + y^3/3)

pdf("cumulative.pdf")
plot(x, cdfx, type="l", col="blue", xlab="", ylab="Cumulative Probability", xlim=c(0,1), main="CDF Plot")
lines(y, cdfy, lty=2, col="red", lwd=2)
legend("bottomright", ncol=1, legend=c("X","Y"), lty=c(1,2), col=c("blue","red"))
dev.off()
