#preliminaries
rm(list = ls())
setwd("")

#Real value of theta
theta <- 5
#sample size
n <- 25

#Generating 1000 samples of size n
simul <- 1000
sample <- matrix(runif(1000*n, max = theta), 
                 nrow = n)

thetahat <- (n+1)/n*apply(sample, 2, max)

ll <- thetahat/(0.95^(1/n)*(n+1)/n)
ul <- thetahat/(0.05^(1/n)*(n+1)/n)
thetain <- (thetahat>=ll & theta<=ul)
mean(thetain)
