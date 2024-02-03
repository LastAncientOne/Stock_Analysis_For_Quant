# Load necessary libraries
library(quantmod)
library(forecast)

# Define your stock symbol and date range
symbol <- "NVDA"  # Change this to your desired stock symbol
start <- as.Date("2020-01-01")
end <- as.Date("2024-01-01")

# Download stock data
getSymbols(symbol, from = start, to = end, auto.assign = TRUE)

# Extract the closing prices from the stock data
closing_prices <- Cl(get(symbol))

# Convert returns to time series
closing_ts <- ts(closing_prices, start = start, frequency = 252)

# Calculate the simple moving average (SMA)
window_size <- 20  # You can adjust this value based on your preference
sma <- SMA(closing_ts, n = window_size)

# Forecast using the last value of the SMA
forecast_period <- 100  # Number of periods to forecast
forecast_values <- rep(tail(sma, 1), forecast_period)

# Plot the original closing prices, the SMA, and the forecasted values
plot(closing_ts, main = paste("Stock Price and", window_size, "Days SMA"))
lines(sma, col = "red")

# Add a line for forecasted values
forecast_dates <- seq(tail(index(closing_ts), 1), by = 1, length.out = forecast_period)
lines(forecast_dates, forecast_values, col = "blue", lty = 2)

# Print the forecasted values
cat("Forecasted Values:", forecast_values, "\n")

