# Load the required library
library(quantmod)

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the historical data
getSymbols(symbol, from = start_date, to = end_date)
data <- get(symbol)

# Calculate daily returns
returns <- dailyReturn(Cl(data))

# Calculate the mean return
mean_return <- mean(returns)

# Calculate squared differences
squared_diff <- (returns - mean_return)^2

# Sum up the squared differences
sum_squared_diff <- sum(squared_diff)

# Calculate the number of observations
T <- length(returns)

# Calculate close-to-close volatility
close_to_close_volatility <- sqrt(sum_squared_diff / (T - 1))

# Print the result
print(close_to_close_volatility)
