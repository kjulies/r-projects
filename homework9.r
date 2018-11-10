# clean
rm(list = ls())

#setwd("Desktop/projects/r-projects/")

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
# avg starting wage (state=1) = 4.62863 + 1*(-0.02123) = 4.60707