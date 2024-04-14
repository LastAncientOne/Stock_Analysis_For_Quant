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

# Calculate the daily returns
returns <- dailyReturn(data$AAPL.Close)

# Calculate the Close-to-Close Volatility
close_to_close_volatility <- sd(returns, na.rm = TRUE) * sqrt(252) # Assuming 252 trading days in a year

# Print the Close-to-Close Volatility
print(close_to_close_volatility)

