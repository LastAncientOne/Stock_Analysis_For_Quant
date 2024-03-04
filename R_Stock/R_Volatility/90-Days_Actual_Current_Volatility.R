# Load required libraries
library(quantmod)
library(TTR)

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

# Calculate volatility for a specified period (e.g., 90 days)
period <- 90
current_volatility <- sd(returns[(length(returns) - period + 1):length(returns)]) * sqrt(252)  # Assuming 252 trading days in a year

# Print the current volatility
print(paste("Current volatility for", period, "days:", round(current_volatility, 4)))
