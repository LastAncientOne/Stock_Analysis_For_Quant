# Load necessary libraries
library(quantmod)
library(TSA)# install.packages("TSA", type = "binary")
library(forecast)

# Define your stock symbol and date range
symbol <- "NVDA"  # Change this to your desired stock symbol
start <- as.Date("2020-01-01")
end <- as.Date("2024-01-01")

# Download stock data
getSymbols(symbol, from = start, to = end, auto.assign = TRUE)

# Extract the closing prices from the stock data
closing_prices <- Cl(get(symbol))

# Calculate returns
returns <- Delt(closing_prices)

# Convert returns to time series
returns_ts <- ts(returns, start = start, frequency = 252) 
# Fit an ARIMA model
arima_model <- Arima(returns_ts)

# Print the ARIMA model summary
summary(arima_model)

# Forecast future returns
forecast_values <- forecast(arima_model, h = 10)  # You can adjust the 'h' parameter as needed

# Print the forecast
print(forecast_values)

