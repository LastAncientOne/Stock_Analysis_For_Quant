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

# Calculate the daily standard deviation of returns
daily_sd <- sd(returns, na.rm = TRUE)

# Calculate the annualized volatility
trading_days_per_year <- 252  # Assuming 252 trading days in a year
annualized_volatility <- daily_sd * sqrt(trading_days_per_year)

# Print the annualized volatility
print(annualized_volatility)
