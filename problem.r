rm(list=ls())

# [1]
# a) Unfair coin and you flip 8 times. Probability heads is 0.4. What's the probability to have 2 heads?
# b) 8 athletes to compete in Olympic Games. Probability of making the final race is 0.4. What's the probability that 2 athletes make it into the final race?
dbinom(2,8,0.4)

# [2]
# a) Expectation number of heads
# b) Expectation number of athletes that make it into the finals

# E[Successes|N = 8] = n*p
E_successes_n_8 = 8*0.4

# [3]
# Supose E[N]=2 and var(N)=1.5
E_n = 2
Var_n = 1.5

# a) What is the expectation of the number of heads?
# b) What is the expectation of the number of swimmers that make it to the final?

# E[successes] = E[E[successes|N]] -> expectation of expectation of conditional
# E[E[successes|N = n]] = E[N*p] = 0.4*E[N] =>
E_successes = 0.4*E_n

# a) What is the variance of the number of heads?
# b) What is the variance of the number of swimmers that make it to the final?

# Var(success) = Var(E[successes|N]) + E[Var(successes|N)]
# we know of binomial:
#       E[successes|N] = n*p
#       Var(sucesses|N) = n*p*(1-p)
#
# so we get => Var(N*p) + E[N*p*(1-p)] => p^2*Var(N) + p*(1-p)*E[N]
Var_successes = 0.4^2*Var_n + 0.4*(1 - 0.4)*E_n
