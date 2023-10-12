# Load necessary libraries
library(quantmod)
library(ggplot2)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Weighted Moving Average (WMA)
wma_period <- 14
weights <- seq(1, wma_period, by = 1)
Stock$WMA <- sapply(1:nrow(Stock), function(i) {
  if (i <= wma_period) {
    return(NA)
  } else {
    sum(Stock$AAPL.Close[(i - wma_period + 1):i] * weights) / sum(weights)
  }
})

# Create separate charts for Closing Price and WMA
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = Stock + " Closing Price",
       x = "Date",
       y = "Price")

wma_chart <- ggplot(Stock, aes(x = index(Stock), y = WMA)) +
  geom_line(color = 'blue') +
  labs(title = "Weighted Moving Average (WMA)",
       x = "Date",
       y = "WMA")

# Arrange charts using grid
library(gridExtra)
grid.arrange(closing_price_chart, wma_chart, ncol = 1)
