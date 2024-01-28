# Load necessary libraries
library(tidyquant)
library(prophet)

# Define your stock symbol and date range
symbol <- "NVDA"  # Change this to your desired stock symbol
start <- as.Date("2022-01-01")
end <- as.Date("2024-01-01")

# Create a tibble with closing prices
stock_data <- tq_get(symbol, from = start, to = end, get = "stock.prices")

# Rename columns to meet Prophet's requirements
stock_data <- stock_data %>%
  rename(ds = date, y = adjusted)

# Initialize and fit the Prophet model
model <- prophet()
model <- add_seasonality(
  model,
  name = "yearly",
  period = 365.25,
  fourier.order = 10
)

# Fit the model
model <- fit.prophet(model, stock_data)

# Create a dataframe with future dates for prediction
future <- make_future_dataframe(model, periods = 365)

# Generate forecasts
forecast <- predict(model, future)

# Plot the forecast
plot(model, forecast)



