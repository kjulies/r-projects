# a) Unfair coin and you flip 8 times. Probability heads is 0.4. What's the probability to have 2 heads?
# b) 8 athletes to compete in Olympic Games. Probability of making the final race is 0.4. What's the probability that 2 athletes make it into the final race?
dbinom(2,8,0.4)

# a) Expectation number of heads
# b) Expectation number of athletes that make it into the finals

# E[Successes|N = 8] = n*p
8*0.4
