rm(list = ls()) #cleaning up
library(utils)
library(tidyverse)

data <- read.csv("nlsw88.csv")

##########
# Part 1 #
##########
# Testing: log(wage_i) = b_0 + b_1*years_school_i + error_i

# Modeling
fit <- lm(lwage~yrs_school, data=data)
summary(fit)
coefficients(fit)

# Confidence interval 90%
ci <- confint(fit, level=0.90)
ci

# Sum residuals
sum(residuals(fit)) # or sum(fit$residuals)

##########
# Part 2 #
##########
# Testing: log(wage_i) = b_0 + b_1*black_i + error_i
#
# We can deduce:
#   - E[wage|black=0] = b_0 + b_1*E[black=0] + E[error] = b_0 + b_1*0 + 0 = b_0
#   - E[wage|black=1] = b_0 + b_1*E[black=0] + E[error] = b_0 + b_1*1 + 0 = b_0 + b_1
#
# So:
#   - b_0 = E[wage_no_black]
#   - b_1 = E[wage_black] - b_0 = E[wage_black] - E[wage_no_black]
#
mean_no_black = mean(data$lwage[data$black == 0])
mean_black = mean(data$lwage[data$black == 1])

fit2 <- lm(lwage~black, data=data)
coefficients(fit2)
print(mean_no_black) #equals to intercept coefficient
print(mean_black-mean_no_black) #equals to black coefficient

# Hypothesis: black is not affecting the wages
#   - null hypothesis: b_1 = 0
#
# Using t-statistic = b_1/se(b_1)  - taken from summary
summary(fit2)
t_statistic <- -0.16554/0.02744

# Other:
anova(fit2) #gives us: SSR, SST, degrees freedom, F value, p-value, ...
