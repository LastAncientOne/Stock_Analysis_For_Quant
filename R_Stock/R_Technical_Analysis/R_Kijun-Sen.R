library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data for AAPL from 2016-01-01 to 2018-01-01
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Kijun-sen (Base Line): (26-Period High + 26-Period Low) / 2
Stock$KS <- (runMax(Hi(Stock), n = 26) + runMin(Lo(Stock), n = 26)) / 2

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for Kijun-sen (Base Line)
ks_chart <- ggplot(Stock, aes(x = index(Stock), y = KS)) +
  geom_line(color = 'blue') +
  labs(title = "Kijun-sen (Base Line)",
       x = "Date",
       y = "Kijun-sen") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, ks_chart, ncol = 1)