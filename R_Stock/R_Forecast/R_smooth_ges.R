# ges() - Generalised Exponential Smoothing;
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

# Perform Generalized Exponential Smoothing (GES)
# You can choose your desired smoothing parameters (alpha, beta, gamma, phi) and method
alpha <- 0.2  # Smoothing parameter (adjust as needed)
beta <- NULL  # Smoothing parameter (set to NULL for simple exponential smoothing)
gamma <- NULL  # Smoothing parameter (set to NULL for simple exponential smoothing)
phi <- 0.1    # Smoothing parameter for damping (adjust as needed)
method <- "GES"  # Generalized Exponential Smoothing method

# Fit the GES model
ges_model <- ges(stock_data, alpha = alpha, beta = beta, gamma = gamma, phi = phi, method = method)

# Plot the results
plot(ges_model)

# Generate a forecast for a specific number of periods (e.g., 10 periods)
forecast_values <- forecast(ges_model, h = 10)
print(forecast_values)
