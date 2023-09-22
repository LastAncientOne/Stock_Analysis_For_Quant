# Load necessary libraries
library(quantmod)
library(ggplot2)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate EMA
ema_period <- 14
Stock$EMA <- EMA(Stock$AAPL.Close, n = ema_period)

# Create separate charts for Closing Price and EMA
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

ema_chart <- ggplot(Stock, aes(x = index(Stock), y = EMA)) +
  geom_line(color='blue') +
  labs(title = "Exponential Moving Average (EMA)",
       x = "Date",
       y = "EMA")

# Arrange charts using grid
library(gridExtra)
grid.arrange(closing_price_chart, ema_chart, ncol = 1)

