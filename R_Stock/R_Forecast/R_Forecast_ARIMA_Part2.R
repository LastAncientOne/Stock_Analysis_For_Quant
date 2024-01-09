# Load necessary libraries
library(quantmod)
library(forecast)

# Define your stock symbol and date range
symbol <- "NVDA"
start <- "2021-01-01"
end <- "2023-10-11"

# Download stock data
getSymbols(symbol, from = start, to = end)

# Extract the closing prices from the stock data
closing_prices <- Ad(get(symbol))

# Check if the data looks correct
head(closing_prices)

# Perform a basic check for stationarity using ADF test
adf_test <- adf.test(closing_prices)
print(adf_test)

# If the data is non-stationary, consider differencing:
# closing_prices_diff <- diff(closing_prices)
# adf_test_diff <- adf.test(closing_prices_diff)
# print(adf_test_diff)

# Fit an ARIMA model to the closing prices
arima_model <- auto.arima(closing_prices)

# Print the summary of the ARIMA model
summary(arima_model)

# Make forecasts
forecast_values <- forecast(arima_model, h = 10)  # Change the number of periods as needed

# Print the forecasts
print(forecast_values)

# Plot the forecast
plot(forecast_values, main = "ARIMA Forecast for NVDA Stock", xlab = "Date", ylab = "Price")
