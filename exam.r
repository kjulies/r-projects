rm(list = ls()) #cleaning up
library(tidyverse)

df5=data.frame()
for (i in 1:10000){
  df5<-rbind(df5,rexp(5,2))
}
df5$mean<-rowMeans(df5,na.rm=TRUE,dims=1)

ggplot(df5, aes(mean))+
  geom_histogram(data=df5, aes(mean, ..density..), binwidth = 0.01)

mean(df5$mean)

##############1###################
df1=data.frame()
for (i in 1:10000){
  df1<-rbind(df1,rexp(1,2))
}
df1$mean<-rowMeans(df1,na.rm=TRUE,dims=1)

ggplot(df1, aes(mean))+
  geom_histogram(data=df1, aes(mean, ..density..), binwidth = 0.01)

mean(df1$mean)

##############10###################
df10=data.frame()
for (i in 1:10000){
  df10<-rbind(df10,rexp(10,2))
}
df10$mean<-rowMeans(df10,na.rm=TRUE,dims=1)

ggplot(df10, aes(mean))+
  geom_histogram(data=df10, aes(mean, ..density..), binwidth = 0.01)

mean(df10$mean)

##############30###################
df30=data.frame()
for (i in 1:10000){
  df30<-rbind(df30,rexp(30,2))
}
df30$mean<-rowMeans(df30,na.rm=TRUE,dims=1)

ggplot(df30, aes(mean))+
  geom_histogram(data=df30, aes(mean, ..density..), binwidth = 0.01)

mean(df30$mean)

##### same graph #####
df = data.frame("X1"  = df1$mean,
                "X5"  = df5$mean,
                "X10" = df10$mean,
                "X30" = df30$mean)
mean(df1$mean)
mean(df5$mean)
mean(df10$mean)
mean(df30$mean)

ggplot(df)+
  geom_histogram(data=df1, aes(mean, ..density..), color="red", binwidth = 0.01)+
  geom_histogram(data=df5, aes(mean, ..density..), color="orange", binwidth = 0.01)+
  geom_histogram(data=df10, aes(mean, ..density..), color="yellow", binwidth = 0.01)+
  geom_histogram(data=df30, aes(mean, ..density..), color="green", binwidth = 0.01)
  