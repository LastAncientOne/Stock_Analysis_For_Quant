# sma() - Simple Moving Average in state-space form;
# Load the required libraries
library(quantmod)
library(smooth)

# Define your stock symbol and date range
symbol <- "NVDA"  # Change this to your desired stock symbol
start <- "2020-01-01"
end <- "2023-10-11"

# Download stock data
getSymbols(symbol, from = start, to = end)

# Extract the stock price data
stock_data <- Ad(get(symbol))

# Calculate the Simple Moving Average
# You can choose your desired period for the SMA
sma_period <- 10  # Set the period for the SMA (adjust as needed)
sma_values <- sma(stock_data, n = sma_period)

# Plot the SMA
plot(stock_data, type = "l", col = "blue", main = paste("Simple Moving Average (", sma_period, ")", sep = ""))
lines(sma_values, col = "red")

# Optionally, you can generate a forecast for a specific number of periods
# Note that SMA is not a forecasting method, so this part is not necessary for SMA
forecast_values <- forecast(sma_values, h = 10)
print(forecast_values)
