# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Slow Stochastic Oscillator
n <- 14  # Period for Slow Stoch
k <- 3   # Smoothing for %K
d <- 3   # Smoothing for %D

# Calculate %K
Stock$LowestLow <- rollapply(Stock$AAPL.Low, n, min, align = "right")
Stock$HighestHigh <- rollapply(Stock$AAPL.High, n, max, align = "right")
Stock$FastStochK <- 100 * (Stock$AAPL.Close - Stock$LowestLow) / (Stock$HighestHigh - Stock$LowestLow)

# Calculate %D
Stock$SlowStochD <- rollapply(Stock$FastStochK, d, mean, align = "right")

# Create a ggplot chart for buy and sell signals
Buy_Signal <- ifelse(Stock$FastStochK > 20 & Stock$SlowStochD > 20, 1, 0)
Sell_Signal <- ifelse(Stock$FastStochK < 80 & Stock$SlowStochD < 80, -1, 0)

signal_chart <- ggplot(Stock, aes(x = index(Stock))) +
  geom_point(aes(y = Stock$SlowStochD, color = factor(Buy_Signal - Sell_Signal)), size = 3) +
  labs(title = "Buy and Sell Signals",
       x = "Date",
       y = "Slow %D") +
  scale_color_manual(values = c("red", "green", "black"), labels = c("Sell", "Buy", "No Signal")) +
  theme(legend.title = element_blank())  # Remove legend title

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for Slow Stochastic %D
slow_stoch_chart <- ggplot(Stock, aes(x = index(Stock), y = Stock$SlowStochD)) +
  geom_line(color = 'blue') +
  labs(title = "Slow Stochastic %D",
       x = "Date",
       y = "Slow %D") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, slow_stoch_chart, signal_chart, ncol = 1)

