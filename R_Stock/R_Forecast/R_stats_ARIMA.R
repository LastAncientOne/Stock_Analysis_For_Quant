# Load necessary libraries
library(quantmod)
library(stats)

# Define your stock symbol and date range
symbol <- "NVDA"  # Change this to your desired stock symbol
start <- as.Date("2022-01-01")
end <- as.Date("2024-01-01")

# Download stock data
getSymbols(symbol, from = start, to = end, auto.assign = TRUE)

# Extract the closing prices from the stock data
closing_prices <- Cl(get(symbol))

# Convert closing_prices to a numeric vector
closing_prices_numeric <- as.numeric(closing_prices)

# Fit an autoregressive model
arima_model <- arima(closing_prices_numeric)

# Forecast future prices using the AR model
forecast_values <- predict(arima_model, n.ahead = 100)  # Change 100 to your desired number of days ahead

# Create a sequence of future dates
future_dates <- seq.Date(max(index(closing_prices)) + 1, length.out = 100, by = "days")  # Adjust the length as needed

# Plot closing prices
plot(index(closing_prices), closing_prices_numeric, type = "l", col = "blue", lwd = 2, xlab = "Date", ylab = "Closing Prices", main = "Closing Prices and Forecast Values")

# Add forecast values to the plot
lines(future_dates, forecast_values$pred, col = "red", lty = 2, lwd = 2)

# Add legend
legend("topleft", legend = c("Closing Prices", "Forecast Values"), col = c("blue", "red"), lty = c(1, 2), lwd = 2)
