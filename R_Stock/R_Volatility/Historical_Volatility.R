# Load the required libraries
library(quantmod)

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the historical data
getSymbols(symbol, from = start_date, to = end_date)
data <- get(symbol)

# Calculate the daily returns
returns <- dailyReturn(data$AAPL.Close)

# Number of periods (n) for future volatility calculation
future_n <- 21  # You can adjust this value as needed

# Calculate historical volatility (standard deviation of returns)
historical_volatility <- sqrt(rollapply(returns^2, future_n, mean, align = "right", fill = NA, na.rm = TRUE))

# Drop NA values
historical_volatility <- na.omit(historical_volatility)

# View historical volatility
print(historical_volatility)

# Print the last value of historical volatility as an estimate for future volatility
print(tail(historical_volatility, 1))
