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
indiv_final$positive_difshare <- as.numeric(indiv_final$difshare > 0)
mean(indiv_final$positive_difshare)

DCdensity(indiv_final$difshare, ext.out=TRUE)
# Difference in the log estimate in heights at the cutpoint?
#   ext.out=TRUE to see all the calculated values.
#   log estimate = theta = -0.002470001
#
#   p-value = 0.9620681   so we CAN'T reject the null (difference in cutoff is 0)


# keep only the observations within 50 percentage points of the cutoff
#    this means diffshare between -0.5 and 0.5 (cutoff is 0 by default)
subset_indiv_final = subset(indiv_final,  -0.5 < difshare & difshare < 0.5)
DCdensity(subset_indiv_final$difshare, ext.out=TRUE)

# create models to test
model1 = lm(myoutcomenext ~ positive_difshare, 
                            data=subset_indiv_final)

model2 = lm(myoutcomenext ~ positive_difshare + difshare, 
                            data=subset_indiv_final)

model3 = lm(myoutcomenext ~ positive_difshare + difshare + positive_difshare*difshare, 
                            data=subset_indiv_final)

model4 = lm(myoutcomenext ~ positive_difshare + difshare + I(difshare^2), 
                            data=subset_indiv_final)

model5 = lm(myoutcomenext ~ positive_difshare + difshare + I(difshare^2) + 
                            positive_difshare*difshare + positive_difshare*I(difshare^2), 
                            data=subset_indiv_final)

model6 = lm(myoutcomenext ~ positive_difshare + 
                            difshare + I(difshare^2)+ I(difshare^3), 
                            data=subset_indiv_final)

model7 = lm(myoutcomenext ~ positive_difshare + 
                            difshare + I(difshare^2)+ I(difshare^3) + 
                            positive_difshare*difshare + positive_difshare*I(difshare^2) + positive_difshare*I(difshare^3), 
                            data=subset_indiv_final)

# From model1 to model4 we see the effects of positive_difshare is greater than 0.6
# All the models has a p-value (on positive_difshare) < 0.001 so we can reject the null at 99% level.
#   This means we cannot say there's no effect between positive_difshare and the outcome