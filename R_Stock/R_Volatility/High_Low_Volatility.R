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

# Define thresholds for high and low volatility (for example, 1 standard deviation above and below the mean)
high_volatility_threshold <- mean(returns, na.rm = TRUE) + daily_volatility
low_volatility_threshold <- mean(returns, na.rm = TRUE) - daily_volatility

# Check if daily returns exceed high or low volatility thresholds
high_volatility_days <- returns[returns > high_volatility_threshold]
low_volatility_days <- returns[returns < low_volatility_threshold]

# Count the number of days with high and low volatility
num_high_volatility_days <- length(high_volatility_days)
num_low_volatility_days <- length(low_volatility_days)

# Print the number of days with high and low volatility
cat("Number of high volatility days:", num_high_volatility_days, "\n")
cat("Number of low volatility days:", num_low_volatility_days, "\n")

# Calculate the standard deviation of daily returns
volatility <- sd(returns, na.rm = TRUE)

# Print the calculated volatility
cat("Volatility for", symbol, "is:", volatility, "\n")

# Define thresholds for high and low volatility (you can adjust these thresholds as needed)
high_vol_threshold <- 0.03  # For example, 3%
low_vol_threshold <- 0.01   # For example, 1%

# Compare volatility to the thresholds
if (volatility > high_vol_threshold) {
  cat("High volatility detected for", symbol, "\n")
} else if (volatility < low_vol_threshold) {
  cat("Low volatility detected for", symbol, "\n")
} else {
  cat("Medium volatility detected for", symbol, "\n")
}
