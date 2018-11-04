rm(list = ls()) #cleaning up
library(utils)
library(tidyverse)

data <- read.csv("nlsw88.csv")

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