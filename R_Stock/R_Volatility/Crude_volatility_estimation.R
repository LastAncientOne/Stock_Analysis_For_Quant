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

# Calculate the daily volatility (standard deviation of returns)
daily_volatility <- sd(returns, na.rm = TRUE)

# Given data
average_daily_movement <- daily_volatility
current_value_index <-  tail(data$AAPL.Adjusted, 1)

# Calculate daily percentage movement
daily_percentage_movement <- (average_daily_movement / current_value_index) * 100

# Apply the "rule of 16" to estimate annualized volatility
annualized_volatility <- daily_percentage_movement * 16

# Print the result
print(paste("Estimated annualized volatility based on the crude method:", annualized_volatility, "%"))
