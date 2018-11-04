# Unrestricted: y = b_0 + b_1*x_1 + b_2*x_2 + b_3*x_3 + b_4*x_4
# Restricted:   y = b_0 + b_3*x_3 + b_4*x_4
#
# Testing: 
#
# H_0:             b_1 = b_2 = 0   <= null hyphotesis
# H_Alternative:   b_1 != 0 or b_2 != 0

# We are given this data
SSR_R <- 198.3 #sum squares residual for restricted
SSR_U <- 183.2 #sum squares residual for unrestricted
alpha <- 0.05
r = 2 #restrictions (dropped coeficients)
n = 500 #observations
k = 4 #number of coeficients of regressors (b_0 or intercept is not counted here)

# This test is one-sided hypotheses, so only one tail
F_critical_value = qf(alpha, r, n-(k+1), lower.tail = FALSE)
F_statistic = ((SSR_R - SSR_U)/r)/(SSR_U/(n-(k+1)))

print(F_critical_value)
print(F_statictic)

if (F_stat > F_critical_value){
  print("Reject de null hyphotesis")
}else{
  print("No reject de null hyphotesis")
}

