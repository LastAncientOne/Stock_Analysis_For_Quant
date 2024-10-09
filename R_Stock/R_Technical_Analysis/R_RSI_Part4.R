# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate RSI
rsi_period <- 14
Stock$RSI <- RSI(Stock$AAPL.Close, n = rsi_period)

# Create separate charts for Closing Price and RSI

# Closing Price Chart
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# RSI Chart with annotations and shaded region
rsi_chart <- ggplot(Stock, aes(x = index(Stock), y = RSI)) +
  geom_line(color = 'red') +
  geom_text(aes(x = as.Date(index(Stock)[30]), y = 70, label = 'Overbought'), size = 4, hjust = 0) +
  geom_text(aes(x = as.Date(index(Stock)[30]), y = 30, label = 'Oversold'), size = 4, hjust = 0) +
  geom_ribbon(aes(ymin = 30, ymax = 70), fill = '#adccff', alpha = 0.30) +
  labs(title = "RSI",
       x = "Date",
       y = "RSI")

# Arrange charts using grid
grid.arrange(closing_price_chart, rsi_chart, ncol = 1)
