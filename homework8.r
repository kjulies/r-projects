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

##########
# Part 3 #
##########
# Testing: log(wage_i) = b_0 + b_1*yrs_school + b_2*ttl_exp + error_i
#
fit3 <- lm(lwage~yrs_school+ttl_exp, data=data)
r2 <- summary(fit3)$r.squared
print(r2) # tell us: 26.7% of the total variance in the logarithm of the wage
          # is explained by the years of schooling and the total experience

# Testing:
#
# Years school counts double over total experience, so:  2*b_1 = b_2
#
# Restricted model:  log(wage_i) = b_0 + b_1*(yrs_school + 2*ttl_exp) + error_i
#
data$yrs_exp <- data$yrs_school+ 2*data$ttl_exp
restricted_fit3 <- lm(lwage~yrs_exp, data=data)
summary(restricted_fit3) # so, b_1 will value 0.026292

# Use 'anova' to calculate ((SSR_r - SSR_u)/r) / (SSR_u/(n - k - 1))
anova_rest = anova(restricted_fit3) #gives us: SSR, SST, degrees freedom, F value, p-value, ...
anova_unrest = anova(fit3)

SSR_r <- anova_rest$`Sum Sq`[2]
SSR_u <- anova_unrest$`Sum Sq`[3]
n_minus_k_plus_1 <- anova_unrest$Df[3] #be careful, it's not counting k+1
f_test_statistic <- ((SSR_r - SSR_u)/r) / (SSR_u/(n_minus_k_plus_1))
f_test_statistic
p_value <- df(f_test_statistic, df1 = 1, df2 = n_minus_k_plus_1)
p_value
