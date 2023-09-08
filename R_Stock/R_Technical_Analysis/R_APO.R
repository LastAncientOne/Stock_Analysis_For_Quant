# Load necessary libraries
library(quantmod)
library(ggplot2)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Absolute Price Oscillator (APO)
short_period <- 12
long_period <- 26
Stock$EMA_short <- EMA(Stock$AAPL.Close, n = short_period)
Stock$EMA_long <- EMA(Stock$AAPL.Close, n = long_period)
Stock$APO <- Stock$EMA_short - Stock$EMA_long

# Create separate charts for Closing Price and APO
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

apo_chart <- ggplot(Stock, aes(x = index(Stock), y = APO)) +
  geom_line(color='blue') +
  labs(title = "Absolute Price Oscillator (APO)",
       x = "Date",
       y = "APO")

# Arrange charts using grid
library(gridExtra)
grid.arrange(closing_price_chart, apo_chart, ncol = 1)
