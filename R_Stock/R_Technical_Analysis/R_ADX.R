# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate ADX
adx_period <- 14
Stock$ADX <- ADX(HLC(Stock), n = adx_period)

# Create separate charts for Closing Price and ADX
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = Stock + " Closing Price",
       x = "Date",
       y = "Price")

adx_chart <- ggplot(Stock, aes(x = index(Stock), y = ADX)) +
  geom_line(color='green') +
  labs(title = "ADX",
       x = "Date",
       y = "ADX")

# Arrange charts using grid
grid.arrange(closing_price_chart, adx_chart, ncol = 1)
