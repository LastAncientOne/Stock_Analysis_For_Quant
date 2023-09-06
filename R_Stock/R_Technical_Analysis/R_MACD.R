# Load necessary libraries
library(quantmod)
library(ggplot2)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate MACD
Stock$EMA12 <- EMA(Stock$AAPL.Close, n = 12)
Stock$EMA26 <- EMA(Stock$AAPL.Close, n = 26)
Stock$MACD <- Stock$EMA12 - Stock$EMA26
Stock$Signal <- EMA(Stock$MACD, n = 9)

# Create separate charts for Closing Price and MACD
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

macd_chart <- ggplot(Stock, aes(x = index(Stock))) +
  geom_line(aes(y = MACD), color = 'blue', linetype = 'solid') +
  geom_line(aes(y = Signal), color = 'red', linetype = 'dashed') +
  labs(title = "MACD",
       x = "Date",
       y = "MACD") +
  scale_y_continuous(sec.axis = sec_axis(~., name = "Signal"))

# Arrange charts using grid
library(gridExtra)
grid.arrange(closing_price_chart, macd_chart, ncol = 1)

