?rbinom
n <- 1000 #number of observations

#binomial distribution
successes <- rbinom(n, 8, 0.2)

#plotting histogram
hist(successes)

