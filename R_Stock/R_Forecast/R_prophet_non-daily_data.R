# Load necessary libraries
library(tidyquant)
library(prophet)
library(dplyr)  # Add this line to load dplyr

# Uncertainty in seasonality
# Define your stock symbol and date range
symbol <- "NVDA"  # Change this to your desired stock symbol
start <- as.Date("2020-01-01")
end <- as.Date("2024-01-01")

# Create a tibble with closing prices
stock_data <- tq_get(symbol, from = start, to = end)

# Convert stock_data to required format for prophet
stock_data <- stock_data %>%
  rename(ds = date, y = adjusted)

m <- prophet(stock_data, seasonality.mode = 'multiplicative')
future <- make_future_dataframe(m, periods = 3652, freq = 'day')
fcst <- predict(m, future)
plot(m, fcst)

prophet_plot_components(m, fcst)

# Month
future <- make_future_dataframe(m, periods = 120, freq = 'month')
fcst <- predict(m, future)
plot(m, fcst)