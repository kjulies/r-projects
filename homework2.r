?rbinom
n <- 1000 #number of observations
p <- 0.2 #probability of success

#create random binomial distribution of [0,1,...,7] scores
scores <- rbinom(n, 8, p)

#plotting histogram
hist(scores)

#Unfair coin with P(heads) = 0.65, 10 tosses
#10 trials, exactly 7 heads
dbinom(7, 10, 0.65) #using density function

#10 trials, at most 7 heads
pninom(7, 10, 0.65) #cumulative probs, using distribution function

#10 trials, at least 6 heads
# density 6 heads + density 7 heads + ... + density 10 heads
dbinom(6, 10, 0.65)+dbinom(7, 10, 0.65)+dbinom(8, 10, 0.65)+dbinom(9, 10, 0.65)+dbinom(10, 10, 0.65)
#or cumulative of 10 heads - cumulative 5 heads
pbinom(10, 10, 0.65) - pbinom(5, 10, 0.65)


#Plotting better the previous hist(scores) using densities
library(tidyverse)
df <- as_tibble(data.frame(scores))
df_with_freqs <- df %>% 
                 group_by(scores) %>%
                 summarize(n=n()) %>%
                 mutate(freq= n/sum(n))

ggplot(df_with_freqs, aes(x=scores, y=freq)) + geom_col() + ylab("Estimated Density")

#Plotting analytical densities in binominal distribution
binom <- as_tibble(list(x=0:n, prob= dbinom(0:n, n, p)))
ggplot(binom, aes(x=x, y=prob)) + geom_col() + ylab("Analytical Density")

#Computing the cumulative density function using previous probability density function
df_with_cdf <- binom %>%
               mutate(cdf=cumsum(prob))
ggplot(df_with_cdf, aes(x=x, y=cdf)) + geom_step() + ylab("CDF")

#Plotting histogram and density with ggplot
ggplot(binom, aes(x))+
  geom_histogram(data=binom, aes(x, ..density..), fill="white", color="darkred")+
  geom_density(kernel="gaussian", aes(x))
