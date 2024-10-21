# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)
library(TTR)  # for technical indicators

# Get stock data
getSymbols('AAPL', from = '2016-01-01', to = '2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate the Typical Price (TP) - no longer needed for Connor's RSI
# Calculate RSI for different periods
Stock$RSI3 <- RSI(Cl(Stock), n = 3)
Stock$RSI2 <- RSI(Cl(Stock), n = 2)
Stock$RSI100 <- RSI(Cl(Stock), n = 100)

# Calculate Connor's RSI
Stock$Connors_RSI <- (Stock$RSI3 + Stock$RSI2 + Stock$RSI100) / 3

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for Connor's RSI
connors_rsi_chart <- ggplot(Stock, aes(x = index(Stock), y = Connors_RSI)) +
  geom_line(color = 'blue') +
  geom_hline(yintercept = 70, color = 'red', linetype = "dashed") +  # Overbought line
  geom_hline(yintercept = 30, color = 'red', linetype = "dashed") + # Oversold line
  labs(title = "Connor's RSI",
       x = "Date",
       y = "Connor's RSI") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, connors_rsi_chart, ncol = 1)