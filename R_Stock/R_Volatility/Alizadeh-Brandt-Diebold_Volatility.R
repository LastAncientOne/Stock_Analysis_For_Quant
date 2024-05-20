# Load the required library
library(quantmod)

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the historical data
getSymbols(symbol, from = start_date, to = end_date)

# Calculate daily simple returns
returns <- Delt(Cl(AAPL))

# Drop NA values
returns <- returns[!is.na(returns)]

# Number of observations
N <- length(returns)

# Time lag vector
tau <- 1:N

# Calculate the mean return
mean_return <- mean(returns)

# Calculate ABD volatility estimate
ABD_volatility <- sum((1/tau) * (returns - mean_return)^2) / N

# Print the ABD volatility estimate
print(ABD_volatility)
