rm(list = ls()) #cleaning up
library(utils)
library(tidyverse)

data <- as.tibble(read.csv("demo.csv"))
model <- lm(GDP ~ FHouse, data=data)

ggplot(data, aes(x = FHouse, y = GDP)) +
  geom_point()+
  geom_smooth(method='lm')

predict(model, data.frame(FHouse=c(3)))
summary(model)

##### conditional expectations: E[GDP|FHouse=fh] ####
cond_exp <- c()
for(fh in c(sort(unique(data$FHouse)))){
  cond_exp <- c(cond_exp, mean(data$GDP[data$FHouse==fh]) )
}
cond_exp

#### plotting them
fh <- sort(unique(data$FHouse))
means <- data.frame(fh, cond_exp)
ggplot(data, aes(x = FHouse, y = GDP)) +
  geom_point()+
  geom_smooth(method='lm')+
  geom_point(data=means, aes(x=fh, y=cond_exp), color="green")

#### Change the model

model2 <- lm(GDP ~ FHouse + I(FHouse^2), data=data)

ggplot(data, aes(x = FHouse, y = GDP)) +
  geom_point()+
  geom_smooth(method='lm', formula= y ~ x + I(x^2))+
  geom_point(data=means, aes(x=fh, y=cond_exp), color="green")

predict(model2, data.frame(FHouse=c(3)))
summary(model2)

### differences
fh1 <- predict(model2, data.frame(FHouse=c(1)))
fh3 <- predict(model2, data.frame(FHouse=c(3)))

diff_fh_3_1 <- fh3 - fh1

fh4 <- predict(model2, data.frame(FHouse=c(4)))
fh6 <- predict(model2, data.frame(FHouse=c(6)))

diff_fh_6_4 <- fh6 - fh4
