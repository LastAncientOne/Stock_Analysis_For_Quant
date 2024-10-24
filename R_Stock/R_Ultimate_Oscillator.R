# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)  # for technical indicators

# Get stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Ultimate Oscillator using built-in TTR function
Stock$UO <- ultimateOscillator(HLC(Stock), n = c(7, 14, 28))

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for the Ultimate Oscillator (UO)
uo_chart <- ggplot(Stock, aes(x = index(Stock), y = UO)) +
  geom_line(color = 'blue') +
  geom_hline(yintercept = 70, color = 'red', linetype = "dashed") +  # Overbought level
  geom_hline(yintercept = 30, color = 'red', linetype = "dashed") +  # Oversold level
  labs(title = "Ultimate Oscillator (UO)",
       x = "Date",
       y = "UO") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, uo_chart, ncol = 1)