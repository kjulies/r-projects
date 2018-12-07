rm(list = ls()) #cleaning up
library(utils)
library(tidyverse)

gender_data <- as.tibble(read.csv("olken.csv"))

ggplot(gender_data, aes(x=head_edu, color=factor(treat_invite))) +
  geom_density()

ggplot(gender_data, aes(x=mosques, color=factor(treat_invite))) +
  geom_density()

ggplot(gender_data, aes(x=pct_poor, color=factor(treat_invite))) +
  geom_density()

ggplot(gender_data, aes(x=total_budget, color=factor(treat_invite))) +
  geom_density()

###########
ggplot(gender_data, aes(x=pct_missing, color=factor(treat_invite))) +
  geom_density()

#sample means
tmean_missing <- mean(gender_data$pct_missing[gender_data$treat_invite==1])
cmean_missing <- mean(gender_data$pct_missing[gender_data$treat_invite==0])

avg_treatment_effect <- tmean_missing - cmean_missing

#######
tsize = length(gender_data$pct_missing[gender_data$treat_invite==1])
csize = length(gender_data$pct_missing[gender_data$treat_invite==0])
#sample variances
tvar_missing = var(gender_data$pct_missing[gender_data$treat_invite==1])
cvar_missing = var(gender_data$pct_missing[gender_data$treat_invite==0])

std_err_neyman = sqrt( tvar_missing/tsize + cvar_missing/csize )

##### t-statistic ######
t = avg_treatment_effect / std_err_neyman

###### p-value #########
p_value = 2 * pnorm(abs(t), lower.tail = FALSE)
