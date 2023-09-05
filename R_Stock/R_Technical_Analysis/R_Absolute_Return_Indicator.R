# Load necessary libraries
library(quantmod)
library(ggplot2)
library(gridExtra)

# Get stock data
getSymbols('AAPL', from='2016-01-01', to='2018-01-01', adjust = TRUE)
Stock <- AAPL

# Calculate Absolute Return Indicator
Stock$ARI <- abs(diff(Cl(Stock), lag = 1))  # Use lag to calculate returns

# Create a ggplot chart for Closing Price
closing_price_chart <- ggplot(Stock, aes(x = index(Stock), y = AAPL.Close)) +
  geom_line() +
  labs(title = Stock + " Closing Price",
       x = "Date",
       y = "Price")

# Create a ggplot chart for Absolute Return Indicator
ari_chart <- ggplot(Stock, aes(x = index(Stock), y = ARI)) +
  geom_line(color = 'Blue') +
  labs(title = "Absolute Return Indicator (ARI)",
       x = "Date",
       y = "ARI") +
  theme(plot.title = element_text(hjust = 0.5))  # Center the plot title

# Arrange charts using grid
grid.arrange(closing_price_chart, ari_chart, ncol = 1)
