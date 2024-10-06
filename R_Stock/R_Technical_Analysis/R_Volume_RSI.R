# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)  # For the RSI function

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate RSI for Volume
rsi_period <- 14
Stock$RSI <- RSI(Stock$AAPL.Volume, n = rsi_period)

# Create separate charts for Closing Price and RSI
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

rsi_chart <- ggplot(Stock, aes(x = index(Stock), y = RSI)) +
  geom_line(color='red') +
  labs(title = "Volume RSI",
       x = "Date",
       y = "RSI")

# Arrange charts using grid
grid.arrange(closing_price_chart, rsi_chart, ncol = 1)
