#Preliminaries
rm(list=ls())

#At an auction, bidders make offers to buy the goods,
#and a bidder's valuation is how much the bidder offers to pay for the good.

#Uniform Valuations
number_of_bidders <- 2
number_of_simulations <- 1000

set.seed(1)
valuations1 <- matrix(runif(
  number_of_bidders * number_of_simulations, min=0, max=1),
  nrow = number_of_simulations
)

# Defining a price
#
# expected profit = price * P(Valuation_bidder >= price for at least one bidder)
# P(V_bidder >= price) = 1 - CDF nth order statistic from U[0,1] evaluated at price
# CDF of uniform [0,1] = price^number_of_bidders

# expected_profit = price * (1 - price^number_of_bidders)
# optimal price: derivative of expected_profit, setting equal to 0 and solving for price
optimal_price <- (1/(number_of_bidders + 1))^(1/number_of_bidders)

# So expected, optimal profit will be
expected_optimal_profit = (number_of_bidders/(number_of_bidders + 1)) * optimal_price

###############
# Another way # (posted price)
###############

N <- number_of_bidders
V <- 1000

set.seed(5) #use another random seed
valuations<- matrix(runif(
  N * V, min=0, max=1),
  nrow = V
)

maximum_valuation <- apply(valuations, 1, max)
optimal_price <- 1/((N+1)^(1/N))
expected_revenue_posted <- (N/(N+1) * optimal_price)

revenue <- optimal_price * (maximum_valuation >= optimal_price)
mean(revenue)
expected_revenue_posted

###################
# English Auction #
###################

# last person wins the auction, so n-1st order statistic from U[0,1]
# f(x) = N*(N-1)*(1-x)*x^(N-2) and with integral of f(x) we obtain
expected_profit_auction <- (N-1)/(N+1)

####################
#    Comparison    #
####################
rank_of_valuations <- apply(valuations, 1, rank)
price_auction <- apply(valuations, 1, function(x)
(x[rank(x) == N - 1]))|
expected_revenue_auction <- (N-1)/(N+1)

mean(price_auction)
expected_revenue_auction
# IF N > 2, expected_profit_auction does better!!
