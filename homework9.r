# clean
rm(list = ls())

#setwd("Desktop/projects/r-projects/")

##########
# Part 1 #  Difference in Difference
##########  ========================

# load csv file
fastfood <- read.csv("fastfood.csv", header = TRUE, row.names = NULL)
fastfood

# linear model, average difference between fast-food restaurants located 
# in NJ and Pennsylvania in terms of the number of full-time employees 
model1 = lm(formula = empft ~ state, data = fastfood)
summary(model1) #avg diff = -2.6006

# Difference is not significant at 1% level because the p-value is 0.0188 (null hypothesis says 
# that this difference is 0) and it's greater than 0.01. So we CAN'T reject the null. But we do at 5%.

# same for partial employees
model2 = lm(formula = emppt ~ state, data = fastfood)
summary(model2)

# same with wages
model3 = lm(formula = wage_st ~ state, data = fastfood)
summary(model3)

# avg starting wage (state=0) = 4.62863
# avg starting wage (state=1) = b_0 + b_1*S = 4.62863 + (-0.02123)*1 = 4.60707
# Can we reject the null hypothesis that the avg starting wage is the same in state=1 and state=0?
#    To be the same, b_1 must be 0. So..
#    No, we CAN'T because the p-value of null hypothesis (when b_1 = 0) is 0.638 (big for typical confidence levels)


# taking into account pa1 y pa2 for full-time employment
model4 = lm(formula = empft ~ state + pa1 + pa2, data = fastfood)
summary(model4) #error, not estimable because state, pa1 and pa2 are collinear

# difference in difference
model5 = lm(formula = empft2 - empft ~ state , data = fastfood)
summary(model5) # DiD = 3.443


##########
# Part 2 #  Regression Discontinuity
##########  ========================

# clean
rm(list = ls())

#install.packages("rdd")
library(rdd)

# load csv file
indiv_final <- read.csv("indiv_final.csv", header = TRUE, row.names = NULL)

#if difshare > 0, then 1. Create dummy.
indiv_final$same <- as.numeric(indiv_final$difshare > 0)
DCdensity(indiv_final$difshare)
