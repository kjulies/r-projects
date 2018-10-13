#
# Shipment of 100 packets; shipment is denied if more than 5 packets are wrong.
# K is number of packets to check (randomly) in shipment = sample.
# Shipment is accepted if no wrong packets are found in the sample.
# Find K where P(bad shipment is accepted) < 0.1
#
for (k in c(2:100)){
  p <- choose(6, 0)*choose(94, k)/choose(100, k)
  if ( p <= 0.1){
    print(paste("k:", k, " and p:", p))
    break
  }
}

# Now shipment is accepted if there is at most 1 wrong packet in the sample
for (k in c(2:100)){
  p <- choose(6, 1)*choose(94, k-1)/choose(100, k)
  if ( p <= 0.1){
    print(paste("k:", k, " and p:", p))
    break
  }
}

#
# Let the number of chocolate chips in a certain type of cookie have a Poisson distribution.
# Probability that a randomly chosen cookie has at least 2 chocolate chips > 0.99
# Find the possible values of mean in 6,7,8 or 9 to assure that.
for (lambda in c(6,7,8,9)){
  p <- 1 - lambda^0 * exp(-lambda) / factorial(0) - lambda^1 * exp(-lambda) / factorial(1)
  print(paste("lambda: ",lambda, " p:", p))
}

# Another way
for (lambda in c(6,7,8,9)){
  p <- ppois(1, lambda = lambda, lower = FALSE)
  print(paste("lambda: ",lambda, " p:", p))
}
