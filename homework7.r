# Preliminaries
#-------------------------------------------------
#install.packages('perm')
library(perm)
rm(list = ls())

# Fisher
#-------------------------------------------------

#permutations in a matrix
perms <- chooseMatrix(8, 4)
#observed values in treated [0,1,0,0,0,1,1,1]
A <- matrix(c(0.462, 0.731, 0.571, 0.923, 0.333, 0.750, 0.893, 0.692), nrow=8, ncol=1, byrow=TRUE)
treatment_avg <- (1/4)*perms%*%A
control_avg <- (1/4)*(1-perms)%*%A
test_statistic <- abs(treatment_avg-control_avg)
rownumber <- apply(apply(perms, 1, 
                         function(x) (x == c(0, 1, 0, 0, 0, 1, 1, 1))), 
                   2, sum)
rownumber <- (rownumber == 8)
observed_test <- test_statistic[rownumber == TRUE]

#number of test statistics greater or equal the statistic observed
larger_than_observed <- (test_statistic >= observed_test)
sum(larger_than_observed)

df <- data.frame(perms, control_avg, treatment_avg, test_statistic)

# Fisher, large number (simulation by random instead of permutation)
#-------------------------------------------------
simul_stat <- as.vector(NULL)
schools <- read.csv('teachers_final.csv')
set.seed(1001)
for(i in 1:1000) {
  print(i)
  schools$rand <- runif(100,min=0,max=1)
  schools$treatment_rand <- as.numeric(rank(schools$rand)<=49)
  schools$control_rand = 1-schools$treatment_rand
  simul_stat <-append(simul_stat,
            sum(schools$treatment_rand*schools$open)/sum(schools$treatment_rand) 
            - sum(schools$control_rand*schools$open)/sum(schools$control_rand))
}

schools$control = 1-schools$treatment
actual_stat <- sum(schools$treatment*schools$open)/sum(schools$treatment) - sum(schools$control*schools$open)/sum(schools$control)
sum(abs(simul_stat) >= actual_stat)/NROW(simul_stat)
#the result it's near to zero, so we need Neyman's

# Neyman
#---------------------------------------------------
#Printing the ATE
ate <- actual_stat
ate

control_mean <- sum(schools$control*schools$open)/sum(schools$control)
treatment_mean <- sum(schools$treatment*schools$open)/sum(schools$treatment)

#sample variances for treatment and control
s_c <- (1/(sum(schools$control)-1))*sum(((schools$open-control_mean)*schools$control)^2)
s_t <- (1/(sum(schools$treatment)-1))*sum(((schools$open-treatment_mean)*schools$treatment)^2)

#formula to get neyman variance
Vneyman <- (s_c/sum(schools$control) + s_t/sum(schools$treatment))
print(sqrt(Vneyman))

#t-statistic
print(actual_stat/sqrt(Vneyman))
t_stat <- actual_stat/sqrt(Vneyman)

#p-value
print(2 * (1 - pnorm(t_stat))) #near to zero

#confident interval for 95%
print(actual_stat-1.96*sqrt(Vneyman))
print(actual_stat+1.96*sqrt(Vneyman))


### Plotting Kernel Regression ###
# (using np, ggplot doesn't have kernel regression)
#install.packages('np')
library(np)
bw_004 = npreg(xdat=schools$open, ydat=schools$pctpostwritten, bws = 0.04)
plot(bw_004)
bw_0001 = npreg(xdat=schools$open, ydat=schools$pctpostwritten, bws = 0.001)
plot(bw_0001)
bw_1 = npreg(xdat=schools$open, ydat=schools$pctpostwritten, bws = 1)
plot(bw_1)
bw_20 = npreg(xdat=schools$open, ydat=schools$pctpostwritten, bws = 20)
plot(bw_20)


### Plotting CDFs to know FSD ###
#CDF: cumulative density function
#FSD: first stochastic dominate
library(tidyverse)

#Incorrect way
cdf_treatment = ecdf(schools$treatment*schools$teacherscore)
cdf_control = ecdf(schools$control*schools$teacherscore)
#plot(cdf_treatment, col='blue')
plot.ecdf(schools$treatment*schools$teacherscore, col='blue')
lines(cdf_control, col='red')

#Correct way
schools$group[schools$treatment==1] <-"T"
schools$group[schools$treatment==0] <-"C"
ggplot(schools, aes(pctpostwritten,colour = group)) + stat_ecdf()
