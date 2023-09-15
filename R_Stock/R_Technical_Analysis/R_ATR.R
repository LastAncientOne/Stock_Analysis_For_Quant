# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate ATR (replace ADX calculation)
atr_period <- 14
Stock$ATR <- ATR(HLC(Stock), n = atr_period)

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = Stock + "Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for ATR (replace ADX chart)
atr_chart <- ggplot(Stock, aes(x = index(Stock), y = ATR)) +
  geom_line(color = 'green') +
  labs(title = "Average True Range (ATR)",
       x = "Date",
       y = "ATR") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, atr_chart, ncol = 1)

