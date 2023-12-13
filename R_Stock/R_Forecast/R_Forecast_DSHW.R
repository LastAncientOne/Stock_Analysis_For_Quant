# Double-Seasonal Holt-Winters
# Load required libraries
library(quantmod)
library(forecast)
library(ggplot2)

# Define your symbol and time frame
symbol <- 'NVDA'
start <- '2018-01-01'
end <- '2023-08-01'

# Download stock data
getSymbols(symbol, from = start, to = end)
stock_data <- Ad(get(symbol))

# Convert stock data to a time series (assuming monthly data)
stock_ts <- ts(stock_data, frequency = 12)

# Perform forecasting using Double-Seasonal Holt-Winters (dshw)
dshw_model <- forecast::dshw(stock_ts)

# Define the forecast period
forecast_period <- 12  # Example: forecasting for the next 12 periods (adjust as needed)

# Forecast using dshw
forecast_result <- forecast::forecast(dshw_model, h = forecast_period)

# Plot the forecast
plot(forecast_result, main = paste(symbol, " Stock Price Forecast"))

# Add historical data in blue
lines(stock_ts, col = "blue", lwd = 2)

# Print the forecast result
print(forecast_result)

# Calculate accuracy measures for the forecast
accuracy_measures <- accuracy(forecast_result)

# Print the accuracy measures
print(accuracy_measures)

