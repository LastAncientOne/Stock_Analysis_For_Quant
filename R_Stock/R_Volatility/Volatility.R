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

# Calculate volatility using standard deviation
volatility <- sd(returns, na.rm = TRUE)

# Drop NA values
volatility <- na.omit(volatility)

# View historical volatility
print(volatility)

# Define thresholds for high and low volatility
high_vol_threshold <- 0.02  # For example, consider anything above 2% daily return as high volatility
low_vol_threshold <- 0.005  # For example, consider anything below 0.5% daily return as low volatility

# Days into high and low volatility based on these thresholds
high_volatility_days <- returns > high_vol_threshold
low_volatility_days <- returns < low_vol_threshold
