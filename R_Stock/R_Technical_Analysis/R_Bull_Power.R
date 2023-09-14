# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Accumulation/Distribution Line (ADL)
Stock$ADL <- cumsum(((Stock$AAPL.Close - Stock$AAPL.Low) - (Stock$AAPL.High - Stock$AAPL.Close)) / (Stock$AAPL.High - Stock$AAPL.Low) * Stock$AAPL.Volume)

# Calculate 13-period Exponential Moving Average (EMA)
Stock$EMA <- EMA(Stock$AAPL.Close, n = 13)

# Calculate Bull Power
Stock$BullPower <- Stock$AAPL.High - Stock$EMA

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = Stock + " Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for Bull Power
bull_power_chart <- ggplot(Stock, aes(x = index(Stock), y = BullPower)) +
  geom_line(color = 'green') +
  labs(title = "Bull Power",
       x = "Date",
       y = "Bull Power") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, bull_power_chart, ncol = 1)
