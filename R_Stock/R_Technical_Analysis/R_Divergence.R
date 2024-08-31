# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate RSI
rsi_period <- 14
Stock$RSI <- RSI(Cl(Stock), n = rsi_period)

# Calculate Divergence
Stock$Divergence <- Stock$AAPL.Close - Stock$RSI

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = "AAPL Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for Divergence
divergence_chart <- ggplot(Stock, aes(x = index(Stock), y = Divergence)) +
  geom_line(color = 'blue') +
  labs(title = "Divergence",
       x = "Date",
       y = "Divergence") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, divergence_chart, ncol = 1)

