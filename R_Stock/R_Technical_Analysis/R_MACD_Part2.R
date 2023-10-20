# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate MACD
Stock$EMA12 <- EMA(Stock$AAPL.Close, n = 12)
Stock$EMA26 <- EMA(Stock$AAPL.Close, n = 26)
Stock$MACD <- Stock$EMA12 - Stock$EMA26

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for MACD
macd_chart <- ggplot(Stock, aes(x = index(Stock), y = MACD)) +
  geom_line(color = 'blue') +
  labs(title = "MACD",
       x = "Date",
       y = "MACD") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, macd_chart, ncol = 1)

