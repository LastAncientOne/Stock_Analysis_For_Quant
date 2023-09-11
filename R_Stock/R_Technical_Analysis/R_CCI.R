# Load necessary libraries
library(quantmod)
library(ggplot2)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate CCI
cci_period <- 20
tp <- (HLC(Stock)[,1] + HLC(Stock)[,2] + HLC(Stock)[,3]) / 3
sma <- SMA(tp, n = cci_period)
md <- mean(abs(tp - sma), na.rm = TRUE)
Stock$CCI <- (tp - sma) / (0.015 * md)

# Create separate charts for Closing Price and CCI
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

cci_chart <- ggplot(Stock, aes(x = index(Stock), y = CCI)) +
  geom_line(color='red') +
  labs(title = "Commodity Channel Index (CCI)",
       x = "Date",
       y = "CCI")

# Arrange charts using grid
library(gridExtra)
grid.arrange(closing_price_chart, cci_chart, ncol = 1)
