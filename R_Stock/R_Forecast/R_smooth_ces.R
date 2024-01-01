# ces() - Complex Exponential Smoothing;
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

# Perform Complex Exponential Smoothing (CES)
# You can choose your desired smoothing parameters (alpha, beta, gamma) and method
alpha <- 0.2  # Smoothing parameter (adjust as needed)
beta <- NULL  # Smoothing parameter (set to NULL for simple exponential smoothing)
gamma <- NULL  # Smoothing parameter (set to NULL for simple exponential smoothing)

# Fit the CES model
ces_model <- ces(stock_data, alpha = alpha, beta = beta, gamma = gamma)

# Plot the results
plot(ces_model)

# Generate a forecast for a specific number of periods (e.g., 10 periods)
forecast_values <- forecast(ces_model, h = 10)
print(forecast_values)


